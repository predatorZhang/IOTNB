<%@ page language="java" pageEncoding="UTF-8" %>

<!-- BEGIN SIDEBAR -->
<div class="page-sidebar nav-collapse collapse" style="width: 12%">

    <ul class="page-sidebar-menu">
            <li>

                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->

                <div class="sidebar-toggler hidden-phone"></div>

                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->

            </li>
        <region:region-permission permission="CTRL_组织机构:read" region="app.4">
            <!--组织结构管理-->
            <li class="${currentMenu == 'org' ? 'start active' : ''}">
                <a href="${ctx}/content/user/app-info-list.jsp" target="_top">

                    <i class="icon-cogs"></i>

                    <span class="title">组织机构</span>

                    <span class="selected"></span>

                </a>

            </li>
            <!--组织机构管理-->
        </region:region-permission>
        <region:region-permission permission="CTRL_权限管理(平台):read" region="app.4">
            <!--权限管理-->
            <li class="${currentMenu == 'auth' ? 'start active' : ''}">
                <!--TODO LIST:换成相应模块下的jsp文件-->
                <a href="${ctx}/content/auth/resc-info-list.jsp" target="_top">

                    <i class="icon-cogs"></i>

                    <span class="title">权限管理</span>

                    <span class="selected"></span>

                </a>

            </li>
            <!--权限管理-->
        </region:region-permission>
        <region:region-permission permission="CTRL_系统服务:read" region="app.4">
            <!--系统服务-->
            <li class="${currentMenu == 'service' ? 'start active' : ''}">

                <% String hrefValue=request.getContextPath()+"/content/service/service-info-list.jsp"; %>
                <region:region-permission permission="CTRL_注册服务管理:read" region="app.4">
                    <% hrefValue=request.getContextPath()+"/content/service/service-info-list.jsp"; %>
                </region:region-permission>
                <a href=<%=hrefValue%>>
                    <i class="icon-cogs"></i>

                    <span class="title">系统服务</span>

                    <span class="selected"></span>

                </a>
            </li>
            <!--系统服务-->
        </region:region-permission>
        <region:region-permission permission="CTRL_管线资源:read" region="app.4">
            <!--管线资源-->
            <li class="${currentMenu == 'pipe' ? 'start active' : ''}">

                <% String hrefValue1=request.getContextPath()+"/content/pipe/pipe-info-list.jsp"; %>
                <region:region-permission permission="CTRL_管线资源管理:read" region="app.4">
                <% hrefValue1=request.getContextPath()+"/content/pipe/pipe-info-list.jsp"; %>
                </region:region-permission>
                <a href=<%=hrefValue1%>>

                    <i class="icon-cogs"></i>

                    <span class="title">管线资源</span>

                    <span class="selected"></span>

                </a>
            </li>
            <!--管线资源-->
        </region:region-permission>

        <region:region-permission permission="CTRL_系统管理(平台):read" region="app.4">
            <!--系统管理-->
            <li class="${currentMenu == 'sys' ? 'start active' : ''}">

                <a href="${ctx}/content/sys/sys-log-list.jsp">

                    <i class="icon-cogs"></i>

                    <span class="title">系统管理</span>

                    <span class="selected"></span>

                </a>

            </li>
            <!--系统管理-->
        </region:region-permission>
    </ul>

</div>

<!-- END SIDEBAR MENU -->
