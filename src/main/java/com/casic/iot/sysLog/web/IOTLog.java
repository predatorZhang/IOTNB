package com.casic.iot.sysLog.web;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by admin on 2017/7/6.
 */

@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.METHOD })
public  @interface IOTLog {
    String businessName() default "";
    String operationType() default "";
    String content() default "";

}
