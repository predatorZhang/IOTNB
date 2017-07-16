package com.casic.iot.core.ext.cache;

public interface CacheStrategy {
    Cache getCache(String name);
}
