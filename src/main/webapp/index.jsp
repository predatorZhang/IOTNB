<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "view");%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if IE 10]> <html lang="en" class="ie10"> <![endif]-->

<!--[if IE 11]> <html lang="en" class="ie11"> <![endif]-->

<!--[if !IE]><!-->
<html lang="en"> <!--<![endif]-->

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${ctx}/css/console2.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/css/daterangepicker.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/css/index.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="./js/echarts.js"></script>
    <script type="text/javascript" charset="utf-8" src="./js/echarts-gl.min.js"></script>

    <style type="text/css">
        .global-logo .logo {
            background-image: url('${ctx}/images/logo.svg');
            background-size: 146px;
        }

        .global-logo .logo.en {
            background-image: url('${ctx}/images/logo.svg');
        }
    </style>

</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<input type="hidden" id="context" value="${ctx}">

<div class="modal-ready">
    <div class="container">
        <div class="viewport" id="console">

            <%@include file="/common/layout/header.jsp" %>

            <%@include file="/common/layout/menu.jsp" %>

            <div class="content" style="">

                <div class="echart">
                    <div class="condition">
                        <div class="blank-area"></div>
                    </div>
                    <div id="dev_status_chart" class="chartdiv" style="width:100%;height:200px;"></div>
                </div>
                <div class="echart">
                    <div class="condition">
                        <div class="blank-area"></div>
                    </div>
                    <div id="dev_distribute_chart" class="chartdiv" style="width: 100%;height:200px;"></div>
                </div>
                <div class="echart">
                    <div class="condition">

                        <div style="float: left;margin-left: 0px">
                            <select>
                                <option>全部</option>
                                <option>超声波流量监测仪</option>
                                <option>全量程液位监测仪</option>
                                <option>噪声监测仪</option>
                                <option>压力监测仪</option>
                                <option>消防栓防盗水监测仪</option>
                                <option>井盖状态监测仪</option>
                                <option>可燃气体泄露监测仪</option>
                                <option>雨量计</option>
                                <option>其他</option>
                            </select>
                        </div>

                        <ul>
                            <li class="btnstyle active">日</li>
                            <li class="btnstyle">月</li>
                            <li class="btnstyle">年</li>
                        </ul>

                        <div id="user-count-range"
                             class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
                             data-tablet="" data-desktop="tooltips" data-placement="top"
                             data-original-title="选择统计时间范围">
                            <i class="icon-calendar"></i>
                            <span></span>
                        </div>

                    </div>
                    <div id="dev_type_chart" class="chartdiv" style="width:100%;height:200px;"></div>
                </div>
                <div class="echart">
                    <div class="condition">
                        <div class="blank-area"></div>
                    </div>
                    <div id="dev_domain_chart" class="chartdiv" style="width: 100%;height:200px;"></div>
                </div>
                <div class="echart">
                    <div class="condition">
                        <div id="dev-count-range"
                             class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
                             data-tablet="" data-desktop="tooltips" data-placement="top"
                             data-original-title="选择统计时间范围">
                            <i class="icon-calendar"></i>
                            <span></span>
                        </div>
                    </div>
                    <div id="dev_alarm_chart" class="chartdiv" style="width: 100%;height:200px;"></div>
                </div>
                <div class="echart">
                    <div class="condition">

                        <div style="float: left;margin-left: 0px">
                            <select>
                                <option>全部</option>
                                <option>超声波流量监测仪</option>
                                <option>全量程液位监测仪</option>
                                <option>噪声监测仪</option>
                                <option>压力监测仪</option>
                                <option>消防栓防盗水监测仪</option>
                                <option>井盖状态监测仪</option>
                                <option>可燃气体泄露监测仪</option>
                                <option>雨量计</option>
                                <option>其他</option>
                            </select>
                        </div>

                        <ul>
                            <li class="btnstyle active">日</li>
                            <li class="btnstyle">月</li>
                            <li class="btnstyle">年</li>
                        </ul>

                        <div id="alarm-count-range"
                             class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
                             data-tablet="" data-desktop="tooltips" data-placement="top"
                             data-original-title="选择统计时间范围">
                            <i class="icon-calendar"></i>
                            <span></span>
                        </div>

                    </div>
                    <div id="dev_user_chart" class="chartdiv" style="width:100%;height:200px;"></div>
                </div>
                <div style="clear:both"></div>
            </div>

            <div class="notify" style=""></div>

            <div class="loading-overlay" style="display: none"></div>

            <div class="account-lock" style="display:none"></div>

        </div>
    </div>


    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/app.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/js/date.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/js/daterangepicker.js"></script>
    <script type="text/javascript" src="${ctx}/js/datatable-wrapper.js"></script>
    <script type="text/javascript" src="${ctx}/js/device/device.js"></script>
    <script type="text/javascript" src="${ctx}/js/overview/index.js"></script>


    <script>
        $(function () {
            App.init();
            Index.init();
        });
    </script>

    <script type="text/javascript">

        var dev_status_option = {
            title: {
                text: '按类型统计设备',
                left: 'center',
                bottom: 0
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['超声波流量监测仪', '全量程液位监测仪', '噪声监测仪', '压力监测仪', '消防栓防盗水监测仪', '井盖状态监测仪', '可燃气体泄露监测仪', '雨量计', '其他']
            },
            series: [
                {
                    name: '设备类型',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: [
                        {value: 35, name: '超声波流量监测仪'},
                        {value: 120, name: '全量程液位监测仪'},
                        {value: 24, name: '噪声监测仪'},
                        {value: 234, name: '压力监测仪'},
                        {value: 34, name: '消防栓防盗水监测仪'},
                        {value: 294, name: '井盖状态监测仪'},
                        {value: 23, name: '可燃气体泄露监测仪'},
                        {value: 24, name: '雨量计'},
                        {value: 8, name: '其他'}
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
        var myChart = echarts.init(document.getElementById('dev_status_chart'));
        myChart.setOption(dev_status_option);

        var dev_distribute_option = {
            title: {
                text: '按分布统计设备',
                left: 'center',
                bottom: 0
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['北仑区', '江北区', '江东区', '其他']
            },
            series: [
                {
                    name: '设备安装区域',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: [
                        {value: 335, name: '北仑区'},
                        {value: 120, name: '江北区'},
                        {value: 234, name: '江东区'},
                        {value: 234, name: '其他'}
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
        var myChart = echarts.init(document.getElementById('dev_distribute_chart'));
        myChart.setOption(dev_distribute_option);

        var dev_domain_option = {
            title: {
                text: '按行业统计设备',
                left: 'center',
                bottom: 0
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['给水', '燃气', '电力', '其他']
            },
            series: [
                {
                    name: '设备应用行业',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: [
                        {value: 335, name: '给水'},
                        {value: 120, name: '燃气'},
                        {value: 234, name: '电力'},
                        {value: 234, name: '其他'}
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
        var myChart = echarts.init(document.getElementById('dev_domain_chart'));
        myChart.setOption(dev_domain_option);


        var dev_num_option = {
            title: {
                text: '设备增量统计',
                left: 'center',
                bottom: 0
            },
            tooltip: {
                trigger: 'none',
                axisPointer: {
                    type: 'cross'
                }
            },
            legend: {
                data: ['设备数量'],
                padding:0,
                right:"right"
            },
            grid: {
                x:30,
                y:20,
                x2:20,
                y2:50
               /*
                top: 70,
                bottom: 50*/
            },
            xAxis: [
                {
                    type: 'category',
                    axisTick: {
                        alignWithLabel: true
                    },
                    axisLine: {
                        onZero: false
                    },
                    axisPointer: {
                        label: {
                            formatter: function (params) {
                                return '数量  ' + params.value
                                        + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
                            }
                        }
                    },
                    data: ["2016-1", "2016-2", "2016-3", "2016-4", "2016-5", "2016-6", "2016-7", "2016-8", "2016-9", "2016-10", "2016-11", "2016-12"]
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [

                {
                    name: '设备数量',
                    type: 'line',
                    smooth: true,
                    data: [4, 6, 11, 18, 48, 69, 231, 46, 55, 18, 10, 4]
                }
            ]
        };
        var myChart = echarts.init(document.getElementById('dev_type_chart'));
        myChart.setOption(dev_num_option);

        var alarm_option = {
            title: {
                text: '设备报警统计',
                left: 'center',
                bottom: 0
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['液位超限', '管线泄漏', '压力超限', '浓度超限', '井盖开启']
            },
            series: [
                {
                    name: '报警类型',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: [
                        {value: 10, name: '液位超限'},
                        {value: 3, name: '管线泄漏'},
                        {value: 18, name: '压力超限'},
                        {value: 5, name: '浓度超限'},
                        {value: 40, name: '井盖开启'}
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
        var myChart = echarts.init(document.getElementById('dev_alarm_chart'));
        myChart.setOption(alarm_option);

        var user_option = {
            title: {
                text: '用户数量统计',
                left: 'center',
                bottom: 0
            },
            tooltip: {
                trigger: 'none',
                axisPointer: {
                    type: 'cross'
                }
            },
            legend: {
                data: ['用户数量']
            },
            grid: {
                top: 70,
                bottom: 50
            },
            xAxis: [
                {
                    type: 'category',
                    axisTick: {
                        alignWithLabel: true
                    },
                    axisLine: {
                        onZero: false
                    },
                    axisPointer: {
                        label: {
                            formatter: function (params) {
                                return '数量  ' + params.value
                                        + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
                            }
                        }
                    },
                    data: ["2016-1", "2016-2", "2016-3", "2016-4", "2016-5", "2016-6", "2016-7", "2016-8", "2016-9", "2016-10", "2016-11", "2016-12"]
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [

                {
                    name: '用户数量',
                    type: 'line',
                    smooth: true,
                    data: [4, 6, 11, 18, 48, 69, 231, 46, 55, 18, 10, 4]
                }
            ]
        };
        var myChart = echarts.init(document.getElementById('dev_user_chart'));
        myChart.setOption(user_option);
    </script>
    <script type="text/javascript">

        $(".condition li").click(function () {
            $(this).parent().children().removeClass("active");
            $(this).addClass("active");
        });

    </script>
    </body>
</div>

</html>

