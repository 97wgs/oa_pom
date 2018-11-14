package com.qf.oa.service;

import com.qf.oa.entity.Role;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/5 9:10
 * @Version 1.0
 */
public interface IRoleService {

    List<Role> queryAll();

    List<Role> queryAllEid(Integer eid);

    int addRole(Role role);

    int updateResc(Integer rid, Integer[] reids);

    int deleteById(Integer id);

    int update(Role role);
}
