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
    <link href="${ctx}/css/console.css" rel="stylesheet" type="text/css">
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
                            <a class="level level-zone level-zone-0 pek2" href="#" data-permalink="">设备管理</a>
                            <a class="level  vxnets" href="#" data-permalink="">设备信息展示</a>
                        </div>
                    </div>

                    <div class="page-intro vxnets">
                        <p class="lead">
                            <em>设备信息展示</em>
                        </p>
                    </div>

                    <div class="pane">
                        <div class="toolbar table-toolbar">

                            <a class="btn" href="#">
                                <span class="icon icon-refresh"></span>
                            </a>

                            <a class="btn" id="btn-add-dev">
                                <span class="icon icon-create"></span>
                                <span class="text">新增</span>
                            </a>

                            <div class="dropdown btn-disabled">

                                <input class="dropdown-toggle" type="text">

                                <div class="dropdown-text">
                                    <span class="icon icon-more"></span>
                                    <span class="text">更多操作</span>
                                </div>

                                <div class="dropdown-content">
                                    <a class="btn" href="#">
                                        <span class="icon icon-edit"></span>
                                        <span class="text">编辑</span>
                                    </a>
                                    <a class="btn" href="#">
                                        <span class="icon icon-pause"></span>
                                        <span class="text">停用</span>
                                    </a>
                                    <a class="btn" href="#">
                                        <span class="icon icon-play"></span>
                                        <span class="text">启动</span>
                                    </a>

                                    <a class="btn btn-danger" href="#">
                                        <span class="icon icon-delete"></span>
                                        <span class="text">删除</span>
                                    </a>

                                </div>
                            </div>

                            <div class="form-search"><input placeholder=" " type="search"></div>

                            <div class="pagination">
                                <span class="pages">合计 : &nbsp;&nbsp;</span><span class="per-page">每页:&nbsp;</span>
                                <div class="select-con" style="width: 80px;">
                                    <select class="dropdown-select" name="limit">
                                        <option value="5" selected="">5</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="50">50</option>
                                        <%--<option value="100">100</option>--%>
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

                        <table class="table table-bordered table-hover vxnets">
                            <thead>
                            <tr>
                                <th class="checkbox"><input type="checkbox"></th>
                                <!-- <th class="sortable sort-reverse" data-key="create_time">设备编号
                                     <span class="icon-sort"></span>
                                 </th>-->
                                <th>设备编号</th>
                                <th class="sortable" data-key="vxnet_type">设备类型
                                    <div class="dropdown"><input class="dropdown-toggle" type="text">
                                        <div class="dropdown-text"></div>
                                        <div class="dropdown-content">
                                            <a href="#" data-filter="vxnet_type" data-vxnet_type="0,1,2">全部</a>
                                            <a href="#" data-filter="vxnet_type" data-vxnet_type="0">液位</a>
                                            <a href="#" data-filter="vxnet_type" data-vxnet_type="1">噪声</a>
                                            <a href="#" data-filter="vxnet_type" data-vxnet_type="2">流量</a>
                                        </div>
                                    </div>
                                    <span class="icon-sort"></span>
                                </th>
                                <th>报警值</th>
                                <th>报警位置</th>
                                <th class="sortable sort-reverse" data-key="create_time">报警时间
                                    <span class="icon-sort"></span>
                                </th>
                                <th>处置状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th class="checkbox"><input type="checkbox"></th>
                                <th>B0001</th>
                                <th>噪声</th>
                                <th>105mg</th>
                                <th>梅山大道</th>
                                <th>2017-02-18</th>
                                <th>正在处理中</th>
                            </tr>
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


    <div class="eip contextmenu" style="display: none">
        <a class="" href="#">
            <span class="icon icon-create"></span>
            <span class="text">新增</span>
        </a>
        <a class="" href="#">
            <span class="icon icon-edit"></span>
            <span class="text">编辑</span>
        </a>
        <a class="" href="#">
            <span class="icon icon-pause"></span>
            <span class="text">停用</span>
        </a>
        <a class="" href="#">
            <span class="icon icon-play"></span>
            <span class="text">启动</span>
        </a>
        <a class="" href="#">
            <span class="icon icon-delete"></span>
            <span class="text">删除</span>
        </a>
    </div>

    <div class="window-overlay" id="dg-add-dev" style="display: none;">
        <div class="modal" style="width: 600px; height: auto; margin-left: -350px; margin-top: -200px; top: 50%;">
            <div class="modal-header" style="cursor: move;">
                <h4>新增设备
                    <a class="close" id="btn-close-dg-add-dev">
                        <span class="icon-close icon-Large"></span>
                    </a>
                </h4>
            </div>
            <div class="modal-content" id="">
                <form class="form form-horizontal">
                    <fieldset>
                        <legend>新增设备</legend>
                        <div class="item">
                            <div class="control-label">设备名称</div>
                            <div class="controls"><input type="text" name="keypair_name" value="" autofocus=""></div>
                        </div>
                        <div class="item">
                            <div class="control-label">设备编号</div>
                            <div class="controls"><input type="text" name="keypair_name" value="" autofocus=""></div>
                        </div>
                        <div class="item system">
                            <div class="control-label">设备类型</div>
                            <div class="controls">
                                <div class="select-con"><select class="dropdown-select" name="encrypt_method">
                                    <option value="全量程液位监测仪">全量程液位监测仪</option>
                                    <option value="压力监测仪">压力监测仪</option>
                                    <option value="噪声监测仪">噪声监测仪</option>
                                    <option value="流量监测仪">流量监测仪</option>
                                </select></div>
                                <!--<span class="help enc-method" style="display: none">若要使用加密算法 ssh-ed25519 , 请先确保主机内 OpenSSH 版本大于等于 6.5</span>-->
                            </div>
                        </div>
                        <div class="item" style="display: none">
                            <div class="control-label">方式</div>
                            <div class="controls"><label class="radio inline"><input type="radio" value="system"
                                                                                     name="mode"
                                                                                     checked="">创建新密钥对</label><label
                                    class="radio inline"><input type="radio" value="user" name="mode">使用已有公钥</label>
                            </div>
                        </div>
                        <div class="item system">
                            <div class="control-label">所属区域</div>
                            <div class="controls">
                                <div class="select-con"><select class="dropdown-select" name="encrypt_method">
                                    <option value="梅山大道">梅山大道</option>
                                    <option value="横四路">横四路</option>
                                    <option value="纵六路">纵六路</option>
                                </select></div>
                                <span class="help enc-method" style="display: none">若要使用加密算法 ssh-ed25519 , 请先确保主机内 OpenSSH 版本大于等于 6.5</span>
                            </div>
                        </div>

                        <div class="form-actions"><input class="btn btn-primary" type="submit" value="提交"><input
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
    <script type="text/javascript" src="${ctx}/js/device/device.js"></script>


    <script>
        $(function () {
            App.init();
            MouseDown.init();
            Device.init();
        });
    </script>
    </body>
</div>

</html>

