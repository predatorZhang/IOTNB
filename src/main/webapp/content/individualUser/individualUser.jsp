<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/taglibs.jsp" %>
<%pageContext.setAttribute("currentMenu", "patrol");%>

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

    <script>
        function isEmail(){
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            var str=document.getElementsByName("email")[0].value;
            if(!reg.test(str))
            {
                alert("邮件格式不正确!");
            }
        }

        function checkMobile(){
            var sMobile = document.getElementsByName("phone")[0].value;
            if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(sMobile))){
                alert("不是完整的11位手机号或者正确的手机号前七位");
//                document.getElementsByName("phone").focus();
            }
        }
    </script>
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
                        <a class="level level-zone level-zone-0 pek2" href="#" data-permalink="">人员管理</a>
                        <a class="level  vxnets" href="#" data-permalink="">人员信息展示</a>
                    </div>
                </div>

                <div class="page-intro vxnets">
                    <p class="lead">
                        <em>人员信息展示</em>
                    </p>
                </div>

                <div class="pane">
                    <div class="toolbar table-toolbar">

                        <a class="btn" id="btn-refresh-pal">
                            <span class="icon icon-refresh"></span>
                        </a>

                        <a class="btn" id="btn-add-pal">
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
                                <a class="btn" href="#" id="btn-edit-pal">
                                    <span class="icon icon-edit"></span>
                                    <span class="text">编辑</span>
                                </a>
                                <a class="btn"  id="exp">
                                    <span class="icon icon-download"></span>
                                    <span class="text">导出</span>
                                </a>
                                <a class="btn btn-danger" href="#" id="btn-delete-pal">
                                    <span class="icon icon-delete"></span>
                                    <span class="text">删除</span>
                                </a>

                            </div>

                        </div>

                        <div class="form-search">用户名：<input placeholder=" " type="search"></div>

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

                    <table class="table table-bordered table-hover vxnets" id="tableIndividualUser">
                        <thead>
                        <tr>
                            <th class="checkbox"><input type="checkbox" id="checkAll"></th>
                            <th class="sortable" data-key="vxnet_dbId">序号</th>
                            <th class="sortable" data-key="vxnet_userName">用户名<span class="icon-sort"></span></th>
                            <th class="sortable" data-key="vxnet_passWord">密码<span class="icon-sort"></span></th>
                            <th class="sortable sort-reverse" data-key="vxnet_phone">电话</th>
                            <th class="sortable sort-reverse" data-key="vxnet_email">邮箱</th>
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
    <a class="" href="#" id="mouse-add-pal">
        <span class="icon icon-create"></span>
        <span class="text">新增</span>
    </a>
    <a class="" href="#" id="mouse-edit-pal">
        <span class="icon icon-edit"></span>
        <span class="text">编辑</span>
    </a>
    <a class="" href="#" id="mouse-delete-pal">
        <span class="icon icon-delete"></span>
        <span class="text">删除</span>
    </a>
</div>

<div class="window-overlay" id="dg-add-pal" style="display: none;">
    <div class="modal" style="width: 500px; height: auto; margin-left: -250px; margin-top: -200px; top: 50%;">
        <div class="modal-header" style="cursor: move;">
            <h4>新增人员
                <a class="close" id="btn-close-dg-add-pal">
                    <span class="icon-close icon-Large"></span>
                </a>
            </h4>
        </div>
        <div class="modal-content" id="">
            <form class="form form-horizontal" id="add_individualUser_form" action="${ctx}/individualUser/individualUser-info-save.do" method="post">
                <fieldset>
                    <legend>新增人员</legend>
                    <input type="hidden" name="dbId"  id="dbId" value="" autofocus=""/>
                    <div class="item">
                        <div class="control-label">人员名称</div>
                        <div class="controls"><input type="text" name="userName" id="userName" autofocus=""></div>
                    </div>
                    <div class="item">
                        <div class="control-label">密码</div>
                        <div class="controls"><input type="text" name="password" id="password" autofocus=""></div>
                    </div>
                    <div class="item">
                        <div class="control-label">电话</div>
                        <div class="controls"><input type="text" name="phone"  id="phone" onchange="checkMobile()"></div>
                    </div>
                    <div class="item">
                        <div class="control-label">邮箱</div>
                        <div class="controls"><input type="text" name="email"  id="email" onchange="isEmail()"></div>
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
<script type="text/javascript" src="${ctx}/js/individualUser/individualUser.js"></script>

<script>
    $(function () {
        App.init();
        MouseDown.init();
        IndividualUser.init();
    });
</script>
</body>
</div>

</html>

