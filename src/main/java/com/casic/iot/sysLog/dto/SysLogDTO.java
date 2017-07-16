package com.casic.iot.sysLog.dto;

import com.casic.iot.sysLog.domain.SysLog;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SysLogDTO {
	private Long id;
	private String businessName;
	private String operationType;
	private String content;
	private String createUser;
	private String createTime;
    private String beginDate;
    private String endDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateTime() {
		return createTime;
	}


	public void setCreateTime(Date createTime) {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(null!=createTime){
			this.createTime = dateFormat.format(createTime);
		}
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

    public static SysLogDTO ConvertToDTO(SysLog sysLog) {
		if (null != sysLog) {
			SysLogDTO dto = new SysLogDTO();
			dto.setId(sysLog.getId());
			dto.setBusinessName(sysLog.getBusinessName());
			dto.setContent(sysLog.getContent());
			dto.setCreateTime(sysLog.getCreateTime());
			dto.setCreateUser(sysLog.getCreateUser());
			dto.setOperationType(sysLog.getOperationType());
			return dto;
		}
		return new SysLogDTO();
	}

	public static List<SysLogDTO> ConvertToDTOs(List<SysLog> list) {
		List<SysLogDTO> dtoList = new ArrayList<SysLogDTO>();
		for (SysLog sysLog : list) {
			dtoList.add(ConvertToDTO(sysLog));
		}
		return dtoList;
	}

}
