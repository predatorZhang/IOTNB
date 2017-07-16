package com.casic.iot.device.manager;

import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.device.domain.DeviceType;
import com.casic.iot.device.dto.DeviceTypeDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeviceTypeManager extends HibernateEntityDao<DeviceType> {

   public  List<DeviceTypeDTO> getDeviceTypes (){
       List<DeviceTypeDTO> types = DeviceTypeDTO.ConvertToDTOs(findBy("active", true));
       return types;
   }


}
