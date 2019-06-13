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
	[学号Sno] [nchar](10) NOT NULL,
	[姓名Sname] [nchar](10) NULL,
	[性别Ssex] [nchar](10) NULL,
	[年龄Sage] [nchar](10) NULL,
	[所在系Sdept] [nchar](10) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[学号Sno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[Course](
	[课程号Cno] [nchar](10) NULL,
	[课程名Cname] [nchar](10) NULL,
	[先行课Cpno] [nchar](10) NULL,
	[学分Ccredit] [nchar](10) NULL
) ON [PRIMARY]

GO
--------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[SC](
	[学号Sno] [nchar](10) NOT NULL,
	[课程号Cno] [nchar](10) NOT NULL,
	[成绩Grade] [nchar](10) NULL,
 CONSTRAINT [PK_SC] PRIMARY KEY CLUSTERED 
(
	[学号Sno] ASC,
	[课程号Cno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
------------------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX Stusno ON Student(学号Sno);
CREATE UNIQUE INDEX Coucno ON Course(课程号Cno);
CREATE UNIQUE INDEX Scno ON SC(学号Sno ASC,课程号Cno DESC);
-----------------------------------------------------------------------------------------------------------------
SELECT 姓名Sname,学号Sno,所在系Sdept
FROM Student;
----------------------------------------------
SELECT* 
FROM Student;
---------------------------------------------
SELECT 姓名Sname,2019-年龄Sage
FROM Student;
----------------------------------------------
SELECT 姓名Sname,'Year of Birth',2014-年龄Sage,LOWER(所在系sdept)
FROM Student
----------------------------------------------
SELECT DISTINCT 学号Sno
    FROM SC
----------------------------------------------
SELECT 姓名Sname,年龄Sage
FROM Student
WHERE 年龄Sage<20
----------------------------------------------
SELECT DISTINCT 学号Sno
FROM SC
WHERE 成绩Grade<60
---------------------------------------------
SELECT 姓名Sname,所在系Sdept,年龄Sage
FROM Student
WHERE 年龄Sage BETWEEN 20 AND 23;
---------------------------------------------
SELECT*
FROM Student
WHERE 学号Sno LIKE '20125121';  
---------------------------------------------
SELECT 姓名Sname,学号Sno,性别Ssex
FROM Student 
WHERE 姓名Sname LIKE'刘%';
---------------------------------------------
SELECT 学号Sno,成绩Grade
FROM SC
WHERE 课程号Cno='2'
ORDER BY 成绩Grade DESC;
--------------------------------------------
SELECT*
FROM Student
ORDER BY 所在系Sdept,年龄Sage DESC;
--------------------------------------------
SELECT COUNT(*)
FROM Student;
--------------------------------------------
SELECT AVG(成绩Grade)
FROM SC
WHERE 课程号Cno='2';
--------------------------------------------
SELECT SUM(学分Ccredit)
FROM SC,Course
WHERE 学号Sno='201215121' AND SC.课程号Cno=Course.课程号Cno;
--------------------------------------------
SELECT 课程号Cno,COUNT(学号Sno)
FROM SC
GROUP BY 课程号Cno;
-----------------------------------------------
SELECT Student.*,SC.*
FROM Student,SC
WHERE Student.学号Sno=SC.学号Sno;
------------------------------------------------
SELECT Student.学号Sno,姓名Sname,课程名Cname,成绩Grade
FROM Student,SC,Course
WHERE Student.学号Sno=SC.学号Sno AND SC.课程号Cno=Course.课程号Cno
-----------------------------------------------
SELECT 姓名Sname,年龄Sage
FROM Student
WHERE 年龄Sage<ANY(SELECT 年龄Sage
               FROM Student 
               WHERE 所在系Sdept='CS')
AND 所在系Sdept<>'CS';
-------------------------------------------------

UPDATE Student
SET 年龄Sage=年龄Sage+1;
------------------------------------------------
CREATE VIEW IS_Student
AS
SELECT 学号Sno,姓名Sname, 年龄Sage
FROM Student
WHERE 所在系Sdept='IS'
WITH CHECK OPTION
-----------------------------------------------

CREATE VIEW BT_S(学号Sno,姓名Sname,出生年份sbirth)
AS
SELECT 学号Sno,姓名Sname,2008-年龄Sage
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

