package com.maureen.reflect;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class ClassAPI {
    public static void main(String[] args) throws Exception {
        //创建Class对象
        Class<?> clazz = Class.forName("com.maureen.reflect.Student");

        //===========获取成员变量===========================
        // 1. getFields：包括子类及父类，同时只能包含public的属性
        Field[] fields = clazz.getFields();
        for (Field field : fields) {
            System.out.println(field);
            System.out.println(field.getName());
            System.out.println(field.getType());
            System.out.println(field.getModifiers());
            System.out.println("---------");
        }
        //2.getDeclaredFields：此方法返回的是当前类的所有属性，不仅仅局限于public类型，所有的访问修饰类型都可以获取
        System.out.println("1====================");
        Field[] declaredFields = clazz.getDeclaredFields();//className和address
        for (Field field : declaredFields) {
            System.out.println(field.getName());
        }
        //3.getDeclaredField(name):获取指定的属性
        System.out.println("2===================");
        //反射在一定程度上破坏了封装性，需要合理使用
        Field address = clazz.getDeclaredField("address");
        //设置该属性是否能被访问，true表示能被访问，破坏了封装性
        address.setAccessible(true);
        System.out.println(address.getName());
        //给属性设置值
        Object o = clazz.newInstance();
        address.set(o, "北京市"); //如果没有address.setAccessible(true)会报错
        System.out.println(((Student) o).getAddress());

        //=====================获取成员方法============================
        //1. getMethods：获取该对象的普通方法,包含的方法范围是当前对象及父类（包含了Person和Object类)对象的所有public方法
        System.out.println("3===================");
        Method[] methods = clazz.getMethods();
        for (Method method : methods) {
            System.out.println(method.getName());
        }
        //2.getDeclaredMethods：获取当前类中的所有方法，无论什么访问修饰符
        System.out.println("---------");
        Method[] declaredMethods = clazz.getDeclaredMethods();
        for (Method method : declaredMethods) {
            System.out.println(method.getName());
        }
        //3.getDeclaredMethod(name, Class<?> ...): 获取指定的方法
        System.out.println("---------");
        Method add = clazz.getDeclaredMethod("add", int.class, int.class);
        add.setAccessible(true);
        Object o1 = clazz.newInstance();
        add.invoke(o1, 123, 123);//调用add方法

        //==========================获取构造方法===========================
        //1. getConstructors：获取对象的public的构造方法
        System.out.println("-------------------");
        Constructor<?>[] constructors = clazz.getConstructors();
        for (Constructor<?> constructor : constructors) {
            System.out.println(constructor.getName());
        }
        //2. getDeclaredConstructors：获取对象的所有构造方法，无论是私有还是公有
        System.out.println("------------------");
        Constructor<?>[] declaredConstructors = clazz.getDeclaredConstructors();
        for (Constructor<?> constructor : declaredConstructors) {
            System.out.println(constructor.getName());
        }
        //3. getDeclaredConstructor(Class<?> ...)：获取指定参数的构造方法
        //如何调用私有的构造方法
        Constructor<?> declaredConstructor = clazz.getDeclaredConstructor(String.class, int.class, String.class);
        declaredConstructor.setAccessible(true);
        Object o2 = (Student) declaredConstructor.newInstance("maureen", 18, "java");
        System.out.println(o2);
    }
}
