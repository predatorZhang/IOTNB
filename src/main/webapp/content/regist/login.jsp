<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "");%>

<html>

<head>
    <link rel="icon" href="${ctx}/images/favicon.ico?v=1" type="image/x-icon"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=1300"/>
    <link href="${ctx}/css/login.css" rel="stylesheet" type="text/css"/>

    <style type="text/css">
        .header-logo {
            background-image: url('../../images/logo.svg');
            background-size: 180px
        }
    </style>

</head>

<input type="hidden" id="context" value="${ctx}">

<body class="modal-ready">

<div class="container">

    <div class="page-home">

        <div id="header">
            <div class="viewport-wrapper">
                <div class="viewport-inner">
                    <a class="header-logo" href="${ctx}/homePage.jsp" data-permalink="">宁波航天</a>
                </div>
            </div>
        </div>

        <div class="content-wrapper login">

            <div class="form-wrapper">

                <form id="loginForm" class="form login" action="" method="POST">

                    <h2>登录</h2>

                    <fieldset>

                        <div class="item user">
                            <input name="enterpriseName" value="" placeholder="邮箱" type="text" style="width: 100%">
                        </div>

                        <div class="item password">
                            <input name="passWord" value="" placeholder="密码" type="password" style="width: 100%">
                        </div>

                        <div class="item">
                            <div class="controls types">
                                <label class="inline"><input name="userType" value="0" checked="" type="radio">企业用户</label>
                                <label class="inline"><input name="userType" value="1" type="radio">个人用户</label>
                            </div>
                        </div>

                        <div class="item">
                            <input class="btn btn-primary" value="登录" type="submit" onclick="submitForm()">
                        </div>
                    </fieldset>
                    <p>
                        <a class="signup" href="${ctx}/content/regist/regist.jsp">注册</a>
                    </p>
                </form>

            </div>

        </div>

    </div>

</div>

<script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx}/js/main.js"></script>
<script>

    /*firefox----这段js重新封装了event对象，经验证可以在火狐下支持！----*/

    function __firefox() {
        HTMLElement.prototype.__defineGetter__("runtimeStyle", __element_style);
        window.constructor.prototype.__defineGetter__("event", __window_event);
        Event.prototype.__defineGetter__("srcElement", __event_srcElement);
    }

    function __element_style() {
        return this.style;
    }

    function __window_event() {
        return __window_event_constructor();
    }

    function __event_srcElement() {
        return this.target;
    }

    function __window_event_constructor() {
        if (document.all) {
            return window.event;
        }
        var _caller = __window_event_constructor.caller;
        while (_caller != null) {
            var _argument = _caller.arguments[0];
            if (_argument) {
                var _temp = _argument.constructor;
                if (_temp.toString().indexOf("Event") != -1) {
                    return _argument;
                }
            }
            _caller = _caller.caller;
        }
        return null;
    }

    if (window.addEventListener) {
        __firefox();
    }
    /*end firefox------------------------------------------------*/

</script>
<script>

    $(function () {

    });

    function submitForm() {
        $.ajax({
            type: "POST",
            url: "${ctx}/regist/login.do",
            data: $('#loginForm').serialize(),
            dataType: 'json',
            async: false,
            success: function (data) {
                var jData = data;
                if (jData.success == "true") {
                    location.href = "${ctx}/index.jsp";
//                    window.event.returnValue = false;
                    if (document.all) {
                        window.event.returnValue = false;
                    } else {
                        event.preventDefault();
                    }
                } else {
                    alert(jData.message);
                }
            },
            error: function (request) {
                alert("登陆失败");
            }
        });
    }
</script>

</body>

</html>