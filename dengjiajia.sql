CREATE DATABASE [stdtb] ON  PRIMARY 
( NAME = N'stdtb_data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\stdtb_data.mdf' , SIZE = 10240KB , MAXSIZE = 102400KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'stdtb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\stdtb_log.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 10%);
GO
ALTER DATABASE [stdtb] SET COMPATIBILITY_LEVEL = 100
GO
-----------------------------------------------------------------------------------------------------
EXEC sp_addlogin 'dengjiajia','dengjiajia'
create login uaersfl with password='dengjiajia'
-----------------------------------------------------------------------------------------------------
CREATE USER [usr1] FOR LOGIN [NT SERVICE\SQLSERVERAGENT]
CREATE USER [usr2] FOR LOGIN [NT SERVICE\MSSQLSERVER]
CREATE USER [usr3] FOR LOGIN [dengjiajia] 
GO
-----------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[Student](
	[ѧ��Sno] [nchar](10) NOT NULL,
	[����Sname] [nchar](10) NULL,
	[�Ա�Ssex] [nchar](10) NULL,
	[����Sage] [nchar](10) NULL,
	[����ϵSdept] [nchar](10) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ѧ��Sno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[Course](
	[�γ̺�Cno] [nchar](10) NULL,
	[�γ���Cname] [nchar](10) NULL,
	[���п�Cpno] [nchar](10) NULL,
	[ѧ��Ccredit] [nchar](10) NULL
) ON [PRIMARY]

GO
--------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[SC](
	[ѧ��Sno] [nchar](10) NOT NULL,
	[�γ̺�Cno] [nchar](10) NOT NULL,
	[�ɼ�Grade] [nchar](10) NULL,
 CONSTRAINT [PK_SC] PRIMARY KEY CLUSTERED 
(
	[ѧ��Sno] ASC,
	[�γ̺�Cno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
------------------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX Stusno ON Student(ѧ��Sno);
CREATE UNIQUE INDEX Coucno ON Course(�γ̺�Cno);
CREATE UNIQUE INDEX Scno ON SC(ѧ��Sno ASC,�γ̺�Cno DESC);
-----------------------------------------------------------------------------------------------------------------
SELECT ����Sname,ѧ��Sno,����ϵSdept
FROM Student;
----------------------------------------------
SELECT* 
FROM Student;
---------------------------------------------
SELECT ����Sname,2019-����Sage
FROM Student;
----------------------------------------------
SELECT ����Sname,'Year of Birth',2014-����Sage,LOWER(����ϵsdept)
FROM Student
----------------------------------------------
SELECT DISTINCT ѧ��Sno
    FROM SC
----------------------------------------------
SELECT ����Sname,����Sage
FROM Student
WHERE ����Sage<20
----------------------------------------------
SELECT DISTINCT ѧ��Sno
FROM SC
WHERE �ɼ�Grade<60
---------------------------------------------
SELECT ����Sname,����ϵSdept,����Sage
FROM Student
WHERE ����Sage BETWEEN 20 AND 23;
---------------------------------------------
SELECT*
FROM Student
WHERE ѧ��Sno LIKE '20125121';  
---------------------------------------------
SELECT ����Sname,ѧ��Sno,�Ա�Ssex
FROM Student 
WHERE ����Sname LIKE'��%';
---------------------------------------------
SELECT ѧ��Sno,�ɼ�Grade
FROM SC
WHERE �γ̺�Cno='2'
ORDER BY �ɼ�Grade DESC;
--------------------------------------------
SELECT*
FROM Student
ORDER BY ����ϵSdept,����Sage DESC;
--------------------------------------------
SELECT COUNT(*)
FROM Student;
--------------------------------------------
SELECT AVG(�ɼ�Grade)
FROM SC
WHERE �γ̺�Cno='2';
--------------------------------------------
SELECT SUM(ѧ��Ccredit)
FROM SC,Course
WHERE ѧ��Sno='201215121' AND SC.�γ̺�Cno=Course.�γ̺�Cno;
--------------------------------------------
SELECT �γ̺�Cno,COUNT(ѧ��Sno)
FROM SC
GROUP BY �γ̺�Cno;
-----------------------------------------------
SELECT Student.*,SC.*
FROM Student,SC
WHERE Student.ѧ��Sno=SC.ѧ��Sno;
------------------------------------------------
SELECT Student.ѧ��Sno,����Sname,�γ���Cname,�ɼ�Grade
FROM Student,SC,Course
WHERE Student.ѧ��Sno=SC.ѧ��Sno AND SC.�γ̺�Cno=Course.�γ̺�Cno
-----------------------------------------------
SELECT ����Sname,����Sage
FROM Student
WHERE ����Sage<ANY(SELECT ����Sage
               FROM Student 
               WHERE ����ϵSdept='CS')
AND ����ϵSdept<>'CS';
-------------------------------------------------

UPDATE Student
SET ����Sage=����Sage+1;
------------------------------------------------
CREATE VIEW IS_Student
AS
SELECT ѧ��Sno,����Sname, ����Sage
FROM Student
WHERE ����ϵSdept='IS'
WITH CHECK OPTION
-----------------------------------------------

CREATE VIEW BT_S(ѧ��Sno,����Sname,�������sbirth)
AS
SELECT ѧ��Sno,����Sname,2008-����Sage
FROM Student
-------------------------------------------------
create login dengjiajia with password='dengjiajia', default_database=stdtb

create user dengjiajia for login dengjiajia with default_schema=dbo
exec sp_addrolemember 'usr1','dengjiajia'
EXEC sp_addrole 'Teacher'
GRANT SELECT,UPDATE,INSERT
ON SC
TO Teacher

EXEC sp_addrolemember Teacher, 'usr1'
EXEC sp_addrolemember Teacher, 'usr2'
EXEC sp_addrolemember Teacher, 'usr3'
-------------------------------------------------
CREATE TABLE TEACHER
(Eno NUMERIC(4)PRIMARY KEY,
Ename CHAR(10),
Job CHAR(8),
Sal NUMERIC(7,2),
Deduct NUMERIC(7,2),
Deptno NUMERIC(2),
CONSTRANT TEACHERKey FOREIGN KEY(Deptno)
REFERENCES DEPT(Deptno),
CONSTRAINT C1 CHECK(Sal+Deduct>=3000)
);

