package com.casic.iot.person.web;

import com.casic.iot.SessionContext;
import com.casic.iot.core.mapper.JsonMapper;
import com.casic.iot.person.domain.Regist;
import com.casic.iot.person.dto.RegistDTO;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yxw on 2017/6/22.
 */
@Controller
@RequestMapping("regist")
public class RegistController {

    private RegistManager registManager;

    @Resource
    public void setRegistManager(RegistManager registManager) {
        this.registManager = registManager;
    }

    @RequestMapping("regist-info-save")
    public String save(@ModelAttribute RegistDTO registDTO,
                       @RequestParam(value = "license", required = false) MultipartFile license, HttpSession session) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {

            Regist regist = new Regist();
            if (registDTO.getEnterpriseName().equalsIgnoreCase("") || registDTO.getPassWord().equalsIgnoreCase("")) {
                JOptionPane.showMessageDialog(null, "企业名称和密码不能为空", "提示", JOptionPane.ERROR_MESSAGE);
            } else {
                regist.setEnterpriseName(registDTO.getEnterpriseName());
                regist.setEmail(registDTO.getEmail());
                regist.setPhone(registDTO.getPhone());
                regist.setIndustry(registDTO.getIndustry());
                regist.setPassWord(registDTO.getPassWord());
                regist.setRegion(registDTO.getRegion());
                regist.setLicense(registManager.saveLicense(license));
                regist.setActive(1);
                registManager.save(regist);

                JOptionPane.showMessageDialog(null, "注册成功", "提示", JOptionPane.ERROR_MESSAGE);
            }

        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "注册失败", "提示", JOptionPane.ERROR_MESSAGE);
        }
        return "regist/login";
    }

    @IOTLog(operationType = "登录", content = "用户登录", businessName = "用户")
    @RequestMapping("login")
    @ResponseBody
    public void login(@ModelAttribute RegistDTO registDTO,
                      HttpSession session,
                      HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (registManager.login(registDTO, session)) {
                map.put("success", "true");
                map.put("message", registDTO.getEnterpriseName() + "登录成功！");

                //:更新seesionMap信息信息
                HttpSession oldSession = (HttpSession) SessionContext.
                        getInstance().getSessionMap().
                        get(session.getAttribute(StringUtils.SYS_DBID));

                if (oldSession != null) {
                  /*  SessionContext.getInstance().getSessionMap().remove(oldSession.getId());
                    SessionContext.getInstance().getSessionMap().remove(session.getAttribute(StringUtils.SYS_DBID));*/
                    oldSession.invalidate();
                }
                SessionContext.getInstance().getSessionMap().
                        putIfAbsent(session.getAttribute(StringUtils.SYS_DBID), session);

            } else {
                map.put("success", "false");
                map.put("message", registDTO.getEnterpriseName() + "密码错误！");
            }
            String json = new JsonMapper().toJson(map);
            response.getWriter().write(json);
        } catch (Exception ex) {
            ex.printStackTrace();
            map.put("success", "false");
            map.put("message", registDTO.getEnterpriseName() + "登陆失败！");
        }
    }

    @RequestMapping("page-query-enterprise-list")
    public void pageQueryList(String jsonParam, String iDisplayStart,
                              String iDisplayLength, String search, HttpSession session,
                              HttpServletResponse response) {
        try {
            DataTableParameter dataTableParam = DataTableUtils.getDataTableParameterByJsonParam(jsonParam);
            dataTableParam.setsSearch(search);
            dataTableParam.setiDisplayLength(Integer.parseInt(iDisplayLength));
            dataTableParam.setiDisplayStart(Integer.parseInt(iDisplayStart));
            DataTable<RegistDTO> dt = registManager.pageQueryRegistDto(dataTableParam, session);
            String json = new JsonMapper().toJson(dt);
            response.setCharacterEncoding("utf-8");
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("update-status")
    @ResponseBody
    public Map<String, Object> updateStatus(@RequestParam(value = "dbId", required = true) String dbId,
                                            @RequestParam(value = "status", required = true) String status) {
        Map<String, Object> res = new HashMap<String, Object>();
        res.put("success", registManager.updateStatus(dbId, status));
        return res;
    }

    @RequestMapping("stat-by-devIndustry")
    @ResponseBody
    public Map<String, Object> statByIndustry(@RequestParam(value = "statStyle", required = true) int statStyle,
                                              @RequestParam(value = "devType", required = false) String devType,
                                              @RequestParam(value = "beginDate", required = false) String beginDate,
                                              @RequestParam(value = "endDate", required = false) String endDate) {
        Map<String, Object> res = new HashMap<String, Object>();
        Map<String, Object> temp = new HashMap<String, Object>();
        temp.put("increase", registManager.statUsers(0, statStyle, devType, beginDate, endDate));
        temp.put("all", registManager.statUsers(1, statStyle, devType, beginDate, endDate));
        res.put("data", temp);
        return res;
    }


    @RequestMapping("login-out")
    public String loginOut() throws IOException {
        HttpServletRequest request =  ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
//        sysLogInfoManager.saveSysLog(StringUtils.LOG_SYS,
//                (UserInfo) session.getAttribute(StringUtils.SYS_USER), "注销成功");
        session.invalidate();
        return "redirect:../homePage.jsp";
    }

}