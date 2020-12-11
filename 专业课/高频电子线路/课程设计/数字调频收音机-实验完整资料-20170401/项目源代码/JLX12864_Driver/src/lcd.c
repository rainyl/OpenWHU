/*
 * lcd.c
 *
 *  Created on: 2016-5-5
 *      Author: DanyangHong
 */

#include "lcd.h"
#include "ASCII.h"
const int numtab[]={
		1,10,100,1000,10000,100000,100000
};

/*--------дָ��------------*/
void wr_cmd(unsigned char cmd)
{
	CLR_LCDRS;
	char i;
	for(i=0;i<8;i++)
	{
		CLR_SCK;
		if(cmd&0x80) SET_SDA;
		else CLR_SDA;
		SET_SCK;
		cmd = cmd<<=1;
	}
}

/*--------д����------------*/
void wr_dat(unsigned char dat)
{
	SET_LCDRS;
	char i;
	for(i=0;i<8;i++)
	{
		CLR_SCK;
		if(dat&0x80) SET_SDA;
		else CLR_SDA;
		SET_SCK;
		dat=dat<<=1;
	}
}

/**************************************************************
 * 						��ʼ��
 *
 **************************************************************/
void lcd_clear(void)
{
	unsigned char i,j;
	for(i=0;i<9;i++)
	{
		wr_cmd(0xb0+i);
		wr_cmd(0x10);
		wr_cmd(0x00);
		for(j=0;j<132;j++)
		{
			wr_dat(0x00);
		}
	}
}
void lcd_clear_page(unsigned char page_num){
	unsigned char j;
	wr_cmd(0xb0+page_num);
	wr_cmd(0x10);
	wr_cmd(0x00);
	for(j=0;j<132;j++){
		wr_dat(0x00);
	}
}

/*��ʱ*/
void delay(int i)
{
	int j;
	for(j=0;j<i;j++);
}

void Lcd_Init()
{
	P1DIR |= BIT0+BIT1+BIT2+BIT3+BIT4;
	SET_LCDRST;
	CLR_LCDRST;
	delay(10000);
	SET_LCDRST;
	P1OUT|=BIT0;
	wr_cmd(0xe2);    /*��λ*/
	wr_cmd(0x2c);    /*��ѹ���� 1*/
	wr_cmd(0x2e);    /*��ѹ���� 2*/
	wr_cmd(0x2f);    /*��ѹ���� 3*/
	wr_cmd(0x23);    /*�ֵ��Աȶȣ������÷�Χ 20��27*/
	wr_cmd(0x81);    /*΢���Աȶ�*/
	wr_cmd(0x28);    /*΢���Աȶȵ�ֵ�������÷�Χ 0��63*/
	wr_cmd(0xa2);    /*1/9 ƫѹ�ȣ�bias��*/
	wr_cmd(0xc8);    /*��ɨ��˳�򣺴��ϵ���*/
	wr_cmd(0xa0);    /*��ɨ��˳�򣺴�����*/
	wr_cmd(0xaf);    /*����ʾ*/
	lcd_clear();
}
/**************************************************************
 * 						��ʾ
 *
 **************************************************************/

void lcd_addr(unsigned char page,unsigned char column)
{
	//column=column;
	wr_cmd(0xb0+page); /*����ҳ��ַ*/
	wr_cmd(0x10+(column>>4&0x0f)); /*�����е�ַ�ĸ�4 λ*/
	wr_cmd(column&0x0f); /*�����е�ַ�ĵ�4 λ*/
}

/*��ʾ8x16 ����ͼ��ASCII, ��8x16 ����������ַ�������ͼ��*/
void disp_graph_8x16(unsigned char page,unsigned char column,const unsigned char *dp,unsigned char style)
{
	unsigned char i,j;
	for(j=0;j<2;j++)
	{
		lcd_addr(page+j,column);
		for (i=0;i<8;i++)
		{
	 		if(style)
	 			wr_dat((*dp)^0xff);
	 		else
	 			wr_dat(*dp);
			dp++;
		}
	}
}
/*��ʾ 16x16 ����ͼ�񡢺��֡���Ƨ�ֻ� 16x16 ���������ͼ��*/
void disp_graph_16x16(unsigned char page,unsigned char column,const unsigned char *dp,unsigned char style)
{
	unsigned char i,j;
	for(j=0;j<2;j++)
	{
		lcd_addr(page+j,column);
		for (i=0;i<16;i++)
		{
	 		if(style)
	 			wr_dat((*dp)^0xff);
	 		else
	 			wr_dat(*dp);
			dp++;
		}
	}
}
/*��ʾ 5*7 ����ͼ��ASCII, �� 5x7 ����������ַ�������ͼ��*/
void disp_graph_6x7(unsigned char page,unsigned char column,const unsigned char *dp,unsigned char style)
{
	unsigned char i;
 	lcd_addr(page,column);
 	for (i=0;i<6;i++)
 	{
 		if(style)
 			wr_dat((*dp)^0xff);
 		else
 			wr_dat(*dp);
 		dp++;
 	}
}
/**************************************************************
 * 						�߲���ʾ
 *
 **************************************************************/
/*=======8*16========*/
//void DispStringAt(unsigned char x,unsigned char y,char *str,unsigned char style)
//{
//  unsigned char i;
//  for(i=0;;i++)
//  {
//    if(str[i]==0)
//      break;
//    disp_graph_8x16(x,y+i*8,ASCII8_16[str[i]-' '],style);
//  }
//}
//
//void DispDecAt(unsigned char x,unsigned char y,int dat,unsigned char len,unsigned char style)
//{
//	char str[12];
//	unsigned char i,dl;
//	str[len]=0;
//	for(i=0;i<len;i++)
//	{
//		dl=dat%10;
//		dat/=10;
//		str[len-i-1]=dl+'0';
//	}
//	DispStringAt(x,y,str,style);
//}
//////��ʾ��ʮλ����
////void DispDecAtlong(unsigned char x,unsigned char y,long dat,unsigned char len)
////{
////	char str[12];
////	unsigned char i,dl;
////	str[len]=0;
////	for(i=0;i<len;i++)
////	{
////		dl=dat%10;
////		dat/=10;
////		str[len-i-1]=dl+'0';
////	}
////	DispStringAt(x,y,str);
////}
//void DispHexAt(unsigned char x,unsigned char y,long dat,unsigned char len,unsigned char style)
//{
//	unsigned char i,dl;
//	char str[12];
//	for(i=0;i<len;i++)
//	{
//		dl=dat&0xf;
//		dat=dat>>4;
//		if(dl<10)
//			str[len-i-1]=dl+'0';
//		else
//			str[len-i-1]=dl-10+'a';
//	}
//	DispStringAt(x,y,str,style);
//}
//void DispFloatAt(unsigned char x,unsigned char y,float dat,unsigned char len1,unsigned char len2 ,unsigned char style)
//{
//	int dat1,dat2;
//	dat1=(int)dat;
//	dat2=(int)((dat-dat1)*numtab[len2]);
//	DispDecAt(x,y,dat1,len1,style);
//	DispStringAt(x,y+8*len1,".",style);
//	DispDecAt(x,y+8*(len1+1),dat2,len2,style);
//}
/*=======6*7========*/
void DispString67At(unsigned char x,unsigned char y,char *str,unsigned char style)
{
	  unsigned char i;
	  for(i=0;;i++)
	  {
	    if(str[i]==0)
	      break;
	    	disp_graph_6x7(x,y+i*6,ASCII6_7[str[i]-' '],style);
	  }
}
void DispDec67At(unsigned char x,unsigned char y,long dat,unsigned char len,unsigned char style)
{
	char str[12];
	unsigned char i,dl;
	str[len]=0;
	for(i=0;i<len;i++)
	{
		dl=dat%10;
		dat/=10;
		str[len-i-1]=dl+'0';
	}
	DispString67At(x,y,str,style);
}
void DispHex67At(unsigned char x,unsigned char y,long dat,unsigned char len,unsigned char style)
{
	unsigned char i,dl;
	char str[12];
	str[len]=0;
	for(i=0;i<len;i++)
	{
		dl=dat&0xf;
		dat=dat>>4;
		if(dl<10)
			str[len-i-1]=dl+'0';
		else
			str[len-i-1]=dl-10+'a';
	}
	DispString67At(x,y,str,style);
}
void DispFloat67At(unsigned char x,unsigned char y,float dat,unsigned char len1,unsigned char len2 ,unsigned char style)
{
	int dat1,dat2;
	dat1=(int)dat;
	dat2=(int)((dat-dat1)*numtab[len2]);
	DispDec67At(x,y,dat1,len1,style);
	DispString67At(x,y+6*len1,".",style);
	DispDec67At(x,y+6*(len1+1),dat2,len2,style);
}

