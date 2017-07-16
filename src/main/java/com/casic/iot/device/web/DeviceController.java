package com.casic.iot.device.web;


import com.casic.iot.alarm.dto.AlarmRecordDTO;
import com.casic.iot.alarm.manager.AlarmRecordManager;
import com.casic.iot.core.mapper.JsonMapper;
import com.casic.iot.device.domain.Device;
import com.casic.iot.device.domain.DeviceType;
import com.casic.iot.device.dto.DeviceDTO;
import com.casic.iot.device.dto.DeviceStatusEnum;
import com.casic.iot.device.dto.DeviceTypeDTO;
import com.casic.iot.device.manager.DeviceManager;
import com.casic.iot.device.manager.DeviceSensorManager;
import com.casic.iot.device.manager.DeviceTypeManager;
import com.casic.iot.person.manager.RegistManager;
import com.casic.iot.sysLog.web.IOTLog;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.DataTableUtils;
import com.casic.iot.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Predator on 2015/6/15.
 */
@Controller
@RequestMapping("device")
public class DeviceController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private DeviceManager deviceManager;

    @Resource
    private DeviceTypeManager deviceTypeManager;

    @Resource
    private AlarmRecordManager alarmRecordManager;

    @Resource
    private DeviceSensorManager deviceSensorManager;

    @Resource
    private RegistManager registManager;

    @RequestMapping("device-info-list")
    public void list(String jsonParam, String iDisplayStart,
                     String iDisplayLength, String search,
                     HttpServletResponse response, HttpSession session) {
        try {
            DataTableParameter dataTableParam = DataTableUtils.getDataTableParameterByJsonParam(jsonParam);
            dataTableParam.setsSearch(search);
            dataTableParam.setiDisplayLength(Integer.parseInt(iDisplayLength));
            dataTableParam.setiDisplayStart(Integer.parseInt(iDisplayStart));

            DataTable<DeviceDTO> dt = deviceManager.pageQuery(dataTableParam, session);
            String json = new JsonMapper().toJson(dt);
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Map<String, Object> saveEditDevice(DeviceDTO dto) {
        Map<String, Object> map = new HashMap<String, Object>();
        Device device = deviceManager.findUniqueBy("id", dto.getId());
        device.setDevCode(dto.getDevCode());
        device.setDevName(dto.getDevName());
        device.setAddress(dto.getAddress());
        DeviceType deviceType = deviceTypeManager.findUniqueBy("id", Long.valueOf(dto.getTypeId()));
        if (null != deviceType) {
            device.setDeviceType(deviceType);
        }
        deviceManager.save(device);
        map.put("success", true);
        map.put("message", "编辑成功");
        return map;
    }

    public Map<String, Object> saveNewDevice(DeviceDTO dto, HttpSession session) throws ParseException {
        Map<String, Object> map = new HashMap<String, Object>();
        Device device = new Device();
        DeviceType deviceType = deviceTypeManager.findUniqueBy("id", Long.valueOf(dto.getTypeId()));
        if (null != deviceType) {
            device.setDeviceType(deviceType);
        }
        device.setSimid(dto.getSimid());
        device.setDevCode(dto.getDevCode());
        device.setDevName(dto.getDevName());
        device.setAddress(dto.getAddress());
        String userId = session.getAttribute(StringUtils.SYS_DBID).toString();
        device.setUserid(userId);
        device.setStatus(String.valueOf(DeviceStatusEnum.START.getIndex()));
        device.setInstallDate(new Date());
        deviceManager.save(device);
        dto.setId(device.getId());
        map.put("success", true);
        map.put("message", "新增成功");
        return map;
    }

    @RequestMapping("device-info-save")
    @IOTLog(operationType = "新增", content = "新增设备", businessName = "设备")
    public void save(@ModelAttribute DeviceDTO dto,
                     HttpSession session,
                     HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (deviceManager.isExits(dto)) {
                if (null == dto.getId()) {
                    map.put("success", false);
                    map.put("message", "添加设备失败：编号" + dto.getDevCode() + "已经存在！");
                } else {
                    map.put("success", false);
                    map.put("message", "编辑设备失败：编号" + dto.getDevCode() + "已经存在！");
                }
            } else {
                if (null != dto.getId()) {
                    map = saveEditDevice(dto);
                    deviceManager.editDevcieSensor(dto);//修改设备时编辑传感器挂载
                } else {
                    map = saveNewDevice(dto, session);
                    deviceManager.saveDevcieSensor(dto);//新增设备时挂载传感器
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "新增失败");
        }
        try {
            String json = new JsonMapper().toJson(map);
            response.getWriter().write(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("type-list")
    @ResponseBody
    public Map<String, Object> listDeviceType(@ModelAttribute DeviceDTO dto, HttpSession session) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<DeviceTypeDTO> types = deviceTypeManager.getDeviceTypes();
            map.put("success", true);
            map.put("message", types);

        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "保存失败");
        }
        return map;
    }

    @IOTLog(operationType = "删除", content = "设备删除", businessName = "设备")
    @RequestMapping("device-del")
//    @ResponseBody
    public void delete(@ModelAttribute DeviceDTO dto,
                       HttpSession session,
                       HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String[] ids = dto.getIds().split(",");
            for (int i = 0; i < ids.length; i++) {
                Device device = deviceManager.findUniqueBy("id", Long.valueOf(ids[i]));
                device.setActive(false);
                deviceManager.save(device);
                deviceSensorManager.removeDeviceSensorByDevice(Long.valueOf(ids[i]));
            }
            map.put("success", true);
            map.put("message", "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "删除失败");
        }
        try {
            String json = new JsonMapper().toJson(map);
            response.getWriter().write(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @IOTLog(operationType = "启动", content = "启动设备", businessName = "设备")
    @RequestMapping("device-start")
    @ResponseBody
    public void start(@ModelAttribute DeviceDTO dto,HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String[] ids = dto.getIds().split(",");
            for (int i = 0; i < ids.length; i++) {
                Device device = deviceManager.findUniqueBy("id", Long.valueOf(ids[i]));
                device.setStatus(String.valueOf(DeviceStatusEnum.START.getIndex()));
                deviceManager.save(device);
            }
            map.put("success", true);
            map.put("message", "启用成功");

        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "启用失败");
        }
        try {
            String json = new JsonMapper().toJson(map);
            response.getWriter().write(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("device-stop")
    @IOTLog(operationType = "停止", content = "停止设备", businessName = "设备")
    public void stop(@ModelAttribute DeviceDTO dto, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String[] ids = dto.getIds().split(",");
            for (int i = 0; i < ids.length; i++) {
                Device device = deviceManager.findUniqueBy("id", Long.valueOf(ids[i]));
                device.setStatus(String.valueOf(DeviceStatusEnum.STOP.getIndex()));
                deviceManager.save(device);
            }
            map.put("success", true);
            map.put("message", "停用成功");

        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "停用失败");
        }
        try {
            String json = new JsonMapper().toJson(map);
            response.getWriter().write(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("device-change-state")
    public String changeState(@ModelAttribute DeviceDTO dto, HttpSession session) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Device device = deviceManager.findUniqueBy("id", dto.getId());
            device.setStatus(dto.getStatus());
            deviceManager.save(device);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "device/device-info-list";
    }

    @RequestMapping("device-edit")
    public String edit(@ModelAttribute DeviceDTO dto, HttpSession session) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Device device = deviceManager.findUniqueBy("id", dto.getId());
            device.setDevCode(dto.getDevCode());
            device.setDevName(dto.getDevName());
            deviceManager.save(device);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "device/device-info-list";
    }

    @RequestMapping("device-detail")
    public String edit(@RequestParam(value = "id", required = false) Long id, Model model) {
        DeviceDTO dto = deviceManager.getDTO(id);
        if(null!=dto.getUserid()&&null!=registManager.get(Long.valueOf(dto.getUserid()))){
//            dto.setUserName(registManager.get(Long.valueOf(dto.getUserid())).getEnterpriseName());
            dto.setCompany(registManager.get(Long.valueOf(dto.getUserid())).getEnterpriseName());
        }
        AlarmRecordDTO alarmRecordDTO = alarmRecordManager.getDTO(id);
        model.addAttribute("model", dto);
        model.addAttribute("alarm", alarmRecordDTO);
        return "device/device-detail";
    }

    @RequestMapping("exp-dev-list")
    @ResponseBody
    public Map<String, Object> expAlarmList(@RequestParam(value = "search",required = false)String search,
                                            HttpSession session, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String,Object>();
        try {
            String path = request.getSession().getServletContext().getRealPath("/") + "\\xls\\device.xls";
            map = deviceManager.expDevicesToExcel(search, session, path);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "Excel文件生成失败！");
        }
        return map;
    }
    @RequestMapping("stat-by-devType")
    @ResponseBody
    public Map<String,Object>  statByDevType(){
        Map<String,Object> res = new HashMap<String,Object>();
        res.put("data",deviceManager.statByDevType());
        return res;
    }

    @RequestMapping("stat-by-devArea")
    @ResponseBody
    public Map<String,Object>  statByDevArea(){
        Map<String,Object> res = new HashMap<String,Object>();
        res.put("data",deviceManager.statByDevArea());
        return res;
    }

    @RequestMapping("stat-by-devIndustry")
    @ResponseBody
    public Map<String,Object>  statByIndustry(){
        Map<String,Object> res = new HashMap<String,Object>();
        res.put("data",deviceManager.statByIndustry());
        return res;
    }
//    int statType,int statStyle,String devType,String beginDate,String endDate
    @RequestMapping("stat-by-dev")
    @ResponseBody
    public Map<String,Object>  statDev(@RequestParam(value = "statStyle",required=true) int statStyle,
                                              @RequestParam(value = "devType",required=false) String devType,
                                              @RequestParam(value = "beginDate",required=false) String beginDate,
                                              @RequestParam(value = "endDate",required=false) String endDate){
        Map<String,Object> res = new HashMap<String,Object>();
        Map<String,Object> temp = new HashMap<String,Object>();
        temp.put("increase",deviceManager.statDev(0,statStyle,devType,beginDate,endDate));
        temp.put("all",deviceManager.statDev(1,statStyle,devType,beginDate,endDate));
        res.put("data",temp);
        return res;
    }
}
