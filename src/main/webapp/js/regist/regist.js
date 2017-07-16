/**
 * Created by yxw on 2017/6/27.
 */
/**
 * Created by Administrator on 2015/7/26.
 */
var Regist = function () {
    var initButtons = function () {

        //取消按钮
        $('.btn-cancel').live('click', function (e) {
            window.history.back(-1);
        });

    }

        return {

            init: function () {
                //初始化table
                initButtons();
            }
        };

    }();