package com.qf.oa.service.impl;

import com.qf.oa.dao.RescMapper;
import com.qf.oa.entity.Resc;
import com.qf.oa.service.IRescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/5 14:12
 * @Version 1.0
 */
@Service
public class RescServiceImpl implements IRescService {

    @Autowired
    private RescMapper rescMapper;

    @Override
    public List<Resc> queryAll() {
        return rescMapper.queryAll();
    }

    @Override
    public List<Resc> queryAllRid(Integer rid) {
        return rescMapper.queryAllRid(rid);
    }

    @Override
    public int insert(Resc resc) {
        return rescMapper.insert(resc);
    }

    @Override
    public int delete(Integer id) {
        rescMapper.deleteByPrimaryKey(id);
        return 1;
    }
}
