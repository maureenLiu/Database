--��ϰ
--1����ѯ���ű��Ϊ10��Ա����Ϣ
select * from emp where deptno = 10;
--2����ѯ��н����3�����Ա�������벿�ű��
select ename,deptno from emp where sal*12 > 30000;
--3����ѯӶ��Ϊnull����Ա�����빤��
select ename,sal from emp where comm is null;
--4����ѯ���ʴ���1500��and����Ӷ�����Ա������
select ename from emp where sal > 1500 and comm is not null;
--5����ѯ���ʴ���1500��or����Ӷ�����Ա����
select ename from emp where sal > 1500 or comm is not null;
--6����ѯ�������溬��S��Ա����Ϣ ���� ����
select sal,ename from emp where ename like('%S%');
--7����������J��ͷ���ڶ����ַ�O��Ա�������빤��
select ename,sal from emp where ename like('JO%');
--8�������%�Ĺ�Ա����
select ename from emp where ename like('%\%%') escape('\');
--9��ʹ��in��ѯ��������ΪSALES��RESEARCH�Ĺ�Ա���������ʡ����ű��
select ename, sal, deptno
  from emp
 where deptno in
       (select deptno from dept where dname in ('SALES', 'RESEARCH'));
--10��ʹ��exists��ѯ��������ΪSALES��RESEARCH�Ĺ�Ա���������ʡ����ű��
select ename, sal, deptno
  from emp e
 where exists (select deptno
          from dept d
         where dname in ('SALES', 'RESEARCH')
           and e.deptno = d.deptno);

--��1����ѯ20�Ų��ŵ�����Ա����Ϣ
select * from emp where deptno = 20;
--��2�� ��ѯ���й���ΪCLERK��Ա���Ĺ��š�Ա�����Ͳ��ű��
select empno,ename,deptno from emp where job = 'CLERK';
--��3�� ��ѯ����COMM�����ڹ��ʣ�SAL����Ա����Ϣ
select * from emp where comm > sal;
--��4�� ��ѯ������ڹ��ʵ�20%��Ա����Ϣ
select * from emp where comm > (sal*0.2);
--��5�� ��ѯ10�Ų����й���ΪMANAGER��20�Ų����й���ΪCLERK��Ա������Ϣ
select * from emp where (deptno = 10 and job = 'MANAGER') or (deptno = 20 and job = 'CLERK');
--��6�� ��ѯ���й��ֲ���MANAGER��CLERK���ҹ��ʴ��ڻ����2000��Ա������ϸ��Ϣ
select * from emp where job not in('MANAGER','CLERK') and sal >= 2000;
--��7�� ��ѯ�н����Ա���Ĳ�ͬ����
select distinct job from emp where comm is not null;
--��8�� ��ѯ����Ա�����ʺͽ���ĺ� !!!!!!
select ename,(sal+nvl(comm,0)) salcomm from emp;
--��9�� ��ѯû�н���򽱽����100��Ա����Ϣ
select * from emp where (comm is null or comm < 100);
--��10��  ��ѯ���µ�����2����ְ��Ա����Ϣ !!!!!!!
select * from emp where hiredate in (select (last_day(hiredate)-1) from emp);
--��11��  ��ѯԱ��������ڻ����10���Ա����Ϣ !!!!!!!
select * from emp where (sysdate - hiredate)/365 >= 10;
-- ��12�� ��ѯԱ����Ϣ��Ҫ��������ĸ��д�ķ�ʽ��ʾ����Ա�������� �����ݿ����кܶ����ú���)
select upper(substr(ename,1,1)) || lower(substr(ename,2,length(ename)-1)) from emp;
--��13��  ��ѯԱ��������Ϊ6���ַ���Ա������Ϣ
select * from emp where length(ename) = 6;

--��14��  ��ѯԱ�������в�������ĸ��S��Ա��
select * from emp where ename not like('%S%');
select * from emp where ename not in (select ename from emp where ename like('%S%'));

--��15��  ��ѯԱ�������ĵ�2����ĸΪ��M����Ա����Ϣ��
select * from emp where ename like('_M%');

--��16��  ��ѯ����Ա��������ǰ3���ַ���
select substr(ename,1,3) from emp;

--��17��  ��ѯ����Ա�������������������ĸ��s�������á�S���滻
select replace(ename,'s','S') from emp;

--��18��  ��ѯԱ������������ְ���ڣ�������ְ���ڴ��ȵ����������
select ename,hiredate from emp order by hiredate asc;

--��19��  ��ʾ���е����������֡����ʺͽ��𣬰����ֽ������У���������ͬ�򰴹�����������
select ename,job,sal,comm from emp order by job desc, sal asc;

--��20��  ��ʾ����Ա������������ְ����ݺ��·ݣ�����ְ�������ڵ��·��������·���ͬ����ְ���������
select ename, to_char(hiredate, 'yyyy') || '-' || to_char(hiredate, 'mm')
  from emp
 order by to_char(hiredate, 'mm'), to_char(hiredate, 'yyyy');
 
--��21��  ��ѯ��2�·���ְ������Ա����Ϣ
select * from emp where to_char(hiredate,'mm')=2;

--��22��  ��ѯ����Ա����ְ�����Ĺ������ޣ��á�**��**��**�ա�����ʽ��ʾ
select ename,
       floor((sysdate - hiredate) / 365) || '��' ||
       floor(mod((sysdate - hiredate), 365) / 30) || '��' ||
       ceil(mod(mod((sysdate - hiredate), 365), 30)) || '��'
  from emp;
  
--��23��  ��ѯ������һ��Ա���Ĳ�����Ϣ
select *
  from dept
 where deptno in (select distinct deptno from emp where mgr is not null);
 
--��24��  ��ѯ���ʱ�SMITHԱ�����ʸߵ�����Ա����Ϣ
select *
  from emp
 where sal > (select sal from emp where ename like 'SMITH');
 
--��25��  ��ѯ����Ա������������ֱ���ϼ�������
select staname, ename supname
  from (select ename staname, mgr from emp) t
  join emp
    on t.mgr = emp.empno;

--��26��  ��ѯ��ְ����������ֱ���ϼ��쵼������Ա����Ϣ��
select *
  from emp
 where empno in
       (select staempno
          from (select empno staempno, hiredate stahiredate, mgr from emp) t
          join emp
            on t.mgr = emp.empno
           and stahiredate < hiredate);

--��27��  ��ѯ���в��ż���Ա����Ϣ��������Щû��Ա���Ĳ���
select *
  from dept
  left join emp
    on emp.deptno = dept.deptno
 order by dept.deptno;

--��28��  ��ѯ����Ա�����䲿����Ϣ��������Щ���������κβ��ŵ�Ա��
select *
  from emp
  left join dept
    on emp.deptno = dept.deptno
 order by emp.empno;

--��29��  ��ѯ���й���ΪCLERK��Ա�����������䲿�����ơ�
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
 
--��30��  ��ѯ��͹��ʴ���2500�ĸ��ֹ���
select job
  from (select min(sal) min_sal, job from emp group by job)
 where min_sal > 2500;

--��31��  ��ѯ��͹��ʵ���2000�Ĳ��ż���Ա����Ϣ��
select *
  from emp
 where deptno in
       (select distinct deptno
          from (select min(sal) min_sal, deptno from emp group by deptno)
         where min_sal < 2000);

--��32��  ��ѯ��SALES���Ź�����Ա����������Ϣ��
select ename
  from emp
 where deptno in (select deptno from dept where dname = 'SALES');
 
 select ename
   from emp
  where deptno = (select deptno from dept where dname like 'SALES');
 
--��33��  ��ѯ���ʸ��ڹ�˾ƽ�����ʵ�����Ա����Ϣ
select * from emp where sal > (select avg(sal) from emp);

--��34��  ��ѯ��SMITHԱ��������ͬ����������Ա����Ϣ
select *
  from emp
 where job in (select job from emp where ename like 'SMITH')
   and ename not like 'SMITH';

--��35��  �г����ʵ���30�Ų�����ĳ��Ա�����ʵ�����Ա���������͹���
select ename, sal
  from emp
 where sal = any (select sal from emp where deptno = 30);

--��36��  ��ѯ���ʸ���30�Ų����й���������Ա���Ĺ��ʵ�Ա�������͹���
select ename,sal from emp where sal > all(select sal from emp where deptno = 30);

--��37��  ��ѯÿ�������е�Ա��������ƽ�����ʺ�ƽ����������
select dname, empcount, avg_sal, avg_date
  from dept
  join (select count(*) empcount,
               avg(sal) avg_sal,
               avg((sysdate - hiredate) / 365) avg_date,
               deptno
          from emp
         group by deptno) t
    on dept.deptno = t.deptno;

--��38��  ��ѯ����ͬһ�ֹ�����������ͬһ���ŵ�Ա����Ϣ��
select distinct t1.empno, t1.ename, t1.deptno
  from emp t1
  join emp t2
    on t1.job like t2.job
   and t1.deptno <> t2.deptno;

--��39��  ��ѯ�������ŵ���ϸ��Ϣ�Լ���������������ƽ������
select dept.*, person_num, avg_sal
  from dept,
       (select count(*) person_num, avg(sal) avg_sal, deptno
          from emp
         group by deptno) t
 where dept.deptno = t.deptno;

--��40��  ��ѯ���ֹ�������͹���
select job, min(sal) from emp group by job;

--��41��  ��ѯ���������еĲ�ͬ���ֵ���߹���
select max(sal), job, deptno
  from emp
 group by deptno, job
 order by deptno, job;

--��42��  ��ѯ10�Ų���Ա���Լ��쵼����Ϣ��
select *
  from emp
 where empno in (select mgr from emp where deptno = 10);
    or deptno = 10;

--��43��  ��ѯ�������ŵ�������ƽ������
select deptno, count(*), avg(sal) from emp group by deptno;

--��44��  ��ѯ����Ϊĳ������ƽ�����ʵ�Ա����Ϣ
select * from emp where sal in (select avg(sal) avg_sal from emp group by deptno);

--��45��  ��ѯ���ʸ��ڱ�����ƽ�����ʵ�Ա������Ϣ
select emp.*
  from emp
  join (select deptno, avg(sal) avg_sal from emp group by deptno) t
    on emp.deptno = t.deptno
   and sal > avg_sal;
   
--��46��  ��ѯ���ʸ��ڱ�����ƽ�����ʵ�Ա������Ϣ���䲿�ŵ�ƽ������
select emp.*, avg_sal
  from emp
  join (select deptno, avg(sal) avg_sal from emp group by deptno) t
    on emp.deptno = t.deptno
   and sal > avg_sal;

--��47��  ��ѯ���ʸ���20�Ų���ĳ��Ա�����ʵ�Ա������Ϣ
select * from emp where sal > any (select sal from emp where deptno = 20);

--��48��  ͳ�Ƹ������ֵ�������ƽ������
select job, count(*), avg(sal) from emp group by job;

--��49��  ͳ��ÿ�������и������ֵ�������ƽ������
select deptno, job, count(*), avg(sal)
  from emp
 group by deptno, job
 order by deptno, job;

--��50��  ��ѯ���ʡ�������10 �Ų���ĳ��Ա�����ʡ�������ͬ��Ա������Ϣ
select emp.*
  from emp
  join (select sal, comm from emp where deptno = 10) t
    on emp.sal = t.sal
   and nvl(emp.comm, 0) = nvl(t.comm, 0)
   and emp.deptno != 10;

--��51��  ��ѯ������������5�Ĳ��ŵ�Ա������Ϣ
select *
  from emp
 where deptno in
       (select deptno from emp group by deptno having count(*) > 5);

--��52��  ��ѯ����Ա�����ʶ�����1000�Ĳ��ŵ���Ϣ
select *
  from dept
 where deptno in
       (select distinct deptno
          from emp
         where deptno not in
               (select distinct deptno from emp where sal < 1000));

--��53��  ��ѯ����Ա�����ʶ�����1000�Ĳ��ŵ���Ϣ����Ա����Ϣ
select *
  from emp
  join dept
    on dept.deptno in
       (select distinct deptno
          from emp
         where deptno not in
               (select distinct deptno from emp where sal < 1000))
   and dept.deptno = emp.deptno;

--��54��  ��ѯ����Ա�����ʶ���900~3000֮��Ĳ��ŵ���Ϣ
select *
  from dept
 where deptno in (select distinct deptno
                    from emp
                   where deptno not in
                         (select distinct deptno
                            from emp
                           where sal not between 900 and 3000));

--��55��  ��ѯ���й��ʶ���900~3000֮���Ա�����ڲ��ŵ�Ա����Ϣ��
select *
  from emp
 where deptno in (select distinct deptno
                    from emp
                   where deptno not in
                         (select distinct deptno
                            from emp
                           where sal not between 900 and 3000));

--��56��  ��ѯÿ��Ա�����쵼���ڲ��ŵ���Ϣ
select *
  from (select e1.empno, e1.ename, e1.mgr mno, e2.ename mname, e2.deptno
          from emp e1
          join emp e2
            on e1.mgr = e2.empno) t
  join dept
    on t.deptno = dept.deptno;

--��57��  ��ѯ�������Ĳ�����Ϣ
select *
  from dept
 where deptno in
       (select deptno
          from (select count(*) count, deptno from emp group by deptno)
         where count in
               (select max(count)
                  from (select count(*) count, deptno from emp group by deptno)));

--��58��  ��ѯ30�Ų����й�������ǰ3����Ա����Ϣ��
select *
  from emp
 where empno in (select empno
                   from (select empno, sal
                           from emp
                          where deptno = 30
                          order by sal desc)
                  where rownum < 4);

--��59��  ��ѯ����Ա���й�������5~10��֮���Ա����Ϣ
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

--��60��  ��emp���в���һ����¼��Ա����Ϊ1357��Ա������Ϊoracle������Ϊ2050Ԫ�����ź�Ϊ20����ְ����Ϊ2002��5��10��
insert into emp
  (empno, ename, sal, deptno, hiredate)
values
  (1357,
   'oracle',
   2050,
   20,
   to_date('2002��5��10��', 'yyyy"��"mm"��"dd"��"'));

--��61��  ��emp���в���һ����¼��Ա������ΪFAN��Ա����Ϊ8000��������Ϣ��SMITHԱ������Ϣ��ͬ
insert into emp
  select 8000, 'FAN', job, mgr, hiredate, sal, comm, deptno
    from emp
   where ename = 'SMITH';

--��62��  ��������Ա���Ĺ����޸�Ϊ��Ա�����ڲ���ƽ�����ʼ�1000��
update emp t1
   set sal =
       (select new_sal
          from (select avg(sal) + 1000 new_sal, deptno
                  from emp
                 group by deptno) t2
         where t1.deptno = t2.deptno);
         
         
--1����ѯ82��Ա��
select e.* from emp e where to_char(e.hiredate, 'yy') like '82';
select e.* from emp e where to_char(e.hiredate, 'yyyy') = '1982';

--2����ѯ32�깤�����Ա
select round(sysdate - e.hiredate) / 365, e.ename, e.hiredate
  from emp e
 where round((sysdate - e.hiredate) / 365) = 32;

--3����ʾԱ����Ӷ�� 6 ���º���һ������һ������
select next_day(add_months(e.hiredate, 6), 2) from emp e;

--4����û���ϼ���Ա������mgr���ֶ���Ϣ���Ϊ "boss"
select decode(e.mgr, null, 'boss', '�й�������') from emp e;

--5��Ϊ�������ǹ��ʣ���׼�ǣ�10���ų�10%��20���ų�15%��30���ų�20%�������ų�18%
select decode(e.deptno, 10, e.sal * 1.1, 20, e.sal * 1.15, e.sal * 1.18) �ǹ���,
       e.deptno,
       e.sal
  from emp e;
  
  
 --1��������нˮ��ߵ���
select ename, sal, emp.deptno
  from emp
  join (select deptno, max(sal) max_sal from emp group by deptno) t
    on (emp.deptno = t.deptno and emp.sal = t.max_sal);

select ename, sal, deptno
  from emp
 where sal in (select max(sal) from emp group by deptno);
 
 --2������ƽ��нˮ�ĵȼ�
select deptno, avg_sal, grade
  from (select deptno, avg(sal) avg_sal from emp group by deptno) t
  join salgrade
    on (t.avg_sal between salgrade.losal and salgrade.hisal);

--3������ƽ����нˮ�ȼ� 
select deptno, avg(grade) avg_sal_grade
  from (select deptno, grade
          from emp
          join salgrade
            on emp.sal between salgrade.losal and salgrade.hisal)
 group by deptno;
 
 --4����Ա������Щ���Ǿ����� 
select distinct e2.ename manager
  from emp e1
  join emp e2
    on e1.mgr = e2.empno;
select ename from emp where empno in (select mgr from emp);

--5����׼���麯������нˮ�����ֵ 
select distinct sal max_sal
  from emp
 where sal not in
       (select e1.sal e1_sal from emp e1 join emp e2 on e1.sal < e2.sal);
  
select * from (select * from emp order by sal desc) t where rownum < 2;

--6. ��ƽ��нˮ��ߵĲ��ŵĲ��ű�� 
select deptno, avg_sal
  from (select deptno, avg(sal) avg_sal from emp group by deptno)
 where avg_sal =
       (select max(avg_sal)
          from (select avg(sal) avg_sal from emp group by deptno));
--�麯��Ƕ��д��(�Զ����Ƕ��һ�Σ�group by ֻ���ڲ㺯����Ч) 
select deptno, avg_sal
  from (select deptno, avg(sal) avg_sal from emp group by deptno)
 where avg_sal = (select max(avg(sal)) from emp group by deptno);
 
 --7����ƽ��нˮ��ߵĲ��ŵĲ������� 
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

--8����ƽ��нˮ�ĵȼ���͵Ĳ��ŵĲ������� 
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
--9�����ž�������ƽ��нˮ��͵Ĳ�������
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
                          
--10�������ͨԱ�������нˮ��Ҫ�ߵľ���������(not in) 
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
--NOT IN����NULL�򷵻�NULL�������ų�NULLֵ

--11����нˮ��ߵ�ǰ5����Ա 
select empno, ename
  from (select * from emp order by sal desc)
 where rownum <= 5;

--12����нˮ��ߵĵ�6����10����(!important) 
select ename, sal
  from (select t.*, rownum r from (select * from emp order by sal desc) t)
 where r >= 6
   and r <= 10;

--13���������ְ��5��Ա�� 
select ename, to_char(hiredate, 'YYYY"��"MM"��"DD"��"') hiredate
  from (select t.*, rownum r
          from (select * from emp order by hiredate desc) t)
 where r <= 5;

select ename, to_char(hiredate, 'YYYY"��"MM"��"DD""') hiredate
  from (select t.*, rownum r from (select * from emp order by hiredate) t)
 where r > (select count(*) - 5 from emp);
