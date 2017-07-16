package com.casic.iot.sysLog.web;


import com.casic.iot.core.mapper.JsonMapper;
import com.casic.iot.sysLog.dto.SysLogDTO;
import com.casic.iot.sysLog.manager.SysLogManager;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.DataTableUtils;
import com.casic.iot.util.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
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
@RequestMapping("sysLog")
public class SysLogController {
    @Resource
    private SysLogManager sysLogManager;

    @RequestMapping("sys-info-list")
    public void list(@RequestParam(value = "jsonParam", required = true) String jsonParam,
                     @RequestParam(value = "iDisplayStart", required = true) String iDisplayStart,
                     @RequestParam(value = "iDisplayLength", required = true) String iDisplayLength,
                     @RequestParam(value = "search", required = false) String search,
                     @RequestParam(value = "searchDto", required = false) String searchDto,
                     HttpServletResponse response, HttpSession session) {
        try {
            JsonMapper jsonMapper = new JsonMapper();
            SysLogDTO sysLogDTO = jsonMapper.fromJson(searchDto, SysLogDTO.class);
            DataTableParameter dataTableParam = DataTableUtils.getDataTableParameterByJsonParam(jsonParam);
            dataTableParam.setsSearch(search);
            dataTableParam.setiDisplayLength(Integer.parseInt(iDisplayLength));
            dataTableParam.setiDisplayStart(Integer.parseInt(iDisplayStart));
            DataTable<SysLogDTO> dt = sysLogManager.pageQuery(dataTableParam, sysLogDTO, session);
            String json = new JsonMapper().toJson(dt);
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(json);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("listTop5")
    @ResponseBody
    public Map listTop5(HttpServletResponse response, HttpSession session) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String username = (String) session.getAttribute(StringUtils.SYS_USER);
            List<SysLogDTO> sysLogDTOList = sysLogManager.listTop5(username);
            map.put("message", sysLogDTOList);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", true);
            map.put("message", "获取失败");
            e.printStackTrace();
        }
        return map;
    }
}
