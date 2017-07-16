package com.casic.iot.alarm.manager;

import com.casic.iot.alarm.domain.AlarmRecord;
import com.casic.iot.alarm.dto.AlarmEnum;
import com.casic.iot.alarm.dto.AlarmRecordDTO;
import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.core.page.Page;
import com.casic.iot.core.util.StringUtils;
import com.casic.iot.device.domain.Device;
import com.casic.iot.device.manager.DeviceManager;
import com.casic.iot.device.manager.DeviceTypeManager;
import com.casic.iot.person.domain.IndividualUser;
import com.casic.iot.person.domain.Regist;
import com.casic.iot.person.manager.IndividualUserManager;
import com.casic.iot.person.manager.RegistManager;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.DateUtils;
import com.casic.iot.xls.ExportExcel;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.*;

/**
 * Created by test203 on 2017/6/21.
 */
@Service
public class AlarmRecordManager extends HibernateEntityDao<AlarmRecord> {
    @Resource
    private DeviceTypeManager deviceTypeManager;
    @Resource
    private DeviceManager deviceManager;
    @Resource
    private RegistManager registManager;
    public Criteria getCriteria() {
        return getSession().createCriteria(AlarmRecord.class);
    }

    public DataTable<AlarmRecordDTO> pageQuery(DataTableParameter parameter, AlarmRecordDTO alarmRecordDTO,HttpSession session) {
        try {
            Long compId = (Long)session.getAttribute(com.casic.iot.util.StringUtils.SYS_DBID);
            Regist regist = registManager.findUniqueBy("dbId",compId);
            int start = parameter.getiDisplayStart();
            int pageSize = parameter.getiDisplayLength();
            int pageNo = (start / pageSize) + 1;

            Criteria criteria = getCriteria();
            criteria.add(Restrictions.eq("active", true));
            if (alarmRecordDTO!=null) {
                if (StringUtils.isNotBlank(alarmRecordDTO.getDeviceTypeName())&&!alarmRecordDTO.getDeviceTypeName().trim().equals("全部")) {
                    criteria.add(Restrictions.eq("deviceTypeName",
                            deviceTypeManager.get(Long.valueOf(alarmRecordDTO.getDeviceTypeName())).getTypeName()));
                }
                if(StringUtils.isNotBlank(alarmRecordDTO.getBeginDate())){
                    criteria.add(Restrictions.ge("recordDate", DateUtils.sdf1.parse(alarmRecordDTO.getBeginDate())));
                }
                if(StringUtils.isNotBlank(alarmRecordDTO.getEndDate())){
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(DateUtils.sdf1.parse(alarmRecordDTO.getEndDate()));
                    calendar.add(Calendar.DATE, 1);
                    criteria.add(Restrictions.lt("recordDate", calendar.getTime()));
                }
            }
            criteria.createAlias( "device" ,  "device" );
            criteria.add(Restrictions.eq("device.userid",String.valueOf(regist.getDbId())));
            if (StringUtils.isNotBlank(parameter.getsSearch())) {
                criteria.add(Restrictions.like("deviceCode", "%" + parameter.getsSearch() + "%"));
            }
            criteria.addOrder(Order.desc("recordDate"));
            Page page = pagedQuery(criteria, pageNo, pageSize);

            List<AlarmRecord> dtoList = (List<AlarmRecord>) page.getResult();
            List<AlarmRecordDTO> dtos = AlarmRecordDTO.ConvertToDTOs(dtoList);

            DataTable<AlarmRecordDTO> dt = new DataTable<AlarmRecordDTO>();
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
    public AlarmRecordDTO getDTO(Long id) {
        if(null!=id)
        {
            Device device =deviceManager.get(id);
            if(null!=device){
                AlarmRecord alarmRecord=this.findUniqueBy("device",device);
                if(null!=alarmRecord)
                    return AlarmRecordDTO.ConvertToDTO(alarmRecord);
            }

        }
        return new AlarmRecordDTO();
    }

    public Map<String,Object> getAlarmDatas(String deviceCode,String dateStart,String dateEnd){

        Map<String, Object> resultMap = null;
        try{
            Map<String, Object> paramMap = new HashMap<String, Object>();

            String hql = "select to_char(t.recorddate,'yyyy-mm-dd') as day from alarm_alarm_record t" +
                    " where t.device_code= :deviceCode";
            if (StringUtils.isNotBlank(dateStart)) {
                hql += " and t.recorddate >= TO_DATE('" + dateStart + " 00:00:00','YYYY-MM-DD hh24:mi:ss')";
            }
            if (StringUtils.isNotBlank(dateEnd)) {
                hql += " and t.recorddate <= TO_DATE('" + dateEnd + " 23:59:59','YYYY-MM-DD hh24:mi:ss')";
            }
            hql += " group by to_char(t.recorddate,'yyyy-mm-dd') " +
                    " order by to_char(t.recorddate, 'yyyy-mm-dd') asc";
            paramMap.put("deviceCode", deviceCode);
            List<Object[]> alarmList = ( List<Object[]>)this.getSession().createSQLQuery(hql).setProperties(paramMap).list();
            resultMap= new HashMap<String, Object>();
            resultMap.put("alarmList", alarmList);
            resultMap.put("success", true);
        }catch (Exception e){
            e.printStackTrace();
        }

        return resultMap;
    }

    public List<AlarmRecordDTO> queryRecords(String search,AlarmRecordDTO alarmRecordDTO,HttpSession session) throws ParseException {
        Long compId = (Long)session.getAttribute(com.casic.iot.util.StringUtils.SYS_DBID);
        Criteria criteria = getCriteria();
        criteria.addOrder(Order.desc("id"));
        criteria.add(Restrictions.eq("active", true));
        if (alarmRecordDTO!=null) {
            if (StringUtils.isNotBlank(alarmRecordDTO.getDeviceTypeName())&&!alarmRecordDTO.getDeviceTypeName().trim().equals("全部")) {
                criteria.add(Restrictions.eq("deviceTypeName",
                        deviceTypeManager.get(Long.valueOf(alarmRecordDTO.getDeviceTypeName())).getTypeName()));
            }
            if(StringUtils.isNotBlank(alarmRecordDTO.getBeginDate())){
                criteria.add(Restrictions.ge("recordDate", DateUtils.sdf1.parse(alarmRecordDTO.getBeginDate())));
            }
            if(StringUtils.isNotBlank(alarmRecordDTO.getEndDate())){
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(DateUtils.sdf1.parse(alarmRecordDTO.getEndDate()));
                calendar.add(Calendar.DATE, 1);
                criteria.add(Restrictions.lt("recordDate", calendar.getTime()));
            }
        }
        criteria.createAlias( "device" ,  "device" );
        criteria.add(Restrictions.eq("device.userid",String.valueOf(compId)));
        if (StringUtils.isNotBlank(search)) {
            criteria.add(Restrictions.like("deviceCode", "%" + search + "%"));
        }
        List<AlarmRecordDTO> dtos = AlarmRecordDTO.ConvertToDTOs(criteria.list());
        return dtos;
    }
    public Map<String, Object> expAlarmToExcel(String search,AlarmRecordDTO alarmRecordDTO,HttpSession session, String path) throws ParseException, IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        List<AlarmRecordDTO> dtoList =queryRecords(search, alarmRecordDTO, session);
        String[] headers = {"设备编号", "设备类型", "报警值","报警位置", "处置状态","报警时间"};
        OutputStream out = new FileOutputStream(path);
        List<String[]> exportDatas = new ArrayList<String[]>(dtoList.size());
        for(AlarmRecordDTO alarmRecord:dtoList){
            String status = alarmRecord.getMessageStatus();
            switch (status){
                case "1":status = "处理中";
                    break;
                case "2":status ="结束";
                    break;
                case "3":status ="开始";
                    break;
                default:status = "未知";
                    break;
            }
            String[] line = {alarmRecord.getDevCode(),alarmRecord.getDeviceTypeName(),alarmRecord.getItemValue(),alarmRecord.getAddress(),status,alarmRecord.getRecordDate()};
            exportDatas.add(line);
        }
        map.put("success", ExportExcel.exportExcel("报警记录",headers,exportDatas,out));
        map.put("message", "报警记录成功！");
        return map;
    }
    //TODO:报警记录统计没有区分是物联网平台设备的报警记录
    public List statAlarmCount(String beginDate,String endDate){
        String condition = "";
        if(StringUtils.isNotBlank(beginDate)){
            condition +=" and recorddate>=to_date('"+beginDate+"','yyyy-mm-dd')";
        }
        if(StringUtils.isNotBlank(endDate)){
            condition +=" and recorddate<(to_date('"+endDate+"','yyyy-mm-dd')+ interval '1' day)";
        }
        String sql = " select device_type_name,message,count(1) from alarm_alarm_record where 1=1 "+condition+"  group by itemname";
        Query query =this.getSession().createSQLQuery(sql);
        List list = query.list();
        List<Object[]> res = new ArrayList<Object[]>();
        int othersCount = 0;
        for(int i = 0;i<list.size();i++){
            Object[] listItem = (Object[])list.get(i);
            AlarmEnum alarmEnum = AlarmEnum.getByAlarmType(listItem[0].toString(),Integer.valueOf(listItem[1].toString()));
            if(alarmEnum!=null){
                Object[] obj ={alarmEnum.getAlarmType(),Integer.valueOf(listItem[2].toString())};
                res.add(obj);
            }else{
                othersCount+=Integer.valueOf(listItem[2].toString());//统计多一项其他
            }
        }
        if(othersCount>0) {
            Object[] obj = {"其他",othersCount};
            res.add(obj);
        }
        return res;
    }

}
