package com.casic.iot.sysLog.web;


import com.casic.iot.core.util.StringUtils;
import com.casic.iot.device.dto.DeviceDTO;
import com.casic.iot.device.web.DeviceController;
import com.casic.iot.sysLog.domain.SysLog;
import com.casic.iot.sysLog.manager.SysLogManager;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * Created by admin on 2017/7/6.
 */

@Aspect
@Component
public class LogAspect {

    @Resource
    public SysLogManager sysLogManager;

    @Before("@annotation(com.casic.iot.sysLog.web.IOTLog)")
    public void beforeExec(JoinPoint joinPoint) {
        System.out.println("before the method");
/*
        time.set(System.currentTimeMillis());
        tag.set(UUID.randomUUID().toString());

        info(joinPoint);

        MethodSignature ms=(MethodSignature) joinPoint.getSignature();
        Method method=ms.getMethod();
        System.out.println(method.getAnnotation(Log.class).name()+"标记"+tag.get());
*/
    }

    @After("@annotation(com.casic.iot.sysLog.web.IOTLog)")
    public void afterExec(JoinPoint joinPoint) {
        System.out.println("after the method");

        MethodSignature ms = (MethodSignature) joinPoint.getSignature();
        Method method = ms.getMethod();
        String businessName = method.getAnnotation(IOTLog.class).businessName();
        String content = method.getAnnotation(IOTLog.class).content();
        String operationType = method.getAnnotation(IOTLog.class).operationType();

        SysLog sysLog = new SysLog();
        sysLog.setContent(content);
        sysLog.setCreateTime(new Date());
        sysLog.setOperationType(operationType);
        sysLog.setBusinessName(businessName);

        //TODO LIST:根据不同的类名来进行响应的操作
        Class clazz = method.getDeclaringClass();
        if (clazz.equals(DeviceController.class)) {
            //获取参数
            if (method.getName().equals("delete")) {
                DeviceDTO deviceDTO = (DeviceDTO) joinPoint.getArgs()[0];
                String ids = deviceDTO.getIds();
                sysLog.setContent(sysLog.getContent() + ids);
            }
        }

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        //读取session中的用户
        if (session != null) {
            String username = (String) session.getAttribute(com.casic.iot.util.StringUtils.SYS_USER);
            if (!StringUtils.isBlank(username)) {
                sysLog.setCreateUser(username);
                sysLogManager.save(sysLog);
            }
        }
    }

    @Around("@annotation(com.casic.iot.sysLog.web.IOTLog)")
    public void aroundExec(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("before the around the method");
        joinPoint.proceed();
        System.out.println("after the around the method");
    }

    //TODO LIST:增加对于异常日志的记录
   /* @AfterThrowing("@annotation(com.casic.iot.sysLog.web.IOTLog), throwing = "e"")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {


    }*/
}