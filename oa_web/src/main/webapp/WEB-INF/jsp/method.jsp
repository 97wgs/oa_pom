<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/8 0008
  Time: 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script>
    function showBing(man,woman) {
        var dom = document.getElementById("main");
        var myChart = echarts.init(dom);
        var app = {};
        option = null;
        var weatherIcons = {
            'Sunny': './data/asset/img/weather/sunny_128.png',
            'Cloudy': './data/asset/img/weather/cloudy_128.png',
            'Showers': './data/asset/img/weather/showers_128.png'
        };

        option = {
            title: {
                text: '人数统计',
                subtext: '根据性别',
                left: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
// orient: 'vertical',
// top: 'middle',
                bottom: 10,
                left: 'center',
                data: ['男','女']
            },
            series: [
                {
                    type: 'pie',
                    radius: '65%',
                    center: ['50%', '50%'],
                    selectedMode: 'single',
                    data: [
                        {
                            value: man,
                            name: '男',
                            label: {
                                normal: {
                                    backgroundColor: '#eee',
                                    borderColor: '#777',
                                    borderWidth: 1,
                                    borderRadius: 4,
                                    rich: {
                                        title: {
                                            color: '#eee',
                                            align: 'center'
                                        },
                                        abg: {
                                            backgroundColor: '#333',
                                            width: '100%',
                                            align: 'right',
                                            height: 25,
                                            borderRadius: [4, 4, 0, 0]
                                        },
                                        Sunny: {
                                            height: 30,
                                            align: 'left',
                                            backgroundColor: {
                                                image: weatherIcons.Sunny
                                            }
                                        },
                                        Cloudy: {
                                            height: 30,
                                            align: 'left',
                                            backgroundColor: {
                                                image: weatherIcons.Cloudy
                                            }
                                        },
                                        Showers: {
                                            height: 30,
                                            align: 'left',
                                            backgroundColor: {
                                                image: weatherIcons.Showers
                                            }
                                        },
                                        weatherHead: {
                                            color: '#333',
                                            height: 24,
                                            align: 'left'
                                        },
                                        hr: {
                                            borderColor: '#777',
                                            width: '100%',
                                            borderWidth: 0.5,
                                            height: 0
                                        },
                                        value: {
                                            width: 20,
                                            padding: [0, 20, 0, 30],
                                            align: 'left'
                                        },
                                        valueHead: {
                                            color: '#333',
                                            width: 20,
                                            padding: [0, 20, 0, 30],
                                            align: 'center'
                                        },
                                        rate: {
                                            width: 40,
                                            align: 'right',
                                            padding: [0, 10, 0, 0]
                                        },
                                        rateHead: {
                                            color: '#333',
                                            width: 40,
                                            align: 'center',
                                            padding: [0, 10, 0, 0]
                                        }
                                    }
                                }
                            }
                        },
                        {value: woman, name: '女'},
                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        ;
        if (option && typeof option === "object") {
            myChart.setOption(option, true);
        }
    }
</script>
</body>
</html>
