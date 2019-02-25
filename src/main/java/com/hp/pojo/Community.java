package com.hp.pojo;

public class Community {
    private Integer cmId;//小区id

    private String cmName;//小区名称

    private Double longitude;//小区经度

    private Double latitude;//小区维度

    private Integer state;//小区状态

    public Integer getCmId() {
        return cmId;
    }

    public void setCmId(Integer cmId) {
        this.cmId = cmId;
    }

    public String getCmName() {
        return cmName;
    }

    public void setCmName(String cmName) {
        this.cmName = cmName == null ? null : cmName.trim();
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

	@Override
	public String toString() {
		return "Community [cmId=" + cmId + ", cmName=" + cmName + ", longitude=" + longitude + ", latitude=" + latitude
				+ ", state=" + state + "]";
	}
    
}