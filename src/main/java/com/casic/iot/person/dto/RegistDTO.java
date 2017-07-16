package com.casic.iot.person.dto;

import com.casic.iot.person.domain.Regist;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by yxw on 2017/6/22.
 */
public class RegistDTO {

    private Long dbId;
    private String enterpriseName;
    private String passWord;
    private String industry;
    private String userType;
    private String region;
    private String phone;
    private String email;
    private String license;
    private String active;//逻辑删除

    public String getUserType() {
        return userType;
    }
    public void setUserType(String userType) {
        this.userType = userType;
    }

    public Long getDbId() {
        return dbId;
    }

    public void setDbId(Long dbId) {
        this.dbId = dbId;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }


    public static RegistDTO ConvertToDTO(Regist regist){
        try {
            if(null!=regist){
                RegistDTO registDTO = new RegistDTO();
                registDTO.setDbId(regist.getDbId());
                registDTO.setEnterpriseName(regist.getEnterpriseName());
                registDTO.setPassWord(regist.getPassWord());
                registDTO.setRegion(regist.getRegion());
                registDTO.setIndustry(regist.getIndustry());
                registDTO.setPhone(regist.getPhone());
                registDTO.setEmail(regist.getEmail());
                registDTO.setLicense(regist.getLicense());
                registDTO.setActive(String.valueOf(regist.getActive()));
                return registDTO;
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return new RegistDTO();
    }

    public static List<RegistDTO> ConvertToDTOs(List<Regist> regists){
        List<RegistDTO> registDTOs = new ArrayList<RegistDTO>();
        for(Regist regist : regists){
            registDTOs.add(ConvertToDTO(regist));
        }
        return registDTOs;
    }


}
