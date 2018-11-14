package com.qf.oa.entity;

import java.io.Serializable;

/**
 * @Author ${user}
 * @Time 2018/11/8 0008 14:21
 * @Version 1.0
 */
public class SexCount implements Serializable {

    private Integer sex;
    private Integer sexCount;

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public Integer getSexCount() {
        return sexCount;
    }

    public void setSexCount(Integer sexCount) {
        this.sexCount = sexCount;
    }

    @Override
    public String toString() {
        return "SexCount{" +
                "sex=" + sex +
                ", sexCount=" + sexCount +
                '}';
    }
}
