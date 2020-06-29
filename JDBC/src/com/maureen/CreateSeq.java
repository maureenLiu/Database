package com.maureen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class CreateSeq {
    public static void main(String[] args) throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection =DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
        Statement statement = connection.createStatement();
        String sql = "create sequence seq_q increment by 1 start with 1";
        boolean execute = statement.execute(sql);
        System.out.println(execute);
        statement.close();
        connection.close();
    }
}
