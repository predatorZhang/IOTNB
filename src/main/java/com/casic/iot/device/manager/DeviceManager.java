package com.casic.iot.device.manager;

import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.core.hibernate.HibernateUtils;
import com.casic.iot.core.hibernate.MatchType;
import com.casic.iot.core.page.Page;
import com.casic.iot.core.util.StringUtils;
import com.casic.iot.device.domain.Device;
import com.casic.iot.device.domain.DeviceSensor;
import com.casic.iot.device.dto.DeviceDTO;
import com.casic.iot.device.dto.DeviceSensorDTO;
import com.casic.iot.person.domain.IndividualUser;
import com.casic.iot.person.domain.Regist;
import com.casic.iot.person.manager.IndividualUserManager;
import com.casic.iot.person.manager.RegistManager;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.xls.ExportExcel;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.*;

@Service
public class DeviceManager extends HibernateEntityDao<Device> {

    @Resource
    private RegistManager registManager;
    @Resource
    private DeviceSensorManager deviceSensorManager;

    public Criteria getCriteria() {
        return getSession().createCriteria(Device.class);
    }

    public DeviceDTO getDTO(Long id) {
        if (null != id) {
            return DeviceDTO.ConvertToDTO(get(id));
        }
        return new DeviceDTO();
    }

    public Boolean isExits(DeviceDTO dto) {
        Device device = null;
        Criteria criteria = getCriteria();
        criteria.add(Restrictions.and(
                HibernateUtils.buildCriterion("active", true, MatchType.EQ),
                HibernateUtils.buildCriterion("devCode", dto.getDevCode(), MatchType.EQ)));
        List<Device> list = criteria.list();
        if (list.size() > 1)//如果系统中已经存在一个以上，则肯定存在
        {
            return true;
        }

        if (list.size() == 1) {
            if (dto.getId() == null)//如果是新增的话，系统中存在一个则为已经存在
            {
                return true;
            }
            if (list.get(0).getId().longValue() != dto.getId().longValue())//如果是修改
            {
                return true;
            }
        }
        return false;
    }

    public void saveDevcieSensor(DeviceDTO model) {

        Map<String, Object> paraMap = new HashMap<String, Object>();
        String hql = " from Device where active=1 and devCode = '" + model.getDevCode() + "'";
        List<Device> deviceList = (List<Device>) createQuery(hql, paraMap).list();
        for (Device device : deviceList) {
            if (device.getId().longValue() == model.getId().longValue()) {
                String devTypeName = device.getDeviceType().getTypeName();
                DeviceSensorDTO deviceSensorDTO = new DeviceSensorDTO();
                deviceSensorDTO.setDeviceid(model.getId());
                deviceSensorDTO = DeviceSensorDTO.setDeviceSensor(deviceSensorDTO, devTypeName, model.getDevCode());
                if (null != deviceSensorDTO.getSensorcode()) {
                    deviceSensorManager.saveModel(deviceSensorDTO);
                }
            }
        }
    }
    public void editDevcieSensor(DeviceDTO model) {

        Map<String, Object> paraMap = new HashMap<String, Object>();
        Map<String, Object> paraMapSensor = new HashMap<String, Object>();
        String hql = " from Device where active=1 and devCode = '" + model.getDevCode() + "'";
        List<Device> deviceList = (List<Device>) createQuery(hql, paraMap).list();
        for (Device device : deviceList) {
            if (device.getId().longValue() == model.getId().longValue()) {
                String devTypeName = device.getDeviceType().getTypeName();
                DeviceSensorDTO deviceSensorDTO = new DeviceSensorDTO();
                deviceSensorDTO.setDeviceid(model.getId());
                deviceSensorDTO = DeviceSensorDTO.setDeviceSensor(deviceSensorDTO, devTypeName, model.getDevCode());
                String hqlSensor = " from DeviceSensor where active=1 and device.devCode = '" + model.getDevCode() + "'";
                List<DeviceSensor> deviceSensorList = (List<DeviceSensor>) createQuery(hqlSensor, paraMapSensor).list();
                for (DeviceSensor deviceSensor : deviceSensorList) {
                    deviceSensor.setActive(false);
                    deviceSensorManager.save(deviceSensor);
                }
                if (null != deviceSensorDTO.getSensorcode()) {
                    deviceSensorManager.saveModel(deviceSensorDTO);
                }
            }
        }
    }
    //todo list:后期换成对应的DTO
    public DataTable<DeviceDTO> pageQuery(DataTableParameter parameter, HttpSession session) {
        try {
            Long compId = (Long) session.getAttribute(com.casic.iot.util.StringUtils.SYS_DBID);
//            Regist regist = registManager.findUniqueBy("dbId", compId);
            int start = parameter.getiDisplayStart();
            int pageSize = parameter.getiDisplayLength();
            int pageNo = (start / pageSize) + 1;

            Criteria criteria = getCriteria();
            criteria.addOrder(Order.desc("id"));
            criteria.add(Restrictions.eq("active", true));
            criteria.add(Restrictions.eq("userid", String.valueOf(compId)));//确认为企业用户ID

            if (StringUtils.isNotBlank(parameter.getsSearch())) {
                criteria.add(Restrictions.like("devCode", "%" + parameter.getsSearch() + "%"));
            }

            Page page = pagedQuery(criteria, pageNo, pageSize);

            List<Device> dtoList = (List<Device>) page.getResult();
            List<DeviceDTO> dtos = DeviceDTO.ConvertToDTOs(dtoList);

            DataTable<DeviceDTO> dt = new DataTable<DeviceDTO>();
            dt.setAaData(dtos);
            dt.setiTotalDisplayRecords((int) page.getTotalCount());
            dt.setsEcho(parameter.getsEcho());
            dt.setiTotalRecords((int) page.getTotalCount());
            return dt;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public List<DeviceDTO> queryDevices(String search,HttpSession session){
        try {
            Long compId = (Long) session.getAttribute(com.casic.iot.util.StringUtils.SYS_DBID);
            Criteria criteria = getCriteria();
            criteria.addOrder(Order.desc("id"));
            criteria.add(Restrictions.eq("active", true));
            criteria.add(Restrictions.eq("userid", String.valueOf(compId)));//确认为企业用户ID
            if (StringUtils.isNotBlank(search)) {
                criteria.add(Restrictions.like("devCode", "%" +search + "%"));
            }
            List<Device> dtoList = (List<Device>) criteria.list();
            List<DeviceDTO> dtos = DeviceDTO.ConvertToDTOs(dtoList);
            return dtos;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public Map<String, Object> expDevicesToExcel(String search, HttpSession session, String path) throws ParseException, IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        List<DeviceDTO> dtoList = queryDevices(search, session);
        String[] headers = {"设备编号", "设备名称", "当前状态", "设备类型", "创建时间"};
        OutputStream out = new FileOutputStream(path);
        List<String[]> exportDatas = new ArrayList<String[]>(dtoList.size());
        for (DeviceDTO deviceDTO : dtoList) {
            String status = deviceDTO.getStatus();
            if(StringUtils.isEmpty(status)) status = "运行中";
            else{
                switch (status){
                    case "1":status = "运行中";
                        break;
                    case "2":status ="失败";
                        break;
                    default:status = "停止";
                        break;
                }
            }
            String[] line = {deviceDTO.getDevCode(),deviceDTO.getDevName(),status,deviceDTO.getTypeName(),deviceDTO.getInstallDate()};
            exportDatas.add(line);
        }
        map.put("success", ExportExcel.exportExcel("设备列表", headers, exportDatas, out));
        map.put("message", "设备列表导出成功！");
        return map;
    }

    public List statByDevType(){
        Criteria criteria = this.getCriteria();
        criteria.add(Restrictions.eq("active", true));
        criteria.add(Restrictions.isNotNull("userid"));
        criteria.createAlias("deviceType","deviceType");
        criteria.setProjection(Projections.projectionList().
                add(Projections.groupProperty("deviceType.typeName")).
                add(Projections.rowCount()));
        return criteria.list();
    }

    public List statByDevArea(){
        Criteria criteria = this.getCriteria();
        criteria.add(Restrictions.eq("active", true));
        criteria.add(Restrictions.isNotNull("userid"));
        criteria.setProjection(Projections.projectionList().
                add(Projections.groupProperty("address")).
                add(Projections.rowCount()));
        return criteria.list();
    }
    //按所属行业进行统计
    public List statByIndustry(){
      String sql = " select e.industry,count(1) from alarm_device t left join iot_enterprise e on t.userid = e.dbid where t.active=1 and t.userid is not null group by e.industry";
      Query query =this.getSession().createSQLQuery(sql);
      return query.list();
    }

    /**
     *
     * @param statType    0增量 1总量
     * @param statStyle   0年  1 月   2日
     * @param devType     设备类型名称
     * @param beginDate   统计开始时间
     * @param endDate     统计结束时间
     * @return
     */
    public List statDev(int statType,int statStyle,String devType,String beginDate,String endDate){
        String groupStyle = "",condition ="";
        if(statStyle==0) groupStyle = "to_char(installdate,'yyyy')";
        else if(statStyle==1) groupStyle = "to_char(installdate,'yyyy-mm')";
        else if(statStyle==2) groupStyle = "to_char(installdate,'yyyy-mm-dd')";
        if(StringUtils.isNotBlank(devType)&&!devType.equals("全部")){
            condition = " and t.typename = '"+devType+"' ";
        }
        if(StringUtils.isNotBlank(beginDate)){
            condition +=" and installdate>= to_date('"+beginDate+"','yyyy-mm-dd') ";
        }
        if(StringUtils.isNotBlank(endDate)){
            condition +=" and installdate< (to_date('"+endDate+"','yyyy-mm-dd')+interval '1' day) ";
        }
        String sql = "select "+groupStyle+" ,count(1) from alarm_device d left join alarm_device_type t on d.devicetype_id=t.dbid where " +
                "userid is not null "+condition+
                " group by "+groupStyle +" order by "+ groupStyle +" asc";

        Query query =this.getSession().createSQLQuery(sql);
        List list = query.list();//增量值
        if(statType==1){//统计总量
            int count = 0;
            if(StringUtils.isNotBlank(beginDate)){//获取查询日期之前设备数量
                String sql2 = "select count(1) from alarm_device where userid is not null and installdate< to_date('"+beginDate+"','yyyy-mm-dd')";
                Query query1 = this.getSession().createSQLQuery(sql2);
                List countList = query1.list();
                count = (int) countList.get(0);
            }
            List<Object[]> res = new ArrayList<Object[]>();
            int curSum = count;
            for(int i = 0;i<list.size();i++){//遍历修正每一个增量值为总量
                int c = Integer.valueOf(((Object[])list.get(i))[1].toString());
                Object[] obj= {((Object[])list.get(i))[0],curSum+c};
                res.add(obj);
                curSum +=c;
            }
            return res;
        }
        return list;
    }
}
