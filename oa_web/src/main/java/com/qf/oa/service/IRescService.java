package com.qf.oa.service;

import com.qf.oa.entity.Resc;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/5 14:11
 * @Version 1.0
 */
public interface IRescService {

    List<Resc> queryAll();

    List<Resc> queryAllRid(Integer rid);

    int insert(Resc resc);

    int delete(Integer id);
}
