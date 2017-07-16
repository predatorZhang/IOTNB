package com.casic.iot;

import com.casic.iot.util.StringUtils;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by admin on 2017/7/14.
 */
public class SessionContext {

    private static SessionContext instance;
    private ConcurrentHashMap<String,HttpSession> sessionMap;

    private SessionContext() {
        sessionMap = new ConcurrentHashMap<String,HttpSession>();
    }

    public static SessionContext getInstance() {
        if (instance == null) {
            instance = new SessionContext();
        }
        return instance;
    }

    public synchronized void AddSession(HttpSession session) {
        if (session != null) {
            sessionMap.putIfAbsent(session.getId(), session);
        }
    }

    public synchronized void DelSession(HttpSession session) {
        if (session != null) {
            sessionMap.remove(session.getId());
            if(session.getAttribute(StringUtils.SYS_DBID)!=null){
                sessionMap.remove(session.getAttribute(StringUtils.SYS_DBID));
            }
        }
    }

    public synchronized HttpSession getSession(String session_id) {
        if (session_id == null) return null;
        return (HttpSession) sessionMap.get(session_id);
    }

    public ConcurrentHashMap getSessionMap() {
        return sessionMap;
    }

    public void setMymap(ConcurrentHashMap sessionMap) {
        this.sessionMap = sessionMap;
    }
}
