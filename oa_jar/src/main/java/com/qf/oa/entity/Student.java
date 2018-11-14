package com.qf.oa.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author ken
 * @Time 2018/10/31 15:11
 * @Version 1.0
 */
@Setter
@Getter
@ToString
@EqualsAndHashCode
public class Student {

    private Integer id;
    private String name;
    private Integer age;

    public static void main(String[] args) {
        Date a = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Object b = a;
        String format = dateFormat.format(b);
        System.out.println(format);
    }
}
