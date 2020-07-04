package com.maureen.apacheDBUtils;

import com.maureen.entity.Emp;
import com.maureen.util.MySqlDBUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class DBUtilTest {

    public static Connection connection;

    /**
     * 查询单条数据
     * BeanHander代表一个对象
     * @throws SQLException
     */
    public static void testQuery() throws SQLException {
        connection = MySqlDBUtil.getConnection();
        String sql = "select * from emp where empno =?";
        QueryRunner runner = new QueryRunner();
        Emp query = runner.query(connection, sql, new BeanHandler<Emp>(Emp.class), 7369);
        System.out.println(query);
        connection.close();
    }

    /**
     * 查询结果集
     * @throws SQLException
     */
    public static void testList() throws SQLException {
        connection = MySqlDBUtil.getConnection();
        String sql = "select * from emp";
        QueryRunner runner = new QueryRunner();
        List<Emp> query = runner.query(connection, sql, new BeanListHandler<Emp>(Emp.class));
        for(Emp emp: query) {
            System.out.println(emp);
        }
        connection.close();
    }

    public static void main(String[] args) throws SQLException {
        //testQuery();
        testList();
    }
}
