/**
 * Created by Administrator on 2015/7/26.
 */
var Index = function () {

    var devCountPickerCallback = function(start,end) {
        $('#dev-count-range span').html(start.toString('yyyy-MM-d') + ' ~ ' + end.toString('yyyy-MM-d'));
    };

    var userCountPickerCallback = function (start,end) {
        $('#user-count-range span').html(start.toString('yyyy-MM-d') + ' ~ ' + end.toString('yyyy-MM-d'));
    };

    var alarmCountPickerCallback = function (start,end) {
        $('#alarm-count-range span').html(start.toString('yyyy-MM-d') + ' ~ ' + end.toString('yyyy-MM-d'));
    };

    return {

        init: function () {
            Index.initDatePicker();
        },
        initDatePicker:function() {
            var option ={
                opens: (App.isRTL() ? 'right' : 'left'),
                // format: 'MM/dd/yyyy',
                format: 'yyyy/MM/dd',
                separator: ' to ',
                startDate: Date.today().add({
                    days: -29
                }),
                endDate: Date.today(),
                locale: {
                    applyLabel: '确定',
                    fromLabel: '开始',
                    toLabel: '结束',
                    customRangeLabel: '自定义',
                    daysOfWeek: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
                    monthNames: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                    firstDay: 1
                },
                showWeekNumbers: true,
                buttonClasses: ['btn-danger']
            };

            $('#dev-count-range').daterangepicker(option,devCountPickerCallback);
            $('#dev-count-range').show();
            $('#dev-count-range span').html(Date.today().add({
                    days: -29
                }).toString('yyyy-MM-d') + '~ ' + Date.today().toString('yyyy-MM-d'));

            $('#user-count-range').daterangepicker(option,userCountPickerCallback);
            $('#user-count-range').show();
            $('#user-count-range span').html(Date.today().add({
                    days: -29
                }).toString('yyyy-MM-d') + '~ ' + Date.today().toString('yyyy-MM-d'));

            $('#alarm-count-range').daterangepicker(option,alarmCountPickerCallback);
            $('#alarm-count-range').show();
            $('#alarm-count-range span').html(Date.today().add({
                    days: -29
                }).toString('yyyy-MM-d') + '~ ' + Date.today().toString('yyyy-MM-d'));

            $('.daterangepicker.dropdown-menu').hide();
            $('.range_inputs input').css("width", 120);
        }
    };

}();