package com.casic.iot.alarm.dto;

/**
 * Created by lenovo on 2017/7/14.
 */
public enum AlarmEnum {
    PRESS("压力超限","压力监测仪",3),NOISE("管线泄漏","噪声监测仪",3),HYDRANT_OPEN("出水报警","消防栓防盗水监测仪",1),
    HYDRANT_WATER("出水报警","消防栓防盗水监测仪",2),LIQUID("液位超限","全量程液位监测仪",3),GAS("浓度超限","可燃气体泄漏监测仪",1),
    WELL("井盖开启","井盖状态监测仪",1);
    private String alarmType;
    private String devName;
    private int message;
    private AlarmEnum(String alarmType,String devName,int message){
        this.alarmType = alarmType;
        this.devName = devName;
        this.message = message;
    }

    public static AlarmEnum getByAlarmType(String devName,int message){
       for(AlarmEnum alarmEnum:values()){
           if(alarmEnum.getMessage()==message&&alarmEnum.getDevName().equals(devName)){
               return alarmEnum;
           }
       }
       return null;
    }

    public String getAlarmType() {
        return alarmType;
    }

    public void setAlarmType(String alarmType) {
        this.alarmType = alarmType;
    }

    public String getDevName() {
        return devName;
    }

    public void setDevName(String devName) {
        this.devName = devName;
    }

    public int getMessage() {
        return message;
    }

    public void setMessage(int message) {
        this.message = message;
    }
}
