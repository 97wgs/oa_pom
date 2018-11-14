package com.qf.oa.controller;

import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * @Author ${user}
 * @Time 2018/11/8 0008 18:47
 * @Version 1.0
 */
@ControllerAdvice
public class CommonController {

    @ExceptionHandler(UnauthorizedException.class)
    public String excption(UnauthorizedException e){
        System.out.println("权限不够"+ e.getMessage());
        return "erro";
    }

}
