--������ѯ
/*
select t1.c1,t2.c2 
from t1,t2
where t1.c3 = t2.c4
�ڽ������ӵ���ż������ʹ�õ�ֵ���ӣ�����ʹ�÷ǵ�ֵ����
*/
--��ѯ��Ա�����ƺͲ��ŵ�����
select ename,dname from emp,dept where emp.deptno = dept.deptno;
select * from emp,dept where emp.deptno = dept.deptno;
--��ѯ��Ա�����Լ��Լ���нˮ�ȼ�
select e.ename,e.sal,sg.grade from emp e,salgrade sg where e.sal between sg.losal and sg.hisal;

--��ֵ���ӣ��������а�����ͬ������
--�ǵ�ֵ���ӣ���������û����ͬ������������ĳһ��������һ�ű���еķ�Χ֮��
--������
select * from emp;
select * from dept;
--��Ҫ����Ա���е��������ݶ�������ʾ,���õ�ֵ���ӵĻ�ֻ��ѹ�������������ʾ
--û�й����������ݲ�����ʾ����ʱ��Ҫ������
--���ࣺ��������(������ȫ��������ʾ������������(���ұ��ȫ��������ʾ��
select * from emp e,dept d where e.deptno = d.deptno;   --��ֵ����
select * from emp e,dept d where e.deptno = d.deptno(+);  --��������
select * from emp e,dept d where e.deptno(+) = d.deptno;  --��������
--�����ӣ���һ�ű��ɲ�ͬ�ı����������Լ������Լ�
--���ӣ�����Ա������������Ʋ����
select e.ename,m.ename from emp e, emp m where e.mgr = m.empno;
--�ѿ����������������ű����ǲ�ָ������������ʱ�򣬻���еѿ���������������ܼ�¼����ΪM*N,һ�㲻Ҫʹ��
select * from emp e,dept d;

--92�ı������﷨���ڵ����⣺
--��92�﷨�У����ű������������ŵ�where�Ӿ��У�ͬʱwhere��Ҫ�Ա������������
--����൱�ڽ��������������������ൽһ��̫�ң��Ӷ�������99�﷨
