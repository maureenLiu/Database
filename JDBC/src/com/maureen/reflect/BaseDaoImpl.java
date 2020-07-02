package com.maureen.reflect;

import com.maureen.entity.Dept;
import com.maureen.entity.Emp;
import com.maureen.util.DBUtil;
import com.sun.xml.internal.ws.api.model.MEP;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * 想查询N张表的数据，但是不想写N多的方法，能否写一个方法完成所有表的查询工作
 */
public class BaseDaoImpl {
    /**
     * 统一的查询表的方法
     *
     * @param sql    不同的sql语句
     * @param params sql语句的参数
     * @param clazz  sql语句查询返回的对象
     * @return
     */
    public List getRows(String sql, Object[] params, Class clazz) {
        List list = new ArrayList();
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
            //建立连接
            connection = DBUtil.getConnection();
            //创建pstmt对象
            pstmt = connection.prepareStatement(sql);
            //给sql语句填充参数
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i + 1, params[i]);
                }
            }
            //开始执行查询操作,resultSet中有返回的结果，需要将返回的结果放置到不同的对象中该
            resultSet = pstmt.executeQuery();
            //获取结果集合的元数据对象
            ResultSetMetaData metaData = resultSet.getMetaData();
            //判断查询到的每一行记录中包含多少个列
            int columnCount = metaData.getColumnCount();
            //循环遍历resultSet
            while (resultSet.next()) {
                //创建放置具体结果属性的对象
                Object obj = clazz.newInstance();
                for (int i = 0; i < columnCount; i++) {
                    //从结果集合中获取单一列的值
                    Object objValue = resultSet.getObject(i + 1);
                    //获取列的名称
                    String columnName = metaData.getColumnName(i + 1).toLowerCase();
                    //获取类中的属性
                    Field declaredField = clazz.getDeclaredField(columnName);
                    //获取类中属性对应的set方法
                    Method method = clazz.getMethod(getSetName(columnName), declaredField.getType());
                    if (objValue instanceof Number) {
                        Number number = (Number) objValue;
                        String fname = declaredField.getType().getName();
                        if ("int".equals(fname) || "java.lang.Integer".equals(fname)) {
                            method.invoke(obj, number.intValue());
                        } else if ("byte".equals(fname) || "java.lang.Byte".equals(fname)) {
                            method.invoke(obj, number.byteValue());
                        } else if ("short".equals(fname) || "java.lang.Short".equals(fname)) {
                            method.invoke(obj, number.shortValue());
                        } else if ("long".equals(fname) || "java.lang.Long".equals(fname)) {
                            method.invoke(obj, number.longValue());
                        } else if ("float".equals(fname) || "java.lang.Float".equals(fname)) {
                            method.invoke(obj, number.floatValue());
                        } else if ("double".equals(fname) || "java.lang.Double".equals(fname)) {
                            method.invoke(obj, number.doubleValue());
                        }
                    } else {
                        method.invoke(obj, objValue);
                    }
                }
                list.add(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(connection, pstmt, resultSet);
        }
        return list;
    }

    public String getSetName(String name) {
        //结果为setXxx
        return "set" + name.substring(0, 1).toUpperCase() + name.substring(1);
    }

    public static void main(String[] args) {
        BaseDaoImpl baseDao = new BaseDaoImpl();

        System.out.println("===========查询emp表：");
        //测试：查询emp表中的数据
        String sql1 = "select empno, ename, deptno from emp where deptno = ?";
        List rows1 = baseDao.getRows(sql1, new Object[]{10}, Emp.class);
        for(Iterator it = rows1.iterator(); it.hasNext(); ) {
            Emp emp = (Emp) it.next();
            System.out.println(emp);
        }

        System.out.println("===========查询dept表：");
        //测试：查询dept表中的数据
        String sql2 = "select deptno, dname, loc from dept";
        List rows2 = baseDao.getRows(sql2, new Object[]{}, Dept.class);
        for(Iterator it = rows2.iterator(); it.hasNext(); ) {
            Dept dept = (Dept) it.next();
            System.out.println(dept);
        }
    }
}
