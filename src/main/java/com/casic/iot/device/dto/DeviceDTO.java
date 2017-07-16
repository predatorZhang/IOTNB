package com.casic.iot.device.dto;



import com.casic.iot.device.domain.Device;
import com.casic.iot.device.domain.DeviceType;
import com.casic.iot.util.DateUtils;

import java.util.ArrayList;
import java.util.List;

public class DeviceDTO {
    private Long id;
    private String devCode;
    private String devName;
    private String typeName;
    private String address;
    private String typeId;
    private String status;
    private String userid;
    private String userName;
    private String simid;
    private String installDate;
    private String ids;
    private String company;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDevCode() {
        return devCode;
    }

    public void setDevCode(String devCode) {
        this.devCode = devCode;
    }

    public String getDevName() {
        return devName;
    }

    public void setDevName(String devName) {
        this.devName = devName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getSimid() {
        return simid;
    }

    public void setSimid(String simid) {
        this.simid = simid;
    }

    public String getInstallDate() {
        return installDate;
    }

    public void setInstallDate(String installDate) {
        this.installDate = installDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public static DeviceDTO ConvertToDTO(Device device){
        if(null!=device){
            DeviceDTO dto = new DeviceDTO();
            dto.setId(device.getId());
            dto.setDevCode(device.getDevCode());
            dto.setDevName(device.getDevName());
            if(null!=device.getInstallDate()) {
                dto.setInstallDate(DateUtils.sdf4.format(device.getInstallDate()));
            } else {
                dto.setInstallDate("");
            }
            dto.setUserid(device.getUserid());
            dto.setStatus(device.getStatus());
            dto.setAddress(device.getAddress());
            dto.setSimid(device.getSimid());

            if (device.getDeviceType() != null & device.getDeviceType().getActive() == true)
            {
                DeviceType type = device.getDeviceType();
                dto.setTypeName(type.getTypeName());
                dto.setTypeId(type.getId() + "");
            }
            return dto;
        }
        return new DeviceDTO();
    }

    public static List<DeviceDTO> ConvertToDTOs(List<Device> list){
        List<DeviceDTO> dtoList = new ArrayList<DeviceDTO>();
        for(Device device : list){
            dtoList.add(ConvertToDTO(device));
        }
        return dtoList;
    }

}
