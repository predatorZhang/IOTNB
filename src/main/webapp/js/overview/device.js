/**
 * Created by Administrator on 2015/7/26.
 */
var overview = function () {

 
    return {

        init: function () {

            Device.initTable();

            //弹出添加设备窗口
            $('#btn-add-dev').live('click', function (e) {
                $("#dg-add-dev").show();
            });

            //关闭添加设备窗口
            $('#btn-close-dg-add-dev').live('click', function (e) {
                $("#dg-add-dev").hide();
            });

        }

    };

}();