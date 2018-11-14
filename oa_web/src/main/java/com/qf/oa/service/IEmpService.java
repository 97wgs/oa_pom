package com.qf.oa.service;

import com.qf.oa.entity.Employee;
import com.qf.oa.entity.Role;
import com.qf.oa.entity.SexCount;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/2 9:10
 * @Version 1.0
 */
public interface IEmpService {

    List<Employee> queryAll();

    int saveOrUpdate(Employee employee);

    int updateRolesInfo(Integer eid, Integer[] rid);

    List<Role> queryByEid(Integer eid);

    Employee login(String email, String password);

    int delete(Integer id);

    Employee queryByEmail(String email);

    List<Employee> queryEmpInfo(String keyword, Integer eid);

    List<Employee> countByDname();

    List<SexCount> countBySex();
}
