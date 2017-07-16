package com.casic.iot.alarm.web;

import com.casic.iot.alarm.dto.AlarmRecordDTO;
import com.casic.iot.alarm.manager.AlarmRecordManager;
import com.casic.iot.core.mapper.JsonMapper;
import com.casic.iot.sysLog.web.IOTLog;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.DataTableUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by test203 on 2017/6/21.
 */
@Controller
@RequestMapping("alarmRecord")
public class AlarmRecordController {
    @Resource
    private AlarmRecordManager alarmRecordManager;

    @RequestMapping("alarm-info-list")
      public void list(@RequestParam(value = "jsonParam",required = true)String jsonParam,
                       @RequestParam(value = "iDisplayStart",required = true)  String iDisplayStart,
                       @RequestParam(value = "iDisplayLength",required = true) String iDisplayLength,
                       @RequestParam(value = "search",required = false)String search,
                       @RequestParam(value = "searchDto",required = false) String searchDto,
                       HttpServletResponse response, HttpSession session) {
        try {
            AlarmRecordDTO dto = null;
            JsonMapper jsonMapper = new JsonMapper();
            if(!StringUtils.isEmpty(searchDto)) dto= jsonMapper.fromJson(searchDto, AlarmRecordDTO.class);
            DataTableParameter dataTableParam = DataTableUtils.getDataTableParameterByJsonParam(jsonParam);
            dataTableParam.setsSearch(search);
            dataTableParam.setiDisplayLength(Integer.parseInt(iDisplayLength));
            dataTableParam.setiDisplayStart(Integer.parseInt(iDisplayStart));
            DataTable<AlarmRecordDTO> dt = alarmRecordManager.pageQuery(dataTableParam,dto,session);
            String json = new JsonMapper().toJson(dt);
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(json);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("getData")
//    @ResponseBody
    public void getData( @RequestParam(value = "devcode",required = true) String devcode,
                         @RequestParam(value = "beginDate",required = false) String beginDate,
                         @RequestParam(value = "endDate",required = false) String endDate,
                         HttpServletResponse response) throws Exception{

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            resultMap=alarmRecordManager.getAlarmDatas(devcode, beginDate, endDate);
            String json = new JsonMapper().toJson(resultMap);
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(json);
        }catch (Exception e){
            e.printStackTrace();
        }

    }
    @RequestMapping("exp-alarm-list")
    @IOTLog(operationType = "导出", content = "导出报警信息", businessName = "报警")
    public void expAlarmList(@RequestParam(value = "search",required = false)String search,
                     @RequestParam(value = "searchDto",required = false) String searchDto,
                      HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String,Object>();
        try {
            AlarmRecordDTO dto = null;
            JsonMapper jsonMapper = new JsonMapper();
            if(!StringUtils.isEmpty(searchDto)) dto= jsonMapper.fromJson(searchDto, AlarmRecordDTO.class);
            String path = request.getSession().getServletContext().getRealPath("/") + "\\xls\\alarmList.xls";
            map = alarmRecordManager.expAlarmToExcel(search, dto, session, path);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "Excel文件生成失败！");
        }
        try {
            String json = new JsonMapper().toJson(map);
            response.getWriter().write(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("stat-alarm-count")
    @ResponseBody
    public Map<String,Object>  statByIndustry(String beginDate,String endDate){
        Map<String,Object> res = new HashMap<String,Object>();
        res.put("data",alarmRecordManager.statAlarmCount(beginDate,endDate));
        return res;
    }

}
