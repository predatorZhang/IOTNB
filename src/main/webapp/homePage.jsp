<%--
  Created by IntelliJ IDEA.
  User: yxw
  Date: 2017/6/29
  Time: 8:50
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "");%>

<html>
<head>
    <link rel="icon" href="${ctx}/images/favicon.ico?v=1" type="image/x-icon" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${ctx}/css/app.css" rel="stylesheet" type="text/css" />
    <meta name="viewport" content="width=1300" />
</head>

<input type="hidden" id="context" value="${ctx}">

<body class="modal-ready home">
<%@include file="/common/layout/homeHeader.jsp" %>

<section class="page" style="min-height: 500px;">
<div id="home" class="home">
<section class="intro home timeline timeline-wrapper">
    <div class="timeline-arrows">
        <a class="arrow arrow-left" href="#" data-dir="-1"><span class="icon icon-light-prev"></span></a>
        <a class="arrow arrow-right" href="#" data-dir="1"><span class="icon icon-light-next"></span></a>
    </div>
    <div class="viewport-inner stage">
        <ul class="stage-items">

            <li class="stage-item layout-center" style="display: none" data-animation="slideDown" data-bg="amazingIsland.png"></li>
            <li class="stage-item layout-center" style="display: none" data-animation="slideUp" data-bg="pipeline.png"></li>
            <li class="stage-item layout-left" style="display: none" data-animation="slideRight" data-bg="casic.png"></li>
            <li class="stage-item layout-left" style="display: none" data-animation="slideLeft" data-bg="online.png"></li>

        </ul>
    </div>
    <div class="timeline-loading"></div>
    <div class="intro-timeline timeline-controller">

        <div class="year" style="width: 336px">
            <em>2017</em>
            <div class="feature timeline-controller-item  published">
                <a class="dot" href="#"></a>
                <span class="name">梅山岛</span>
            </div>
            <div class="feature timeline-controller-item  published">
                <a class="dot" href="#"></a>
                <span class="name">智慧管网</span>
            </div>
            <div class="feature timeline-controller-item  published">
                <a class="dot" href="#"></a>
                <span class="name">航天科工</span>
            </div>
            <div class="feature timeline-controller-item  published">
                <a class="dot" href="#"></a>
                <span class="name">正式上线</span>
            </div>
        </div>
    </div>
</section>
<div class="home-features">
</div>
<div class="home-numbers">
    <div class="viewport-inner">
        <ul>
            <li>
                <a class="number">1000</a>
                <div class="info">
                    <b>6<span class="unit">家</span></b>企业用户
                </div>
            </li>
            <li>
                <a class="number">128</a>
                <div class="info">
                    <b>128<span class="unit">类</span></b>行业分布
                </div>
            </li>
            <li>
                <a class="number">85000</a>
                <div class="info">
                    <b>85000<span class="unit">台</span></b>接入设备
                </div>
            </li>
            <li>
                <a class="number">5000</a>
                <div class="info">
                    <b>5000<span class="unit">台</span></b>日活设备
                </div>
            </li>
            <li>
                <a class="number">150</a>
                <div class="info">
                    <b>150<span class="unit">个</span></b>开放API
                </div>
            </li>
        </ul>
    </div>
</div>
<div class="home-console">
    <div class="viewport-inner">
        <div class="grid_14 console-screenshot"></div>
        <div class="grid_10 notes">
            <h2>管理控制台</h2>
            <p>可以通过简单清晰的操作，实现创建设备，配置设备，远程控制，系统监控等功能。</p>
            <ul>
                <li>资源可视化展示及操作</li>
                <li>历史及实时监控图表</li>
                <li>记录所有重要操作行为</li>
            </ul>
            <a class="btn btn-primary" href="" data-permalink="">
                <span class="icon icon-arrow-right"></span>了解详情</a>
        </div>
    </div>
</div>
</div>
</section>
<%@include file="/common/layout/homeFooter.jsp" %>

<script type="text/javascript">

</script>

<script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx}/js/main.js"></script>

<script>
    $(function () {
        Main.init();
    });

</script>

</body>

</html>