<%--
  Created by IntelliJ IDEA.
  User: ken
  Date: 2018/11/1
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen" />
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen" />
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen" />

    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>

    <!-- 时间日期插件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/widget/My97DatePicker/WdatePicker.js"></script>

    <!-- dialog弹出框的导入 -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css"/>
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="resources/js/plugin.js"></script>

    <!-- ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>

    <style>
        .time-input {
            padding: 6px;
            font-size: 13px;
            border: 1px solid #d5d5d5;
            color: #333;
        }
    </style>

    <script>
        /**
         * 显示父部门的树形结构
         */
        function showDepsTree(){
            $.get("dep/listajax", function(data){

                //生成Ztree
                createZtree("ztree_div", data, {
                    name:"dname",
                    pid:"pid",
                    icon:false,
                    expand:true,
                    onclick:function(event, treeId, treeNode){
                        //将选中的父部门名称设置给button按钮
                        $("#btn_id").html(treeNode.dname);
                        $("#pid_id").val(treeNode.id);
                        //关闭弹出框
                        closeDialog("tree_dialog");
                    }
                });

                //弹出dialog
                openDialog("tree_dialog", "选择父部门", 300, 200)
            }, "json");
        }

        /**
         * 修改父部门
         *
         */
        function showDepsTree_update(){
            $.get("dep/listajax", function(data){

                //生成Ztree
                createZtree("ztree_div", data, {
                    name:"dname",
                    pid:"pid",
                    icon:false,
                    expand:true,
                    onclick:function(event, treeId, treeNode){
                        //将选中的父部门名称设置给button按钮
                        $("#btn_id_update").html(treeNode.dname);
                        $("#pid_id_update").val(treeNode.id);
                        //关闭弹出框
                        closeDialog("tree_dialog");
                    }
                });

                //弹出dialog
                openDialog("tree_dialog", "选择父部门", 300, 200)
            }, "json");
        }

        /**
         * 修改部门
         * @param eid
         */
        function updateDep(id, dname, pname, dinfo, pid, createtime){
            //获得需要修改的所有部门信息
            //填充到dialog的表单上
            $("#dname_id_update").val(dname);
            $("#did").val(id);
            $("#pid_id_update").val(pid);
            $("#btn_id_update").html(pname);

            //Thu Nov 12 00:00:00 CST 2015
            var date = new Date(createtime);
            var dateStr = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
            $("#createtime_id_update").val(dateStr);
            $("#dinfo_id_update").val(dinfo);


            //弹出dialog
            openDialog('div_dialog_update', '修改部门');
        }

        /**
         * 导入方法
         */
        function tryImport() {
            var file = document.querySelector("input[type=file]").value
            if (file == ""){
                alert("请先选择Excel文件")
                return;
            }else {
                $("#excelForm").submit();
            }
        }
    </script>

</head>
<body>
<div id="main-content">
    <div class="content-box">
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab1">
                <table>
                    <thead>
                    <tr>
                        <th><input class="check-all" type="checkbox" /></th>
                        <th>编号</th>
                        <th>部门名称</th>
                        <th>父部门</th>
                        <th>部门描述</th>
                        <th>成立时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${deps}" var="dep">
                            <tr>
                                <td><input type="checkbox" /></td>
                                <td>${dep.id}</td>
                                <td>${dep.dname}</td>
                                <td>${dep.pname}</td>
                                <td>${dep.dinfo}</td>
                                <td><fmt:formatDate value="${dep.createtime}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <!-- Icons -->
                                    <a href="javascript:updateDep(${dep.id},'${dep.dname}','${dep.pname}','${dep.dinfo}', ${dep.pid}, '${dep.createtime}');" title="Edit"><img
                                        src="resources/images/icons/pencil.png" alt="Edit" />
                                    <a
                                        href="dep/delete/${dep.id}" title="Delete"><img
                                        src="resources/images/icons/cross.png" alt="Delete" /></a>
                                    <a
                                        href="#" title="Edit Meta"><img
                                        src="resources/images/icons/hammer_screwdriver.png"
                                        alt="Edit Meta" /></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <div class="bulk-actions align-left">
                                <a class="mybutton" href="javascript:openDialog('div_dialog', '部门添加');">添加部门</a><br>
                            </div>

                            <!-- 分页导航 -->
                            <%@ include file="page.jsp"%>
                            <div class="clear"></div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
            <form action="/dep/import" enctype="multipart/form-data" id="excelForm" method="post">
                <input type="file" name="excel" id="">
                <a href="javascript:tryImport()">导入部门表</a>
                <a href="/dep/export">导出部门表</a>
                <input type="submit" value="提交">
            </form>
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->

<!-- 添加弹出框 -->
<div id="div_dialog" style="display: none;">
    <form action="${pageContext.request.contextPath}/dep/add" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>部门名称</label>
                <input class="text-input input" type="text" id="dname_id"
                    name="dname" />
            </p>
            <p>
                <label>父部门</label>
                <button id="btn_id" class="mybutton" type="button" onclick="showDepsTree();">无</button>
                <input id="pid_id" name="pid" type="hidden" value="-1"/>
            </p>
            <p>
                <label>成立时间</label>
                <input
                    class="Wdate time-input " type="text" id="createtime_id"
                    name="createtime" onclick="WdatePicker()"/>
            </p>

            <p>
                <label>部门描述</label>
                <textarea class="text-input textarea wysiwyg" id="dinfo_id"
                          name="dinfo" cols="79" rows="15"></textarea>
            </p>
            <p>
                <input class="mybutton" type="submit" value="提交" />
            </p>
        </fieldset>
        <div class="clear"></div>
        <!-- End .clear -->
    </form>
</div>

<%--修改弹出框--%>
<div id="div_dialog_update" style="display: none;">
    <form action="${pageContext.request.contextPath}/dep/update" method="post">
        <fieldset>
            <input type="hidden" name="id" id="did">
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>部门名称</label>
                <input class="text-input input" type="text" id="dname_id_update"
                    name="dname" />
            </p>
            <p>
                <label>父部门</label>
                <button id="btn_id_update" class="mybutton" type="button" onclick="showDepsTree_update();">无</button>
                <input id="pid_id_update" name="pid" type="hidden" value="-1"/>
            </p>
            <p>
                <label>成立时间</label>
                <input
                    class="Wdate time-input " type="text" id="createtime_id_update"
                    name="createtime" onclick="WdatePicker()"/>
            </p>

            <p>
                <label>部门描述</label>
                <textarea class="text-input textarea wysiwyg" id="dinfo_id_update"
                          name="dinfo" cols="79" rows="15"></textarea>
            </p>
            <p>
                <input class="mybutton" type="submit" value="提交" />
            </p>
        </fieldset>
        <div class="clear"></div>
        <!-- End .clear -->
    </form>
</div>

<!-- 树形弹出框 -->
<div id="tree_dialog" style="display: none;">
    <div id="ztree_div" class="ztree"></div>
</div>

</body>
</html>
