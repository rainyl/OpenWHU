// EXP3_1.2.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include <iostream>
#include <math.h>
#include <omp.h>
#include <time.h>
using namespace std;

#define N 100000000

int main()
{
	clock_t start, finish;
	double eps = 3.1415 / N;
	double result = 0.0, x = 0.0;
	start = clock();
	omp_set_num_threads(4);//ǿ�����ÿ����߳�����������Խ��Խ�ã�
#pragma omp parallel for
	for (int i = 0; i < N; i++)
	{
#pragma omp critical
		//��ͬ���ʶ���һ��Ҫ��������
		result += (sin(x) * eps);
#pragma omp critical
		x += eps;
		//���԰��̺߳Ŵ�ӡ����֤�����̳߳ɹ�����
		//cout << "This is Thread " << omp_get_thread_num() << endl;
	}
	finish = clock();
	cout.precision(15);
	cout << "Result = " << result << endl;
	cout << "It takes " << ((double)(finish - start) / CLOCKS_PER_SEC) << " seconds to calculate." << endl;
    return 0;
}

