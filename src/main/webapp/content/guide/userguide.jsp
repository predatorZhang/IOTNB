<%@page contentType="text/html;charset=UTF-8" %>

<%@include file="/taglibs.jsp" %>

<%pageContext.setAttribute("currentMenu", "");%>

<html>
<head>
    <link rel="icon" href="${ctx}/images/favicon.ico?v=1" type="image/x-icon"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${ctx}/css/app.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/qingcloud.css" rel="stylesheet" type="text/css"/>

    <meta name="viewport" content="width=1300"/>
</head>

<input type="hidden" id="context" value="${ctx}">

<body class="modal-ready home">
<%@include file="/common/layout/homeHeader.jsp" %>

<div class="document">
    <div class="documentwrapper">
        <div class="bodywrapper">
            <div class="body" role="main">

                <div class="section" id="guide-introduction">
                    <span id="id1"></span>
                    <h1>使用入门<a class="headerlink" href="#guide-introduction" title="永久链接至标题"></a></h1>
                    <p>基础物联网平台是一个提供地下管网前端传感设备数据接入、存储、服务提供的公有云平台</p>
                    <div class="section" id="guide-concept">
                        <span id=""></span>
                        <div class="section" id="id2">
                            <h3>设备管理<a class="headerlink" href="#id3" title="永久链接至标题"></a></h3>
                            <p>企业用户通过设备管理模块，可快速注册待接入设备</p>
                        </div>
                        <div class="section" id="id3">
                            <h3>报警管理<a class="headerlink" href="#id4" title="永久链接至标题"></a></h3>
                            <p>企业用户通过报警管理模块，可浏览报警设备列表</p>
                        </div>
                        <div class="section" id="id4">
                            <h3>人员管理<a class="headerlink" href="#id5" title="永久链接至标题"></a></h3>
                            <p>企业用户通过人员管理模块，可维护管理企业内部的普通用户</p>
                        </div>
                        <div class="section" id="id5">
                            <h3>日志管理<a class="headerlink" href="#id6" title="永久链接至标题"></a></h3>
                            <p>日志管理模块，提供完善的系统操作日志记录</p>
                        </div>
                    </div>

                </div>


            </div>
        </div>
    </div>
    <div class="sphinxsidebar" role="navigation" aria-label="main navigation">
        <div class="sphinxsidebarwrapper">
            <h3><a href="../index.html">內容目录</a></h3>
            <ul class="current">
                <li class="toctree-l1 current">
                    <a class="reference internal" href="userguide.jsp">用户指南</a>
                    <ul class="current">
                        <li class="toctree-l2 current">
                            <a class="current reference internal" href="">使用入门</a>
                            <ul>
                                <li class="toctree-l3"><a class="reference internal" href="#id1">总览</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#id2">设备管理</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#id3">报警管理</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#id4">人员管理</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#id5">日志管理</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>

            <ul>
                <li class="toctree-l1"><a class="reference internal" href="api.jsp">API 文档</a></li>
            </ul>
        </div>
    </div>
    <div class="clearer"></div>
</div>

<%@include file="/common/layout/homeFooter.jsp" %>

<script type="text/javascript">

</script>

<script type="text/javascript" src="${ctx}/js/jquery-1.8.0.min.js"></script>
<%--
<script type="text/javascript" src="${ctx}/js/main.js"></script>
--%>

<script>
    $(function () {

        /*
         Main.init();
         */
    });

</script>

</body>

</html>