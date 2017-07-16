<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/taglibs.jsp" %>
<%pageContext.setAttribute("currentMenu", "enterprise");%>

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
                        <a class="level level-zone level-zone-0 pek2" href="#" data-permalink="">企业管理</a>
                        <a class="level  vxnets" href="#" data-permalink="">企业信息展示</a>
                    </div>
                </div>

                <div class="page-intro vxnets">
                    <p class="lead">
                        <em>企业信息展示</em>
                    </p>
                </div>

                <div class="pane">
                    <div class="toolbar table-toolbar">

                        <a class="btn" id="btn-refresh-pal">
                            <span class="icon icon-refresh"></span>
                        </a>
                        <a class="btn" href="#" id="exp">
                            <span class="icon icon-download"></span>
                            <span class="text">导出</span>
                        </a>

                        <div class="form-search">企业名称:<input placeholder=" " type="search"></div>

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
                    <div>
                        <input id="selectedId" type="hidden">
                    </div>
                    <table class="table table-bordered table-hover vxnets" id="table_enterprise">
                        <thead>
                        <tr>
                            <th class="sortable" data-key="vxnet_dbId">编号</th>
                            <th class="sortable" data-key="vxnet_enterpriseName">企业名称<span class="icon-sort"></span></th>
                            <th class="sortable" data-key="vxnet_industry">所属行业<span class="icon-sort"></span></th>
                            <th class="sortable" data-key="vxnet_region">所属区域<span class="icon-sort"></span></th>
                            <th class="sortable" data-key="vxnet_license">营业执照<span class="icon-sort"></span></th>
                            <th class="sortable sort-reverse" data-key="vxnet_phone">电话</th>
                            <th class="sortable sort-reverse" data-key="vxnet_email">邮箱</th>
                            <th class="sortable sort-reverse" data-key="vxnet_active">账户状态</th>
                        </tr>
                        </thead>

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
    <a class="" href="#" id="mouse-active">
        <span class="icon icon-create"></span>
        <span class="text">启用</span>
    </a>
    <a class="" href="#" id="mouse-stop">
        <span class="icon icon-edit"></span>
        <span class="text">停用</span>
    </a>
    <a class="" href="#" id="mouse-failed">
        <span class="icon icon-delete"></span>
        <span class="text">未通过</span>
    </a>
</div>


<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/js/app.js"></script>
<script type="text/javascript" src="${ctx}/js/enterprise/mouseDown4Enterprise.js"></script>
<script type="text/javascript" src="${ctx}/js/main.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${ctx}/js/datatable-wrapper.js"></script>
<script type="text/javascript" src="${ctx}/js/enterprise/enterprise.js"></script>

<script>
    $(function () {
        App.init();
        MouseDown.init();
        Enterprise.init();
    });
</script>
</body>
</div>

</html>

