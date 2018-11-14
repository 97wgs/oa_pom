package com.qf.oa.service.impl;

import com.qf.oa.dao.DepartmentMapper;
import com.qf.oa.entity.Department;
import com.qf.oa.service.IDepService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/1 10:19
 * @Version 1.0
 */
@Service
public class DepServiceImpl implements IDepService {

    @Autowired
    private DepartmentMapper depDao;


    @Override
    public List<Department> queryAll() {
        return depDao.queryAll();
    }

    @Override
    public int insert(Department department) {
        return depDao.insert(department);
    }

    @Override
    public int delete(Integer did) {
        return depDao.deleteById(did);
    }

    @Override
    public int update(Department dep) {
        depDao.updateByPrimaryKey(dep);
        return 1;
    }

    @Override
    public HSSFWorkbook export() {
        //创建工作簿
        HSSFWorkbook wk = new HSSFWorkbook();
        //创建工作表
        HSSFSheet sheet = wk.createSheet("部门表");
        //第一行
        HSSFRow row1 = sheet.createRow(0);
        //给第一行赋值
        HSSFCell row1Cell1 = row1.createCell(0);
        row1Cell1.setCellValue("部门编号");
        HSSFCell row1Cell2 = row1.createCell(1);
        row1Cell2.setCellValue("上级部门");
        HSSFCell row1Cell3 = row1.createCell(2);
        row1Cell3.setCellValue("部门名称");
        HSSFCell row1Cell4 = row1.createCell(3);
        row1Cell4.setCellValue("创建时间");
        //拿到部门List
        List<Department> deps = depDao.queryAll();
        //写入表中
        for (int i=1;i<=deps.size();i++) {
//            创建第1~deps.size行
            HSSFRow row = sheet.createRow(i);
            Department dep = deps.get(i-1);
            HSSFCell cell1 = row.createCell(0);
            Integer id = dep.getId();
            cell1.setCellValue(id);
            HSSFCell cell2 = row.createCell(1);
            String pname = dep.getPname();
            cell2.setCellValue(pname);
            HSSFCell cell3 = row.createCell(2);
            String dname = dep.getDname();
            cell3.setCellValue(dname);
            HSSFCell cell4 = row.createCell(3);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String createtime = dateFormat.format(dep.getCreatetime());
            cell4.setCellValue(createtime);
        }

        return wk;
    }

}
