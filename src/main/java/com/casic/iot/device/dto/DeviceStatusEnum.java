package com.casic.iot.device.dto;

/**
 * Created by admin on 2017/4/6.
 */
public enum DeviceStatusEnum {

    DELETE("删除",0),
    START("运行中",1),
    FAILED("失败",2),
    STOP("停止",3);

    // 成员变量
    private String name;
    private int index;
    // 构造方法
    private DeviceStatusEnum(String name, int index){
        this.name=name;
        this.index=index;
    }
   public int getIndex(){
       return this.index;
   }
    public String getName(){
        return this.name;
    }
    public static DeviceStatusEnum getByIndex(String index) {
        try {
            for (DeviceStatusEnum temp : values()) {
                if (temp.index == Integer.parseInt(index)) {
                    return temp;
                }
            }
        } catch (Exception e) {}
        return null;
    }
    //覆盖方法
    @Override
    public String toString(){
        return this.name;
    }


}
