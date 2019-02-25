package com.hp.pojo;

import java.util.Date;

public class Announcement {
    private Integer anId;//公告id

    private Integer cmId;//小区id

    private Integer uId;//用户id

    private Date createtime;//创建时间

    private String message;//具体信息

    public Integer getAnId() {
        return anId;
    }

    public void setAnId(Integer anId) {
        this.anId = anId;
    }

    public Integer getCmId() {
        return cmId;
    }

    public void setCmId(Integer cmId) {
        this.cmId = cmId;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
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

	@Override
	public String toString() {
		return "Announcement [anId=" + anId + ", cmId=" + cmId + ", uId=" + uId + ", createtime=" + createtime
				+ ", message=" + message + "]";
	}
    
}