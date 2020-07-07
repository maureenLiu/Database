--1、给不同部门的人员涨薪，10部门涨10%,20部门涨20%,30部门涨30%
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
  
  
--2、新建表test
create table test(
   id number(10) primary key,
   type number(10) ,
   t_id number(10),
   value varchar2(5)
);
insert into test values(100,1,1,'张三');
insert into test values(200,2,1,'男');
insert into test values(300,3,1,'50');

insert into test values(101,1,2,'刘二');
insert into test values(201,2,2,'男');
insert into test values(301,3,2,'30');

insert into test values(102,1,3,'刘三');
insert into test values(202,2,3,'女');
insert into test values(302,3,3,'10');

select * from test;
/*
需求:行转列
将表的显示转换为
姓名      性别     年龄
--------- -------- ----
张三       男        50
*/
select decode(type, 1, value) 姓名,
       decode(type, 2, value) 性别,
       decode(type, 3, value) 年龄
  from test;
--max函数是为了过滤null值
select max(decode(type, 1, value)) 姓名,
       max(decode(type, 2, value)) 性别,
       max(decode(type, 3, value)) 年龄
  from test group by t_id; 


--3、一道sql语句面试题，关于group by
/*表内容：
2005-05-09 胜
2005-05-09 胜
2005-05-09 负
2005-05-09 负
2005-05-10 胜
2005-05-10 负
2005-05-10 负
如果要生成下列结果，该如何写sql语句？
           胜 负
2005-05-09 2  2
2005-05-10 1  2 */
--------------------------------------
create table tmp(rq varchar2(10), shengfu varchar2(5));
insert into tmp values('2005-05-09','胜');
insert into tmp values('2005-05-09','胜');
insert into tmp values('2005-05-09','负');
insert into tmp values('2005-05-09','负');
insert into tmp values('2005-05-10','胜');
insert into tmp values('2005-05-10','负');
insert into tmp values('2005-05-10','负');
--答案
--步骤1：先建立结果要求的列
select rq,decode(shengfu, '胜',1),decode(shengfu,'负',2) from tmp;
--步骤2：在步骤1的基础上合并日期相同的行
select rq,
       count(decode(shengfu, '胜', 1)) 胜,
       count(decode(shengfu, '负', 2)) 负
  from tmp
 group by rq;


--4、
create table STUDENT_SCORE
(
       name    VARCHAR2(20),
       subject VARCHAR2(20),
       score   NUMBER(4,1)
);
insert into student_score (NAME,SUBJECT,SCORE) values ('张三','语文',78.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('张三','数学',88.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('张三','英语',98.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('李四','语文',89.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('李四','数学',76.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('李四','英语',90.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('王五','语文',99.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('王五','数学',66.0);
insert into student_score (NAME,SUBJECT,SCORE) values ('王五','英语',91.0);

/*
4.1 得到类似下面的结果
姓名  语文  数学  英语
王五  89    56    89
*/
--至少使用4种方式写出：
--方法1：decode
--步骤1：先建立要求的列
select name,
       decode(subject, '语文', score) 语文,
       decode(subject, '数学', score) 数学,
       decode(subject, '英语', score) 英语
  from student_score;
--步骤2：在步骤1的基础上合并同一名称的行
select name 姓名,
       max(decode(subject, '语文', score)) 语文,
       max(decode(subject, '数学', score)) 数学,
       max(decode(subject, '英语', score)) 英语
  from student_score
 group by name;
 
 --方法2：case when
 select ss.name,
        max(case ss.subject
              when '语文' then
               ss.score
            end) 语文,
        max(case ss.subject
              when '数学' then
               ss.score
            end) 数学,
        max(case ss.subject
              when '英语' then
               ss.score
            end) 英语
   from student_score ss
  group by ss.name;
  
--方法3：join
select ss.name,ss.score from student_score ss where ss.subject = '语文'; --生成一张语文成绩表
select ss.name,ss.score from student_score ss where ss.subject = '数学'; --生成一张数学成绩表
select ss.name,ss.score from student_score ss where ss.subject = '英语'; --生成一张英语成绩表

select ss01.name, ss01.score 语文, ss02.score 数学, ss03.score 英语
  from (select ss.name, ss.score
          from student_score ss
         where ss.subject = '语文') ss01
  join (select ss.name, ss.score
          from student_score ss
         where ss.subject = '数学') ss02
    on ss01.name = ss02.name
  join (select ss.name, ss.score
          from student_score ss
         where ss.subject = '英语') ss03
    on ss01.name = ss03.name;
 
--方法4：union all
select t.name, sum(t.语文) 语文, sum(t.数学) 数学, sum(t.英语) 英语
  from (select ss01.name, ss01.score 语文, 0 数学, 0 英语
          from student_score ss01
         where ss01.subject = '语文'
        union all
        select ss02.name, 0 语文, ss02.score 数学, 0 英语
          from student_score ss02
         where ss02.subject = '数学'
        union all
        select ss03.name, 0 语文, 0 数学, ss03.score 英语
          from student_score ss03
         where ss03.subject = '英语') t
 group by t.name;


/*
4.2 有一张表，里面有3个字段：语文、数学、英语，其中有3条记录分别表示语文70分，数学80分，英语58分，请用
大于或等于80表示优秀，大于或等于60表示及格，小于60分表示不及格。
显示格式：
    语文     数学     英语
    及格     优秀     不及格
*/

--答案
select case
         when 语文 >= 80 then
          '优秀'
         when 语文 >= 60 then
          '及格'
         else
          '不及格'
       end 语文,
       case
         when 数学 >= 80 then
          '优秀'
         when 数学 >= 60 then
          '及格'
         else
          '不及格'
       end 数学,
       case
         when 英语 >= 80 then
          '优秀'
         when 英语 >= 60 then
          '及格'
         else
          '不及格'
       end 英语
  from (select name 姓名,
               max(decode(subject, '语文', score)) 语文,
               max(decode(subject, '数学', score)) 数学,
               max(decode(subject, '英语', score)) 英语
          from student_score
         where name='王五') t; ---从生成的王五成绩单这张虚拟表中判断各科成绩的等级

  
--5、请用一个sql语句得到结果
/*
从table1，table2中取出如table3所列格式数据，注意提供的数据即及结果不准确，只是作为一个格式。

table1：
月份mon  部门dept  业绩yj
---------------------------
一月份    01      10
一月份    02      10
一月份    03      5
二月份    02      8
二月份    04      9
三月份    03      8

table2：
部门dept         部门名称dname
-------------------------------
01                国内业务一部
02                国内业务二部
03                国内业务三部
04                国际业务部

table3：(result)
部门dept   一月份  二月份  三月份
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
insert into yj01(month,deptno,yj) values('一月份',01,10);
insert into yj01(month,deptno,yj) values('一月份',02,10);
insert into yj01(month,deptno,yj) values('一月份',03,5);
insert into yj01(month,deptno,yj) values('二月份',02,8);
insert into yj01(month,deptno,yj) values('二月份',04,9);
insert into yj01(month,deptno,yj) values('三月份',03,8);

create table yjdept(
       deptno number(10),
       dname varchar2(20)
);
insert into yjdept(deptno,dname) values(01,'国内业务一部');
insert into yjdept(deptno,dname) values(02,'国内业务二部');
insert into yjdept(deptno,dname) values(03,'国内业务三部');
insert into yjdept(deptno,dname) values(04,'国际业务部');
--答案：
select deptno,
       max(decode(month, '一月份', yj)) 一月份,
       max(decode(month, '二月份', yj)) 二月份,
       max(decode(month, '三月份', yj)) 三月份
  from yj01
 group by deptno;
