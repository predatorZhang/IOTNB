package com.casic.iot.device.domain;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.io.Serializable;
import java.text.ParseException;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "ALARM_DEVICE")
@SequenceGenerator(name = "SEQ_DEVICE_ID", sequenceName = "SEQ_DEVICE_ID", allocationSize=1,initialValue=1)
public class Device implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2023118078562324658L;
	private Long id;
	private String devCode;
	private String devName;
	private Date installDate;
	private Boolean active = true;
	private String simid; //SIM卡号
	private String userid;
	private String address;
	private DeviceType deviceType;
	private String status;//0:删除；1、正常运行；2、运行失败；3、停止

	@Column(name = "STATUS", nullable = false)
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "DEVICETYPE_ID", nullable = false)
	@NotFound(action = NotFoundAction.IGNORE)
	public DeviceType getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(DeviceType deviceType) {
		this.deviceType = deviceType;
	}

	@Column(name = "USERID", nullable = false)
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_DEVICE_ID")
	@Column(name = "DBID")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "DEVCODE", nullable = false)
	public String getDevCode() {
		return devCode;
	}

	public void setDevCode(String devCode) {
		this.devCode = devCode;
	}

	@Column(name = "DEVNAME", nullable = false)
	public String getDevName() {
		return devName;
	}

	public void setDevName(String devName) {
		this.devName = devName;
	}


	@Column(name = "INSTALLDATE")
	public Date getInstallDate() {
		return installDate;
	}

	public void setInstallDate(Date installDate) throws ParseException {
		this.installDate = installDate;
	}

	@Column(name = "ACTIVE", nullable = false)
	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	@Column(name = "SIMID")
	public String getSimid() {
		return simid;
	}

	public void setSimid(String simid) {
		this.simid = simid;
	}

	@Column(name = "AREA")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
