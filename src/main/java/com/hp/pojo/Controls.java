package com.hp.pojo;

public class Controls {
    private Integer cnId;//控件id

    private String cnName;//控件名称
    
    private Integer roomId;//场景id
    

    public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	public Integer getCnId() {
        return cnId;
    }

    public void setCnId(Integer cnId) {
        this.cnId = cnId;
    }

    public String getCnName() {
        return cnName;
    }

    public void setCnName(String cnName) {
        this.cnName = cnName == null ? null : cnName.trim();
    }

	@Override
	public String toString() {
		return "Controls [cnId=" + cnId + ", cnName=" + cnName + ", roomId=" + roomId + "]";
	}
    
}