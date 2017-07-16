package com.casic.iot.device.manager;


import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.core.page.Page;
import com.casic.iot.device.domain.SensorType;
import com.casic.iot.device.dto.SensorTypeDTO;
import com.casic.iot.sysLog.manager.SysLogManager;
import com.casic.iot.util.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SensorTypeManager extends HibernateEntityDao<SensorType> {

    private SysLogManager sysLogManager;

    @Resource
    public void setSysLogManager(SysLogManager sysLogManager) {
        this.sysLogManager = sysLogManager;
    }

    public Criteria getCriteria(){
        return getSession().createCriteria(SensorType.class);
    }

    public Map pageQuerySensor(SensorTypeDTO model)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            StringBuilder hql = new StringBuilder();
            hql.append("from SensorType where active=1");
            if (null!=model.getSensorcode() ) {
                hql.append(" and sensorcode=:sensorcode");
                map.put("sensorcode", model.getSensorcode());
            }
            if (StringUtils.isNotBlank(model.getSensorname())) {
                hql.append(" and sensorname like :sensorname");
                map.put("sensorname", "%" +  model.getSensorname() + "%");
            }
            hql.append(" order by id desc");
            Page p = pagedQuery(hql.toString(), model.getPage(), model.getRows(), map);
            List<SensorType> list = (List<SensorType>) p.getResult();
            int total = (int) p.getTotalCount();

            List<SensorTypeDTO> dtos = SensorTypeDTO.ConvertToDTOs(list);
            map.clear();
            map.put("rows", dtos);
            map.put("total", total);

        } catch (Exception e) {
            e.printStackTrace();
            map.clear();
            map.put("rows", new ArrayList<SensorTypeDTO>());
            map.put("total", 0);
        } finally {
//            sysLogManager.saveSysLog("传感器类型", "search","查询");
        }
        return map;
    }

    public Map saveSensorType(SensorTypeDTO model)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        try
        {
            Criteria criteria = getCriteria();
            criteria.add(Restrictions.eq("isuse", true));
            criteria.add(Restrictions.eq("sensorcode", model.getSensorcode()));
            if (criteria.list().size() > 0)
            {
                map.put("success", true);
                map.put("msg", "编码重复！");
                return map;
            }

            SensorType sensorType = new SensorType();
            sensorType.setDefaultid(model.getDefaultid());
            sensorType.setSensorname(model.getSensorname());
            sensorType.setSensorcode(model.getSensorcode());
            save(sensorType);

            map.put("success", true);
            map.put("msg", "保存成功");
            return map;

        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", true);
            map.put("msg", "保存失败！");
            return map;
        } finally {
//            sysLogManager.saveSysLog("传感器类型", "add", "新增传感器类型：\""+model.getSensorname() + "\"，" + map.get("msg"));
        }
    }

    public Map editSensorTyp(SensorTypeDTO model)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        try
        {
            SensorType sensorType = get(model.getSensorcode());
            sensorType.setSensorname(model.getSensorname());
            sensorType.setDefaultid(model.getDefaultid());
            save(sensorType);
            map.put("success", true);
            map.put("msg", "编辑成功！");
            return map;
        }
        catch (Exception e)
        {
            e.printStackTrace();
            map.put("success", false);
            map.put("msg", "编辑失败！");
            return map;
        } finally {
//            sysLogManager.saveSysLog("传感器类型", "edit",
//                                     "编辑传感器类型：\"" + model.getSensorname() + "\"，" + map.get("msg"));
        }
    }

}
