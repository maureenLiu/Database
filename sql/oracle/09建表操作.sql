/*
CREATE TABLE [schema.]table
(column datatype[DEFAULT expr],...
);
*/

--���Ҫ�󣺽���һ�������洢ѧ����Ϣ�ı����е��ֶΰ�����ѧ����ѧ�š����������䡢��ѧ���ڡ��꼶���༶��email����Ϣ��
--����Ϊgradeִ����Ĭ��ֵΪ1������ڲ�������ʱ��ָ��grade��ֵ���ʹ�����һ�꼶��ѧ��
create table student
(
stu_id number(10),
name varchar2(20),
age number(3),
hiredate date,
grade varchar2(10) default 1,
classes varchar2(10),
email varchar2(50)
);
insert into student values(20200625,'zhangsan',22,to_date('2019-11-09','YYYY-MM-DD'),'2','1','123@qq.com');
insert into student(stu_id,name,age,hiredate,classes,email) values(20200625,'zhangsan',22,to_date('2019-11-09','YYYY-MM-DD'),'1','123@qq.com');
select * from student;

--����ı�ṹ�����Ҫʹ�õ��������� powerdesigner

--����ӱ���е�ʱ�򣬲����������ó�not null
--�����µ���
alter table student add address varchar2(100);
--ɾ����
alter table student drop column address;
--�޸��ֶ�
alter table student modify(email varchar2(100));
--�޸ı���
rename student to stu;
--ɾ����
/*
��ɾ�����ʱ�򣬾����������������������������������ʱ��������ɾ������Ҫʹ�ü���ɾ��cascade
cascade�����A��B��A���е�ĳ���ֶ���B���е�ĳ���ֶ�����������ô��ɾ��A���ʱ��Ҫ�Ƚ�B��ɾ��
set null:��ɾ����ʱ�򣬽���Ĺ����ֶ����óɿ�
*/
drop table stu;



--�������ʱ����Ը����е������������У�������Щ���򱻳���ΪԼ����
/*
Լ����Ϊ5���ࣺ
     1��not null���ǿ�Լ�����������ݵ�ʱ��ĳЩ�в�����Ϊ�ա�
     2��unique key��Ψһ��Լ���������޶�ĳ���е�ֵ��Ψһ�ģ�Ψһ������һ�㱻���������С�
     3��primary key���������ǿ���Ψһ���κ�һ�ű�һ����������������������Ψһ�ر�ʶһ�м�¼��
     4��foreign key��������������֮���й�����ϵ(һ�����ĳ�е�ֵ��������һ�ű��ĳ��ֵ)��ʱ����Ҫʹ�����
     5��checkԼ�������Ը����û��Լ��������޶�ĳЩ�е�ֵ
*/
--�����ڴ������ʱ��ֱ�ӽ��������Լ��������Ӻã�����������Լ���Ļ�������Ȱ������������������Ȳ���
create table student
(
stu_id number(10) primary key,
name varchar2(20) not null,
age number(3) check(age > 0 and age <126), 
hiredate date,
grade varchar2(10) default 1,
classes varchar2(10),
email varchar2(50) unique,
deptno number(2),
foreign key (deptno) references dept(deptno)
);
--û�в���name�е�ֵ�����������ִ�в��ɹ��ģ���Ϊname�б���not null
insert into student(stu_id,age,hiredate,classes,email) values(20200625,22,to_date('2019-11-09','YYYY-MM-DD'),'1','123@qq.com');
--������ֻ�ܲ���һ�Σ���Ϊemail����Ψһ��
insert into student(stu_id,name,age,hiredate,classes,email) values(20200625,'zhangsan',22,to_date('2019-11-09','YYYY-MM-DD'),'1','123@qq.com');
--age�в����ֵ222��������Ҫ��
insert into student(stu_id,name,age,hiredate,classes,email) values(20200626,'zhangsan',222,to_date('2019-11-09','YYYY-MM-DD'),'1','123@qq.com');
--�޷����룬��Ϊdeptno = 50��dept����û��������ݣ�����ִ���"δ�ҵ�����ؼ���"
insert into student(stu_id,name,age,hiredate,classes,email,deptno) values(20200626,'zhangsan',22,to_date('2019-11-09','YYYY-MM-DD'),'1','123@qq.com',50);
--���Գɹ�ִ��
insert into student(stu_id,name,age,hiredate,classes,email,deptno) values(20200626,'zhangsan',22,to_date('2019-11-09','YYYY-MM-DD'),'1','123@qq.com',10);

--Լ������Ӻ�ɾ��
create table student
(
stu_id number(10) primary key,
name varchar2(20) not null,
age number(3) check(age > 0 and age <126), 
hiredate date,
grade varchar2(10) default 1,
classes varchar2(10),
email varchar2(50) unique,
deptno number(2)
);
--������Լ��
alter table student add constraint fk_0001 foreign key(deptno) references dept(deptno);
