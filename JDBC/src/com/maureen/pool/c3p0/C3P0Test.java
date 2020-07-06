package com.maureen.pool.c3p0;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 使用ComboPooledDataSource获取连接
 */
public class C3P0Test {
    public static Connection connection;
    public static ComboPooledDataSource dataSource;

    public static void getConnection() {
        dataSource = new ComboPooledDataSource();
    }

    public static void queryData() {
        try {
            connection = dataSource.getConnection();
            String sql = "select * from emp";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString("ename"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


    public static void main(String[] args) throws PropertyVetoException, SQLException {
        /**
         * 直接在类的方法中设置连接的参数，一般没人使用，最好使用配置文集
         */
//        ComboPooledDataSource cpds = new ComboPooledDataSource();
//        cpds.setDriverClass("com.mysql.jdbc.Driver"); //loads the jdbc driver
//        cpds.setJdbcUrl("jdbc:mysql://localhost:3306/demo");
//        cpds.setUser("root");
//        cpds.setPassword("123456");
//        //获取连接
//        Connection connection = cpds.getConnection();
//        System.out.println(connection);
//        connection.close();
        //查询数据
        getConnection();
        queryData();

    }
}
