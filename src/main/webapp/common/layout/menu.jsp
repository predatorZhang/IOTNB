<%@ page language="java" pageEncoding="UTF-8" %>

<div class="nav-zone show" style="">
    <div class="nav-zone-inner">
        <div class="zone-items page-sidebar nav-collapse collapse"><!--todo list-->
            <h5>宁波智慧管网</h5>
            <ul class="level-1 page-sidebar-menu ">

                <li class="cate no-items overview ${currentMenu == 'view' ? 'selected' : ''} ">
                    <a href="${ctx}/index.jsp" data-permalink="">
                        <span class="fa fa-overview"></span>
                        <span class="text">总览</span>
                    </a>
                </li>

                <li class="cate no-items computing_networks ${currentMenu == 'device' ? 'selected' : ''}">
                    <a href="${ctx}/content/device/device-info-list.jsp">
                        <span class="fa fa-computing_networks"></span>
                        <span class="text">设备管理</span>
                    </a>

                </li>

                <li class="cate no-items storage ${currentMenu == 'alarm' ? 'selected' : ''}">
                    <a href="${ctx}/content/alarm/alarmRecord.jsp"><span class="fa fa-alarms"></span>
                        <span class="text">报警管理</span>
                    </a>
                </li>

                <li class="cate no-items security ${currentMenu == 'patrol' ? 'selected' : ''}">
                    <a href="${ctx}/content/individualUser/individualUser.jsp"><span class="fa fa-subusers"></span>
                        <span class="text">人员管理</span>
                    </a>
                </li>

                <li class="cate no-items security ${currentMenu == 'log' ? 'selected' : ''}">
                    <a href="${ctx}/content/log/Syslog.jsp"><span class="fa fa-logs"></span>
                        <span class="text">日志管理</span>
                    </a>
                </li>
                <li class="cate no-items security ${currentMenu == 'enterprise' ? 'selected' : ''}">
                    <a href="${ctx}/content/enterprise/enterprise.jsp"><span class="fa fa-domain"></span>
                        <span class="text">企业管理</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
