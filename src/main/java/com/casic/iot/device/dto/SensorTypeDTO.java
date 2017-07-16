package com.casic.iot.device.dto;


import com.casic.iot.device.domain.SensorType;

import java.util.ArrayList;
import java.util.List;

public class SensorTypeDTO {
	private String sensorcode;
	private String sensorname; 
	private Boolean isuse;
	private String defaultid;
    private int page;
    private int rows;

    public Boolean getIsuse() {
		return isuse;
	}
	public void setIsuse(Boolean isuse) {
		this.isuse = isuse;
	}
	public String getDefaultid() {
		return defaultid;
	}
	public void setDefaultid(String defaultid) {
		this.defaultid = defaultid;
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

    public SensorTypeDTO() {

        this.page = this.page <= 0 ? 1 : this.page;
        this.rows = this.rows <= 0 ? 10 : this.rows;

    }

    public static SensorTypeDTO ConvertToDTO(SensorType sensorType) {
        if (null != sensorType) {
            SensorTypeDTO dto = new SensorTypeDTO();
            dto.setSensorcode(sensorType.getSensorcode());
            dto.setSensorname(sensorType.getSensorname());
            dto.setDefaultid(sensorType.getDefaultid());
            dto.setIsuse(sensorType.getIsuse());
            return dto;
        }
        return new SensorTypeDTO();
    }

    public static List<SensorTypeDTO> ConvertToDTOs(List<SensorType> list) {
        List<SensorTypeDTO> dtoList = new ArrayList<SensorTypeDTO>();
        for (SensorType sensorType : list) {
            dtoList.add(ConvertToDTO(sensorType));
        }
        return dtoList;
    }

}
