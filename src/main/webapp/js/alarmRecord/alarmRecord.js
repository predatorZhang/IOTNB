/**
 * Created by Administrator on 2015/7/26.
 */
var AlarmRecord = function () {
    var table = null;
    var initDeviceType = function () {
        var url = $("#context").val() + "/device/type-list.do";
       // $("#deviceTypeName").empty();//清空原有select内的数据
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
                            $("#deviceTypeName").append("<option value='" + id + "'>" + text + "</option>");
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
        $('#btn-refresh-alarm').live('click', function (e) {
            location.href = $("#context").val() + "/content/alarm/alarmRecord.jsp";
        });
        //弹出查询报警信息窗口
        $('#btn-query-alarm').live('click', function (e) {
            $("#dg-query-alarm").show();
            $(':input', '#search_form')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('selected');

        });
        //关闭查询报警信息窗口
        $('#btn-close-dg-query-alarm').live('click', function (e) {
            $("#dg-query-alarm").hide();
        });
        //取消添加设备窗口
        $('.btn-cancel').live('click', function (e) {
            $("#dg-query-alarm").hide();
        });

        $("#exp").live("click",function(e){
            var requestParams = {
                search: $('.form-search input').val()
            };
            if($("#search_form").length>0){requestParams.searchDto=JSON.stringify($("#search_form").serializeJSON());}
            $.ajax({
                url:$("#context").val() + "/alarmRecord/exp-alarm-list.do",
                type:"post",
                dataType:"json",
                data:requestParams,
                success:function(data){
                   if(data.success) {
                       window.location.href = $('#context').val() + '\\xls\\alarmList.xls';
                   }else{
                       alert(data.message);
                   }
                },
                error:function(data){
                    alert("导出失败！");
                }
            });
        });
    };
    return {

        init: function () {
            //初始化table
            $("#search_form input").not("[type='button']").val("");
            AlarmRecord.initTable();
            //获取设备类型下拉列表
            initDeviceType();
            //初始化绑定事件
            initButtons();
            $("#deviceTypeName").unbind("change");
        },
        initTable: function () {
            var callback = function (data) {
                $("#dg-query-alarm").hide();
            };
            var options = {
                "sAjaxSource": $("#context").val() + "/alarmRecord/alarm-info-list.do",
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
                    "mDataProp": "deviceTypeName"
                }, {
                    "mDataProp": "itemValue"
                }, {
                    "mDataProp": "address"
                },{
                    "mDataProp": "recordDate"
                },{
                    "mDataProp": "messageStatus",
                    "mRender": function (source, type, val) {
                        if (val.messageStatus == "1") {
                            return '<span class="icon-status icon-in-progress"></span>处理中</td>';
                        } else if (val.messageStatus == "2") {
                            return '<span class="icon-status icon-failed"></span>结束</td>';
                        } else if (val.messageStatus == "3") {
                            return '<span class="icon-status icon-stopped"></span>开始</td>';
                        }else{
                            return '<span class="icon-status icon-stopped"></span>未知</td>';
                        }
                    }
                }],
                "aoColumnDefs": [{
                    'bVisible': false,
                    'aTargets': [1]
                }],
                "callback": callback
            };
            table = datatableWrapper.init($('#alarmRecord'), options);
            $('#query').click( function (e) {
                table.fnDraw(true);
            });
        }
    };

}();