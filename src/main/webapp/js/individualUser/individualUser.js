/**
 * Created by yxw on 2017/6/21.
 */
/**
 * Created by Administrator on 2015/7/26.
 */
var IndividualUser = function () {
    var table = null;

    var initButtons = function () {
        //刷新table
        $('#btn-refresh-pal').live('click', function (e) {
            location.href = $("#context").val() + "/content/individualUser/individualUser.jsp";
        });
        //弹出添加人员窗口
        $('#btn-add-pal').live('click', function (e) {
            $("#dg-add-pal").show();
            $(':input', '#add_patrol_form')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('selected');
        });
        //关闭添加人员窗口
        $('#btn-close-dg-add-pal').live('click', function (e) {
            $("#dg-add-pal").hide();
        });
        //取消添加人员窗口
        $('.btn-cancel').live('click', function (e) {
            $("#dg-add-pal").hide();
        });
        //删除人员
        $('#btn-delete-pal').live('click', function (e) {
            var obj = document.getElementsByName('checkBox');
            var s = '';
            for (var i = 0; i < obj.length; i++) {
                if (obj[i].checked) s += obj[i].value + ',';
            }
            if (s == '') {
                alert("请在复选框中选择人员");
            } else {
                s = s.substring(0, s.length - 1);
                deleteDevices(s);
            }
        });
        //编辑人员
        $('#btn-edit-pal').live('click', function (e) {
            e.preventDefault();
            var selectedCounts = $("input[type='checkbox'][name=checkBox]:checked").length;
            if (selectedCounts < 1) {
                alert("请在复选框中选择人员");
                return;
            }
            if (selectedCounts > 1) {
                alert("只能选择一个人员编辑");
                return;
            }
            $(':input', '#add_patrol_form')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('selected');
            var obj = $("input[type=checkbox][name=checkBox]:checked");
            var rowIndex = obj[0].parentNode.parentNode.rowIndex;
            var aData = table.fnGetData(rowIndex - 1);
            $("#dbId").val(aData.dbId);
            $("#userName").val(aData.userName);
            $("#passWord").val(aData.passWord);
            $("#phone").val(aData.phone);
            $("#email").val(aData.email);
            $("#industry").val(aData.industry);
            $("#dg-add-pal").show();
        });

        //右键菜单中添加设备
        $('#mouse-add-pal').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-add-pal").dispatchEvent(evt);
        });
        //右键菜单中编辑设备
        $('#mouse-edit-pal').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-edit-pal").dispatchEvent(evt);
        });
        //右键菜单中删除设备
        $('#mouse-delete-pal').live('click', function (e) {
            $("#menu").hide();
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, true);
            document.getElementById("btn-delete-pal").dispatchEvent(evt);
        });

    };

    var deleteDevices = function (ids) {
        var url = $("#context").val() + "/individualUser/individualUser-del.do?ids=" + ids;
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    location.href = $("#context").val() + "/content/individualUser/individualUser.jsp";
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
            url:$("#context").val() + "/individualUser/exp-user-list.do",
            type:"post",
            dataType:"json",
            data:requestParams,
            success:function(data){
                if(data.success) {
                    window.location.href = $('#context').val() + '\\xls\\user.xls';
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
            IndividualUser.initTable();

            initButtons();

        },

        initTable: function () {

            var options = {
                "sAjaxSource": $("#context").val() + "/individualUser/individualUser-info-list.do",
                "aoColumns": [{
                    "mDataProp": "dbId",
                    "mRender": function (source, type, val) {
                        if ($('#checkAll').is(':checked'))
                            return "<input name ='checkBox' type=checkbox  checked value=" + source + ">";
                        else
                            return "<input name ='checkBox' type=checkbox  value=" + source + ">";
                    },
                    "sClass": "checkbox"
                }, {
                    "mDataProp": "dbId"
                },{
                    "mDataProp": "userName"
                }, {
                    "mDataProp": "password"
                },{
                    "mDataProp": "phone"
                },{
                    "mDataProp": "email"
                }],
                "aoColumnDefs": [{
                    'bVisible':false,
                    'aTargets': [1]
                }]
            };
            table = datatableWrapper.init($('#tableIndividualUser'), options);
            //TODO LIST:
        }

    };
}();