package com.qf.oa.controller;

import com.qf.oa.entity.Student;
import com.qf.oa.service.IStuService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/10/31 15:05
 * @Version 1.0
 */
@Controller
@RequestMapping("/stu")
public class StuController extends BaseController {

    @Autowired
    private IStuService stuService;

    @RequestMapping("/queryall")
    public String queryAll(Model model, Page page){
        List<Student> students = stuService.queryAll();
        model.addAttribute("stus", students);
        return "stulist";
    }
}
