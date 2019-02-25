package com.hp.pojo;


/** 
* @author 作者 E-mail: 王文帅
* @version 创建时间：2017年10月16日 上午10:15:43 
* 类说明 
*/
public class QueryUser {
	private String uName;//用户名
	private String realname;//用户真实姓名
	private String address;//用户地址
	private Integer cmId;//小区id
	private Integer state;//用户账号状态
	private Integer page=1;//第几页
	private Integer size=10;//每页显示数据条数
	private Integer startRow;//从第几条数据开始查询
	public QueryUser() {
		// TODO Auto-generated constructor stub
	}
	public QueryUser(String uName, String realname, String address, Integer cmId, Integer state, Integer page,
			Integer size, Integer startRow) {
		super();
		this.uName = uName;
		this.realname = realname;
		this.address = address;
		this.cmId = cmId;
		this.state = state;
		this.page = page;
		this.size = size;
		this.startRow = startRow;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getCmId() {
		return cmId;
	}
	public void setCmId(Integer cmId) {
		this.cmId = cmId;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	public Integer getStartRow() {
		return startRow;
	}
	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}
	@Override
	public String toString() {
		return "QueryUser [uName=" + uName + ", realname=" + realname + ", address=" + address + ", cmId=" + cmId
				+ ", state=" + state + ", page=" + page + ", size=" + size + ", startRow=" + startRow + "]";
	}
	
}
