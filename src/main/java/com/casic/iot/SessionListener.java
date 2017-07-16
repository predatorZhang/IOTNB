package com.casic.iot;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by admin on 2017/7/14.
 */
public class SessionListener implements HttpSessionListener {

    public  static SessionContext sessionContext=SessionContext.getInstance();

    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        sessionContext.AddSession(httpSessionEvent.getSession());
    }

    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        sessionContext.DelSession(httpSessionEvent.getSession());
    }

}
