#include <msp430g2553.h>
#include "SI4730.h"
#include "lcd.h"

uint Frequency_fm=884;
uint Frequency_am=531;
uint read_buff = 0;

uchar Mode = 0;
uchar FM_AM_ = 0;
uchar pass_one = 0;
uchar uiReceiveDataBuffer[8]={0};

//void Si4730_Delay(unsigned int k)
//{
//	unsigned int j;
//	for(j=0;j<k;j++);
//}

void ResetSi47XX_2w()
{
   Si4730_RESET_LOW;
   Si4730_SCLK_HIGH;
   Si4730_SDIO_LOW;
   delay_ms(300);
   Si4730_SDIO_HIGH;
   delay_ms(1);
   Si4730_RESET_HIGH;
   delay_ms(1);
}

void Si4730_start()
{
	Si4730_SDIO_OUT;
	Si4730_SDIO_HIGH;
    I2C_CLK_Delay();
    Si4730_SCLK_HIGH;
    I2C_CLK_Delay();
    Si4730_SDIO_LOW;
    I2C_CLK_Delay();
    Si4730_SCLK_LOW;
}

//void Si4730_ack()
//{
//	Si4730_SDIO_IN;
//	Si4730_SCLK_LOW;
//	I2C_CLK_Delay();
//	Si4730_SDIO_LOW;
//    I2C_CLK_Delay();
//    Si4730_SCLK_HIGH;
//    I2C_CLK_Delay();
//    Si4730_SCLK_LOW;
//    I2C_CLK_Delay();
//    Si4730_SDIO_HIGH;
//}

void Si4730_ack()
{
	Si4730_SDIO_IN;
	Si4730_SCLK_LOW;
	I2C_CLK_Delay();
//	Si4730_SDIO_LOW;
//  I2C_CLK_Delay();
    Si4730_SCLK_HIGH;
    I2C_CLK_Delay();
    Si4730_SCLK_LOW;
    I2C_CLK_Delay();
//    Si4730_SDIO_HIGH;
}

void Si4730_stop()
{
	Si4730_SDIO_OUT;
	Si4730_SDIO_LOW;
    I2C_CLK_Delay();
    Si4730_SCLK_HIGH;
    I2C_CLK_Delay();
    Si4730_SDIO_HIGH;
    I2C_CLK_Delay();
    Si4730_SCLK_LOW;
}

void Si4730_writebyte(uchar write_data)
{
	uchar i;
	Si4730_SDIO_OUT;
	for(i=8;i!=0;i--)    // ѭ������8��λ
	{
		if(write_data & 0x80) Si4730_SDIO_HIGH;  //11000111b
		else Si4730_SDIO_LOW;
		Si4730_SCLK_HIGH;
		I2C_CLK_Delay();

		Si4730_SCLK_LOW; //SDA�����������ݱ仯
		write_data <<= 1;   //��������λ
	}
}

void Operation_Si4730_Write(uchar *data1,uchar numByte)
{
	uchar j;

	Si4730_start();
	Si4730_writebyte(WRITE_ADDR);//������ַ 0xc6 11000110b
	Si4730_ack();
	I2C_CLK_Delay();
	for(j=LOW;j<numByte;j++,*data1++)
	{
		Si4730_writebyte(*data1);
		Si4730_ack();
		I2C_CLK_Delay();
	}
	Si4730_stop(); //���ͽ���
}


void I2CAcknowledge(void)
{
	Si4730_SDIO_OUT;
	Si4730_SCLK_LOW;
	Si4730_SDIO_LOW;
	I2C_CLK_Delay();
	Si4730_SCLK_HIGH;
	I2C_CLK_Delay();
	Si4730_SCLK_LOW;
}

void Operation_Si4730_Read(uchar *data1,uchar numByte)
{
	char j,i;
	i=0;

	Si4730_start();
	Si4730_writebyte(READ_ADDR);//������ַ 0xc7 11000111b
	Si4730_ack();
	I2C_CLK_Delay();
	Si4730_SDIO_IN;
	for(j=LOW;j<numByte;j++,*data1++)
	{
		while(i<=7)
		{
			Si4730_SCLK_HIGH;
			I2C_CLK_Delay();
			*data1 =(*data1<<1)|(READ_SDIO);
			Si4730_SCLK_LOW;
			I2C_CLK_Delay();
			i++;
		}
		DispDec67At(4,0,*data1,8,0);
		i=0;
		I2CAcknowledge();
	}
	Si4730_stop(); //���ͽ���
}


void OperationSi47XX_2w(unsigned char operation, unsigned char *data1, unsigned char numBytes)
{
	unsigned char controlWord,j;
	signed char i;
/***************************************************
START: make sure here SDIO_DIR =OUT, SCLK = 1,	SDIO = 1
****************************************************/
	Si4730_SCLK_HIGH;
	Si4730_SDIO_HIGH;
	I2C_CLK_Delay();
	Si4730_SDIO_LOW;
	I2C_CLK_Delay();
	Si4730_SCLK_LOW;
	I2C_CLK_Delay();
/***************************************************
WRITE CONTROL DATA: make sure here: SLCK = 0; SDIO = 0
****************************************************/
	if(operation == READ_ADDR)
		controlWord = READ_ADDR;
	else
		controlWord = WRITE_ADDR;

	for(i = 7; i>=0; i--){
		if((controlWord >> i) & 0x01)
			Si4730_SDIO_HIGH;
		else
			Si4730_SDIO_LOW;

		I2C_CLK_Delay();
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		Si4730_SCLK_HIGH;
		I2C_CLK_Delay();
		Si4730_SCLK_LOW;
		I2C_CLK_Delay();
	}
/***************************
ACK bit
***************************/
	Si4730_SDIO_IN;
	Si4730_SCLK_HIGH;
	I2C_CLK_Delay();
    Si4730_SCLK_LOW;
	I2C_CLK_Delay();
/***************************************
WRITE or READ data
****************************************/
	for(j = 0; j < numBytes; j++, data1++){
		if(operation == WRITE_ADDR)
			Si4730_SDIO_OUT;
		else
			Si4730_SDIO_IN;

		for(i = 7; i>=0; i--){
			if(operation == WRITE_ADDR){
				if((*data1 >> i) & 0x01)
					Si4730_SDIO_HIGH;
				else
					Si4730_SDIO_LOW;
				}
			I2C_CLK_Delay();
			Si4730_SCLK_HIGH;
			I2C_CLK_Delay();
            if(operation == READ_ADDR)
            {
            	*data1 =(*data1<<1);
            	if(READ_SDIO)
            		*data1 = *data1|0x01;
            }
			Si4730_SCLK_LOW;
			I2C_CLK_Delay();
		}
/******************************
ACK bit or SEND ACK=0
���һ��bit ��ACK���뷢��
*******************************/
		if(operation == WRITE_ADDR)
			Si4730_SDIO_IN;
		else{
			Si4730_SDIO_OUT;
			if(j == (numBytes - 1))
				Si4730_SDIO_HIGH;
			else
				Si4730_SDIO_LOW;
		}
		I2C_CLK_Delay();
		Si4730_SCLK_HIGH;
		I2C_CLK_Delay();
       	Si4730_SCLK_LOW;
		I2C_CLK_Delay();
	}
/****************************
STOP: make sure here: SCLK = 0
*****************************/
	Si4730_SDIO_OUT;
	Si4730_SDIO_LOW;
	I2C_CLK_Delay();
	Si4730_SCLK_HIGH;
	I2C_CLK_Delay();
	Si4730_SDIO_HIGH;
	delay_ms(1);
}





void Si4730_Power_Up_FM_AM_Choose(unsigned char mod) //fm,amѡ��
{
	unsigned char write_buf[3]={0x01,0xd0,0x05};
	switch(mod)
	{
	   case FM_RECEIVER:        //si4730
		  write_buf[1] = 0xd0; //ʹ��ʱ�Ӿ���32.768khz ,FMģʽ
		  write_buf[2] = 0x05; //ģ��L/R���
		  break;

		 case AM_RECEIVER:           //si4730
		   write_buf[1] = 0xd1; //ʹ��ʱ�Ӿ���32.768khz ,AMģʽ
		   write_buf[2] = 0x05; //ģ��L/R���
		   break;
	}
	Operation_Si4730_Write(&(write_buf[0]), 3);//need wait >=300mS
	delay_ms(500);
}

void Si4730_Tune(char mod,unsigned short Channel_Freq)
{
	unsigned char write_buf[5];

	write_buf[0]= mod;
	write_buf[1]= 0x00;

	write_buf[2] = Channel_Freq >> 8;   //д����ֽ�
	write_buf[3] = Channel_Freq;     //д����ֽ�

	write_buf[4]= 0x00;

	Operation_Si4730_Write(&(write_buf[0]), 5);
}

void Search_FM()   //�����ֶ�FM Ƶ�ʵ����ӳ��� menu = 15
{
   if(Mode)
   {
    Frequency_fm += 10;   //����+0.1MHz
    if(Frequency_fm > Max_freq_FM)
     Frequency_fm = Min_freq_FM;
   }

   else
   {
    Frequency_fm -= 10;   //����-0.1MHz
    if(Frequency_fm < Min_freq_FM)
     Frequency_fm = Max_freq_FM;
   }
	// Si4730_Power_Up(FM_RECEIVER); //������̨
	Si4730_Tune(FM_RECEIVER,Frequency_fm); //FM����оƬ����ˢ��һ��
}

//=================fm end============

//===============am start==============

void Si4730_Tune_AM(char mod,unsigned short Channel_Freq)
{
	unsigned char write_buf[6];

	write_buf[0]= mod;
	write_buf[1]= 0x00;

	write_buf[2] = Channel_Freq >> 8;   //д����ֽ�
	write_buf[3] = Channel_Freq;     //д����ֽ�

	write_buf[4]= 0x00;
	write_buf[5]= 0x00;

	Operation_Si4730_Write(&(write_buf[0]), 6);
}

void Search_AM()   //�����ֶ�FM Ƶ�ʵ����ӳ��� menu = 95
{
   if(Mode)
   {
    Frequency_am += 9;   //����+9KHz
    if(Frequency_am > max_freq_AM)
     Frequency_am = min_freq_AM;
   }

   else
   {
    Frequency_am -= 9;   //����-9KHz
    if(Frequency_am < min_freq_AM)
     Frequency_am = max_freq_AM;
   }
   // Si4730_Power_Up(AM_RECEIVER); //������̨
   Si4730_Tune_AM(AM_RECEIVER,Frequency_am); //AM����оƬ����ˢ��һ��
}

//=======================am end========================

void Si4730_auto_seek()
{
	unsigned char write_buf[2];
//	unsigned char write_buf1[2]={0x22,0x01};
	write_buf[0] = 0x21;
	write_buf[1] = 0x04;

	Operation_Si4730_Write(&(write_buf[0]), 2);
}

void SI4730_GET_FRE()
{
	unsigned char write_buf1[2]={0x22,0x01};
	OperationSi47XX_2w(WRITE_ADDR,&(write_buf1[0]) ,2);
	OperationSi47XX_2w(READ_ADDR, &(uiReceiveDataBuffer[0]), 8);
	read_buff = (uiReceiveDataBuffer[2]<<8) | uiReceiveDataBuffer[3];
	read_buff = read_buff+0;
	DispDec67At(2,0,read_buff,8,0);
}

void SI4730_GPIO_INIT()
{
	P1DIR |= BIT6+BIT7;
	P1OUT &=  ~BIT6;
	P1OUT &= ~BIT7;

    P2DIR |= BIT5;
	P2OUT &= ~BIT5;
}

