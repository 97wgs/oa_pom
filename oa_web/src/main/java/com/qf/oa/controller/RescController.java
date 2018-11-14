package com.qf.oa.controller;

import com.qf.oa.entity.Resc;
import com.qf.oa.service.IRescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/5 14:11
 * @Version 1.0
 */
@Controller
@RequestMapping("/resc")
public class RescController  {

    @Autowired
    private IRescService rescService;

    @RequestMapping("/list")
    public String rescList(Model model){
        List<Resc> rescs = rescService.queryAll();
        model.addAttribute("rescs", rescs);
        return "resclist";
    }

    @RequestMapping("/listajax")
    @ResponseBody
    public List<Resc> rescListAjax(){
        List<Resc> rescs = rescService.queryAll();
        return rescs;
    }

    @RequestMapping("/listajax2")
    @ResponseBody
    public List<Resc> rescListAjax2(Integer rid){
        List<Resc> rescs = rescService.queryAllRid(rid);
        System.out.println(rescs);
        return rescs;
    }

    @RequestMapping("/add")
    public String insert(Resc resc){
        rescService.insert(resc);
        return "redirect:/resc/list";
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id){
        rescService.delete(id);
        return "redirect:/resc/list";
    }
}
