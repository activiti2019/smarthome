package com.hp.pojo;

import java.util.Date;

public class Feedback {
    private Integer fId;//反馈信息id

    private Integer uId;//用户id

    private Integer cnId;//控件id

    private Date createtime;//创建时间

    private String message;//具体信息

    private Integer fixed;//控件是否维修

    public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
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

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message == null ? null : message.trim();
    }

    public Integer getFixed() {
        return fixed;
    }

    public void setFixed(Integer fixed) {
        this.fixed = fixed;
    }

	@Override
	public String toString() {
		return "Feedback [fId=" + fId + ", uId=" + uId + ", cnId=" + cnId + ", createtime=" + createtime + ", message="
				+ message + ", fixed=" + fixed + "]";
	}
    
}