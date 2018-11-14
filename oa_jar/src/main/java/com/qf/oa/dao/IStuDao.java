package com.qf.oa.dao;

import com.qf.oa.entity.Student;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/10/31 15:13
 * @Version 1.0
 */
public interface IStuDao {

    Student queryOne(Integer id);

    List<Student> queryAll();
}
