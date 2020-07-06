package com.maureen.pool.hikariCP;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * HikariDataSource的不同创建方式，参考自https://github.com/brettwooldridge/HikariCP
 */
public class HikariCPTest {
    public static void main(String[] args) throws SQLException {
        /**
         * 第一种方式
         */
//        HikariConfig config = new HikariConfig();
//        config.setJdbcUrl("jdbc:mysql://localhost:3306/demo");
//        config.setUsername("root");
//        config.setPassword("123456");
//
//        HikariDataSource ds = new HikariDataSource(config);

        /**
         * 第二种方式
         */
//        HikariDataSource ds = new HikariDataSource();
//        ds.setJdbcUrl("jdbc:mysql://localhost:3306/demo");
//        ds.setUsername("root");
//        ds.setPassword("123456");

        /**
         * 第三种方式
         */
        HikariConfig config = new HikariConfig("src/com/maureen/pool/hikariCP/hikariCP.properties");
        HikariDataSource ds = new HikariDataSource(config);

        Connection connection = ds.getConnection();
        System.out.println(connection);
        connection.close();


    }
}
