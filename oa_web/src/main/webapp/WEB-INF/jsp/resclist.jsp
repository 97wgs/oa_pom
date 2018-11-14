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
         * 显示父权限的树形结构
         */
        function showRescTree(){
            $.get("resc/listajax", function(data){

                //生成Ztree
                createZtree("ztree_div", data, {
                    name:"rname",
                    pid:"pid",
                    icon:false,
                    expand:true,
                    onclick:function(event, treeId, treeNode){
                        //将选中的父部门名称设置给button按钮
                        $("#btn_id").html(treeNode.rname);
                        $("#pid_id").val(treeNode.id);

                        if(treeNode.rstate == 1){
                            $("#span_id").html("二级权限");
                            $("#rstate_id").val(2);
                        } else if(treeNode.rstate == 2){
                            $("#span_id").html("三级权限");
                            $("#rstate_id").val(3);
                        } else if(treeNode.rstate == 3){
                            alert("三级权限下不能再有子权限！");
                            return;
                        }

                        //关闭弹出框
                        closeDialog("tree_dialog");
                    }
                });

                //弹出dialog
                openDialog("tree_dialog", "选择父权限", 300, 200)
            }, "json");
        }

        function updateRescInfo(id,rname,rpath,rstate) {

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
                        <th>权限名称</th>
                        <th>权限路径</th>
                        <th>权限类型</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${rescs}" var="resc">
                            <tr>
                                <td><input type="checkbox" /></td>
                                <td>${resc.id}</td>
                                <td>${resc.rname}</td>
                                <td>${resc.rpath}</td>
                                <td>
                                    <c:if test="${resc.rstate == 1}">
                                        一级权限
                                    </c:if>
                                    <c:if test="${resc.rstate == 2}">
                                        二级权限
                                    </c:if>
                                    <c:if test="${resc.rstate == 3}">
                                        三级权限
                                    </c:if>
                                </td>
                                <td>
                                    <!-- Icons -->
                                    <a href="javascript:updateRescInfo(${resc.id},'${resc.rname}','${resc.rpath}',${resc.rstate});" title="Edit"><img
                                        src="resources/images/icons/pencil.png" alt="Edit" /></a>
                                    <a
                                        href="resc/delete/${resc.id}" title="Delete"><img
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
                                <a class="mybutton" href="javascript:openDialog('div_dialog', '权限添加');">添加权限</a>
                            </div>

                            <!-- 分页导航 -->
                            <%@ include file="page.jsp"%>
                            <div class="clear"></div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->

<!-- 弹出框 -->
<div id="div_dialog" style="display: none;">
    <form action="${pageContext.request.contextPath}/resc/add" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>权限名称</label>
                <input class="text-input input" type="text" id="rname_id"
                    name="rname" />
            </p>
            <p>
                <label>父权限</label>
                <button id="btn_id" class="mybutton" type="button" onclick="showRescTree();">无</button>
                <input id="pid_id" name="pid" type="hidden" value="-1"/>
            </p>
            <p>
                <label>权限路径</label>
                <input class="text-input input" type="text" id="rpath_id"
                       name="rpath" />
            </p>

            <p>
                <label>权限类型</label>
                <span id="span_id">一级权限</span>
                <input type="hidden" name="rstate" id="rstate_id" value="1"/>
            </p>
            <p>
                <input class="mybutton" type="submit" value="提交" />
            </p>
        </fieldset>
        <div class="clear"></div>
        <!-- End .clear -->
    </form>
</div>

<div id="div_dialog_update" style="display: none;">
    <form action="${pageContext.request.contextPath}/resc/update" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>权限名称</label>
                <input class="text-input input" type="text" id="rname_id_update"
                    name="rname" />
            </p>
            <p>
                <label>父权限</label>
                <button id="btn_id_update" class="mybutton" type="button" onclick="showRescTree();">无</button>
                <input id="pid_id_update" name="pid" type="hidden" value="-1"/>
            </p>
            <p>
                <label>权限路径</label>
                <input class="text-input input" type="text" id="rpath_id_update"
                       name="rpath" />
            </p>

            <p>
                <label>权限类型</label>
                <span id="span_id_update">一级权限</span>
                <input type="hidden" name="rstate" id="rstate_id_update" value="1"/>
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
