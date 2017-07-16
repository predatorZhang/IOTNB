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
    <link href="${ctx}/css/console.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.form.js"></script>

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

                            <a class="btn" id="btn-refresh-dev">
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
                                    <a class="btn" href="#" id="btn-edit-dev">
                                        <span class="icon icon-edit"></span>
                                        <span class="text">编辑</span>
                                    </a>
                                    <a class="btn" href="#" id="btn-stop-dev">
                                        <span class="icon icon-pause"></span>
                                        <span class="text">停用</span>
                                    </a>
                                    <a class="btn" href="#" id="btn-start-dev">
                                        <span class="icon icon-play"></span>
                                        <span class="text">启动</span>
                                    </a>
                                    <a class="btn" id="exp">
                                        <span class="icon icon-download"></span>
                                        <span class="text">导出</span>
                                    </a>

                                    <a class="btn btn-danger" id="btn-delete-dev">
                                        <span class="icon icon-delete"></span>
                                        <span class="text">删除</span>
                                    </a>
                                </div>
                            </div>

                            <div class="form-search">设备名称：<input placeholder=" " type="search"></div>

                            <div class="pagination">
                                <span class="pages">合计 : &nbsp;&nbsp;</span><span class="per-page">每页:&nbsp;</span>
                                <div class="select-con" style="width: 80px;">
                                    <select class="dropdown-select" name="limit">
                                        <option value="10"selected="">10</option>
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

                        <table class="table table-bordered table-hover vxnets" id="zhangfan">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="checkAll" ></th>

                                <th>ID</th>

                                <th>设备编号</th>

                                <th>设备名称</th>

                                <th>当前状态</th>

                                <th>设备类型</th>

                                <th>创建时间</th>

                                <th>设备详情</th>

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


    <div id ="menu" class="eip contextmenu" style="display: none">
        <a class="" href="#" id="mouse-add-dev">
            <span class="icon icon-create"></span>
            <span class="text">新增</span>
        </a>
        <a class="" href="#" id="mouse-edit-dev">
            <span class="icon icon-edit"></span>
            <span class="text">编辑</span>
        </a>
        <a class="" href="#" id="mouse-stop-dev">
            <span class="icon icon-pause"></span>
            <span class="text">停用</span>
        </a>
        <a class="" href="#" id="mouse-start-dev">
            <span class="icon icon-play"></span>
            <span class="text">启动</span>
        </a>
        <a class="" href="#" id="mouse-delete-dev">
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
                <form class="form form-horizontal" id="add_device_form">
                    <fieldset>
                        <legend>新增设备</legend>
                        <input type="hidden" name="id"  id="id" value="" autofocus=""/>
                        <div class="item">
                            <div class="control-label">设备编号</div>
                            <div class="controls"><input type="text" name="devCode"  id="devCode" value="" autofocus=""></div>
                        </div>
                        <div class="item">
                            <div class="control-label">设备名称</div>
                            <div class="controls"><input type="text" name="devName" id="devName" value="" autofocus=""></div>
                        </div>
                        <div class="item system">
                            <div class="control-label">设备类型</div>
                            <div class="controls">
                                <div class="select-con"><select class="dropdown-select" name="typeId" id="typeName">
                                </select></div>
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
                                <div class="select-con"><select class="dropdown-select" name="cmbProvince" id="cmbProvince">
                                </select></div>
                                <div class="select-con"><select class="dropdown-select" name="cmbCity" id="cmbCity">
                                </select></div>
                                <div class="select-con"><select class="dropdown-select" name="address" id="address">
                                </select></div>
                                <span class="help enc-method" style="display: none">若要使用加密算法 ssh-ed25519 , 请先确保主机内 OpenSSH 版本大于等于 6.5</span>
                            </div>
                        </div>

                        <div class="form-actions"><input class="btn btn-primary" type="button" id="submitForm" value="提交"><input
                                class="btn btn-cancel" type="button" value="取消"></div>
                    </fieldset>
                </form>
            </div>
            <div class="modal-footer"></div>
        </div>
    </div>

    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <%--<script type="text/javascript" src="${ctx}/js/bootstrap-table.js"></script>--%>
    <script type="text/javascript" src="${ctx}/js/app.js"></script>
    <script type="text/javascript" src="${ctx}/js/mouseDown.js"></script>
    <script type="text/javascript" src="${ctx}/js/main.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.dataTables.js"></script>
    <script type="text/javascript" src="${ctx}/js/datatable-wrapper.js"></script>
    <script type="text/javascript" src="${ctx}/js/device/device.js"></script>
    <script type="text/javascript" src="${ctx}/js/city.js"></script>
    <script>
        $(function () {
            App.init();
            MouseDown.init();
            addressInit('cmbProvince', 'cmbCity', 'address');
            Device.init();
        });
    </script>
    </body>
</div>

</html>

