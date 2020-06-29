package com.maureen.dao.impl;

import com.maureen.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BatchDaoImpl {
    public static void main(String[] args) {
        /**
         * 对比批处理插入数据的方式和 单条插入数据的方式耗时
         */
        long start = System.currentTimeMillis();
        insertBatch();
        System.out.println(System.currentTimeMillis() - start); //1236ms

        System.out.println("--------");
        long start2 = System.currentTimeMillis();
        for(int i = 101 ; i < 201; i++) {
            insert(i, "maureen"+i);
        }
        System.out.println(System.currentTimeMillis() - start2); //1882ms
    }

    /**
     * 批处理
     */
    public static  void insertBatch() {
        Connection connection = DBUtil.getConnection();
        PreparedStatement pstmt = null;
        String sql = "insert into emp(empno,ename) values(?,?)";
        //准备预处理块对象
        try {
            pstmt = connection.prepareStatement(sql);
            for(int i = 0; i < 100; i++) {
                pstmt.setInt(1, i);
                pstmt.setString(2,"maureen" + i);
                //向批处理中添加sql语句
                pstmt.addBatch();
            }
            int[] ints = pstmt.executeBatch();
//            for (int anInt : ints) {
//                System.out.println(anInt);
//            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, pstmt);
        }
    }

    /**
     * 每次插入一条，连续插入100条数据
     * 涉及到了数据库频繁的建立连接和断开连接，更加耗时
     */
    public static  void insert(int empno, String name) {
        Connection connection = DBUtil.getConnection();
        PreparedStatement pstmt = null;
        String sql = "insert into emp(empno,ename) values(?,?)";
        //准备预处理块对象
        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, empno);
            pstmt.setString(2,name);
            int i = pstmt.executeUpdate();
//            System.out.println(i);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, pstmt);
        }
    }
}
