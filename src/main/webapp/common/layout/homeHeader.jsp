<%@ page import="java.util.HashSet" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="/taglibs.jsp" %>

<div id="header">
    <div class="viewport-wrapper">
        <div class="viewport-inner">
            <a class="header-logo" href="${ctx}/homePage.jsp" data-permalink="">宁波航天</a>
            <div class="header-account">
                <a class="btn btn-outline btn-signin" href="${ctx}/content/regist/login.jsp">登录</a>
                <a class="btn btn-primary btn-signup" href="${ctx}/content/regist/regist.jsp">注册</a>
            </div>
            <ul class="header-nav">
                <li class="nav-item products"><a href="/products" data-permalink="">产品</a>
                    <ul class="items">
                        <li><a href="" data-permalink="">物联网平台</a></li>
                        <li><a href="" data-permalink="">开放 API</a></li>
                        <li><a href="" target="_blank">地图服务</a></li>
                    </ul></li>
                <li class="nav-item customers"><a href="/customers" data-permalink="">客户案例</a>
                    <ul class="items">
                        <li><a href="" data-permalink="">给水行业</a></li>
                        <li><a href="" data-permalink="">热力行业</a></li>
                        <li><a href="" data-permalink="">排水行业</a></li>
                        <li><a href="" data-permalink="">电力行业</a></li>
                        <li><a href="" data-permalink="">燃气行业</a></li>
                        <li><a href="" data-permalink="">电信行业</a></li>
                        <li><a href="" data-permalink="">政府客户</a></li>
                    </ul>
                </li>
            <%--    <li class="nav-item pricing"><a href="" data-permalink="">价格</a>
                    <ul class="items">
                        <li><a href="" data-permalink="">资源价格</a></li>
                    </ul>
                </li>--%>
                <li class="nav-item console"><a href="">控制台</a></li>
                <li class="nav-item documentation"><a href="https://docs.qingcloud.com">文档</a>
                    <ul class="items">
                        <li><a href="${ctx}/content/guide/userguide.jsp">用户指南</a></li>
                        <li><a href="${ctx}/content/guide/api.jsp" >API 文档</a></li>
                    </ul>
                </li>
                <li class="nav-item about"><a href="/about" data-permalink="">关于</a>
                    <ul class="items">
                        <li><a href="/about/news" data-permalink="">企业动态</a></li>
                        <li><a href="/about/media" data-permalink="">媒体报道</a></li>
                      <%--  <li><a href="/about/join_us" data-permalink="">加入我们</a></li>
                        <li><a href="/about/contact_us" data-permalink="">联系我们</a></li>
                        <li><a href="/about/tos" data-permalink="">服务条款</a></li>--%>
                    </ul></li>
            </ul>
        </div>
    </div>
</div>