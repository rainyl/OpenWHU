
// Multi_core_hw1Dlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "Multi_core_hw1.h"
#include "Multi_core_hw1Dlg.h"
#include "afxdialogex.h"
#include "Student.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// �Ի�������
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_ABOUTBOX };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

// ʵ��
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(IDD_ABOUTBOX)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// CMulti_core_hw1Dlg �Ի���



CMulti_core_hw1Dlg::CMulti_core_hw1Dlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(IDD_MULTI_CORE_HW1_DIALOG, pParent)
	, st_name1(_T(""))
	, st_name2(_T(""))
	, st_name3(_T(""))
	, st_num1(_T(""))
	, st_num2(_T(""))
	, st_num3(_T(""))
	, num_query(_T(""))
	, register_1(FALSE)
	, register_2(FALSE)
	, register_3(FALSE)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMulti_core_hw1Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT1, st_name1);
	DDX_Text(pDX, IDC_EDIT2, st_name2);
	DDX_Text(pDX, IDC_EDIT3, st_name3);
	DDX_Text(pDX, IDC_EDIT5, st_num1);
	DDX_Text(pDX, IDC_EDIT6, st_num2);
	DDX_Text(pDX, IDC_EDIT7, st_num3);
	DDX_Text(pDX, IDC_EDIT4, num_query);
	DDX_Check(pDX, IDC_CHECK1, register_1);
	DDX_Check(pDX, IDC_CHECK2, register_2);
	DDX_Check(pDX, IDC_CHECK3, register_3);
}

BEGIN_MESSAGE_MAP(CMulti_core_hw1Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(BT_Input, &CMulti_core_hw1Dlg::OnBnClickedInput)
	ON_BN_CLICKED(BT_Query, &CMulti_core_hw1Dlg::OnBnClickedQuery)
END_MESSAGE_MAP()


// CMulti_core_hw1Dlg ��Ϣ�������

BOOL CMulti_core_hw1Dlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// ��������...���˵�����ӵ�ϵͳ�˵��С�

	// IDM_ABOUTBOX ������ϵͳ���Χ�ڡ�
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// ���ô˶Ի����ͼ�ꡣ  ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

void CMulti_core_hw1Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ  ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CMulti_core_hw1Dlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CMulti_core_hw1Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMulti_core_hw1Dlg::OnBnClickedInput()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	UpdateData(TRUE);//�ѿؼ���ֵ�����ؼ�����
	CFile file(_T("student.dat"), CFile::modeCreate | CFile::modeWrite);
	CArchive ar(&file, CArchive::store);
	CStudent stu(true);

	stu.setName(st_name1);
	stu.setNum(st_num1);
	stu.setState(register_1);
	stu.Serialize(ar);

	stu.setName(st_name2);
	stu.setNum(st_num2);
	stu.setState(register_2);
	stu.Serialize(ar);

	stu.setName(st_name3);
	stu.setNum(st_num3);
	stu.setState(register_3);
	stu.Serialize(ar);

	ar.Close();
	file.Close();
}


void CMulti_core_hw1Dlg::OnBnClickedQuery()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	//���ļ���ȡ��ע���ѧ����Ϣ
	CTypedPtrArray<CObArray, CStudent *> m_Students;

	CFile file(_T("student.dat"), CFile::modeRead);
	CArchive ar(&file, CArchive::load);
	
	//���ļ���ȡ��Ϣ
	CStudent *stu0 = new CStudent();
	stu0->Serialize(ar);
	m_Students.Add(stu0);
	CStudent *stu1 = new CStudent();
	stu1->Serialize(ar);
	m_Students.Add(stu1);
	CStudent *stu2 = new CStudent();
	stu2->Serialize(ar);
	m_Students.Add(stu2);

	ar.Close();
	file.Close();

	UpdateData(TRUE);//�ѿؼ���ֵ�����ؼ�����
	CString student;
	int i;
	for (i = 0;i < m_Students.GetSize();i++)
	{
		CStudent *stu = m_Students.GetAt(i);
		if (stu->getNum() == num_query)
		{
			student += "������";
			student += stu->getName();
			student += "\r\n";
			student += "ѧ�ţ�";
			student += stu->getNum();
			student += "\r\n";
			student += "ע��״̬��";
			if (stu->getState())
			{
				student += "��ע��";
			}
			else
			{
				student += "δע��";
			}
			break;
		}
	}
	if (i >= m_Students.GetSize())
	{
		student = "δ��ѯ����ѧ��������";
	}
	MessageBoxA(student);
}
