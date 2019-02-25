package com.hp.pojo;

public class State {
    private Integer stId;//控件状态id

    private Integer uId;//用户id

    private Integer cnId;//控件id

    private Integer state;//控件异常状态

    private Integer onoff;//控件开关

    private String temperature;//温度

    private Integer light;//灯光亮度

    public Integer getStId() {
        return stId;
    }

    public void setStId(Integer stId) {
        this.stId = stId;
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

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getOnoff() {
        return onoff;
    }

    public void setOnoff(Integer onoff) {
        this.onoff = onoff;
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature == null ? null : temperature.trim();
    }

    public Integer getLight() {
        return light;
    }

    public void setLight(Integer light) {
        this.light = light;
    }

	@Override
	public String toString() {
		return "State [stId=" + stId + ", uId=" + uId + ", cnId=" + cnId + ", state=" + state + ", onoff=" + onoff
				+ ", temperature=" + temperature + ", light=" + light + "]";
	}
    
}