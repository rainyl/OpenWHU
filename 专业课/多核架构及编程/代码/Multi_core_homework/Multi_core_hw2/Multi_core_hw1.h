
// Multi_core_hw1.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CMulti_core_hw1App: 
// �йش����ʵ�֣������ Multi_core_hw1.cpp
//

class CMulti_core_hw1App : public CWinApp
{
public:
	CMulti_core_hw1App();

// ��д
public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CMulti_core_hw1App theApp;