package com.hp.pojo;

public class SuperAdmin {
    private Integer saId;//超级管理员id

    private String saName;//超级管理员用户名

    private String saPwd;//超级管理员密码
    
    private Integer rId;//超级管理员权限

    public Integer getSaId() {
        return saId;
    }

    public void setSaId(Integer saId) {
        this.saId = saId;
    }

    public String getSaName() {
        return saName;
    }

    public void setSaName(String saName) {
        this.saName = saName == null ? null : saName.trim();
    }

    public String getSaPwd() {
        return saPwd;
    }

    public void setSaPwd(String saPwd) {
        this.saPwd = saPwd == null ? null : saPwd.trim();
    }

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}
}