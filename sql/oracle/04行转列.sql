--1������ͬ���ŵ���Ա��н��10������10%,20������20%,30������30%
select ename,
       sal,
       deptno,
       decode(deptno, 10, sal * 1.1, 20, sal * 1.2, 30, sal * 1.3)
  from emp;

select ename,
       sal,
       deptno,
       case deptno
         when 10 then
          sal * 1.1
         when 20 then
          sal * 1.2
         when 30 then
          sal * 1.3
       end
  from emp;
  
  
--2���½���test
create table test(
   id number(10) primary key,
   type number(10) ,
   t_id number(10),
   value varchar2(5)
);
insert into test values(100,1,1,'����');
insert into test values(200,2,1,'��');
insert into test values(300,3,1,'50');

insert into test values(101,1,2,'����');
insert into test values(201,2,2,'��');
insert into test values(301,3,2,'30');

insert into test values(102,1,3,'����');
insert into test values(202,2,3,'Ů');
insert into test values(302,3,3,'10');

select * from test;
/*
����:��ת��
�������ʾת��Ϊ
����      �Ա�     ����
--------- -------- ----
����       ��        50
*/
select decode(type, 1, value) ����,
       decode(type, 2, value) �Ա�,
       decode(type, 3, value) ����
  from test;
--max������Ϊ�˹���nullֵ
select max(decode(type, 1, value)) ����,
       max(decode(type, 2, value)) �Ա�,
       max(decode(type, 3, value)) ����
  from test group by t_id; 


--3��һ��sql��������⣬����group by
/*�����ݣ�
2005-05-09 ʤ
2005-05-09 ʤ
2005-05-09 ��
2005-05-09 ��
2005-05-10 ʤ
2005-05-10 ��
2005-05-10 ��
���Ҫ�������н���������дsql��䣿
           ʤ ��
2005-05-09 2  2
2005-05-10 1  2 */
--------------------------------------
create table tmp(rq varchar2(10), shengfu varchar2(5));
insert into tmp values('2005-05-09','ʤ');
insert into tmp values('2005-05-09','ʤ');
insert into tmp values('2005-05-09','��');
insert into tmp values('2005-05-09','��');
insert into tmp values('2005-05-10','ʤ');
insert into tmp values('2005-05-10','��');
insert into tmp values('2005-05-10','��');
--��
--����1���Ƚ������Ҫ�����
select rq,decode(shengfu, 'ʤ',1),decode(shengfu,'��',2) from tmp;
--����2���ڲ���1�Ļ����Ϻϲ�������ͬ����
select rq,
       count(decode(shengfu, 'ʤ', 1)) ʤ,
       count(decode(shengfu, '��', 2)) ��
  from tmp
 group by rq;


--4��
create table STUDENT_SCORE
(
       name    VARCHAR2(20),
       subject VARCHAR2(20),
       score   NUMBER(4,1)
);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','����',78.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','��ѧ',88.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','Ӣ��',98.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','����',89.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','��ѧ',76.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','Ӣ��',90.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','����',99.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','��ѧ',66.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('����','Ӣ��',91.0);

/*
4.1 �õ���������Ľ��
����  ����  ��ѧ  Ӣ��
����  89    56    89
*/
--����ʹ��4�ַ�ʽд����
--����1��decode
--����1���Ƚ���Ҫ�����
select name,
       decode(subject, '����', score) ����,
       decode(subject, '��ѧ', score) ��ѧ,
       decode(subject, 'Ӣ��', score) Ӣ��
  from student_score;
--����2���ڲ���1�Ļ����Ϻϲ�ͬһ���Ƶ���
select name ����,
       max(decode(subject, '����', score)) ����,
       max(decode(subject, '��ѧ', score)) ��ѧ,
       max(decode(subject, 'Ӣ��', score)) Ӣ��
  from student_score
 group by name;
 
 --����2��case when
 select ss.name,
        max(case ss.subject
              when '����' then
               ss.score
            end) ����,
        max(case ss.subject
              when '��ѧ' then
               ss.score
            end) ��ѧ,
        max(case ss.subject
              when 'Ӣ��' then
               ss.score
            end) Ӣ��
   from student_score ss
  group by ss.name;
  
--����3��join
select ss.name,ss.score from student_score ss where ss.subject = '����'; --����һ�����ĳɼ���
select ss.name,ss.score from student_score ss where ss.subject = '��ѧ'; --����һ����ѧ�ɼ���
select ss.name,ss.score from student_score ss where ss.subject = 'Ӣ��'; --����һ��Ӣ��ɼ���

select ss01.name, ss01.score ����, ss02.score ��ѧ, ss03.score Ӣ��
  from (select ss.name, ss.score
          from student_score ss
         where ss.subject = '����') ss01
  join (select ss.name, ss.score
          from student_score ss
         where ss.subject = '��ѧ') ss02
    on ss01.name = ss02.name
  join (select ss.name, ss.score
          from student_score ss
         where ss.subject = 'Ӣ��') ss03
    on ss01.name = ss03.name;
 
--����4��union all
select t.name, sum(t.����) ����, sum(t.��ѧ) ��ѧ, sum(t.Ӣ��) Ӣ��
  from (select ss01.name, ss01.score ����, 0 ��ѧ, 0 Ӣ��
          from student_score ss01
         where ss01.subject = '����'
        union all
        select ss02.name, 0 ����, ss02.score ��ѧ, 0 Ӣ��
          from student_score ss02
         where ss02.subject = '��ѧ'
        union all
        select ss03.name, 0 ����, 0 ��ѧ, ss03.score Ӣ��
          from student_score ss03
         where ss03.subject = 'Ӣ��') t
 group by t.name;


/*
4.2 ��һ�ű�������3���ֶΣ����ġ���ѧ��Ӣ�������3����¼�ֱ��ʾ����70�֣���ѧ80�֣�Ӣ��58�֣�����
���ڻ����80��ʾ���㣬���ڻ����60��ʾ����С��60�ֱ�ʾ������
��ʾ��ʽ��
    ����     ��ѧ     Ӣ��
    ����     ����     ������
*/

--��
select case
         when ���� >= 80 then
          '����'
         when ���� >= 60 then
          '����'
         else
          '������'
       end ����,
       case
         when ��ѧ >= 80 then
          '����'
         when ��ѧ >= 60 then
          '����'
         else
          '������'
       end ��ѧ,
       case
         when Ӣ�� >= 80 then
          '����'
         when Ӣ�� >= 60 then
          '����'
         else
          '������'
       end Ӣ��
  from (select name ����,
               max(decode(subject, '����', score)) ����,
               max(decode(subject, '��ѧ', score)) ��ѧ,
               max(decode(subject, 'Ӣ��', score)) Ӣ��
          from student_score
         where name='����') t; ---�����ɵ�����ɼ���������������жϸ��Ƴɼ��ĵȼ�

  
--5������һ��sql���õ����
/*
��table1��table2��ȡ����table3���и�ʽ���ݣ�ע���ṩ�����ݼ��������׼ȷ��ֻ����Ϊһ����ʽ��

table1��
�·�mon  ����dept  ҵ��yj
---------------------------
һ�·�    01      10
һ�·�    02      10
һ�·�    03      5
���·�    02      8
���·�    04      9
���·�    03      8

table2��
����dept         ��������dname
-------------------------------
01                ����ҵ��һ��
02                ����ҵ�����
03                ����ҵ������
04                ����ҵ��

table3��(result)
����dept   һ�·�  ���·�  ���·�
-------------------------------------
01          10                     
02          10        10
03          5                8
04                     9         
-------------------------------------         
*/

create table yj01(
       month varchar2(10),
       deptno number(10),
       yj     number(10)
);
insert into yj01(month,deptno,yj) values('һ�·�',01,10);
insert into yj01(month,deptno,yj) values('һ�·�',02,10);
insert into yj01(month,deptno,yj) values('һ�·�',03,5);
insert into yj01(month,deptno,yj) values('���·�',02,8);
insert into yj01(month,deptno,yj) values('���·�',04,9);
insert into yj01(month,deptno,yj) values('���·�',03,8);

create table yjdept(
       deptno number(10),
       dname varchar2(20)
);
insert into yjdept(deptno,dname) values(01,'����ҵ��һ��');
insert into yjdept(deptno,dname) values(02,'����ҵ�����');
insert into yjdept(deptno,dname) values(03,'����ҵ������');
insert into yjdept(deptno,dname) values(04,'����ҵ��');
--�𰸣�
select deptno,
       max(decode(month, 'һ�·�', yj)) һ�·�,
       max(decode(month, '���·�', yj)) ���·�,
       max(decode(month, '���·�', yj)) ���·�
  from yj01
 group by deptno;
