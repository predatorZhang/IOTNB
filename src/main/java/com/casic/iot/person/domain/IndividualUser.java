package com.casic.iot.person.domain;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by yxw on 2017/6/22.
 */
@Entity
@Table(name = "IOT_USER")
@SequenceGenerator(name = "SEQ_IOT_USER_ID", sequenceName = "SEQ_IOT_USER_ID", allocationSize=1,initialValue=1)
public class IndividualUser implements Serializable {

    private static final long serialVersionUID = -2023118078562324658L;
    private Long dbId;
    private String userName;
    private String password;
    private String phone;
    private String email;
    private int active;//逻辑删除
    private Regist regist;
    private Date createTime;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_IOT_USER_ID")
    @Column(name = "DBID")
    public Long getDbId() {
        return dbId;
    }

    public void setDbId(Long dbId) {
        this.dbId = dbId;
    }

    @Column(name = "USER_NAME")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Column(name = "PASSWORD")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    @Column(name = "ACTIVE")
    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name="ENTERPRISE_ID")
    public Regist getRegist() {
        return regist;
    }

    public void setRegist(Regist regist) {
        this.regist = regist;
    }

    @Column(name="CREATETIME")
    public Date getCreateTime(){
        return createTime;
    }
    public void setCreateTime(Date createTime){
        this.createTime = createTime;
    }
}
