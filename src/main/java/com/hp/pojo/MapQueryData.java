package com.hp.pojo;
/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月24日 下午10:18:19 
* 类说明 
*/
public class MapQueryData {
	private Integer cmId;//小区id
	private String cmName;//小区名称
	private Double longitude;//小区经度
    private Double latitude;//小区维度
    private String aName;//小区管理员用户名
    private Long userCount;//该小区用户数量
    private Long stateCount;//该小区总异常数
    private Long recordCount;//该小区未处理异常数
    public MapQueryData() {
		// TODO Auto-generated constructor stub
	}
	public MapQueryData(Integer cmId, String cmName, Double longitude, Double latitude, String aName, Long userCount,
			Long stateCount, Long recordCount) {
		super();
		this.cmId = cmId;
		this.cmName = cmName;
		this.longitude = longitude;
		this.latitude = latitude;
		this.aName = aName;
		this.userCount = userCount;
		this.stateCount = stateCount;
		this.recordCount = recordCount;
	}
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
		this.cmName = cmName;
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
	public String getaName() {
		return aName;
	}
	public void setaName(String aName) {
		this.aName = aName;
	}
	public Long getUserCount() {
		return userCount;
	}
	public void setUserCount(Long userCount) {
		this.userCount = userCount;
	}
	public Long getStateCount() {
		return stateCount;
	}
	public void setStateCount(Long stateCount) {
		this.stateCount = stateCount;
	}
	public Long getRecordCount() {
		return recordCount;
	}
	public void setRecordCount(Long recordCount) {
		this.recordCount = recordCount;
	}
	@Override
	public String toString() {
		return "MapQueryData [cmId=" + cmId + ", cmName=" + cmName + ", longitude=" + longitude + ", latitude="
				+ latitude + ", aName=" + aName + ", userCount=" + userCount + ", stateCount=" + stateCount
				+ ", recordCount=" + recordCount + "]";
	}
	
}
