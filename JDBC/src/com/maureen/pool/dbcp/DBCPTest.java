package com.maureen.pool.dbcp;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBCPTest {
    public static void main(String[] args) {
        //数据库连接池资源，之后的操作只需要从池中获取即可
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/demo");
        dataSource.setUsername("root");
        dataSource.setPassword("123456");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = dataSource.getConnection();
            String sql = "select * from emp";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                System.out.println(resultSet.getString("ename"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close(); //并不会关闭连接，而是将连接放回连接池中
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

//        try {
//            //关闭连接池，但是通常都是不关的
//            dataSource.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
    }
}
