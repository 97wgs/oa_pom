package com.qf.oa.service.impl;

import com.qf.oa.dao.RoleMapper;
import com.qf.oa.entity.Role;
import com.qf.oa.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/5 9:10
 * @Version 1.0
 */
@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> queryAll() {
        return roleMapper.queryAll();
    }

    @Override
    public List<Role> queryAllEid(Integer eid) {
        return roleMapper.queryAllEid(eid);
    }

    @Override
    public int addRole(Role role) {
        return roleMapper.insert(role);
    }

    @Override
    @Transactional
    public int updateResc(Integer rid, Integer[] reids) {
        roleMapper.deleteRescByRid(rid);
        roleMapper.insertRescRidInfo(rid, reids);
        return 1;
    }

    @Override
    public int deleteById(Integer id) {
        roleMapper.deleteByPrimaryKey(id);
        return 1;
    }

    @Override
    public int update(Role role) {
        roleMapper.updateByPrimaryKey(role);
        return 1;
    }
}
