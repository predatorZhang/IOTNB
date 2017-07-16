/**
 * Created by Administrator on 2015/7/26.
 */
var datatableWrapperAlarm = function () {

    var oTable;
    var iDisplayStart = 0;
    var callback = null;
    var __bindEvent = function () {
        $('.form-search input').bind('input propertychange', function() {
            iDisplayStart = 0;
            oTable.fnDraw();
        });
        //下拉事件
        $('.dropdown-select').bind('change', function() {
            iDisplayStart = 0;
            oTable.fnDraw();
        });
        //翻页按钮
        $('.btn.prev').bind('click', function() {
            iDisplayStart = parseInt(iDisplayStart) - parseInt($('.dropdown-select').val());
            oTable.fnDraw();
        });
        $('.btn.next').bind('click', function() {
            iDisplayStart = parseInt(iDisplayStart) + parseInt($('.dropdown-select').val());
            oTable.fnDraw();
        });
    };

    var __setPagination = function (totalRecords) {

        $(".pages").html("合计：" + totalRecords+"&nbsp;&nbsp;");

        //计算总页数
        var totalPages = Math.ceil(totalRecords / $('.dropdown-select').val());
        $("#totalPages").html("页数："+parseInt(Math.floor(parseInt(iDisplayStart)/$('.dropdown-select').val())+1)+"/"+ totalPages+"&nbsp;&nbsp;");

        //设置翻页按钮
        $(".btn.prev").removeClass("btn-forbidden");
        $(".btn.prev").removeClass("btn-");
        $(".btn.next").removeClass("btn-forbidden");
        $(".btn.next").removeClass("btn-");

        $(".btn.prev").show();
        $(".btn.next").show();
        $("#totalPages").show();

        if(totalPages<=1) {
            //隐藏div
            $(".btn.prev").hide();
            $(".btn.next").hide();
            $("#totalPages").hide();
        }else if(iDisplayStart-$('.dropdown-select').val()<0){
            $(".btn.prev").addClass("btn-forbidden");
            $(".btn.next").addClass("btn-");
        }else if(iDisplayStart+1>(totalPages-1)*$('.dropdown-select').val()){
            $(".btn.prev").addClass("btn-");
            $(".btn.next").addClass("btn-forbidden");
        }else{
            $(".btn.prev").addClass("btn-");
            $(".btn.next").addClass("btn-");
        }

    };
    return {

        init: function (datatable,options) {
            __bindEvent();

            function retrieveData(sSource, aoData, fnCallback) {
                $.ajax({
                    type: "POST",
                    url: sSource,
                    dataType: "json",
                    data: {
                        jsonParam: JSON.stringify(aoData),
                        search: $('.form-search input').val(),
                        iDisplayStart:iDisplayStart,
                        iDisplayLength: $('.dropdown-select').val(),
                        deviceTypeName:$('#deviceTypeName').val()
                    },
                    success: function (data) {
                        fnCallback(data);
                        var totalRecords = data.iTotalDisplayRecords;
                        __setPagination(totalRecords);
                        if(callback!=null) {
                            callback(data);
                        }

                    }
                });
            }

            var sAjaxSource = options.sAjaxSource;
            callback=options.callback;
            var aoColumns = options.aoColumns;
            var aoColumnDefs = options.aoColumnDefs;

            oTable = datatable.dataTable({
                "bAutoWidth":false,
                "bServerSide": true,
                "bFilter": false,
                "bLengthChange": false,
                "bPaginate": false,
                "bInfo": false,//去掉底部文字
                "sAjaxSource": sAjaxSource,
                "fnServerData": retrieveData,
                "aoColumns": aoColumns,
                "aoColumnDefs": aoColumnDefs
            });
            return oTable;
        }
    };

}();