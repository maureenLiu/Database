package com.maureen.pool.c3p0;

import com.mchange.v2.c3p0.DataSources;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * 使用工厂方法的方式获取连接
 * <p>
 * 不可以往里面添加参数的写法：
 * DataSource ds_unpooled = DataSources.unpooledDataSource("jdbc:mysql://localhost:3306/demo","root","123456");
 * DataSource ds_pooled = DataSources.pooledDataSource(ds_unpooled);
 * <p>
 * 可以往里面添加参数的写法：
 * DataSource ds_unpooled = DataSources.unpooledDataSource("jdbc:mysql://localhost:3306/demo","root","123456");
 * Map overrides = new HashMap();
 * overrides.put("maxStatements", "200");
 * overrides.put("maxPoolSize", new Integer(50));
 * DataSource ds_pooled = DataSources.pooledDataSource(ds_unpooled, overrides);
 */
public class C3P0FactoryTest {
    public static void main(String[] args) throws SQLException {
        DataSource ds_unpooled = DataSources.unpooledDataSource("jdbc:mysql://localhost:3306/demo",
                "root",
                "123456");
        //无法往里面添加参数
//        DataSource ds_pooled = DataSources.pooledDataSource(ds_unpooled);

        Map overrides = new HashMap();
        overrides.put("maxStatements", "200");         //Stringified property values work
        overrides.put("maxPoolSize", new Integer(50)); //"boxed primitives" also work
        // create the PooledDataSource using the default configuration and our overrides
        //可以往里面添加参数值
        DataSource ds_pooled = DataSources.pooledDataSource(ds_unpooled, overrides);

        Connection connection = ds_pooled.getConnection();
        System.out.println(connection);
        connection.close();
    }
}
