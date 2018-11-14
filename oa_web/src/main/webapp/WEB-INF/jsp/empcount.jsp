<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/7 0007
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>

    <style type="text/css">
        table.gridtable {
            font-family: verdana,arial,sans-serif;
            font-size:20px;
            color:#333333;
            border-width: 1px;
            border-color: #666666;
            border-collapse: collapse;
        }
        table.gridtable th {
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #666666;
            background-color: #dedede;
        }
        table.gridtable td {
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #666666;
            background-color: #ffffff;
        }
    </style>

    <script src="/resources/js/echarts.js"></script>
    <script type="text/javascript"
            src="/resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="/resources/scripts/simpla.jquery.configuration.js"></script>

    <script type="text/javascript">
        function showZhu(){
            var div = $("#main");
            var dom = document.getElementById("main");
            var myChart = echarts.init(dom);
            var app = {};
            option = null;
            var dataAxis = ${dnames};
            var data = ${counts};
            var yMax = data[0]*5;
            var dataShadow = [];

            for (var i = 0; i < data.length; i++) {
                dataShadow.push(yMax);
            }

            option = {
                title: {
                    text: '各部门人数统计',
                    subtext: '点击柱子或者滑动鼠标滚轮能够自动缩放'
                },
                xAxis: {
                    data: dataAxis,
                    axisLabel: {
                        inside: true,
                        textStyle: {
                            color: '#fff'
                        }
                    },
                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        show: false
                    },
                    z: 10
                },
                yAxis: {
                    axisLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    axisLabel: {
                        textStyle: {
                            color: '#999'
                        }
                    }
                },
                dataZoom: [
                    {
                        type: 'inside'
                    }
                ],
                series: [
                    { // For shadow
                        type: 'bar',
                        itemStyle: {
                            normal: {color: 'rgba(0,0,0,0.05)'}
                        },
                        barGap:'-100%',
                        barCategoryGap:'40%',
                        data: dataShadow,
                        animation: false
                    },
                    {
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1,
                                    [
                                        {offset: 0, color: '#83bff6'},
                                        {offset: 0.5, color: '#188df0'},
                                        {offset: 1, color: '#188df0'}
                                    ]
                                )
                            },
                            emphasis: {
                                color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1,
                                    [
                                        {offset: 0, color: '#2378f7'},
                                        {offset: 0.7, color: '#2378f7'},
                                        {offset: 1, color: '#83bff6'}
                                    ]
                                )
                            }
                        },
                        data: data
                    }
                ]
            };

            // Enable data zoom when user click bar.
            var zoomSize = 5;
            myChart.on('click', function (params) {
                console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
                myChart.dispatchAction({
                    type: 'dataZoom',
                    startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
                    endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
                });
            });
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
            }
        }
    </script>
<jsp:include page="method.jsp"/>
</head>
<body>
<div id="main" style="width: 800px;height: 500px;">
    <div id="table_count">
        <table border="1" class="gridtable">
            <tr>
                <th>部门名称</th>
                <th>员工人数</th>
            </tr>
            <c:forEach items="${list}" var="emp">
                <tr>
                    <td>${emp.dname}</td>
                    <td>${emp.number}</td>
                <tr/>
            </c:forEach>
        </table>
    </div>
</div>
<a href="/emp/count">图表</a>
<a href="javascript:showZhu()">柱状图</a>
<a href="javascript:showBing(${man},${woman})">饼状图</a>

</body>
</html>
