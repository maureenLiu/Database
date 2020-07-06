package com.maureen.pool.druid;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.util.Properties;

public class DruidTest {
    public static void main(String[] args) throws Exception {
//        DruidDataSource dataSource = new DruidDataSource();

        Properties properties = new Properties();
        //从文件中读取配置信息
        FileInputStream fileInputStream = new FileInputStream("src/com/maureen/pool/druid/druid.properties");
        //加载配置文件属性
        properties.load(fileInputStream);

        DataSource dataSource = DruidDataSourceFactory.createDataSource(properties);
        Connection connection = dataSource.getConnection();
        System.out.println(connection);
        connection.close();
    }
}
