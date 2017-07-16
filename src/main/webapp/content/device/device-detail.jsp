<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "device");%>

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

    <script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>

    <style type="text/css">
        .global-logo .logo {
            background-image: url('${ctx}/images/logo.svg');
            background-size: 146px;
        }

        .global-logo .logo.en {
            background-image: url('${ctx}/images/logo.svg');
        }

        .dashboard-date-range {
            display: none;
            padding-top: -1px;
            margin-right: 0px;
            margin-top: -8px;
            padding: 8px;
            padding-bottom: 7px;
            cursor: pointer;
            color: #fff;
            background-color: #e02222;
        }

        .dashboard-date-range span {
            font-size: 12px;
            font-weight: 300;
            color: #fff;
            text-transform: uppercase;
        }

        .dashboard-date-range .icon-calendar {
            text-transform: normal;
            color: #fff;
            margin-top: 0px;
            font-size: 14px;
        }

        .dashboard-date-range span {
            font-weight: normal;
        }

        .dashboard-date-range .icon-angle-down {
            color: #fff;
            font-size: 16px;
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
                <div id="eips" class="wrapper permalink">
                    <div class="topbar">
                        <div class="breadcrumbs">
                            <a class="level level-zone level-zone-0 pek2" href="#" data-permalink="">设备管理</a>
                            <a class="level  vxnets" href="#" data-permalink="">设备详情</a>
                        </div>
                    </div>
                    <div class="description">
                        <div class="detail-item">
                            <div class="title"><h3>基本属性&nbsp;</h3>

                            </div>

                            <dl class="dl-horizontal">
                                <dt>ID</dt>
                                <dd>${model.id}</dd>
                                <dt>设备名称</dt>
                                <dd>${model.devCode}</dd>
                                <dt>设备编号</dt>
                                <dd>${model.devName}</dd>
                                <dt>设备类型</dt>
                                <dd>${model.typeName}</dd>
                                <dt>安装时间</dt>
                                <dd>${model.installDate}</dd>
                                <%--<dt>状态</dt>--%>
                                <%--<dd class="associated" width="35%"><span class="icon-status icon-associated"></span>&nbsp;--%>
                                    <%--正常工作--%>
                                <%--</dd>--%>
                                <dt>所属公司</dt>
                                <dd>${model.company}</dd>
                                <dt>所属道路</dt>
                                <dd>${model.address}</dd>
                                <%--<dt>注册人</dt>--%>
                                <%--<dd>${model.userName}</dd>--%>

                            </dl>
                        </div>
                        <div class="detail-item lease-info">
                            <div class="title"><h3>最新报警信息</h3>

                            </div>
                            <dl class="dl-horizontal contract">
                                <dt>报警时间</dt>
                                <dd>${alarm.recordDate}</dd>
                                <dt>报警值</dt>
                                <!--<dd class="time"></dd>-->
                                <dd>${alarm.itemValue}</dd>
                                <dt>报警地点</dt>
                                <dd>${alarm.address}</dd>
                            </dl>
                        </div>
                    </div>
                    <div class="details-tab">
                        <ul class="tabs">
                            <li class="current">
                                <a class="tab-item" href="https://console.qingcloud.com/pek2/eips/eip-h2rzmub5/#"
                                   data-tab="monitor">
                                    <span class="fa fa-monitor"></span>监控</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="monitor">
                                <div class="title">
                                    <h3>监控</h3>

                                    <div class="btn-group nested btn-monitor-range">

                                        <div id="dashboard-report-range"
                                             class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
                                             data-tablet="" data-desktop="tooltips" data-placement="top"
                                             data-original-title="选择统计时间范围">

                                            <i class="icon-calendar"></i>

                                            <span></span>

                                            <i class="icon-angle-down"></i>

                                        </div>

                                    </div>

                                </div>
                                <div class="charts">
                                    <div class="chart" id="device_chart">

                                        <h4>实时数据曲线图</h4>

                                        <div class="toggle toggle-off" data-tooltip="" title=""
                                             data-original-title="实时数据">
                                        </div>

                                        <div class="labels">单位:&nbsp;
                                            <span class="unit" id="unit">mg</span>
                                        </div>

                                        <div class="svg-inner">
                                           <input name="devCode_chart" id="devCode_chart" value=${model.devCode} type="hidden"/>
                                           <input name="devType" id="devType" value=${model.typeName} type="hidden"/>
                                            <div id="dev_data_show" class="chartdiv"
                                                 style="width: 100%;height:200px;"></div>

                                        </div>
                                    </div>
                                    <div class="chart" id="alarm_chart" name="alarm_chart"><h4>报警柱状图</h4>
                                        <%--<div class="toggle toggle-off" data-tooltip="" title=""--%>
                                             <%--data-original-title="报警状态">--%>
                                        <%--</div>--%>

                                        <%--<div class="labels">单位:&nbsp;--%>
                                            <%--<span class="unit" id="unitAlarm">mg</span>--%>
                                        <%--</div>--%>

                                        <div class="svg-inner">
                                            <input name="devCode_chart" id="devCodeAlarm" value=${model.devCode} type="hidden"/>
                                            <input name="devType" id="devTypeAlarm" value=${model.typeName} type="hidden"/>
                                            <div id="dev_alarm_show" class="chartdiv"
                                                 style="width: 100%;height:250px;"></div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="notify" style=""></div>

            <div class="loading-overlay" style="display: none"></div>

            <div class="account-lock" style="display:none"></div>

        </div>
    </div>

    <script type="text/javascript" charset="utf-8" src="${ctx}/js/echarts.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/js/echarts-gl.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/js/date.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/js/daterangepicker.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/app.js"></script>
    <script type="text/javascript" src="${ctx}/js/main.js"></script>
    <script type="text/javascript" src="${ctx}/js/device/device_detail.js"></script>
    <script type="text/javascript" src="${ctx}/js/config.js"></script>

    <script>
        $(function () {
            App.init();
            deviceDetail.init();
        });
    </script>
    </body>
</div>

</html>

