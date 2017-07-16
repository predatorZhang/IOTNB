package com.casic.iot.person.domain;

/**
 * Created by yxw on 2017/6/22.
 */

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


@Entity
@Table(name = "IOT_ENTERPRISE")
@SequenceGenerator(name = "SEQ_IOT_ENTERPRISE_ID", sequenceName = "SEQ_IOT_ENTERPRISE_ID", allocationSize=1,initialValue=1)
public class Regist implements Serializable {
    private static final long serialVersionUID = -2023118078562324658L;
    private Long dbId;
    private String enterpriseName;
    private String passWord;
    private String industry;
    private String region;
    private String phone;
    private String email;
    private String license;
    private int active;//逻辑删除
    private List<IndividualUser> users;
    private Date registerDate;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_IOT_ENTERPRISE_ID")
    @Column(name = "DBID")
    public Long getDbId() {
        return dbId;
    }

    public void setDbId(Long dbId) {
        this.dbId = dbId;
    }

    @Column(name = "ENTERPRISE_NAME")
    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    @Column(name = "INDUSTRY")
    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    @Column(name = "PASSWORD")
    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    @Column(name = "REGION")
    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    @Column(name = "PHONE")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "EMAIL")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "LICENSE")
    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    @Column(name = "ACTIVE")
    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    @OneToMany(fetch=FetchType.LAZY,mappedBy = "regist")
    public List<IndividualUser> getUsers() {
        return users;
    }

    public void setUsers(List<IndividualUser> users) {
        this.users = users;
    }

    @Column(name = "REGISTERDATE")
    public Date getRegisterDate(){return registerDate;}

    public void setRegisterDate(Date registerDate){
        this.registerDate = registerDate;
    }
}
