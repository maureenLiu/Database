--练习
--1、查询部门编号为10的员工信息
select * from emp where deptno = 10;
--2、查询年薪大于3万的人员的姓名与部门编号
select ename,deptno from emp where sal*12 > 30000;
--3、查询佣金为null的人员姓名与工资
select ename,sal from emp where comm is null;
--4、查询工资大于1500且and含有佣金的人员的姓名
select ename from emp where sal > 1500 and comm is not null;
--5、查询工资大于1500或or含有佣金的人员姓名
select ename from emp where sal > 1500 or comm is not null;
--6、查询姓名里面含有S的员工信息 工资 名称
select sal,ename from emp where ename like('%S%');
--7、求姓名以J开头，第二个字符O的员工姓名与工资
select ename,sal from emp where ename like('JO%');
--8、求包含%的雇员姓名
select ename from emp where ename like('%\%%') escape('\');
--9、使用in查询部门名称为SALES和RESEARCH的雇员姓名、工资、部门编号
select ename, sal, deptno
  from emp
 where deptno in
       (select deptno from dept where dname in ('SALES', 'RESEARCH'));
--10、使用exists查询部门名称为SALES和RESEARCH的雇员姓名、工资、部门编号
select ename, sal, deptno
  from emp e
 where exists (select deptno
          from dept d
         where dname in ('SALES', 'RESEARCH')
           and e.deptno = d.deptno);

--（1）查询20号部门的所有员工信息
select * from emp where deptno = 20;
--（2） 查询所有工种为CLERK的员工的工号、员工名和部门编号
select empno,ename,deptno from emp where job = 'CLERK';
--（3） 查询奖金（COMM）高于工资（SAL）的员工信息
select * from emp where comm > sal;
--（4） 查询奖金高于工资的20%的员工信息
select * from emp where comm > (sal*0.2);
--（5） 查询10号部门中工种为MANAGER或20号部门中工种为CLERK的员工的信息
select * from emp where (deptno = 10 and job = 'MANAGER') or (deptno = 20 and job = 'CLERK');
--（6） 查询所有工种不是MANAGER和CLERK，且工资大于或等于2000的员工的详细信息
select * from emp where job not in('MANAGER','CLERK') and sal >= 2000;
--（7） 查询有奖金的员工的不同工种
select distinct job from emp where comm is not null;
--（8） 查询所有员工工资和奖金的和 !!!!!!
select ename,(sal+nvl(comm,0)) salcomm from emp;
--（9） 查询没有奖金或奖金低于100的员工信息
select * from emp where (comm is null or comm < 100);
--（10）  查询各月倒数第2天入职的员工信息 !!!!!!!
select * from emp where hiredate in (select (last_day(hiredate)-1) from emp);
--（11）  查询员工工龄大于或等于10年的员工信息 !!!!!!!
select * from emp where (sysdate - hiredate)/365 >= 10;
-- （12） 查询员工信息，要求以首字母大写的方式显示所有员工的姓名 （数据库中有很多内置函数)
select upper(substr(ename,1,1)) || lower(substr(ename,2,length(ename)-1)) from emp;
--（13）  查询员工名正好为6个字符的员工的信息
select * from emp where length(ename) = 6;

--（14）  查询员工名字中不包含字母“S”员工
select * from emp where ename not like('%S%');
select * from emp where ename not in (select ename from emp where ename like('%S%'));

--（15）  查询员工姓名的第2个字母为“M”的员工信息。
select * from emp where ename like('_M%');

--（16）  查询所有员工姓名的前3个字符。
select substr(ename,1,3) from emp;

--（17）  查询所有员工的姓名，如果包含字母“s”，则用“S”替换
select replace(ename,'s','S') from emp;

--（18）  查询员工的姓名和入职日期，并按入职日期从先到后进行排列
select ename,hiredate from emp order by hiredate asc;

--（19）  显示所有的姓名、工种、工资和奖金，按工种降序排列，若工种相同则按工资升序排列
select ename,job,sal,comm from emp order by job desc, sal asc;

--（20）  显示所有员工的姓名、入职的年份和月份，若入职日期所在的月份排序，若月份相同则按入职的年份排序
select ename, to_char(hiredate, 'yyyy') || '-' || to_char(hiredate, 'mm')
  from emp
 order by to_char(hiredate, 'mm'), to_char(hiredate, 'yyyy');
 
--（21）  查询在2月份入职的所有员工信息
select * from emp where to_char(hiredate,'mm')=2;

--（22）  查询所有员工入职以来的工作期限，用“**年**月**日”的形式表示
select ename,
       floor((sysdate - hiredate) / 365) || '年' ||
       floor(mod((sysdate - hiredate), 365) / 30) || '月' ||
       ceil(mod(mod((sysdate - hiredate), 365), 30)) || '天'
  from emp;
  
--（23）  查询至少有一个员工的部门信息
select *
  from dept
 where deptno in (select distinct deptno from emp where mgr is not null);
 
--（24）  查询工资比SMITH员工工资高的所有员工信息
select *
  from emp
 where sal > (select sal from emp where ename like 'SMITH');
 
--（25）  查询所有员工的姓名及其直接上级的姓名
select staname, ename supname
  from (select ename staname, mgr from emp) t
  join emp
    on t.mgr = emp.empno;

--（26）  查询入职日期早于其直接上级领导的所有员工信息。
select *
  from emp
 where empno in
       (select staempno
          from (select empno staempno, hiredate stahiredate, mgr from emp) t
          join emp
            on t.mgr = emp.empno
           and stahiredate < hiredate);

--（27）  查询所有部门及其员工信息，包括那些没有员工的部门
select *
  from dept
  left join emp
    on emp.deptno = dept.deptno
 order by dept.deptno;

--（28）  查询所有员工及其部门信息，包括那些还不属于任何部门的员工
select *
  from emp
  left join dept
    on emp.deptno = dept.deptno
 order by emp.empno;

--（29）  查询所有工种为CLERK的员工的姓名及其部门名称。
select ename, dname
  from emp
  join dept
    on job like 'CLERK'
   and emp.deptno = dept.deptno;
   
select emp.ename, dept.dname
  from emp
  join dept
    on emp.deptno = dept.deptno
 where job = 'CLERK';
 
--（30）  查询最低工资大于2500的各种工作
select job
  from (select min(sal) min_sal, job from emp group by job)
 where min_sal > 2500;

--（31）  查询最低工资低于2000的部门及其员工信息。
select *
  from emp
 where deptno in
       (select distinct deptno
          from (select min(sal) min_sal, deptno from emp group by deptno)
         where min_sal < 2000);

--（32）  查询在SALES部门工作的员工的姓名信息。
select ename
  from emp
 where deptno in (select deptno from dept where dname = 'SALES');
 
 select ename
   from emp
  where deptno = (select deptno from dept where dname like 'SALES');
 
--（33）  查询工资高于公司平均工资的所有员工信息
select * from emp where sal > (select avg(sal) from emp);

--（34）  查询与SMITH员工从事相同工作的所有员工信息
select *
  from emp
 where job in (select job from emp where ename like 'SMITH')
   and ename not like 'SMITH';

--（35）  列出工资等于30号部门中某个员工工资的所有员工的姓名和工资
select ename, sal
  from emp
 where sal = any (select sal from emp where deptno = 30);

--（36）  查询工资高于30号部门中工作的所有员工的工资的员工姓名和工资
select ename,sal from emp where sal > all(select sal from emp where deptno = 30);

--（37）  查询每个部门中的员工数量、平均工资和平均工作年限
select dname, empcount, avg_sal, avg_date
  from dept
  join (select count(*) empcount,
               avg(sal) avg_sal,
               avg((sysdate - hiredate) / 365) avg_date,
               deptno
          from emp
         group by deptno) t
    on dept.deptno = t.deptno;

--（38）  查询从事同一种工作但不属于同一部门的员工信息。
select distinct t1.empno, t1.ename, t1.deptno
  from emp t1
  join emp t2
    on t1.job like t2.job
   and t1.deptno <> t2.deptno;

--（39）  查询各个部门的详细信息以及部门人数、部门平均工资
select dept.*, person_num, avg_sal
  from dept,
       (select count(*) person_num, avg(sal) avg_sal, deptno
          from emp
         group by deptno) t
 where dept.deptno = t.deptno;

--（40）  查询各种工作的最低工资
select job, min(sal) from emp group by job;

--（41）  查询各个部门中的不同工种的最高工资
select max(sal), job, deptno
  from emp
 group by deptno, job
 order by deptno, job;

--（42）  查询10号部门员工以及领导的信息。
select *
  from emp
 where empno in (select mgr from emp where deptno = 10);
    or deptno = 10;

--（43）  查询各个部门的人数及平均工资
select deptno, count(*), avg(sal) from emp group by deptno;

--（44）  查询工资为某个部门平均工资的员工信息
select * from emp where sal in (select avg(sal) avg_sal from emp group by deptno);

--（45）  查询工资高于本部门平均工资的员工的信息
select emp.*
  from emp
  join (select deptno, avg(sal) avg_sal from emp group by deptno) t
    on emp.deptno = t.deptno
   and sal > avg_sal;
   
--（46）  查询工资高于本部门平均工资的员工的信息及其部门的平均工资
select emp.*, avg_sal
  from emp
  join (select deptno, avg(sal) avg_sal from emp group by deptno) t
    on emp.deptno = t.deptno
   and sal > avg_sal;

--（47）  查询工资高于20号部门某个员工工资的员工的信息
select * from emp where sal > any (select sal from emp where deptno = 20);

--（48）  统计各个工种的人数与平均工资
select job, count(*), avg(sal) from emp group by job;

--（49）  统计每个部门中各个工种的人数与平均工资
select deptno, job, count(*), avg(sal)
  from emp
 group by deptno, job
 order by deptno, job;

--（50）  查询工资、奖金与10 号部门某个员工工资、奖金都相同的员工的信息
select emp.*
  from emp
  join (select sal, comm from emp where deptno = 10) t
    on emp.sal = t.sal
   and nvl(emp.comm, 0) = nvl(t.comm, 0)
   and emp.deptno != 10;

--（51）  查询部门人数大于5的部门的员工的信息
select *
  from emp
 where deptno in
       (select deptno from emp group by deptno having count(*) > 5);

--（52）  查询所有员工工资都大于1000的部门的信息
select *
  from dept
 where deptno in
       (select distinct deptno
          from emp
         where deptno not in
               (select distinct deptno from emp where sal < 1000));

--（53）  查询所有员工工资都大于1000的部门的信息及其员工信息
select *
  from emp
  join dept
    on dept.deptno in
       (select distinct deptno
          from emp
         where deptno not in
               (select distinct deptno from emp where sal < 1000))
   and dept.deptno = emp.deptno;

--（54）  查询所有员工工资都在900~3000之间的部门的信息
select *
  from dept
 where deptno in (select distinct deptno
                    from emp
                   where deptno not in
                         (select distinct deptno
                            from emp
                           where sal not between 900 and 3000));

--（55）  查询所有工资都在900~3000之间的员工所在部门的员工信息。
select *
  from emp
 where deptno in (select distinct deptno
                    from emp
                   where deptno not in
                         (select distinct deptno
                            from emp
                           where sal not between 900 and 3000));

--（56）  查询每个员工的领导所在部门的信息
select *
  from (select e1.empno, e1.ename, e1.mgr mno, e2.ename mname, e2.deptno
          from emp e1
          join emp e2
            on e1.mgr = e2.empno) t
  join dept
    on t.deptno = dept.deptno;

--（57）  查询人数最多的部门信息
select *
  from dept
 where deptno in
       (select deptno
          from (select count(*) count, deptno from emp group by deptno)
         where count in
               (select max(count)
                  from (select count(*) count, deptno from emp group by deptno)));

--（58）  查询30号部门中工资排序前3名的员工信息。
select *
  from emp
 where empno in (select empno
                   from (select empno, sal
                           from emp
                          where deptno = 30
                          order by sal desc)
                  where rownum < 4);

--（59）  查询所有员工中工资排在5~10名之间的员工信息
select *
  from emp
 where empno in (select empno
                   from (select empno, rownum num
                           from (select empno, sal from emp order by sal desc))
                  where num between 5 and 10);

select empno
  from (select empno, sal from emp order by sal desc)
 where rownum <= 10
minus
select empno
  from (select empno, sal from emp order by sal desc)
 where rownum < 5;

--（60）  向emp表中插入一条记录，员工号为1357，员工名字为oracle，工资为2050元，部门号为20，入职日期为2002年5月10日
insert into emp
  (empno, ename, sal, deptno, hiredate)
values
  (1357,
   'oracle',
   2050,
   20,
   to_date('2002年5月10日', 'yyyy"年"mm"月"dd"日"'));

--（61）  向emp表中插入一条记录，员工名字为FAN，员工号为8000，其他信息与SMITH员工的信息相同
insert into emp
  select 8000, 'FAN', job, mgr, hiredate, sal, comm, deptno
    from emp
   where ename = 'SMITH';

--（62）  将各部门员工的工资修改为该员工所在部门平均工资加1000。
update emp t1
   set sal =
       (select new_sal
          from (select avg(sal) + 1000 new_sal, deptno
                  from emp
                 group by deptno) t2
         where t1.deptno = t2.deptno);
         
         
--1、查询82年员工
select e.* from emp e where to_char(e.hiredate, 'yy') like '82';
select e.* from emp e where to_char(e.hiredate, 'yyyy') = '1982';

--2、查询32年工龄的人员
select round(sysdate - e.hiredate) / 365, e.ename, e.hiredate
  from emp e
 where round((sysdate - e.hiredate) / 365) = 32;

--3、显示员工雇佣期 6 个月后下一个星期一的日期
select next_day(add_months(e.hiredate, 6), 2) from emp e;

--4、找没有上级的员工，把mgr的字段信息输出为 "boss"
select decode(e.mgr, null, 'boss', '中国好声音') from emp e;

--5、为所有人涨工资，标准是：10部门长10%；20部门长15%；30部门长20%其他部门长18%
select decode(e.deptno, 10, e.sal * 1.1, 20, e.sal * 1.15, e.sal * 1.18) 涨工资,
       e.deptno,
       e.sal
  from emp e;
  
  
 --1、求部门中薪水最高的人
select ename, sal, emp.deptno
  from emp
  join (select deptno, max(sal) max_sal from emp group by deptno) t
    on (emp.deptno = t.deptno and emp.sal = t.max_sal);

select ename, sal, deptno
  from emp
 where sal in (select max(sal) from emp group by deptno);
 
 --2、求部门平均薪水的等级
select deptno, avg_sal, grade
  from (select deptno, avg(sal) avg_sal from emp group by deptno) t
  join salgrade
    on (t.avg_sal between salgrade.losal and salgrade.hisal);

--3、求部门平均的薪水等级 
select deptno, avg(grade) avg_sal_grade
  from (select deptno, grade
          from emp
          join salgrade
            on emp.sal between salgrade.losal and salgrade.hisal)
 group by deptno;
 
 --4、雇员中有哪些人是经理人 
select distinct e2.ename manager
  from emp e1
  join emp e2
    on e1.mgr = e2.empno;
select ename from emp where empno in (select mgr from emp);

--5、不准用组函数，求薪水的最高值 
select distinct sal max_sal
  from emp
 where sal not in
       (select e1.sal e1_sal from emp e1 join emp e2 on e1.sal < e2.sal);
  
select * from (select * from emp order by sal desc) t where rownum < 2;

--6. 求平均薪水最高的部门的部门编号 
select deptno, avg_sal
  from (select deptno, avg(sal) avg_sal from emp group by deptno)
 where avg_sal =
       (select max(avg_sal)
          from (select avg(sal) avg_sal from emp group by deptno));
--组函数嵌套写法(对多可以嵌套一次，group by 只对内层函数有效) 
select deptno, avg_sal
  from (select deptno, avg(sal) avg_sal from emp group by deptno)
 where avg_sal = (select max(avg(sal)) from emp group by deptno);
 
 --7、求平均薪水最高的部门的部门名称 
select t1.deptno, dname, avg_sal
  from (select deptno, avg(sal) avg_sal from emp group by deptno) t1
  join dept
    on t1.deptno = dept.deptno
 where avg_sal =
       (select max(avg_sal)
          from (select deptno, avg(sal) avg_sal from emp group by deptno));

select dname
  from dept
 where deptno =
       (select deptno
          from (select deptno, avg(sal) avg_sal from emp group by deptno)
         where avg_sal = (select max(avg_sal)
                            from (select deptno, avg(sal) avg_sal
                                    from emp
                                   group by deptno)));

--8、求平均薪水的等级最低的部门的部门名称 
select dname
  from dept
  join (select deptno, grade
          from (select deptno, avg(sal) avg_sal from emp group by deptno) t
          join salgrade
            on (t.avg_sal between salgrade.losal and salgrade.hisal)) t
    on dept.deptno = t.deptno
 where t.grade =
       (select min(grade)
          from (select avg(sal) avg_sal from emp group by deptno) t
          join salgrade
            on (t.avg_sal between salgrade.losal and salgrade.hisal));
--9、求部门经理人中平均薪水最低的部门名称
select dname
  from (select deptno, avg(sal) avg_sal
          from emp
         where empno in (select mgr from emp)
         group by deptno) t
  join dept
    on t.deptno = dept.deptno
 where avg_sal = (select min(avg_sal)
                    from (select avg(sal) avg_sal
                            from emp
                           where empno in (select mgr from emp)
                           group by deptno) t);
                          
--10、求比普通员工的最高薪水还要高的经理人名称(not in) 
select ename
  from emp
 where empno in (select mgr from emp)
   and sal > (select max(sal)
                from (select e2.sal
                        from emp e1
                       right join emp e2
                          on e1.mgr = e2.empno
                       where e1.ename is null) t);

select ename
  from emp
 where empno in (select mgr from emp)
   and sal >
       (select max(sal)
          from emp
         where empno not in
               (select distinct mgr from emp where mgr is not null));
--NOT IN遇到NULL则返回NULL，必须排除NULL值

--11、求薪水最高的前5名雇员 
select empno, ename
  from (select * from emp order by sal desc)
 where rownum <= 5;

--12、求薪水最高的第6到第10名雇(!important) 
select ename, sal
  from (select t.*, rownum r from (select * from emp order by sal desc) t)
 where r >= 6
   and r <= 10;

--13、求最后入职的5名员工 
select ename, to_char(hiredate, 'YYYY"年"MM"月"DD"日"') hiredate
  from (select t.*, rownum r
          from (select * from emp order by hiredate desc) t)
 where r <= 5;

select ename, to_char(hiredate, 'YYYY"年"MM"月"DD""') hiredate
  from (select t.*, rownum r from (select * from emp order by hiredate) t)
 where r > (select count(*) - 5 from emp);
