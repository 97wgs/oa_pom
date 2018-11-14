package com.qf.oa.service.impl;

import com.qf.oa.dao.EmployeeMapper;
import com.qf.oa.dao.RoleMapper;
import com.qf.oa.entity.Employee;
import com.qf.oa.entity.Role;
import com.qf.oa.entity.SexCount;
import com.qf.oa.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/2 9:10
 * @Version 1.0
 */
@Service
public class EmpServiceImpl implements IEmpService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private RoleMapper roleMapper;


    @Override
    public List<Employee> queryAll() {
        return employeeMapper.queryAll();
    }

    @Override
    public int saveOrUpdate(Employee employee) {
        if(employee.getId() != null || !employee.getId().equals("")){
            return employeeMapper.updateByPrimaryKeySelective(employee);
        } else {
            return employeeMapper.insert(employee);
        }
    }

    /**
     * 修改指定职工的角色信息
     * @param eid
     * @param rid
     * @return
     */
    @Override
    @Transactional
    public int updateRolesInfo(Integer eid, Integer[] rid) {
        //根据职工id，去中间表中删除所有和角色的关联
        employeeMapper.deleteEmpAndRolesInfo(eid);
        //批量添加新的角色关联
        employeeMapper.insertEmpAndRolesInfo(eid, rid);
        return 1;
    }


    @Override
    public List<Role> queryByEid(Integer eid) {
        return roleMapper.queryByEid(eid);
    }

    @Override
    public Employee login(String email, String password) {
        return employeeMapper.login(email,password);
    }

    @Override
    public int delete(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
        return 1;
    }

    @Override
    public Employee queryByEmail(String email) {
        return employeeMapper.queryByEmail(email);
    }

    @Override
    public List<Employee> queryEmpInfo(String keyword, Integer eid) {
        return employeeMapper.queryEmpInfo(keyword,eid);
    }

    @Override
    public List<Employee> countByDname() {
        return employeeMapper.queryCountByDname();
    }

    @Override
    public List<SexCount> countBySex() {
        return employeeMapper.queryCountBySex();
    }
}
