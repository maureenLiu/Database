--事务：表示操作集合，不可分割，要么全部成功，要么全部失败

--事务的开始取决于一个DML(insert,delete,update)语句
/*
事务的结束
  1、正常的commit(使数据修改生效)或者rollback(将数据恢复到上一个状态)
  2、自动提交，但是一般情况下要将自动提交关闭，因为效率太低
  3、用户关闭会话后，会自动提交事务
  4、系统崩溃或断电的时候会回滚事务，也就是将数据恢复到上一个状态
*/
insert into emp(empno,ename) values(1111,'zhangsan');
commit;
rollback;
select * from emp;


--savepoint：保存点
--当一个操作集合中，包含多条sql语句，但是只想让其中某部分成功，某部分失败，此时可以使用保存
--此时如果需要回滚到某个状态的话，使用rollback to sp1(sp1是保存点的名称)
delete from emp where empno = 1111;
delete from emp where empno = 2222;
savepoint sp1;
delete from emp where empno = 3333; --不会执行成功
rollback to sp1;
commit;

/*
事务的四个特性：ACID
     原子性：表示不可分割，一个操作集合要么全部成功，要么全部失败，不可以从中间切分
     一致性：最终是为了保证数据的一致性，当经过N多个操作之后，数据的状态不会改变(转账)
            从一个一致性状态到另一个一致性状态，也就是数据不可以发生错乱
     隔离性：各个事务之间相互不会产生影响，(隔离级别)
            严格的隔离性会导致效率降低，在某些情况下为了提高程序的执行效率，需要降低隔离级别
            隔离级别：
                读未提交
                读已提交
                可重复读
                序列化
               数据不一致的问题：
                      脏读
                      不可重复读
                      幻读
     持久性：所有数据的修改都必须要持久化到存储介质中，不会因为应用程序的关闭而导致数据丢失
     
     四个特性中，哪个是最关键的？
          所有的特性中，都是为了保证数据的一致性，所以一致性是最终的追求。事务中的一致性是通过原子性、隔离性和持久性来保证的。
     锁的机制：
          为了解决在并发访问的时候数据不一致的问题，需要给数据加锁
          加锁的同时需要考虑粒度的问题：
                      操作的对象：数据库、表、行
          一般情况下，锁的粒度越小，效率越高；粒度越大，效率越低。
          在实际的工作环境中，大部分的操作都是行级锁。
*/
