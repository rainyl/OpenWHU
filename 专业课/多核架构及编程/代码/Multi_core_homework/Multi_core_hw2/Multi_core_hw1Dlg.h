
// Multi_core_hw1Dlg.h : ͷ�ļ�
//

#pragma once
#include "afxwin.h"


// CMulti_core_hw1Dlg �Ի���
class CMulti_core_hw1Dlg : public CDialogEx
{
// ����
public:
	CMulti_core_hw1Dlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MULTI_CORE_HW1_DIALOG };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedInput();
	afx_msg void OnBnClickedQuery();
	// ¼��ѧ����Ϣ
	CString st_name1;
	CString st_name2;
	CString st_name3;
	CString st_num1;
	CString st_num2;
	CString st_num3;
	CString num_query;
	BOOL register_1;
	BOOL register_2;
	BOOL register_3;
};
