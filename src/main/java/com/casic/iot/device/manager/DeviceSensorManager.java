package com.casic.iot.device.manager;
import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.device.domain.DeviceSensor;
import com.casic.iot.device.domain.DeviceSensorId;
import com.casic.iot.device.dto.DeviceDTO;
import com.casic.iot.device.dto.DeviceSensorDTO;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DeviceSensorManager extends HibernateEntityDao<DeviceSensor> {

    private DeviceManager deviceManager;
    private SensorTypeManager sensorTypeManager;

    @Resource
    public void setDeviceManager(DeviceManager deviceManager) {
        this.deviceManager = deviceManager;
    }

    @Resource
    public void setSensorTypeManager(SensorTypeManager sensorTypeManager) {
        this.sensorTypeManager = sensorTypeManager;
    }


    public Criteria getCriteria(){
        return getSession().createCriteria(DeviceSensor.class);
    }



    public Map<String, Object> saveModel(DeviceSensorDTO model) {
        Map<String,Object> map = new HashMap<String, Object>();
        try {
            if(isExist4New(model)){
                map.put("success", false);
                map.put("msg", "传感器已挂载！");
                return map;
            }
            DeviceSensorId id = new DeviceSensorId(model.getSensorcode(),model.getSensorid(),model.getDeviceid());
            DeviceSensor deviceSensor = new DeviceSensor();
            deviceSensor.setId(id);
            deviceSensor.setActive(true);
            deviceSensor.setDevice(deviceManager.get(model.getDeviceid()));
            deviceSensor.setSensorType(sensorTypeManager.get(model.getSensorcode()));
            save(deviceSensor);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.put("success", true);
        map.put("msg", "保存成功！");
        return map;
    }

    private boolean isExist4New(DeviceSensorDTO model) {
        DeviceSensorId id = new DeviceSensorId(model.getSensorcode(),model.getSensorid(),model.getDeviceid());
        Criteria criteria = getCriteria();
        criteria.add(Restrictions.eq("id.sensorcode", model.getSensorcode()));
        criteria.add(Restrictions.eq("id.deviceid", model.getDeviceid()));
        if(criteria.list().size()>0){
            return true;
        }
        return false;
    }


    public void removeDeviceSensorByDevice(Long ID) {
//        String hql = "update DeviceSensor set active=0 where id.deviceid=:devId";
//        Map<String,Object> map = new HashMap<String, Object>();
//        map.put("devId",model.getId());
//        batchUpdate(hql, map);

        Map<String,Object> map = new HashMap<String, Object>();
        String hqlSensor = " from DeviceSensor where active=1 and device.id = '" +ID + "'";
        List<DeviceSensor> deviceSensorList = (List<DeviceSensor>) createQuery(hqlSensor, map).list();
        for(DeviceSensor deviceSensor:deviceSensorList){
            deviceSensor.setActive(false);
            save(deviceSensor);
        }
    }

}
