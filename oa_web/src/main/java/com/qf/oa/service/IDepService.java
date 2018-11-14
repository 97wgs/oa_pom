package com.qf.oa.service;

import com.qf.oa.entity.Department;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/1 10:19
 * @Version 1.0
 */
public interface IDepService {

    List<Department> queryAll();

    int insert(Department department);

    int delete(Integer did);

    int update(Department dep);

    HSSFWorkbook export();

}
