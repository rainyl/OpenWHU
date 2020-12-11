// OpenCV_mt.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include <Windows.h>
#include <iostream>
#include <time.h>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
using namespace std;
using namespace cv;

DWORD WINAPI show_image(LPVOID lpParameter);   // thread data  

HANDLE hEvent;

void main() {

	HANDLE handle[4];
	time_t start, finish;

	hEvent = CreateEvent(NULL, FALSE, FALSE, TEXT("image"));

	start = clock();
	for (int i = 0; i < 4; i++)
	{
		handle[i] = CreateThread(NULL, 0, show_image, (LPVOID)&i, 0, NULL);
		Sleep(1);//�����߳����ü�ȡi�ĵ�ǰֵ
	}
	finish = clock();
	WaitForSingleObject(hEvent, INFINITE);
	for (int i = 0; i < 4; i++)
	{
		CloseHandle(handle[i]);
	}
	destroyAllWindows();
	cout << "���̴߳�ͼƬ����ʱ��" << ((double)(finish - start) / CLOCKS_PER_SEC) << "��" << endl;
}

DWORD WINAPI show_image(LPVOID i)
{
	int j = *(int *)i;
	j++;
	Mat image1 = imread("../cat" + to_string(j) + ".jpg", 1);
	namedWindow("Cat" + to_string(j), WINDOW_AUTOSIZE);
	imshow("Cat" + to_string(j), image1);
	waitKey(-1);
	SetEvent(hEvent);
	return 0;
}