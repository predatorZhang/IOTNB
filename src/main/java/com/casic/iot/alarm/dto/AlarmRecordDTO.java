package com.casic.iot.alarm.dto;

import com.casic.iot.alarm.domain.AlarmRecord;
import com.casic.iot.device.dto.DeviceDTO;
import com.casic.iot.util.DateUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by test203 on 2017/6/21.
 */
public class AlarmRecordDTO {
    private String deviceId;
    private String deviceTypeName;
    private String itemName;
    private String message;
    private String messageStatus;
    private String recordDate;
    private String deviceCode;
    private String address;
    private String itemValue;
    private String deviceName;
    private String beginDate;
    private String endDate;
    private String devCode;
    private Long id;

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceTypeName() {
        return deviceTypeName;
    }

    public void setDeviceTypeName(String deviceTypeName) {
        this.deviceTypeName = deviceTypeName;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessageStatus() {
        return messageStatus;
    }

    public void setMessageStatus(String messageStatus) {
        this.messageStatus = messageStatus;
    }

    public String getRecordDate() {
        return recordDate;
    }

    public void setRecordDate(String recordDate) {
        this.recordDate = recordDate;
    }

    public String getDeviceCode() {
        return deviceCode;
    }

    public void setDeviceCode(String deviceCode) {
        this.deviceCode = deviceCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getItemValue() {
        return itemValue;
    }

    public void setItemValue(String itemValue) {
        this.itemValue = itemValue;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getDevCode() {
        return devCode;
    }

    public void setDevCode(String devCode) {
        this.devCode = devCode;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public static AlarmRecordDTO ConvertToDTO(AlarmRecord alarmRecord){
        if(null!=alarmRecord){
            AlarmRecordDTO dto = new AlarmRecordDTO();
            dto.setId(alarmRecord.getId());
            dto.setDevCode(alarmRecord.getDeviceCode());
            dto.setDeviceTypeName(alarmRecord.getDeviceTypeName());
            if(null!=alarmRecord.getRecordDate()) {
                dto.setRecordDate(DateUtils.sdf4.format(alarmRecord.getRecordDate()));
            } else {
                dto.setRecordDate("");
            }
            dto.setItemValue(alarmRecord.getItemValue());
            dto.setItemName(alarmRecord.getItemName());
            dto.setMessageStatus(alarmRecord.getMessageStatus().toString());
            if(null!=alarmRecord.getDevice()){
                dto.setAddress(alarmRecord.getDevice().getAddress());
            }
            if(dto.getAddress()==null){
                dto.setAddress("--");
            }
            if(dto.getItemValue()==null) dto.setItemValue("--");

            return dto;
        }
        return new AlarmRecordDTO();
    }

    public static List<AlarmRecordDTO> ConvertToDTOs(List<AlarmRecord> list){
        List<AlarmRecordDTO> dtoList = new ArrayList<AlarmRecordDTO>();
        for(AlarmRecord alarmRecord : list){
            dtoList.add(ConvertToDTO(alarmRecord));
        }
        return dtoList;
    }
}
