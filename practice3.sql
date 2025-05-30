--3.2
 CREATE TABLE DEPT
 (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
 DNAME VARCHAR2(14),
 LOC VARCHAR2(13) );

 CREATE TABLE EMP
 (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
 ENAME VARCHAR2(10),
 JOB VARCHAR2(9),
 MGR NUMBER(4),
 HIREDATE DATE,
 SAL NUMBER(7,2),
 COMM NUMBER(7,2),
 DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO 
REFERENCES DEPT);

--3.4
INSERT INTO DEPT(DEPTNO, DNAME)VALUES(50,'RESEARCH');
SELECT * FROM DEPT;

--3.5
INSERT INTO DEPT VALUES(60,'MKTG','LA');
SELECT * FROM DEPT;

--3.6
UPDATE DEPT
SET LOC='CHICAGO';
SELECT *FROM DEPT;

--3.7
DELETE FROM DEPT;
SELECT * FROM DEPT;

--3.11
SELECT DEPTNO FROM EMP;

SELECT DISTINCT DEPTNO FROM EMP;

--3.12
SELECT EMPNO AS 주민번호,
       ENAME AS 성명,
       MGR AS 매니저,
       HIREDATE AS 입사일,
       SAL AS 연봉,
       COMM AS 수당,
       DEPTNO AS 부서
FROM EMP;

--3.13
SELECT DEPTNO "부서번호",
       DNAME "회원 번호",
       LOC "회사위치"
FROM DEPT;

--3.15
SELECT ENAME 이름, 
       HIREDATE 입사일, 
       SAL 연봉, 
       ROUND(SAL/12,2) "월 평균 급여"
FROM EMP;

--3.16
SELECT '부서명' || DNAME || '위치' || LOC 
FROM DEPT;

 SELECT DNAME || '부서 ' || LOC || '에 위치' 
FROM DEPT;

--3.18
SELECT * FROM DEPT;
SELECT * FROM EMP;

--3.19
SELECT ENAME AS EMPLOYEE,
       JOB AS TITLE
FROM EMP
WHERE SAL > 3000;

SELECT * FROM EMP
WHERE ENAME IN('SMITH','WARD');

--3.20
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 5000;

SELECT * FROM EMP
WHERE ENAME LIKE '%E%';

--3.21
SELECT * FROM EMP
WHERE (JOB, DEPTNO) IN(('CLERK',10),('SALESMAN',30));

SELECT ENAME,  
       SAL AS SALARY
FROM EMP
WHERE COMM IS NULL AND SAL > 2500;

--3.22
SELECT ENAME,
       JOB,
       SAL
FROM EMP
WHERE DEPTNO=30
AND NOT JOB='SALESMAN'
AND NOT SAL > 2500;

SELECT * FROM EMP
WHERE COMM IS NOT NULL;

--3.23
SELECT ENAME, LOC
FROM DEPT, EMP
WHERE ENAME IN('SMITH','ALLEN'); -- WRONG ANSWER

SELECT ENAME, LOC
FROM DEPT, EMP
WHERE ENAME IN('SMITH','ALLEN')
AND DEPT.DEPTNO=EMP.DEPTNO;

--3.24
SELECT DISTINCT EMP1.SAL -- PPT에서의 정답
FROM EMP EMP1, EMP EMP2
WHERE EMP1.SAL<EMP2.SAL; 

SELECT * FROM EMP;

SELECT DISTINCT SAL -- MAX 값을 찾아서 하는 방법
FROM EMP
WHERE SAL < (SELECT MAX(SAL) FROM EMP);

--3.25
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO (+)= DEPT.DEPTNO; -- RIGHT OUTER JOIN

--3.26
SELECT E1.EMPNO, E1.ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR=E2.EMPNO AND E2.JOB='PRESIDENT';

--3.27
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO,AVG(SAL) FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>2000
ORDER BY DEPTNO;

--3.28
SELECT DISTINCT EMP1.ENAME
FROM EMP EMP1, EMP EMP2
WHERE EMP1.SAL > EMP2.SAL AND EMP2.JOB='SALESMAN';

SELECT ENAME -- Same query using > some clause
FROM EMP
WHERE SAL > SOME(SELECT SAL
                 FROM EMP
                 WHERE JOB='SALESMAN');
       