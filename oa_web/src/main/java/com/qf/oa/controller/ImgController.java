package com.qf.oa.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.UUID;

/**
 * @Author ken
 * @Time 2018/11/2 9:39
 * @Version 1.0
 */
@Controller
@RequestMapping("/img")
public class ImgController {

    @Value("H:/ideaWorkPace/img/")
    private String uploadPath;

    /**
     * 1、上传到哪里？
     *  1)上传到tomcat中
     *      好处：
     *          可以直接通过tomcat访问到上传的图片
     *          无需考虑目标位置是否存在
     *      坏处：
     *          如果上传的文件量很大，会导致tomcat部署项目的体积变的很大
     *          项目重新部署的方式变的很麻烦
     *  2)上传到一个指定的位置（D://img）
     *      好处：
     *          项目重新部署不会对上传图片造成任何影响
     *          图片的容量不会对tomcat造成负担
     *      坏处：
     *          需要确定服务器是有这个位置的
     *  3)上传到一个分布式文件系统中
     *      好处：
     *          因为是分布式文件系统，理论上只要有钱，体积可以无限大
     *
     * 2、上传的文件名叫什么？
     *  1)直接饮用原文件名
     *      问题：
     *          中文的处理
     *          有可能重名
     *  2)自定义文件名（唯一性） - UUID
     *
     * 文件后缀的作用：仅仅只是告诉操作系统这是一个什么文件，没有后缀或者后缀改变都不会改变文件本身的内容
     *
     *
     * @param file
     * @return
     */
    @RequestMapping("/upload")
    @ResponseBody
    public String uploadImg(MultipartFile file){

        //获得上传流
        InputStream in = null;
        OutputStream out = null;
        String path = null;
        try {
            in = file.getInputStream();
            //输出流一定要定位到文件(这个文件可以不存在，会自动创建)
            path = uploadPath + UUID.randomUUID().toString();
            out = new FileOutputStream(path);

            //文件上传
            IOUtils.copy(in, out);

            return "{\"uploadpath\":\"" + path + "\"}";
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if(in != null){
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (out != null){
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }

    /**
     * 获得图片
     * @return
     */
    @RequestMapping("/getImg")
    public void getImg(String path, HttpServletResponse response){
        InputStream in = null;
        OutputStream out = null;
        try {
            //用户需要显示的图片
            in = new FileInputStream(path);
            out = response.getOutputStream();

            IOUtils.copy(in, out);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(in != null){
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if(out != null){
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
