<%@ page import="java.util.HashSet" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="/taglibs.jsp" %>

<div class="nav-global" style="">
    <div>
        <div class="global-logo"><a class="logo" href="" data-permalink=""></a></div>

        <div class="items-inner">
            <div class="global-toggle sidebar-toggler"><a class="fa fa-nav-toggle show" href="#"></a></div>

            <ul class="global-items">
                <!--  <li class="nav-item"><a class="nav-item-inner mobile-app" href="">
                      <span class="with-animation fa fa-app"></span>
                      <span class="nav-text">App</span></a>
                  </li>-->
             <%--   <li class="nav-item">
                    <a class="nav-item-inner" href="#">
                        <span class="fa fa-notifications fa-has-unread"></span>
                        <span class="nav-text">消息中心</span></a>
                    <ul class="dropdown-menu" style="display: none;">
                    </ul>
                </li>--%>

               <%-- <li class="nav-item">
                    <a class="nav-item-inner" href="#">
                        <span class="fa fa-tickets"></span>
                        <span class="nav-text">工单</span>
                    </a>
                    <ul class="dropdown-menu" style="display: none;"></ul>
                </li>--%>

                <li class="nav-item nav-item-help">
                    <a class="nav-item-inner nav-item-inner-help" href="#">
                        <span class="fa fa-help"></span>
                        <span class="nav-text">帮助</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-help" style="display: none;">
                        <div class="dropdown-menu-inner">
                            <ul>
                                <li class="dropdown-menu-item"><a target="_blank"
                                                                  href="${ctx}/content/guide/userguide.jsp"><span
                                        class="fa fa-guide"></span>用户指南</a></li>
                              <%--  <li class="dropdown-menu-item"><a target="_blank"
                                                                  href="https://www.qingcloud.com/icp"><span
                                        class="fa fa-icp"></span>ICP备案</a></li>
                                <li class="dropdown-menu-item"><a target="_blank"
                                                                  href="https://docs.qingcloud.com/faq/index.html"><span
                                        class="fa fa-faq"></span>常见问题</a></li>--%>
                                <li class="dropdown-menu-item"><a target="_blank"
                                                                  href="${ctx}/content/guide/api.jsp"><span
                                        class="fa fa-api"></span>API Docs</a></li>
                             <%--   <li class="dropdown-menu-item"><a target="_blank"
                                                                  href="https://docs.qingcloud.com/cli/index.html"><span
                                        class="fa fa-cli"></span>CLI Docs</a></li>
                                <li class="dropdown-menu-item"><a target="_blank"
                                                                  href="https://docs.qingcloud.com/sdk/index.html"><span
                                        class="fa fa-sdk"></span>SDK Docs</a></li>--%>
                            </ul>
                           <%-- <div class="pipe"></div>
                            <ul>
                                <li class="dropdown-menu-item"><a target="_blank"
                                                                  href="http://status.qingcloud.com/"><span
                                        class="fa fa-service_health"></span>服务健康状态</a></li>
                            </ul>--%>
                        </div>
                    </div>

                </li>


                <li class="nav-item nav-item-profile">
                    <a class="nav-item-inner" href="#">
                            <span class="user-avatar" href="#"
                                  style="background-image: url('https://secure.gravatar.com/avatar/0e1db49630b504baa32acc71992fd388?s=80&amp;d=')"
                                  target="_blank"></span>
                        <span class="user-name">344486139</span><span class="user-verify-new-dot"></span>
                    </a>

                    <div class="dropdown-menu dropdown-menu-profile" style="display: none;">
                        <div class="dropdown-menu-inner">
                            <ul>
<%--
                                <li class="dropdown-menu-item">
                                    <a href="https://console.qingcloud.com/account/profile/basic/"
                                       data-permalink="">
                                        <span class="fa fa-settings"></span>账户信息
                                        <span class="user-verify-new-dot"></span>
                                    </a>
                                </li>--%>

                              <%--  <li class="dropdown-menu-item">
                                    <a href="" data-permalink="">
                                        <span class="fa fa-lock"></span>账户安全
                                    </a>
                                </li>--%>
                            </ul>

                            <div class="pipe"></div>

                            <ul>
                                <li class="dropdown-menu-item">
                                    <a class="logout" href="${ctx}/regist/login-out.do">
                                        <span class="fa fa-logout"></span>登出
                                    </a>
                                </li>
                            </ul>

                        </div>
                    </div>
                </li>

                <!--最近操作-->
                <li class="nav-item nav-item-activities">
                    <a class="nav-item-inner" href="#">
                        <span class="fa fa-activities"></span>
                    </a>

                    <div class="zone-activities" style="display: none;" id="zone-activities">
                        <div class="activities-inner"><h4 class="activities-title">最近操作
                            <a href="${ctx}/content/log/Syslog.jsp" data-permalink="">查看全部</a></h4>
                            <ol class="activities-items">

                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>

<script src="${ctx}/js/baiduTemplate.js" type="text/javascript"></script>

<script>

    function timeago(dateTimeStamp){
        var  minute=1000*60;      //把分，时，天，周，半个月，一个月用毫秒表示
        var  hour=minute*60;
        var day=hour*24;
        var week=day*7;
        var halfamonth=day*15;
        var month=day*30;
        var  now=new Date().getTime();   //获取当前时间毫秒
        var diffValue=now-dateTimeStamp;//时间差
        if(diffValue<0){return;}
        var  minC=diffValue/minute;  //计算时间差的分，时，天，周，
        var  hourC=diffValue/hour;
        var  dayC=diffValue/day;
        var  weekC=diffValue/week;
        var  monthC=diffValue/month;
        if(minC>=1){
            result=" "+parseInt(minC)+"分钟前"
        }else if(hourC>=1){
            result=" "+parseInt(hourC)+"小时前"
        }else if(dayC>=1){
            result=" "+parseInt(dayC)+"天前"
        }else if(weekC>=1){
            result=" "+parseInt(weekC)+"周前"
        }else if(monthC>=1){
            result=" "+parseInt(monthC)+"月前"
        }else{
            result="刚刚";
        }
        return result;
    }

    $(function () {

        $(".nav-item-help").mouseover(function () {
            $(".dropdown-menu-help").show();
        });

        $(".nav-item-help").mouseout(function () {
            $(".dropdown-menu-help").hide();
        });

        $(".nav-item-profile").mouseover(function () {
            $(".dropdown-menu-profile").show();
        });

        $(".nav-item-profile").mouseout(function () {
            $(".dropdown-menu-profile").hide();
        });

        $(".nav-item-activities").mouseover(function () {
            //TODO LIST:调用模板，生成字符串动态追加到指定标签
           /* if(!$(".zone-activities").is(':hidden')) {
                return;
            }*/
            $(".zone-activities").show();

            var template = $("#context").val()+"/tmpl/logPanel.html";
            $.ajax({
                url: template,
                dataType: "html",
                success: function (val) {

                    //TODO LIST:返回接口获取数据
                    jQuery.ajax({
                        type: "POST",
                        dataType: 'json',
                        url: $('#context').val() + "/sysLog/listTop5.do",
                        success: function (result) {
                            var message = result.message;
                            for(i=0;i<message.length;i++) {
                                var time = message[i].createTime;
                                time = time.replace(/-/g,"/");
                                message[i].consume = timeago(new Date(time));
                            }
                            result.message = message;

                            var content = baidu.template(val,result);
                            $(".activities-items").html(content);
                           // $(".zone-activities").show();
                        }
                    });
                }
            });
        });

        $(".nav-item-activities").mouseout(function () {
            /*if(!$(".zone-activities").is(':hidden')) {
                $(".zone-activities").hide();
            }*/
            $(".zone-activities").hide();
        });
    });
</script>