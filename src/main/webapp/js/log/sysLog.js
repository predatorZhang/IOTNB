/**
 * Created by Administrator on 2015/7/26.
 */
var SysLog = function () {
    var table = null;
    var initButtons = function () {
        //刷新table
        $('#btn-refresh-log').live('click', function (e) {
            location.href = $("#context").val() + "/content/log/Syslog.jsp";
        });
        $('#btn-query-logs').live('click', function (e) {
            $("#modal-query-log").show();
            $(':input', '#search_form')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('selected');
        });
        //关闭查询报警信息窗口
        $('#btn-close-query-logs-modal').live('click', function (e) {
            $("#modal-query-log").hide();
        });
        //取消添加设备窗口
        $('.btn-cancel').live('click', function (e) {
            $("#modal-query-log").hide();
        });

    };

    return {

        init: function () {
            //初始化table
            SysLog.initTable();
            //初始化绑定事件
            initButtons();
        },
        initTable: function () {

            var callback = function (data) {
                $("#modal-query-log").hide();
            };


            var options = {
                "sAjaxSource": $("#context").val() + "/sysLog/sys-info-list.do",
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
                    "mDataProp": "operationType"
                }, {
                    "mDataProp": "content"
                }, {
                    "mDataProp": "createTime"
                }, {
                    "mDataProp": "createUser"
                }],
                "aoColumnDefs": [{
                    'bVisible': false,
                    'aTargets': [1]
                }],
                "callback": callback
            };
            table = datatableWrapper.init($('#table_log'), options);

            $('#query').bind('click', function (e) {
                table.fnDraw(true);
            });
        }
    };

}();