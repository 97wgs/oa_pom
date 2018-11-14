package com.qf.oa.controller;

import com.google.gson.Gson;
import com.qf.oa.entity.Employee;
import com.qf.oa.entity.ResultInfo;
import com.qf.oa.entity.Role;
import com.qf.oa.entity.SexCount;
import com.qf.oa.service.IEmpService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/2 9:09
 * @Version 1.0
 */
@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController {

    @Autowired
    private IEmpService empService;


    @RequestMapping("/list")
    public String empList(Model model, Page page){
        List<Employee> employees = empService.queryAll();
        model.addAttribute("emps", employees);
        return "emplist";
    }

    @RequiresPermissions("/emp/saveorupdate")
    @RequestMapping("/saveorupdate")
    public String saveOrUpdate(Employee employee){
        empService.saveOrUpdate(employee);
        return "redirect:/emp/list";
    }

    /**
     * 修改角色信息
     * @return
     */
    @RequiresPermissions("/emp/updateroles")
    @RequestMapping("/updateroles")
    public String updateRoles(Integer eid, Integer[] rid){
        empService.updateRolesInfo(eid, rid);
        return "redirect:/emp/list";
    }

    /**
     * 根据职工id查询该职工拥有的角色
     * @param eid
     * @return
     */
    @RequestMapping("/queryRolesInfo")
    @ResponseBody
    public List<Role> queryRolesInfo(Integer eid){
        List<Role> roles = empService.queryByEid(eid);
        return roles;
    }

    @RequiresPermissions("/emp/delete/*")
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id){
        empService.delete(id);
        return "redirect:/emp/list";
    }

    /**
     * 查询职工的信息
     * @return
     */
    @RequestMapping("/queryinfo")
    @ResponseBody
    public ResultInfo queryEmpInfo(String keyword, @SessionAttribute("loginuser") Employee employee){

        System.out.println("关键字：" + keyword);

        List<Employee> employees = empService.queryEmpInfo(keyword, employee.getId());
        //将List<Employee> -> ResultInfo
        ResultInfo resultInfo = new ResultInfo();
        List<ResultInfo.Info> infos = new ArrayList<>();
        for (Employee employee1 : employees) {
            System.out.println("--->" + employee1);
            ResultInfo.Info info = new ResultInfo.Info();
            info.setValue(employee1.getName() + "(" + employee1.getEmail() + ")");//在页面上显示的内容 姓名(邮箱)
            info.setData(employee1.getEmail());//需要传输的内容
            infos.add(info);
        }
        resultInfo.setSuggestions(infos);
        return resultInfo;
    }

    /**
     * 统计职工
     */
    @RequestMapping("/count")
    public String countByName(Model model){
        //根据姓名统计
        List<Employee> list = empService.countByDname();
        model.addAttribute("list",list);
        String[] dnames = new String[list.size()];
        int[] counts = new int[list.size()];
        for (int i = 0;i<list.size();i++){
            dnames[i] = list.get(i).getDname();
            counts[i] = list.get(i).getNumber();
        }
        Gson gson = new Gson();
        String names = gson.toJson(dnames);
        String numbers = gson.toJson(counts);
        model.addAttribute("dnames",names);
        model.addAttribute("counts",numbers);
        //根据性别统计
        List<SexCount> sexCounts = empService.countBySex();
        for (SexCount sexCount : sexCounts) {
            if (sexCount.getSex()==1){
                model.addAttribute("man",sexCount.getSexCount());
            }else {
                model.addAttribute("woman",sexCount.getSexCount());
            }
        }
        return "empcount";
    }
}
