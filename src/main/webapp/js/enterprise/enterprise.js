/**
 * Created by lenovo on 2017/7/4.
 */
var Enterprise = function(){
    var table = null;
    var initButtons = function () {
        //刷新table
        $('#btn-refresh-pal').live('click', function (e) {
            location.href = $("#context").val() + "/content/enterprise/enterprise.jsp";
        });

        //右键菜单中激活账户
        $('#mouse-active').live('click', function (e) {
            $("#menu").hide();
            operator($("#selectedId").val(),1);
        });
        //右键菜单中停用账户
        $('#mouse-stop').live('click', function (e) {
            $("#menu").hide();
            operator($("#selectedId").val(),0);
        });
        //右键菜单中审核未通过
        $('#mouse-failed').live('click', function (e) {
            $("#menu").hide();
            operator($("#selectedId").val(),3);
        });
        function operator(id,status){
            if(!id){
                alert("未获取到要操作的行")
                return;
            }
            var url = $("#context").val() + "/regist/update-status.do";
            $.ajax({
                url:url,
                type:'post',
                data:{"dbId":id,"status":status},
                dataType:'json',
                success:function(data){
                  if(data.success){
                      table.fnDraw(true);
                      alert("操作成功");
                  }else{
                      alert("操作失败");
                  }
                },
                error:function(){
                    alert("网络故障");
                }
            });
        }

    };

    return {

        init: function () {
            //初始化table
            Enterprise.initTable();
            initButtons();
        },

        initTable: function () {

            var options = {
                "sAjaxSource": $("#context").val() + "/regist/page-query-enterprise-list.do",
                "aoColumns": [{
                    "mDataProp": "dbId"
                },{
                    "mDataProp": "enterpriseName"
                }, {
                    "mDataProp": "industry"
                },{
                    "mDataProp": "region"
                },{
                    "mDataProp": "license",
                    "mRender":function(source,type,val){
                        return "<a href='"+$("#context").val()+"/"+val.license+"' target='_blank'>"+val.license+"</a>"
                    }
                },{
                    "mDataProp": "phone"
                },{
                    "mDataProp": "email"
                },{
                    "mDataProp": "active",
                    "mRender": function (source, type, val) {
                        if (val.active == "0") {
                            return '<span class="icon-status icon-suspended"></span><input class="dbIdValue" type="hidden" value="'+val.dbId+'"/>停用</td>';
                        } else if (val.active == "1") {
                            return '<span class="icon-status icon-in-progress"></span><input class="dbIdValue" type="hidden" value="'+val.dbId+'"/>启用</td>';
                        } else if (val.active == "2") {
                            return '<span class="icon-status icon-stopped"></span><input class="dbIdValue" type="hidden" value="'+val.dbId+'"/>待审核</td>';
                        }else{
                            return '<span class="icon-status icon-failed"></span><input class="dbIdValue" type="hidden" value="'+val.dbId+'"/>未通过审核</td>';
                        }
                    }
                }],
                "aoColumnDefs": [{
                    'bVisible':false,
                    'aTargets': [0]
                }]
            };
            table = datatableWrapper.init($('#table_enterprise'), options);
        }

    }
}();
