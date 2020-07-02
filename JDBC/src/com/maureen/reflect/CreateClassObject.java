package com.maureen.reflect;

import com.maureen.entity.Emp;

public class CreateClassObject {
    public static void main(String[] args) {
        //1、通过Class.forName()来获取Class对象
        try {
            Class clazz = Class.forName("com.maureen.entity.Emp");
            System.out.println(clazz.getPackage()); //package com.maureen.entity
            System.out.println(clazz.getName());  //com.maureen.entity.Emp
            System.out.println(clazz.getSimpleName()); //Emp
            System.out.println(clazz.getCanonicalName()); //com.maureen.entity.Emp
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        //2、通过类名.class来获取
        Class<Emp> clazz1 = Emp.class;
        System.out.println(clazz1.getPackage()); //package com.maureen.entity
        System.out.println(clazz1.getName());  //com.maureen.entity.Emp
        System.out.println(clazz1.getSimpleName()); //Emp
        System.out.println(clazz1.getCanonicalName()); //com.maureen.entity.Emp

        //3、通过对象的getClass()函数来获取
        Class clazz2 = new Emp().getClass();
        System.out.println(clazz2.getPackage()); //package com.maureen.entity
        System.out.println(clazz2.getName());  //com.maureen.entity.Emp
        System.out.println(clazz2.getSimpleName()); //Emp
        System.out.println(clazz2.getCanonicalName()); //com.maureen.entity.Emp

        //4、如果是基本数据类型，可以通过TYPE属性来获取Class对象
        Class<Integer> type = Integer.TYPE;
        System.out.println(type.getName());
        System.out.println(type.getCanonicalName());

    }
}
