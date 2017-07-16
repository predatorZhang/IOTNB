package com.casic.iot.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/7.
 */
public class StringUtils extends com.casic.iot.core.util.StringUtils{

    public static final String SYS_USER = "_current_user";
    public static final String SYS_DBID="0";
    public static final String LOG_SYS = "系统日志";
    public static final String LOG_RUN = "运行日志";
    public static final String LOG_ERROR = "错误日志";
    public static final String LOG_ALARM = "报警日志";

    public static List<Long> ConvertToLongList(String[] array)
    {
        List<Long> list = new ArrayList<Long>();
        for(String str : array)
        {
            list.add(Long.parseLong(str));
        }
        return list;
    }

    public static boolean isPipeType(String pipeType)
    {

        String[] strs={"0","1","2","3","4"};//5类管线
        for(String str:strs){
           if(str.equals(pipeType))
               return true;
        }
        return  false;
    }


    public static boolean getDateFlag(String strDateTime)
    {

        String dateForm="";
        if(strDateTime.split("-").length<2){
            dateForm="yyyy";
        }else if (strDateTime.split("-").length==2){
            dateForm="yyyy-MM";
        }else if (strDateTime.split("-").length>2){
            dateForm="yyyy-MM-dd";
        }
        SimpleDateFormat format = new SimpleDateFormat(dateForm);
        try {
            Date ndate = format.parse(strDateTime);
            if(ndate.compareTo(new Date())==1){
                return false;
            }
            String str = format.format(ndate);
            if (str.equals(strDateTime))
                return true;
            else
                return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }
}
