/**
 * Created by Administrator on 2015/7/26.
 */
var deviceDetail = function () {
    var datas = [];
    var times = [];
    var alarmTimes = [];
    var alarmDatas = [];
    var startDate;
    var endDate;
    var dev_data_option = {
        backgroundColor: '#F8FBFD',//背景色
        title: {
            text: '采集数据显示',
            left: 'center',
            bottom: 0
        },
        tooltip: {
            trigger: 'none',
            axisPointer: {
                type: 'cross'
            }
        },
        legend: {
            data: ['实时数据']
        },
        grid: {
            top: 20,
            bottom: 50
        },
        xAxis: [
            {
                type: 'category',
                axisTick: {
                    alignWithLabel: true
                },
                axisLine: {
                    onZero: false
                },
                axisPointer: {
                    label: {
                        formatter: function (params) {
                            return "时间：" + params.value + "\n" +
                                "采集值" + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
                        }
                    }
                },
                data: times
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '设备数量',
                type: 'line',
                smooth: true,
                itemStyle: {
                    normal: {
                        color: '#8CC9E7'
                    }
                },
                data: datas
            }
        ]
    };
    var dev_alarm_option = {
        backgroundColor: '#F8FBFD',//背景色
        title: {
            text: '报警状态显示',
            left: 'center',
            bottom: 0
        },
        tooltip: {
            //trigger: 'axis'
            trigger: 'item',
            formatter: function (params) {
                if (params.data == 1) {
                    return params.name+":正常";
                } else {
                    return params.name +":报警";
                }
            }
        },

        xAxis: [
            {
                type: 'category',
                data: alarmTimes
            }
        ],
        yAxis: [
            {
                type: 'value',
                min: 0,
                max: 2,
                interval: 0.5
            }
        ],
        series: [
            {
                name: '报警',
                type: 'bar',
                data: alarmDatas,
                itemStyle: {
                    normal: {
                        color: function (value) {
                            if (value.value > 1) {
                                return 'red'
                            }
                            else {
                                return 'green'
                            }
                        }
                    }
                }
            }
        ]
    };
    var initDateBox = function () {
        //datterangepicker initialization
        $('#dashboard-report-range').daterangepicker({
            ranges: {
                '今天': ['today', 'today'],
                '昨天': ['yesterday', 'yesterday'],
                '过去一周': [Date.today().add({
                    days: -6
                }), 'today'],
                '过去一月': [Date.today().add({
                    days: -29
                }), 'today'],
                '当月': [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()],
                '上月': [Date.today().moveToFirstDayOfMonth().add({
                    months: -1
                }), Date.today().moveToFirstDayOfMonth().add({
                    days: -1
                })]
            },
            opens: (App.isRTL() ? 'right' : 'left'),
            // format: 'MM/dd/yyyy',
            format: 'yyyy/MM/dd',
            separator: ' to ',
            startDate: Date.today().add({
                days: -29
            }),
            endDate: Date.today(),
            /*    minDate: '01/01/2012',
             maxDate: '12/31/2014',*/
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
        }, function (start, end) {
            $('#dashboard-report-range span').html(start.toString('yyyy年MM月d日') + ' ~ ' + end.toString('yyyy年MM月d日'));
            startDate = start.toString('yyyy-MM-dd');
            endDate = end.toString('yyyy-MM-dd');
            initDataChart();
            initAlarmChart();
        });
        $('#dashboard-report-range').show();
        $('#dashboard-report-range span').html(Date.today().add({
                days: -29
            }).toString('yyyy年MM月d日') + '~ ' + Date.today().toString('yyyy年MM月d日'));
        $('.daterangepicker.dropdown-menu').hide();
        $('.range_inputs input').css("width", 120);
    };

    var setStartEndDate = function () {
        startDate = $('#dashboard-report-range').data('daterangepicker').startDate.toString('yyyy-MM-dd');
        endDate = $('#dashboard-report-range').data('daterangepicker').endDate.toString('yyyy-MM-dd');
    };

    var getUnit = function (devType) {
        var unit;
        if (devType == "全量程液位监测仪") {
            unit = 'm';
        } else if (devType == "噪声监测仪") {
            unit = 'mg';
        } else if (devType == "可燃气体泄漏监测仪") {
            unit = '%';
        } else if (devType == "超声波流量监测仪") {
            unit = 'm3/h';
        } else if (devType == "压力监测仪") {
            unit = 'MPa';
        } else if (devType == "井盖状态监测仪") {
            unit = '';

        } else if (devType == "消防栓防盗水监测仪") {
            //todo List 消防栓无心跳表
        } else {

        }
        return unit;
    };

    var getUrlByDevType = function (devType) {
        var url;
        if (devType == "全量程液位监测仪") {
            url = config.getBaseServiceUrl() + "/liquid/getData.do";
        } else if (devType == "噪声监测仪") {
            url = config.getBaseServiceUrl() + "/noise/getData.do";
        } else if (devType == "可燃气体泄漏监测仪") {
            url = config.getBaseServiceUrl() + '/gas/getData.do';
        } else if (devType == "超声波流量监测仪") {
            url = config.getBaseServiceUrl() + '/flow/getData.do';
        } else if (devType == "压力监测仪") {
            url = config.getBaseServiceUrl() + '/press/getData.do';
        } else if (devType == "井盖状态监测仪") {
            url = config.getBaseServiceUrl() + '/well/getData.do';
        } else if (devType == "消防栓防盗水监测仪") {
            //todo List 消防栓无心跳表
        } else {

        }
        return url;
    };

    var refreshData = function (myChart, data, times) {
        if (!myChart) {
            return;
        }
        //更新数据
        var option = myChart.getOption();
        option.series[0].data = data;
        option.xAxis[0].data = times;
        myChart.setOption(option, true);
    }

    var getDataList = function (devType, jdata) {

        var jDataList;
        if (devType == "全量程液位监测仪") {
            jDataList = jdata.values;
        } else if (devType == "噪声监测仪") {
            jDataList = jdata.data;
        } else if (devType == "可燃气体泄漏监测仪") {
            jDataList = jdata.flows;
        } else if (devType == "超声波流量监测仪") {
            jDataList = jdata.flowList;
        } else if (devType == "压力监测仪") {
            jDataList = jdata.pressList;
        } else if (devType == "井盖状态监测仪") {
            jDataList = jdata.datas;

        } else if (devType == "消防栓防盗水监测仪") {
            //todo List 消防栓无心跳表
        } else {

        }
        return jDataList;
    };

    var pushDatas = function (dataList, devType) {
        if (devType == "井盖状态监测仪") {
            for (var i = 0; i < dataList.length; i++) {
                times.push(dataList[i][0]);
                datas.push(dataList[i][1] + 1);

            }
            var myChart = echarts.init(document.getElementById('dev_data_show'));
            myChart.setOption(dev_alarm_option, true);
            refreshData(myChart, datas, times);
            times = [];
            datas = [];
        } else {
            for (var i = 0; i < dataList.length; i++) {
                times.push(new Date(dataList[i][0]).Format("yyyy-MM-dd hh:mm:ss"));
                datas.push(dataList[i][1]);

            }
            var myChart = echarts.init(document.getElementById('dev_data_show'));
            myChart.setOption(dev_data_option, true);
            refreshData(myChart, datas, times);
            times = [];
            datas = [];
        }
    };

    var initDataChart = function () {
        var urlPath = getUrlByDevType($("#devType").val());
        if ($("#devType").val() == "井盖状态监测仪") {
            $("#alarm_chart").hide();
        }
        $("#unit").text(getUnit($("#devType").val()));
        $.ajax({
            type: "get",
            url: urlPath,
            crossDomain: true,
            data: {
                devcode: $("#devCode_chart").val(),
                beginDate: startDate,
                endDate: endDate
            },
            dataType: 'jsonp',
            jsonp: "jsoncallback",
            jsonpCallback: "success_jsoncallback",
            success: function (data) {
                var jData = data;
                if (jData.success == true) {
                    var dataList = getDataList($("#devType").val(), jData);
                    if (dataList) {
                        pushDatas(dataList, $("#devType").val());
                    }
                }
            },
            error: function (request) {
                //alert("网络连接错误");
            }
        });
    };

    var initAlarmChart = function () {
        var urlAlarm = $("#context").val() + '/alarmRecord/getData.do';
        $.ajax({
            type: "post",
            url: urlAlarm,
            data: {
                devcode: $("#devCodeAlarm").val(),
                beginDate: startDate,
                endDate: endDate
            },
            dataType: 'json',
            success: function (data) {
                var jData = data;
                if (jData.success == true) {

                    var dataList = jData.datas;
                    var dataList = jData.alarmList;
                    if (dataList) {
                        for (var i = 0; i < dataList.length; i++) {
                            alarmTimes.push(dataList[i]);
                            alarmDatas.push(2);
                        }
                    }
                    var alarmChart = echarts.init(document.getElementById('dev_alarm_show'));
                    alarmChart.setOption(dev_alarm_option, true);
                    refreshData(alarmChart, alarmDatas, alarmTimes);
                    alarmTimes = [];
                    alarmDatas = [];
                }

            },
            error: function (request) {
                //alert("网络连接错误");
            }
        });
    };

    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1,                 //月份
            "d+": this.getDate(),                    //日
            "h+": this.getHours(),                   //小时
            "m+": this.getMinutes(),                 //分
            "s+": this.getSeconds(),                 //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds()             //毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };
    return {

        init: function () {
            initDateBox();
            setStartEndDate();
            initDataChart();
            initAlarmChart();
        }
    }

}();