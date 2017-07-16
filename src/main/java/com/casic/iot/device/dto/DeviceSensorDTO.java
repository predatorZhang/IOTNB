package com.casic.iot.device.dto;

import com.casic.iot.device.domain.DeviceSensor;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 203 on 2015/9/16.
 */
public class DeviceSensorDTO {
    private Long deviceid;
    private Long devTypeId;
    private String deviceName;
    private String sensorcode;
    private String sensorname;
    private String sensorid;
    private String sensoridOld;
    private String devCode;
    private String sensorType;
    private String sensorCode;
    private int page;
    private int rows;

    public DeviceSensorDTO() {
        this.page = this.page <= 0 ? 1 : this.page;
        this.rows = this.rows <= 0 ? 10 : this.rows;
    }

    public Long getDeviceid() {
        return deviceid;
    }

    public void setDeviceid(Long deviceid) {
        this.deviceid = deviceid;
    }

    public Long getDevTypeId() {
        return devTypeId;
    }

    public void setDevTypeId(Long devTypeId) {
        this.devTypeId = devTypeId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getSensorcode() {
        return sensorcode;
    }

    public void setSensorcode(String sensorcode) {
        this.sensorcode = sensorcode;
    }

    public String getSensorname() {
        return sensorname;
    }

    public void setSensorname(String sensorname) {
        this.sensorname = sensorname;
    }

    public String getSensorid() {
        return sensorid;
    }

    public void setSensorid(String sensorid) {
        this.sensorid = sensorid;
    }

    public String getSensoridOld() {
        return sensoridOld;
    }

    public void setSensoridOld(String sensoridOld) {
        this.sensoridOld = sensoridOld;
    }

    public String getDevCode() {
        return devCode;
    }

    public void setDevCode(String devCode) {
        this.devCode = devCode;
    }

    public String getSensorType() {
        return sensorType;
    }

    public void setSensorType(String sensorType) {
        this.sensorType = sensorType;
    }

    public String getSensorCode() {
        return sensorCode;
    }

    public void setSensorCode(String sensorCode) {
        this.sensorCode = sensorCode;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public static DeviceSensorDTO ConvertToDTO(DeviceSensor deviceSensor){
        if(deviceSensor!=null){
            DeviceSensorDTO dto = new DeviceSensorDTO();
            dto.setSensorid(deviceSensor.getId().getSensorid());
            dto.setSensoridOld(deviceSensor.getId().getSensorid());
            if(deviceSensor.getDevice()!=null){
                dto.setDeviceid(deviceSensor.getDevice().getId());
                dto.setDeviceName(deviceSensor.getDevice().getDevName());
            }
            if(deviceSensor.getSensorType()!=null){
                dto.setSensorcode(deviceSensor.getSensorType().getSensorcode());
                dto.setSensorname(deviceSensor.getSensorType().getSensorname());
            }
            return dto;
        }
        return new DeviceSensorDTO();
    }

    public static List<DeviceSensorDTO> ConvertToDTO(List<DeviceSensor> deviceSensors){
        List<DeviceSensorDTO> dtos = new ArrayList<DeviceSensorDTO>();
        for(DeviceSensor deviceSensor : deviceSensors){
            dtos.add(ConvertToDTO(deviceSensor));
        }
        return dtos;
    }

    public static DeviceSensorDTO  setDeviceSensor(DeviceSensorDTO deviceSensorDTO,String devTypeName,String devCode){

        if (devTypeName.equals("全量程液位监测仪")) {
            deviceSensorDTO.setSensorid("液位" +devCode);
            deviceSensorDTO.setSensorcode("000034");
        } else if (devTypeName.equals("噪声监测仪")) {
            deviceSensorDTO.setSensorid("噪声" + devCode);
            deviceSensorDTO.setSensorcode("000032");
        } else if (devTypeName.equals("可燃气体泄漏监测仪")) {
            deviceSensorDTO.setSensorid("浓度" + devCode);
            deviceSensorDTO.setSensorcode("000044");
        } else if (devTypeName.equals("压力监测仪")) {
            deviceSensorDTO.setSensorid("压力" + devCode);
            deviceSensorDTO.setSensorcode("000033");
        } else if (devTypeName.equals("井盖状态监测仪")) {
            deviceSensorDTO.setSensorid("翻转" + devCode);
            deviceSensorDTO.setSensorcode("000048");
        } else if (devTypeName.equals("超声波流量监测仪")) {
            deviceSensorDTO.setSensorid("流量" + devCode);
            deviceSensorDTO.setSensorcode("000031");
        } else if (devTypeName.equals("消防栓防盗水监测仪")) {
            deviceSensorDTO.setSensorid("消防栓" + devCode);
            deviceSensorDTO.setSensorcode("000051");
        } else if (devTypeName.equals("红外高清网络球机")) {
            deviceSensorDTO.setSensorid("摄像头" + devCode);
            deviceSensorDTO.setSensorcode("000052");
        }
        return  deviceSensorDTO;
    }
}
