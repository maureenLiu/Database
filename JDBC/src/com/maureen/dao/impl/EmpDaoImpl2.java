package com.maureen.dao.impl;

import com.maureen.dao.EmpDao;
import com.maureen.entity.Emp;
import com.maureen.util.DBUtil;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * 使用PrepareStatement替换Statement，可以避免sql注入
 * 不再拼接sql语句，而是在sql语句中使用“？”替代直接赋值，PrepareStatement.setXXX函数设置值
 */

public class EmpDaoImpl2 implements EmpDao {
    /**
     * 当插入数据的时候，要注意属性类型的匹配
     * 1、Date
     * 2、String类型在拼接sql的死后必须要添加''
     *
     * @param emp
     */
    @Override
    public void insert(Emp emp) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            connection = DBUtil.getConnection();
            //设置事务是否自动提交，true表示自动提交，false表示不自动提交
//            connection.setAutoCommit(true);

            //String sql = "insert into emp values(?,?,?,?,to_date(?,'YYYY-MM-DD'), ?, ?, ?)";
            String sql = "insert into emp values(?,?,?,?,?,?,?,?)";
            pstmt = connection.prepareStatement(sql);
            //向问号中添加值
            pstmt.setInt(1, emp.getEmpno());
            pstmt.setString(2, emp.getEname());
            pstmt.setString(3, emp.getJob());
            pstmt.setInt(4, emp.getMgr());
            //pstmt.setString(5,emp.getHiredate());
            //如果sql语句中的第5个问号没有to_date函数，那么就使用setDate
            pstmt.setDate(5, new Date(new SimpleDateFormat("yyyy-MM-DD").parse(emp.getHiredate()).getTime()));
            pstmt.setDouble(6, emp.getSal());
            pstmt.setDouble(7, emp.getComm());
            pstmt.setInt(8, emp.getDeptno());
            System.out.println(sql);
            //返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数是：" + i);
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, pstmt);
        }
    }

    @Override
    public void delete(Emp emp) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            connection = DBUtil.getConnection();
            //设置事务是否自动提交，true表示自动提交，false表示不自动提交
//            connection.setAutoCommit(true);

            String sql = "delete from emp where empno = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, emp.getEmpno());
            System.out.println(sql);
            //返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数是：" + i);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, pstmt);
        }
    }

    @Override
    public void update(Emp emp) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            connection = DBUtil.getConnection();
            //设置事务是否自动提交，true表示自动提交，false表示不自动提交
            connection.setAutoCommit(true);

            //拼接sql语句
            String sql = "update emp set job = ? where empno = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, emp.getJob());
            pstmt.setInt(2, emp.getEmpno());
            System.out.println(sql);
            //返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数是：" + i);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, pstmt);
        }
    }

    @Override
    public Emp getEmpByEmpno(Integer empno) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        Emp emp = null;
        try {
            connection = DBUtil.getConnection();
            //设置事务是否自动提交，true表示自动提交，false表示不自动提交
            connection.setAutoCommit(true);
            statement = connection.createStatement();
            //拼接sql语句
            String sql = "select * from emp where empno = " + empno;
            System.out.println(sql);
            //返回值表示受影响的行数
            resultSet = statement.executeQuery(sql);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while (resultSet.next()) {
                emp = new Emp(resultSet.getInt("empno"), resultSet.getString("ename"), resultSet.getString("job"),
                        resultSet.getInt("mgr"), sdf.format(resultSet.getDate("hiredate")), resultSet.getDouble("sal"),
                        resultSet.getDouble("comm"), resultSet.getInt("deptno"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, statement, resultSet);
        }
        return emp;
    }

    @Override
    public Emp getEmpByEname(String name) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        Emp emp = null;
        try {
            connection = DBUtil.getConnection();
            //设置事务是否自动提交，true表示自动提交，false表示不自动提交
            connection.setAutoCommit(true);
            String sql = "select * from emp where ename = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, name);
            System.out.println(sql);
            //返回值表示受影响的行数
            resultSet = pstmt.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            //如果数据库中的字段存在null值，则会出现空指针异常
            while (resultSet.next()) {
                emp = new Emp(resultSet.getInt("empno"), resultSet.getString("ename"), resultSet.getString("job"),
                        resultSet.getInt("mgr"), sdf.format(resultSet.getDate("hiredate")), resultSet.getDouble("sal"),
                        resultSet.getDouble("comm"), resultSet.getInt("deptno"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, pstmt, resultSet);
        }
        return emp;
    }


    public static void main(String[] args) {
        EmpDao empDao = new EmpDaoImpl2();
        Emp emp = new Emp(3333, "sisi", "sales", 1111, "2020-06-28", 1500.0, 500.0, 10);
        System.out.println("---insert result:");
        empDao.insert(emp);
        System.out.println("---delete result:");
        empDao.delete(emp);
        System.out.println("=--update result:");
        empDao.update(emp);
        System.out.println("=--getEmpByEmpno:");
        Emp emp2 = empDao.getEmpByEmpno(7369);
        System.out.println(emp2);
        System.out.println("=--sql注入的查询result:");
        //sql注入
        Emp emp3 = empDao.getEmpByEname("'SMITH' or 1 = 1");
        System.out.println(emp3);
        /**
         * 如果使用Statement，上述两行代码打印结果为：
         * select * from emp where ename = ?
         * null
         * 即没查到数据
         */
        System.out.println("避免sql注入的查询result：");
        Emp emp4 = empDao.getEmpByEname("SMITH");
        System.out.println(emp4);
        /**
         * 使用了PrepareStatement执行结果：
         * select * from emp where ename = ?
         * Emp{empno=7369, ename='SMITH', job='CLERK', mgr=7902, hiredate=1980-12-17, comm=0.0, deptno=20}
         */
    }
}
