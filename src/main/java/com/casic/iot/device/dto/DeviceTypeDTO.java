package com.casic.iot.device.dto;



import com.casic.iot.device.domain.Device;
import com.casic.iot.device.domain.DeviceType;
import com.casic.iot.util.DateUtils;

import java.util.ArrayList;
import java.util.List;

public class DeviceTypeDTO {
    private Long id;
    private String typeCode;
    private String typeName;

    public static DeviceTypeDTO ConvertToDTO(DeviceType deviceType) {
        if (null != deviceType) {
            DeviceTypeDTO dto = new DeviceTypeDTO();
            dto.setId(deviceType.getId());
            dto.setTypeCode(deviceType.getTypeCode());
            dto.setTypeName(deviceType.getTypeName());

            return dto;
        }
        return new DeviceTypeDTO();
    }

    public static List<DeviceTypeDTO> ConvertToDTOs(List<DeviceType> list) {
        List<DeviceTypeDTO> dtoList = new ArrayList<DeviceTypeDTO>();
        for (DeviceType deviceType : list) {
            dtoList.add(ConvertToDTO(deviceType));
        }
        return dtoList;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

}
