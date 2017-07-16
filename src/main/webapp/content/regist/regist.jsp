<%--
  Created by IntelliJ IDEA.
  User: yxw
  Date: 2017/6/26
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "");%>

<html>

<head>
    <link rel="icon" href="${ctx}/images/favicon.ico?v=1" type="image/x-icon" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=1300" />
    <link href="${ctx}/css/app.css" rel="stylesheet" type="text/css" />

    <script>//验证电话和邮箱的格式
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
            }
        }
    </script>

</head>

<input type="hidden" id="context" value="${ctx}">

<body class="modal-ready">

<div class="container">

    <section class="intro home timeline timeline-wrapper" style="min-height: 650px;">

        <div class="window-overlay" id="btn-add-reg">

            <div class="modal" style="width: 550px; height: auto; margin-left: -250px; margin-top: -280px; top: 50%;">

                <div class="modal-header" style="cursor: move;">
                    <h1 align="center" style="font-size:24px;">企业注册</h1>
                </div>

                <div class="modal-content" id="">
                    <form class="form form-horizontal" enctype="multipart/form-data" id="submit_form" action="${ctx}/regist/regist-info-save.do" method="post">

                        <div class="item">
                            <div class="control-label">企业名称</div>
                            <div class="controls">
                                <input type="text" name="enterpriseName" id="enterpriseName" style="width: 300px;height: 35px" autofocus="">
                            </div>
                        </div>

                        <div class="item">
                            <div class="control-label">企业密码</div>
                            <div class="controls">
                                <input type="text" name="passWord"  id="passWord" style="width: 300px;height: 35px" autofocus="">
                            </div>
                        </div>

                        <div class="item">
                            <div class="control-label">联系电话</div>
                            <div class="controls">
                                <input type="text" name="phone"  id="phone" style="width: 300px;height: 35px" onchange="checkMobile()">
                            </div>
                        </div>

                        <div class="item">
                            <div class="control-label">邮箱</div>
                            <div class="controls">
                                <input type="text" name="email" id="email" style="width: 300px;height: 35px" onchange="isEmail()">
                            </div>
                        </div>

                        <div class="item system">
                            <div class="control-label">所属行业</div>
                            <div class="controls">
                                <div class="select-con"><select class="dropdown-select" name="industry" id="industry" style="width: 295px;height: 35px">
                                    <option value="无">无</option>
                                    <option value="供水">供水</option>
                                    <option value="污水">污水</option>
                                    <option value="中水">中水</option>
                                    <option value="通讯">通讯</option>
                                    <option value="热力">热力</option>
                                    <option value="燃气">燃气</option>
                                    <option value="电力">电力</option>
                                    <option value="其他">其他</option>
                                </select></div>
                            </div>
                        </div>

                        <div class="item system">
                            <label class="control-label">所属区域</label>
                            <div class="controls">
                                <select class="dropdown-select" style="width: 100px;height: 35px" name="cmbProvince" id="cmbProvince">
                                </select>
                                <select class="dropdown-select" style="width: 98px;height: 35px" name="cmbCity" id="cmbCity">
                                </select>
                                <select class="dropdown-select" style="width: 95px;height: 35px" name="region" id="region">
                                </select>
                                <span class="help enc-method" style="display: none">若要使用加密算法 ssh-ed25519 , 请先确保主机内 OpenSSH 版本大于等于 6.5</span>
                            </div>
                        </div>

                        <div class="control-group">

                            <label class="control-label">营业执照</label>

                            <div class="controls">

                                <div class="fileupload fileupload-new" data-provides="fileupload">

                                    <div class="input-append">

                                        <input type="file" class="default" style="width: 300px;height: 35px" name="license" id="license"/>

                                    </div>

                                    <span class="validate-inline" for="license"></span>

                                </div>

                            </div>

                        </div>

                        <div>
                            <br>
                            <input class="btn btn-primary" type="submit" style="width: 80px;height: 40px;margin-left: -250px;" value="提交">
                            <input class="btn btn-cancel" type="button" style="width: 80px;height: 40px;margin-right: -550px;background:darkseagreen" value="取消">
                        </div>

                    </form>

                </div>

            </div>

        </div>

</section>

</div>

<script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx}/js/city.js"></script>
<script type="text/javascript" src="${ctx}/js/main.js"></script>
<script type="text/javascript" src="${ctx}/js/regist/regist.js"></script>

<script>

    $(function () {
        addressInit('cmbProvince', 'cmbCity', 'region');
        Regist.init();

    });
</script>

</body>

</html>