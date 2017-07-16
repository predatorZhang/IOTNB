<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "alarm");%>

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
    <link href="${ctx}/css/console.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/css/datepicker.css"/>
    <script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>


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
                <div class="wrapper page">

                    <div class="topbar">
                        <div class="breadcrumbs">
                            <a class="level level-zone level-zone-0 pek2" href="#" data-permalink="">报警管理</a>
                            <a class="level  vxnets" href="#" data-permalink="">报警信息展示</a>
                        </div>
                    </div>
                    <div class="page-intro vxnets">
                        <p class="lead">
                            <em>报警信息展示</em>
                        </p>
                    </div>
                    <div class="pane">
                        <div class="toolbar table-toolbar">

                            <a class="btn" href="#" id="btn-refresh-alarm">
                                <span class="icon icon-refresh"></span>
                            </a>

                            <a class="btn" href="#" id="btn-query-alarm">
                                <span class="icon icon-query"></span>
                                <span class="text">查询</span>
                            </a>
                            <a class="btn" id="exp">
                                <span class="icon icon-download"></span>
                                <span class="text">导出</span>
                            </a>

                            <div class="form-search">设备编号:<input placeholder=" " type="search"></div>

                            <div class="pagination">
                                <span class="pages">合计 : &nbsp;&nbsp;</span><span class="per-page">每页:&nbsp;</span>

                                <div class="select-con" style="width: 80px;">
                                    <select class="dropdown-select" name="limit">
                                        <option value="10" selected="">10</option>
                                        <option value="20">20</option>
                                        <option value="50">50</option>
                                        <option value="100">100</option>
                                    </select>
                                </div>
                                <span class="pages" id="totalPages"></span>

                                <a class="btn prev btn-forbidden" data-direction="prev">
                                    <span class="icon-prev" data-direction="prev"></span>
                                </a>

                                <a class="btn next btn-" data-direction="next">
                                    <span class="icon-next" data-direction="next"></span>
                                </a>
                            </div>

                        </div>

                        <table class="table table-bordered table-hover vxnets" id="alarmRecord">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="checkAll"></th>
                                <th>ID</th>
                                <th>设备编号</th>
                                <th>设备类型</th>
                                <th>报警值</th>
                                <th>报警位置</th>
                                <th>报警时间</th>
                                <th>处置状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot></tfoot>
                        </table>

                        <div style="display: none;"><p class="loading">正在加载...</p></div>
                    </div>
                </div>
            </div>

            <div class="notify" style=""></div>

            <div class="loading-overlay" style="display: none"></div>

            <div class="account-lock" style="display:none"></div>

        </div>
    </div>


    <div class="window-overlay" id="dg-query-alarm" style="display: none;">
        <div class="modal" style="width: 600px; height: auto; margin-left: -350px; margin-top: -200px; top: 50%;">
            <div class="modal-header" style="cursor: move;">
                <h4>报警信息查询
                    <a class="close" id="btn-close-dg-query-alarm">
                        <span class="icon-close icon-Large"></span>
                    </a>
                </h4>
            </div>
            <div class="modal-content" id="">
                <form class="form form-horizontal" id="search_form">
                    <fieldset>
                        <legend>报警信息查询</legend>
                        <div class="item">
                            <div class="control-label">报警时间</div>
                               <div class="m-wrap input-append date date-picker" style="display:inline-block;"
                                 data-date-format="yyyy-mm-dd" data-date-viewmode="years">
                                <input style="max-width: 8em;display: inline"
                                       class="m-wrap m-ctrl-medium date-picker" size="10"
                                       type="text"
                                       data-date-format="yyyy-mm-dd" name="beginDate" value=""
                                       id="txt_begin_day" placeholder="开始日期"/>
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                            </div>
                            <div class="m-wrap input-append date date-picker"
                                 data-date-format="yyyy-mm-dd" data-date-viewmode="years" style="display: inline-block">
                                <input style="max-width: 8em;display: inline"
                                       class="m-wrap m-ctrl-medium date-picker" size="10"
                                       type="text"
                                       data-date-format="yyyy-mm-dd" name="endDate"value=""
                                       id="txt_end_day" placeholder="结束日期"/>
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                            </div>

                        </div>
                        <div class="item system">
                            <div class="control-label">设备类型</div>
                            <div class="controls">
                                <div class="select-con">
                                    <select class="dropdown-select" name="deviceTypeName" id="deviceTypeName">
                                        <option value="全部" >全部</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-actions"><input class="btn btn-primary" type="button" id="query" value="查询"><input
                                class="btn btn-cancel" type="button" value="取消"></div>
                    </fieldset>
                </form>
            </div>
            <div class="modal-footer"></div>
        </div>
    </div>
    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/app.js"></script>
    <script type="text/javascript" src="${ctx}/js/mouseDown.js"></script>
    <script type="text/javascript" src="${ctx}/js/main.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.dataTables.js"></script>
    <script type="text/javascript" src="${ctx}/js/datatable-wrapper.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.serializejson.js"></script>
    <script type="text/javascript" src="${ctx}/js/alarmRecord/alarmRecord.js"></script>


    <script>
        $(function () {
            App.init();
            $('.date-picker').datepicker({
                autoclose: true,
                forceParse: false,
                language: 'zh-CN'
            });
            MouseDown.init();
            AlarmRecord.init();
        });
    </script>
    </body>
</div>

</html>

