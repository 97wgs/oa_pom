package com.qf.oa.service.impl;

import com.qf.oa.dao.IStuDao;
import com.qf.oa.entity.Student;
import com.qf.oa.service.IStuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/10/31 15:02
 * @Version 1.0
 */
@Service
public class StuServiceImpl implements IStuService {

    @Autowired
    private IStuDao stuDao;

    @Override
    public List<Student> queryAll() {
        return stuDao.queryAll();
    }
}
