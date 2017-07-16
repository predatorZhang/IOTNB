<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "service");%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if IE 10]> <html lang="en" class="ie10"> <![endif]-->

<!--[if IE 11]> <html lang="en" class="ie11"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<head>

    <meta charset="utf-8"/>

    <title>地下管线综合信息平台</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>

    <meta content="" name="description"/>

    <meta content="" name="author"/>

    <!-- BEGIN GLOBAL MANDATORY STYLES -->

    <link href="${ctx}/s/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

    <link href="${ctx}/s/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

    <link href="${ctx}/s/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <link href="${ctx}/s/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

    <link href="${ctx}/s/media/css/style.css" rel="stylesheet" type="text/css"/>

    <link href="${ctx}/s/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

    <link href="${ctx}/s/media/css/blue.css" rel="stylesheet" type="text/css" id="style_color"/>

    <link href="${ctx}/s/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/bootstrap-fileupload.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/jquery.gritter.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/chosen.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/select2_metro.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/jquery.tagsinput.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/clockface.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/bootstrap-wysihtml5.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/datepicker.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/timepicker.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/colorpicker.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/bootstrap-toggle-buttons.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/daterangepicker.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/datetimepicker.css"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/s/media/css/multi-select-metro.css"/>

    <link href="${ctx}/s/media/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>

    <!-- END PAGE LEVEL STYLES -->

    <link rel="shortcut icon" href="${ctx}/s/media/image/ht.jpg"/>
    <style type="text/css">

        .page-sidebar .sidebar-toggler{
            margin-left: 72%;
        }
        .page-sidebar-closed .sidebar-toggler{
            margin-left: 2%;
        }
        .page-sidebar-closed .page-content{
            margin-left:3% !important;
        }
        .page-sidebar{
            width: 12%;
        }
        .page-content{
            margin-left: 12%;
        }
        .page-sidebar-closed .page-sidebar{
            width: 3%!important;
        }
    </style>

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

<input type="hidden" id="context" value="${ctx}"/>

<!-- BEGIN HEADER -->

<%@include file="/common/layout/header.jsp" %>

<!-- END HEADER -->

<!-- BEGIN CONTAINER -->

<div class="page-container row-fluid">

    <!-- BEGIN SIDEBAR -->

    <%@include file="/common/layout/menu.jsp" %>

    <!-- END SIDEBAR -->

    <!-- BEGIN PAGE -->

    <div class="page-content">

        <!-- BEGIN PAGE CONTAINER-->

        <div class="container-fluid">

            <div class="clearfix"></div>

            <!--BEGIN SECOND MENU-->

            <%@include file="/common/layout/second-menu-service.jsp" %>

            <!--BEGIN SECOND MENU-->

            <!--BEGIN PAGE CONTENT-->
            <div class="row-fluid">

                <div class="span12">

                    <div class="portlet box blue">

                        <div class="portlet-title">

                            <div class="caption"><i class="icon-edit"></i>服务信息编辑</div>

                            <div class="tools">

                                <a href="javascript:;" class="collapse"></a>

                                <a href="javascript:;" class="reload"></a>

                                <a href="javascript:;" class="remove"></a>

                            </div>

                        </div>

                        <div class="portlet-body form">

                            <div class="portlet-body form">

                                <form action="" class="form-horizontal" id="submit_form">

                                    <div class="alert alert-error hide">

                                        <button class="close" data-dismiss="alert"></button>

                                        操作失败：

                                        <span id="errorMessage"></span>

                                    </div>

                                    <div class="alert alert-success hide">

                                        <button class="close" data-dismiss="alert"></button>

                                        添加成功

                                    </div>

                                    <!--用户名称与密码 -->

                                    <div class="control-group">

                                        <label class="control-label">服务名称<span class="required">*</span></label>

                                        <div class="controls">

                                            <input type="text" id="serviceName" class="m-wrap span6" name="serviceName"
                                                   value="${model.serviceName}">

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>


                                    <%--<div class="control-group">--%>

                                        <%--<label class="control-label"> 服务类型<span class="required">*</span></label>--%>

                                        <%--<div class="controls">--%>

                                            <%--<select class="span6 chosen" data-with-diselect="1" data-placeholder="选择类别" tabindex="1" id="serviceType" name="serviceType">--%>

                                                <%--<c:choose>--%>
                                                    <%--<c:when test="${model.serviceType=='管线图层服务'}">--%>
                                                        <%--<option value="管线图层服务" selected>管线图层服务</option>--%>
                                                        <%--<option value="管线报警服务">管线报警服务</option>--%>
                                                        <%--<option value="管线分析服务">管线分析服务</option>--%>
                                                    <%--</c:when>--%>
                                                    <%--<c:when test="${model.serviceType=='管线报警服务'}">--%>
                                                        <%--<option value="管线报警服务" selected>管线报警服务</option>--%>
                                                        <%--<option value="管线图层服务">管线图层服务</option>--%>
                                                        <%--<option value="管线分析服务">管线分析服务</option>--%>
                                                    <%--</c:when>--%>
                                                    <%--<c:when test="${model.serviceType=='管线分析服务'}">--%>
                                                        <%--<option value="管线分析服务" selected>管线分析服务</option>--%>
                                                        <%--<option value="管线报警服务">管线报警服务</option>--%>
                                                        <%--<option value="管线图层服务">管线图层服务</option>--%>
                                                    <%--</c:when>--%>
                                                    <%--<c:otherwise>--%>
                                                        <%--<option></option>--%>
                                                        <%--<option value="管线图层服务">管线图层服务</option>--%>
                                                        <%--<option value="管线报警服务">管线报警服务</option>--%>
                                                        <%--<option value="管线分析服务">管线分析服务</option>--%>
                                                    <%--</c:otherwise>--%>
                                                <%--</c:choose>--%>

                                            <%--</select>--%>
                                            <%--<span class="help-inline"></span>--%>

                                        <%--</div>--%>

                                    <%--</div>--%>

                                    <div class="control-group">

                                        <label class="control-label">URL<span class="required">*</span></label>

                                        <div class="controls">

                                            <input type="text" id="url" class="m-wrap span6" name="url"
                                                   value="${model.url}">

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">描述<span class="required">*</span></label>

                                        <div class="controls">

                                            <input type="text" id="descn" class="m-wrap span6" name="descn"
                                                   value="${model.descn}">

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <!--隐藏主键-->
                                    <div class="control-group hidden">

                                        <label class="control-label hidden">主键ID<span class="required">*</span></label>

                                        <div class="controls hidden">

                                            <s:if test="model != null">

                                                <input type="text" name="id" value="${model.id}" id="id"/>

                                            </s:if>

                                            <span class="help-inline"></span>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <button type="submit" class="btn blue">提交</button>

                                        <button type="button" class="btn" id="cancelBtn">取消</button>

                                    </div>

                                </form>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

            <!--END PAGE CONTENT-->

        </div>

        <!-- END PAGE CONTAINER-->

        <div class="clearfix"></div>

    </div>

    <!-- END PAGE -->

</div>

<!-- END CONTAINER -->

<!-- BEGIN FOOTER -->

<%@include file="/common/layout/footer.jsp" %>

<!-- END FOOTER -->

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

<!-- BEGIN CORE PLUGINS -->

<script src="${ctx}/s/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

<script src="${ctx}/s/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

<script src="${ctx}/s/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>

<script src="${ctx}/s/media/js/bootstrap.min.js" type="text/javascript"></script>

<!--[if lt IE 9]>

<script src="${ctx}/s/media/js/excanvas.min.js"></script>

<script src="${ctx}/s/media/js/respond.min.js"></script>

<![endif]-->

<script src="${ctx}/s/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

<script src="${ctx}/s/media/js/jquery.blockui.min.js" type="text/javascript"></script>

<script src="${ctx}/s/media/js/jquery.cookie.min.js" type="text/javascript"></script>

<script src="${ctx}/s/media/js/jquery.uniform.min.js" type="text/javascript"></script>

<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->

<%--<script type="text/javascript" src="${ctx}/s/media/js/ckeditor.js"></script>--%>

<script type="text/javascript" src="${ctx}/s/media/js/bootstrap-fileupload.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/chosen.jquery.min.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/select2.min.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/wysihtml5-0.3.0.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/bootstrap-wysihtml5.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/jquery.tagsinput.min.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/jquery.toggle.buttons.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/bootstrap-datepicker.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/bootstrap-datetimepicker.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/clockface.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/date.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/daterangepicker.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/bootstrap-colorpicker.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/bootstrap-timepicker.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/jquery.inputmask.bundle.min.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/jquery.input-ip-address-control-1.0.min.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/jquery.multi-select.js"></script>

<script src="${ctx}/s/media/js/bootstrap-modal.js" type="text/javascript"></script>

<script src="${ctx}/s/media/js/bootstrap-modalmanager.js" type="text/javascript"></script>


<script type="text/javascript" src="${ctx}/s/media/js/jquery.validate.min.js"></script>

<script type="text/javascript" src="${ctx}/s/media/js/additional-methods.min.js"></script>

<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->

<script src="${ctx}/s/media/js/app.js" type="text/javascript"></script>

<script src="${ctx}/s/app/service/service-info-edit.js"></script>

<!-- END PAGE LEVEL SCRIPTS -->

<script>

    jQuery(document).ready(function () {

        App.init();

        ServiceInfoEdit.initForms();
    });

</script>

<!-- END JAVASCRIPTS -->

<!-- END BODY -->
</body>
</html>
</html>