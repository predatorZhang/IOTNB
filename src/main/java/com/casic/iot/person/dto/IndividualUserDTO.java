package com.casic.iot.person.dto;

import com.casic.iot.person.domain.IndividualUser;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by yxw on 2017/6/22.
 */
public class IndividualUserDTO {

    private Long dbId;
    private String userName;
    private String password;
    private String phone;
    private String email;
    private String active;//逻辑删除
    private String ids;

    public Long getDbId() {
        return dbId;
    }

    public void setDbId(Long dbId) {
        this.dbId = dbId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public static IndividualUserDTO ConvertToDTO(IndividualUser individualUser){

        try {
            if(null!=individualUser){
                IndividualUserDTO individualUserDTO = new IndividualUserDTO();
                individualUserDTO.setDbId(individualUser.getDbId());
                individualUserDTO.setUserName(individualUser.getUserName());
                individualUserDTO.setPassword(individualUser.getPassword());
                individualUserDTO.setPhone(individualUser.getPhone());
                individualUserDTO.setEmail(individualUser.getEmail());

                individualUserDTO.setActive(String.valueOf(individualUser.getActive()));

                return individualUserDTO;
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return new IndividualUserDTO();
    }

    public static List<IndividualUserDTO> ConvertToDTOs(List<IndividualUser> individualUsers){
        List<IndividualUserDTO> individualUserDTOs = new ArrayList<IndividualUserDTO>();
        for(IndividualUser user : individualUsers){
            individualUserDTOs.add(ConvertToDTO(user));
        }
        return individualUserDTOs;
    }

}
