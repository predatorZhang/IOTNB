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

                <div class="section" id="rqField">
                    <span id="api-stop-instances"></span><h1>燃气行业接口<a class="headerlink" href="#stopinstances" title="永久链接至标题">¶</a></h1>
                    <p>关闭一台或多台运行状态的主机。</p>
                    <p>主机只有在运行 <cite>running</cite> 状态才能被关闭，如果处于非运行状态，则返回错误信息。</p>
                    <p>主机在关闭状态时，青云只收取主机操作系统所占磁盘空间的费用，价格与硬盘相同，
                        即：每 10G 收费 0.02 元（注：Linux 系统为 20G，Windows 系统为 50G）。
                        当主机启动后，计费系统会继续对此主机的计算资源进行扣费。</p>
                    <p>青云会根据你实际使用的时长收费（精确到秒），所以你可以随时启动、关闭主机，
                        而不用考虑计费周期的限制。</p>
                    <div class="admonition warning">
                        <p class="first admonition-title">警告</p>
                        <p class="last">关闭主机不会保存 RAM 中的数据。</p>
                    </div>
                    <p><strong>Request Parameters</strong></p>
                    <table class="docutils" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="60%">
                            <col width="10%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Parameter name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                            <th class="head">Required</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>instances.n</td>
                            <td>String</td>
                            <td>一个或多个主机ID</td>
                            <td>Yes</td>
                        </tr>
                        <tr class="row-odd"><td>force</td>
                            <td>Integer</td>
                            <td>1: 强制关机，0: 非强制关机，默认为0</td>
                            <td>No</td>
                        </tr>
                        <tr class="row-even"><td>zone</td>
                            <td>String</td>
                            <td>区域 ID，注意要小写</td>
                            <td>Yes</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><a class="reference internal" href="../common/parameters.html#api-common-parameters"><span>公共参数</span></a></p>
                    <p><strong>Response Elements</strong></p>
                    <table class="docutils" id="response-with-job-id" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="70%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>action</td>
                            <td>String</td>
                            <td>响应动作</td>
                        </tr>
                        <tr class="row-odd"><td>job_id</td>
                            <td>String</td>
                            <td>执行任务的 Job ID</td>
                        </tr>
                        <tr class="row-even"><td>ret_code</td>
                            <td>Integer</td>
                            <td>执行成功与否，0 表示成功，其他值则为错误代码</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><strong>Example</strong></p>
                    <p><em>Example Request</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre>https://api.qingcloud.com/iaas/?action=StopInstances
&amp;instances.1=i-rtyv0968
&amp;zone=pek1
&amp;COMMON_PARAMS
</pre></div>
                    </div>
                    <p><em>Example Response</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre><span class="p">{</span>
  <span class="s">"action"</span><span class="p">:</span><span class="s">"StopInstancesResponse"</span><span class="p">,</span>
  <span class="s">"job_id"</span><span class="p">:</span><span class="s">"j-ybnoeitr"</span><span class="p">,</span>
  <span class="s">"ret_code"</span><span class="p">:</span><span class="mi">0</span>
<span class="p">}</span>
</pre></div>
                    </div>
                </div>

                <div class="section" id="supplyWaterField">
                    <span id="api-stop-instances0"></span><h1>给水行业接口<a class="headerlink" href="#stopinstances" title="永久链接至标题">¶</a></h1>
                    <p>关闭一台或多台运行状态的主机。</p>
                    <p>主机只有在运行 <cite>running</cite> 状态才能被关闭，如果处于非运行状态，则返回错误信息。</p>
                    <p>主机在关闭状态时，青云只收取主机操作系统所占磁盘空间的费用，价格与硬盘相同，
                        即：每 10G 收费 0.02 元（注：Linux 系统为 20G，Windows 系统为 50G）。
                        当主机启动后，计费系统会继续对此主机的计算资源进行扣费。</p>
                    <p>青云会根据你实际使用的时长收费（精确到秒），所以你可以随时启动、关闭主机，
                        而不用考虑计费周期的限制。</p>
                    <div class="admonition warning">
                        <p class="first admonition-title">警告</p>
                        <p class="last">关闭主机不会保存 RAM 中的数据。</p>
                    </div>
                    <p><strong>Request Parameters</strong></p>
                    <table class="docutils" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="60%">
                            <col width="10%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Parameter name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                            <th class="head">Required</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>instances.n</td>
                            <td>String</td>
                            <td>一个或多个主机ID</td>
                            <td>Yes</td>
                        </tr>
                        <tr class="row-odd"><td>force</td>
                            <td>Integer</td>
                            <td>1: 强制关机，0: 非强制关机，默认为0</td>
                            <td>No</td>
                        </tr>
                        <tr class="row-even"><td>zone</td>
                            <td>String</td>
                            <td>区域 ID，注意要小写</td>
                            <td>Yes</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><a class="reference internal" href="../common/parameters.html#api-common-parameters"><span>公共参数</span></a></p>
                    <p><strong>Response Elements</strong></p>
                    <table class="docutils" id="response-with-job-id0" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="70%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>action</td>
                            <td>String</td>
                            <td>响应动作</td>
                        </tr>
                        <tr class="row-odd"><td>job_id</td>
                            <td>String</td>
                            <td>执行任务的 Job ID</td>
                        </tr>
                        <tr class="row-even"><td>ret_code</td>
                            <td>Integer</td>
                            <td>执行成功与否，0 表示成功，其他值则为错误代码</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><strong>Example</strong></p>
                    <p><em>Example Request</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre>https://api.qingcloud.com/iaas/?action=StopInstances
&amp;instances.1=i-rtyv0968
&amp;zone=pek1
&amp;COMMON_PARAMS
</pre></div>
                    </div>
                    <p><em>Example Response</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre><span class="p">{</span>
  <span class="s">"action"</span><span class="p">:</span><span class="s">"StopInstancesResponse"</span><span class="p">,</span>
  <span class="s">"job_id"</span><span class="p">:</span><span class="s">"j-ybnoeitr"</span><span class="p">,</span>
  <span class="s">"ret_code"</span><span class="p">:</span><span class="mi">0</span>
<span class="p">}</span>
</pre></div>
                    </div>
                </div>

                <div class="section" id="sewageField">
                    <span id="api-stop-instances0"></span><h1>排水行业接口<a class="headerlink" href="#stopinstances" title="永久链接至标题">¶</a></h1>
                    <p>关闭一台或多台运行状态的主机。</p>
                    <p>主机只有在运行 <cite>running</cite> 状态才能被关闭，如果处于非运行状态，则返回错误信息。</p>
                    <p>主机在关闭状态时，青云只收取主机操作系统所占磁盘空间的费用，价格与硬盘相同，
                        即：每 10G 收费 0.02 元（注：Linux 系统为 20G，Windows 系统为 50G）。
                        当主机启动后，计费系统会继续对此主机的计算资源进行扣费。</p>
                    <p>青云会根据你实际使用的时长收费（精确到秒），所以你可以随时启动、关闭主机，
                        而不用考虑计费周期的限制。</p>
                    <div class="admonition warning">
                        <p class="first admonition-title">警告</p>
                        <p class="last">关闭主机不会保存 RAM 中的数据。</p>
                    </div>
                    <p><strong>Request Parameters</strong></p>
                    <table class="docutils" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="60%">
                            <col width="10%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Parameter name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                            <th class="head">Required</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>instances.n</td>
                            <td>String</td>
                            <td>一个或多个主机ID</td>
                            <td>Yes</td>
                        </tr>
                        <tr class="row-odd"><td>force</td>
                            <td>Integer</td>
                            <td>1: 强制关机，0: 非强制关机，默认为0</td>
                            <td>No</td>
                        </tr>
                        <tr class="row-even"><td>zone</td>
                            <td>String</td>
                            <td>区域 ID，注意要小写</td>
                            <td>Yes</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><a class="reference internal" href="../common/parameters.html#api-common-parameters"><span>公共参数</span></a></p>
                    <p><strong>Response Elements</strong></p>
                    <table class="docutils" id="response-with-job-id0" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="70%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>action</td>
                            <td>String</td>
                            <td>响应动作</td>
                        </tr>
                        <tr class="row-odd"><td>job_id</td>
                            <td>String</td>
                            <td>执行任务的 Job ID</td>
                        </tr>
                        <tr class="row-even"><td>ret_code</td>
                            <td>Integer</td>
                            <td>执行成功与否，0 表示成功，其他值则为错误代码</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><strong>Example</strong></p>
                    <p><em>Example Request</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre>https://api.qingcloud.com/iaas/?action=StopInstances
&amp;instances.1=i-rtyv0968
&amp;zone=pek1
&amp;COMMON_PARAMS
</pre></div>
                    </div>
                    <p><em>Example Response</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre><span class="p">{</span>
  <span class="s">"action"</span><span class="p">:</span><span class="s">"StopInstancesResponse"</span><span class="p">,</span>
  <span class="s">"job_id"</span><span class="p">:</span><span class="s">"j-ybnoeitr"</span><span class="p">,</span>
  <span class="s">"ret_code"</span><span class="p">:</span><span class="mi">0</span>
<span class="p">}</span>
</pre></div>
                    </div>
                </div>

                <div class="section" id="elecField">
                    <span id="api-stop-instances0"></span><h1>电力行业接口<a class="headerlink" href="#stopinstances" title="永久链接至标题">¶</a></h1>
                    <p>关闭一台或多台运行状态的主机。</p>
                    <p>主机只有在运行 <cite>running</cite> 状态才能被关闭，如果处于非运行状态，则返回错误信息。</p>
                    <p>主机在关闭状态时，青云只收取主机操作系统所占磁盘空间的费用，价格与硬盘相同，
                        即：每 10G 收费 0.02 元（注：Linux 系统为 20G，Windows 系统为 50G）。
                        当主机启动后，计费系统会继续对此主机的计算资源进行扣费。</p>
                    <p>青云会根据你实际使用的时长收费（精确到秒），所以你可以随时启动、关闭主机，
                        而不用考虑计费周期的限制。</p>
                    <div class="admonition warning">
                        <p class="first admonition-title">警告</p>
                        <p class="last">关闭主机不会保存 RAM 中的数据。</p>
                    </div>
                    <p><strong>Request Parameters</strong></p>
                    <table class="docutils" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="60%">
                            <col width="10%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Parameter name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                            <th class="head">Required</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>instances.n</td>
                            <td>String</td>
                            <td>一个或多个主机ID</td>
                            <td>Yes</td>
                        </tr>
                        <tr class="row-odd"><td>force</td>
                            <td>Integer</td>
                            <td>1: 强制关机，0: 非强制关机，默认为0</td>
                            <td>No</td>
                        </tr>
                        <tr class="row-even"><td>zone</td>
                            <td>String</td>
                            <td>区域 ID，注意要小写</td>
                            <td>Yes</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><a class="reference internal" href="../common/parameters.html#api-common-parameters"><span>公共参数</span></a></p>
                    <p><strong>Response Elements</strong></p>
                    <table class="docutils" id="response-with-job-id0" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="70%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>action</td>
                            <td>String</td>
                            <td>响应动作</td>
                        </tr>
                        <tr class="row-odd"><td>job_id</td>
                            <td>String</td>
                            <td>执行任务的 Job ID</td>
                        </tr>
                        <tr class="row-even"><td>ret_code</td>
                            <td>Integer</td>
                            <td>执行成功与否，0 表示成功，其他值则为错误代码</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><strong>Example</strong></p>
                    <p><em>Example Request</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre>https://api.qingcloud.com/iaas/?action=StopInstances
&amp;instances.1=i-rtyv0968
&amp;zone=pek1
&amp;COMMON_PARAMS
</pre></div>
                    </div>
                    <p><em>Example Response</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre><span class="p">{</span>
  <span class="s">"action"</span><span class="p">:</span><span class="s">"StopInstancesResponse"</span><span class="p">,</span>
  <span class="s">"job_id"</span><span class="p">:</span><span class="s">"j-ybnoeitr"</span><span class="p">,</span>
  <span class="s">"ret_code"</span><span class="p">:</span><span class="mi">0</span>
<span class="p">}</span>
</pre></div>
                    </div>
                </div>

                <div class="section" id="hotField">
                    <span id="api-stop-instances0"></span><h1>热力行业接口<a class="headerlink" href="#stopinstances" title="永久链接至标题">¶</a></h1>
                    <p>关闭一台或多台运行状态的主机。</p>
                    <p>主机只有在运行 <cite>running</cite> 状态才能被关闭，如果处于非运行状态，则返回错误信息。</p>
                    <p>主机在关闭状态时，青云只收取主机操作系统所占磁盘空间的费用，价格与硬盘相同，
                        即：每 10G 收费 0.02 元（注：Linux 系统为 20G，Windows 系统为 50G）。
                        当主机启动后，计费系统会继续对此主机的计算资源进行扣费。</p>
                    <p>青云会根据你实际使用的时长收费（精确到秒），所以你可以随时启动、关闭主机，
                        而不用考虑计费周期的限制。</p>
                    <div class="admonition warning">
                        <p class="first admonition-title">警告</p>
                        <p class="last">关闭主机不会保存 RAM 中的数据。</p>
                    </div>
                    <p><strong>Request Parameters</strong></p>
                    <table class="docutils" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="60%">
                            <col width="10%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Parameter name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                            <th class="head">Required</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>instances.n</td>
                            <td>String</td>
                            <td>一个或多个主机ID</td>
                            <td>Yes</td>
                        </tr>
                        <tr class="row-odd"><td>force</td>
                            <td>Integer</td>
                            <td>1: 强制关机，0: 非强制关机，默认为0</td>
                            <td>No</td>
                        </tr>
                        <tr class="row-even"><td>zone</td>
                            <td>String</td>
                            <td>区域 ID，注意要小写</td>
                            <td>Yes</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><a class="reference internal" href="../common/parameters.html#api-common-parameters"><span>公共参数</span></a></p>
                    <p><strong>Response Elements</strong></p>
                    <table class="docutils" id="response-with-job-id0" border="1">
                        <colgroup>
                            <col width="20%">
                            <col width="10%">
                            <col width="70%">
                        </colgroup>
                        <thead valign="bottom">
                        <tr class="row-odd"><th class="head">Name</th>
                            <th class="head">Type</th>
                            <th class="head">Description</th>
                        </tr>
                        </thead>
                        <tbody valign="top">
                        <tr class="row-even"><td>action</td>
                            <td>String</td>
                            <td>响应动作</td>
                        </tr>
                        <tr class="row-odd"><td>job_id</td>
                            <td>String</td>
                            <td>执行任务的 Job ID</td>
                        </tr>
                        <tr class="row-even"><td>ret_code</td>
                            <td>Integer</td>
                            <td>执行成功与否，0 表示成功，其他值则为错误代码</td>
                        </tr>
                        </tbody>
                    </table>
                    <p><strong>Example</strong></p>
                    <p><em>Example Request</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre>https://api.qingcloud.com/iaas/?action=StopInstances
&amp;instances.1=i-rtyv0968
&amp;zone=pek1
&amp;COMMON_PARAMS
</pre></div>
                    </div>
                    <p><em>Example Response</em>:</p>
                    <div class="highlight-python"><div class="highlight"><pre><span class="p">{</span>
  <span class="s">"action"</span><span class="p">:</span><span class="s">"StopInstancesResponse"</span><span class="p">,</span>
  <span class="s">"job_id"</span><span class="p">:</span><span class="s">"j-ybnoeitr"</span><span class="p">,</span>
  <span class="s">"ret_code"</span><span class="p">:</span><span class="mi">0</span>
<span class="p">}</span>
</pre></div>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <div class="sphinxsidebar" role="navigation" aria-label="main navigation">
        <div class="sphinxsidebarwrapper">
            <h3><a href="">內容目录</a></h3>

            <ul>
                <li class="toctree-l1"><a class="reference internal" href="userguide.jsp">用户指南</a></li>
            </ul>

            <ul class="current">
                <li class="toctree-l1 current">
                    <a class="reference internal" href="api.jsp">API 文档</a>
                    <ul class="current">
                        <li class="toctree-l2 current">
                            <a class="current reference internal" href="">接入说明</a>
                            <ul>
                                <li class="toctree-l3"><a class="reference internal" href="#rqField">燃气行业接口</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#supplyWaterField">给水行业接口</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#sewageField">排水行业接口</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#elecField">电力行业接口</a></li>
                                <li class="toctree-l3"><a class="reference internal" href="#hotField">热力行业接口</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
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