package com.casic.iot.person.web;

import com.casic.iot.core.mapper.JsonMapper;
import com.casic.iot.person.domain.IndividualUser;
import com.casic.iot.person.domain.Regist;
import com.casic.iot.person.dto.IndividualUserDTO;
import com.casic.iot.person.manager.IndividualUserManager;
import com.casic.iot.person.manager.RegistManager;
import com.casic.iot.sysLog.web.IOTLog;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.DataTableUtils;
import com.casic.iot.util.StringUtils;
import org.springframework.stereotype.Controller;
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
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yxw on 2017/6/22.
 */
@Controller
@RequestMapping("individualUser")
public class IndividualUserController {
    private IndividualUserManager individualUserManager;

    private RegistManager registManager;

    @Resource
    public void setIndividualUserManager(IndividualUserManager individualUserManager) {
        this.individualUserManager = individualUserManager;
    }

    @Resource
    public void setRegistManager(RegistManager registManager) {
        this.registManager = registManager;
    }

    @RequestMapping("individualUser-info-list")
    public void getEnterpriseList(String jsonParam, String iDisplayStart,
                                  String iDisplayLength, String search, HttpSession session,
                                  HttpServletResponse response) throws ParseException {
        try {
            DataTableParameter dataTableParam = DataTableUtils.getDataTableParameterByJsonParam(jsonParam);
            dataTableParam.setsSearch(search);
            dataTableParam.setiDisplayLength(Integer.parseInt(iDisplayLength));
            dataTableParam.setiDisplayStart(Integer.parseInt(iDisplayStart));

            DataTable<IndividualUserDTO> dt = individualUserManager.queryIndividualUserByPage(dataTableParam, session);
            String json = new JsonMapper().toJson(dt);
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("individualUser-info-save")
    public String save(@ModelAttribute IndividualUserDTO individualUserDTO, HttpSession session) {
        IndividualUser individualUser;
        try {
            if (null != individualUserDTO.getDbId()) {
                individualUser = individualUserManager.get(individualUserDTO.getDbId());
            } else {
                individualUser = new IndividualUser();
            }

            individualUser.setUserName(individualUserDTO.getUserName());
            individualUser.setPassword(individualUserDTO.getPassword());
            individualUser.setPhone(individualUserDTO.getPhone());
            individualUser.setEmail(individualUserDTO.getEmail());

            if (session.getAttribute(StringUtils.SYS_DBID).toString().equalsIgnoreCase(""))
                individualUser.setRegist(null);
            else {
                Regist regist = registManager.findUniqueBy("dbId", session.getAttribute(StringUtils.SYS_DBID));
                if (null != regist) {
                    individualUser.setRegist(regist);
                }
            }

            individualUser.setActive(1);

            individualUserManager.save(individualUser);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "individualUser/individualUser";
    }

    @RequestMapping("individualUser-del")
    @IOTLog(operationType = "删除", content = "删除人员", businessName = "人员")
    public void delete(@ModelAttribute IndividualUserDTO individualUserDTO, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String[] ids = individualUserDTO.getIds().split(",");
            for (int i = 0; i < ids.length; i++) {
                IndividualUser individualUser = individualUserManager.findUniqueBy("dbId", Long.valueOf(ids[i]));
                individualUser.setActive(0);
                individualUserManager.save(individualUser);
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


    @RequestMapping("exp-user-list")
    @IOTLog(operationType = "导出", content = "导出人员信息", businessName = "人员")
    public void expAlarmList(@RequestParam(value = "search", required = false) String search,
                             HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String path = request.getSession().getServletContext().getRealPath("/") + "\\xls\\user.xls";
            map = individualUserManager.expUsersToExcel(search, session, path);
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
}
