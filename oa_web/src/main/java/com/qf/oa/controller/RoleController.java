package com.qf.oa.controller;

import com.qf.oa.entity.Role;
import com.qf.oa.service.IRoleService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import com.sun.xml.internal.bind.v2.model.core.ID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/5 9:08
 * @Version 1.0
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    @Autowired
    private IRoleService roleService;

    @RequestMapping("/list")
    public String roleList(Model model, Page page){
        List<Role> roles = roleService.queryAll();
        model.addAttribute("roles", roles);
        return "rolelist";
    }


    @RequestMapping("/add")
    public String insert(Role role){
        roleService.addRole(role);
        return "redirect:/role/list";
    }

    @RequestMapping("/updateresc")
    @ResponseBody
    public Integer updateResc(Integer rid, Integer[] reids){
        roleService.updateResc(rid, reids);
        return 1;
    }

    /**
     * 方案一
     * @return
     */
    @RequestMapping("/listajax")
    @ResponseBody
    public List<Role> roleListAjax(){
        List<Role> roles = roleService.queryAll();
        return roles;
    }

    /**
     * 方案二
     * @return
     */
    @RequestMapping("/listajax2")
    @ResponseBody
    public List<Role> roleListAjax2(Integer eid){
        List<Role> roles = roleService.queryAllEid(eid);
        System.out.println("--->" + roles);
        return roles;
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id){
        roleService.deleteById(id);
        return "redirect:/role/list";
    }

    @RequestMapping("update")
    public String update(Role role){
        roleService.update(role);
        return "redirect:/role/list";
    }

}
