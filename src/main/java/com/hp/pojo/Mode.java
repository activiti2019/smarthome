package com.hp.pojo;

public class Mode {
    private Integer mId;//情景模式id


    private String mName;//情景模式名

    public Integer getmId() {
        return mId;
    }

    public void setmId(Integer mId) {
        this.mId = mId;
    }


    public String getmName() {
        return mName;
    }

    public void setmName(String mName) {
        this.mName = mName == null ? null : mName.trim();
    }
}