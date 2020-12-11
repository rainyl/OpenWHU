//1��ʹ�� ���ⷨ ʵ���߳�ͬ���Ĵ���
#include "stdafx.h"
#include <windows.h>  
#include <iostream>  
using namespace std;


DWORD WINAPI Thread1(LPVOID lpParameter);   // thread data  
DWORD WINAPI Thread2(LPVOID lpParameter);   // thread data  

int cnt = 10;
HANDLE hMutex;

void main() {

	HANDLE handle1, handle2;

	handle1 = CreateThread(NULL, 0, Thread1, NULL, 0, NULL);
	handle2 = CreateThread(NULL, 0, Thread2, NULL, 0, NULL);

	hMutex = CreateMutex(NULL, FALSE, TEXT("cnt"));
	if (hMutex)
	{
		if (ERROR_ALREADY_EXISTS == GetLastError())
		{
			cout << "only instance can run!" << endl;
			return;
		}
	}
	Sleep(1000);
	CloseHandle(hMutex);
	CloseHandle(handle1);
	CloseHandle(handle2);
}


DWORD WINAPI Thread1(LPVOID lpParameter)
{
	while (TRUE) {
		//WaitForSingleObject����ֻ����������᷵�أ�1����ù������2����ʱ
		WaitForSingleObject(hMutex, INFINITE);
		if (cnt > 0)
		{
			cout << "This is Thread1!" << endl;
			cnt--;
		}
		ReleaseMutex(hMutex);//�ͷŹ�����������Ȩ
	}
	return 0;
}


DWORD WINAPI Thread2(LPVOID lpParameter)
{
	while (TRUE) {
		WaitForSingleObject(hMutex, INFINITE);
		if (cnt > 0)
		{
			cout << "This is Thread2!" << endl;
			cnt--;
		}
		ReleaseMutex(hMutex);
	}
	return 0;
}