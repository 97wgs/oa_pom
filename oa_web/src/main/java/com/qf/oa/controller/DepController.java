package com.qf.oa.controller;

import com.qf.oa.entity.Department;
import com.qf.oa.service.IDepService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/1 10:13
 * @Version 1.0
 */
@Controller
@RequestMapping("/dep")
public class DepController extends BaseController {

    @Autowired
    private IDepService depService;
    
    @RequestMapping("/list")
    public String depList(Model model, Page page){
        List<Department> deps = depService.queryAll();
        model.addAttribute("deps", deps);
        return "deplist";
    }

    /**
     * jsonobject : {"":"", "":[{},{},{}]}
     * jsonarray : [{},{},{}]
     * @return
     */
    @RequestMapping("/listajax")
    @ResponseBody
    public List<Department> depListAjax(){
        List<Department> deps = depService.queryAll();
        return deps;
    }

    /**
     * 添加部门
     * @return
     */
    @RequestMapping("/add")
    public String insert(Department department){
        depService.insert(department);
        return "redirect:/dep/list";
    }


    /**
     * 删除部门
     * @param did
     * @return
     */
    @RequestMapping("/delete/{did}")
    public String delete(@PathVariable Integer did){
        depService.delete(did);
        return "redirect:/dep/list";
    }

    @RequestMapping("/update")
    public String update(Department dep){
        depService.update(dep);
        return "redirect:/dep/list";
    }

    @RequestMapping("export")
    public void export(HttpServletResponse response){
        HSSFWorkbook wk = depService.export();
        try {
            wk.write(response.getOutputStream());
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            try {
                if (wk!=null){
                    wk.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    @RequestMapping("import")
    public String importDep(MultipartFile excel){
        System.out.println(excel);
        try {
            HSSFWorkbook wk = new HSSFWorkbook(excel.getInputStream());
            HSSFSheet sheet = wk.getSheet("部门表");
            for (int i =1;i<=sheet.getLastRowNum();i++) {
                HSSFRow row = sheet.getRow(i);
                HSSFCell cell = row.getCell(i);
                String stringCellValue = cell.getStringCellValue();


            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/dep/list";
    }
}
