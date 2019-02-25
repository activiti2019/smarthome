package com.hp.pojo;

import java.util.Date;

public class Record {
    private Integer rId;//异常记录id

    private Integer uId;//用户id

    private Integer cnId;//控件id

    private Integer cmId;//小区id

    private Date createtime;//异常产生时间

    private Date handletime;//异常处理时间

    private Integer handle;//处理状态

    private String handler;//处理人

    public Integer getrId() {
        return rId;
    }

    public void setrId(Integer rId) {
        this.rId = rId;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public Integer getCnId() {
        return cnId;
    }

    public void setCnId(Integer cnId) {
        this.cnId = cnId;
    }

    public Integer getCmId() {
        return cmId;
    }

    public void setCmId(Integer cmId) {
        this.cmId = cmId;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getHandletime() {
        return handletime;
    }

    public void setHandletime(Date handletime) {
        this.handletime = handletime;
    }

    public Integer getHandle() {
        return handle;
    }

    public void setHandle(Integer handle) {
        this.handle = handle;
    }

    public String getHandler() {
        return handler;
    }

    public void setHandler(String handler) {
        this.handler = handler == null ? null : handler.trim();
    }

	@Override
	public String toString() {
		return "Record [rId=" + rId + ", uId=" + uId + ", cnId=" + cnId + ", cmId=" + cmId + ", createtime="
				+ createtime + ", handletime=" + handletime + ", handle=" + handle + ", handler=" + handler + "]";
	}
    
}