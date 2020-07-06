package com.maureen.pool.c3p0;

import com.mchange.v2.c3p0.PooledDataSource;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.SQLException;

/**
 * 自定义DataSource方式获取连接
 * 以下代码是官网示例代码，因为没有写自定义的DataSource，该代码是运行不成功的
 */
public class C3P0Test3 {
    public static void main(String[] args) throws NamingException, SQLException {
        // fetch a JNDI-bound DataSource
        InitialContext ictx = new InitialContext();
        DataSource ds = (DataSource) ictx.lookup("java:comp/env/jdbc/myDataSource"); //自定义的DataSource的完全限定名

        // make sure it's a c3p0 PooledDataSource
        if (ds instanceof PooledDataSource) {
            PooledDataSource pds = (PooledDataSource) ds;
            System.err.println("num_connections: " + pds.getNumConnectionsDefaultUser());
            System.err.println("num_busy_connections: " + pds.getNumBusyConnectionsDefaultUser());
            System.err.println("num_idle_connections: " + pds.getNumIdleConnectionsDefaultUser());
            System.err.println();
        } else
            System.err.println("Not a c3p0 PooledDataSource!");
    }
}
