package com.casic.iot.core.jdbc;

public interface DataSourceInfo {
    String getName();

    void setName(String name);

    void validate();
}
