/**
 * Created by Administrator on 2015/7/26.
 */
var Device = function () {
    var table = null;
    var initDeviceType = function () {
        var url = $("#context").val() + "/device/type-list.do";
        $("#typeName").empty();//清空原有select内的数据
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    if (data.message.length > 0) {
                        for (var i = 0; i < data.message.length; i++) {
                            var id = data.message[i].id;
                            var text = data.message[i].typeName;
                            $("#typeName").append("<option value='" + id + "'>" + text + "</option>");
                        }
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                // alert(errorThrown);
            }
        });
    };

    var initButtons = function () {
        //刷新table
        $('#btn-refresh-dev').live('click', function (e) {
            location.href = $("#context").val() + "/content/device/device-info-list.jsp";
        });
        //弹出添加设备窗口
        $('#btn-add-dev').live('click', function (e) {
            $("#dg-add-dev").show();
            $(':input', '#add_device_form')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('selected');

        });
        //关闭添加设备窗口
        $('#btn-close-dg-add-dev').live('click', function (e) {
            $("#dg-add-dev").hide();
        });
        //提交新增设备表单
        $('#submitForm').live('click', function (e) {
            addDevice();
        });
        //取消添加设备窗口
        $('.btn-cancel').live('click', function (e) {
            $("#dg-add-dev").hide();
        });
        //删除设备
        $('#btn-delete-dev').live('click', function (e) {
            var obj = document.getElementsByName('checkBox');
            var s = '';
            for (var i = 0; i < obj.length; i++) {
                if (obj[i].checked) s += obj[i].value + ',';
            }
            if (s == '') {
                alert("请在复选框中选择设备");
            } else {
                s = s.substring(0, s.length - 1);
                deleteDevices(s);
            }
        });
        //编辑设备
        $('#btn-edit-dev').live('click', function (e) {
            e.preventDefault();
            var selectedCounts = $("input[type='checkbox'][name=checkBox]:checked").length;
            if (selectedCounts < 1) {
                alert("请在复选框中选择一台设备");
                return;
            }
            if (selectedCounts > 1) {
                alert("只能选择一台设备编辑");
                return;
            }
            $(':input', '#add_device_form')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('selected');
            var obj = $("input[type=checkbox][name=checkBox]:checked");
            var rowIndex = obj[0].parentNode.parentNode.rowIndex;
            var aData = table.fnGetData(rowIndex - 1);
            $("#id").val(aData.id);
            $("#devName").val(aData.devName);
            $("#devCode").val(aData.devCode);
            $("#typeName").val(aData.typeId);
            $("#address").val(aData.address);
            $("#dg-add-dev").show();
        });
        //启用设备
        $('#btn-start-dev').live('click', function (e) {
            var obj = document.getElementsByName('checkBox');
            var s = '';
            for (var i = 0; i < obj.length; i++) {
                if (obj[i].checked) s += obj[i].value + ',';
            }
            if (s == '') {
                alert("请在复选框中选择设备");
            } else {
                s = s.substring(0, s.length - 1);
                startDevices(s);
            }
        });
        //停用设备
        $('#btn-stop-dev').live('click', function (e) {
            var obj = document.getElementsByName('checkBox');
            var s = '';
            for (var i = 0; i < obj.length; i++) {
                if (obj[i].checked) s += obj[i].value + ',';
            }
            if (s == '') {
                alert("请在复选框中选择设备");
            } else {
                s = s.substring(0, s.length - 1);
                stopDevices(s);
            }
        });
        //右键菜单中添加设备
        $('#mouse-add-dev').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-add-dev").dispatchEvent(evt);
        });
        //右键菜单中编辑设备
        $('#mouse-edit-dev').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-edit-dev").dispatchEvent(evt);
        });
        //右键菜单中停用设备
        $('#mouse-stop-dev').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-stop-dev").dispatchEvent(evt);
        });
        //右键菜单中启动设备
        $('#mouse-start-dev').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-start-dev").dispatchEvent(evt);
        });
        //右键菜单中删除设备
        $('#mouse-delete-dev').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-delete-dev").dispatchEvent(evt);
        });
    };

    var addDevice = function () {
        var url = $("#context").val() + "/device/device-info-save.do";
        $.ajax({
            url: url,
            type: "post",
            data: $('#add_device_form').serialize(),
            dataType: "json",
            success: function (data) {
                $("#dg-add-dev").hide();
                alert(data.message);
                if (data.success) {
                    location.href = $("#context").val() + "/content/device/device-info-list.jsp";
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
    };

    var deleteDevices = function (ids) {
        var url = $("#context").val() + "/device/device-del.do?ids=" + ids;
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                }
                location.href = $("#context").val() + "/content/device/device-info-list.jsp";
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                // alert(errorThrown);
            }
        });
    };

    var stopDevices = function (ids) {
        var url = $("#context").val() + "/device/device-stop.do?ids=" + ids;
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    location.href = $("#context").val() + "/content/device/device-info-list.jsp";
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                // alert(errorThrown);
            }
        });
    };

    var startDevices = function (ids) {
        var url = $("#context").val() + "/device/device-start.do?ids=" + ids;
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    location.href = $("#context").val() + "/content/device/device-info-list.jsp";
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                // alert(errorThrown);
            }
        });
    };
    $("#exp").live("click",function(e){
        var requestParams = {
            search: $('.form-search input').val()
        };
        $.ajax({
            url:$("#context").val() + "/device/exp-dev-list.do",
            type:"post",
            dataType:"json",
            data:requestParams,
            success:function(data){
                if(data.success) {
                    window.location.href = $('#context').val() + '\\xls\\device.xls';
                }else{
                    alert(data.message);
                }
            },
            error:function(data){
                alert("导出失败！");
            }
        });
    });

    return {

        init: function () {
            //初始化table
            Device.initTable();
            //获取设备类型下拉列表
            initDeviceType();
            //初始化绑定事件
            initButtons();
        },

        initTable: function () {

            var callback = function (data) {
                /*
                 alert("callback method invoke");
                 */
            };


            var options = {
                "sAjaxSource": $("#context").val() + "/device/device-info-list.do",
                "aoColumns": [{
                    "mDataProp": "id",
                    "mRender": function (source, type, val) {
                        if ($('#checkAll').is(':checked'))
                            return "<input name ='checkBox' type=checkbox  checked value=" + source + ">";
                        else
                            return "<input name ='checkBox' type=checkbox  value=" + source + ">";
                    },
                    "sClass": "checkbox"
                }, {
                    "mDataProp": "id"
                }, {
                    "mDataProp": "devCode"
                }, {
                    "mDataProp": "devName"
                }, {
                    "mDataProp": "status",
                    "mRender": function (source, type, val) {
                        if(!val.status) val.status = "1";
                        if (val.status == "1") {
                            return '<span class="icon-status icon-in-progress"></span>运行中</td>';
                        } else if (val.status == "2") {
                            return '<span class="icon-status icon-failed"></span>失败</td>';
                        } else if (val.status == "3") {
                            return '<span class="icon-status icon-stopped"></span>停止</td>';
                        } else {
                            return '<span class="icon-status icon-alarm-alarm"></span>停止</td>';
                        }
                    }
                }, {
                    "mDataProp": "typeName"
                }, {
                    "mDataProp": "installDate"
                }, {
                    "mDataProp": "id",
                    "mRender": function (source, type, val) {
                        //return "<a href='#' class='btn mini green'><i class='icon-remove-sign'></i>设备详情</a>";
                        //return "<a href='http://localhost:8080/iot/content/device/device-detail.jsp'>设备详情</a>";
                        return "<a href='#'>设备详情</a>";
                    }
                }],
                "aoColumnDefs": [{
                    'bVisible': false,
                    'aTargets': [1]
                }],
                "callback": callback
            };
            table = datatableWrapper.init($('#zhangfan'), options);
            $('#zhangfan a').live('click', function (e) {
                e.preventDefault();
                var nRow = $(this).parents('tr')[0];
                var aData = table.fnGetData(nRow);
                var id = aData.id;
                location.href = $("#context").val() + "/device/device-detail.do?id=" + id;
            });
        }

    };

}();