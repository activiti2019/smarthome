package com.hp.pojo;
/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月18日 上午10:40:55 
* 类说明 
*/
public class QueryAdmin {
	private String aName;//小区管理员用户名
	private Integer cmId;//小区id
	private Integer state;//小区管理员账号状态
	private Integer page=1;//第几页
	private Integer size=10;//每页显示数据条数
	private Integer startRow;//从第几条数据开始查询
	public QueryAdmin() {
		// TODO Auto-generated constructor stub
	}
	public QueryAdmin(String aName, Integer cmId, Integer state, Integer page, Integer size, Integer startRow) {
		super();
		this.aName = aName;
		this.cmId = cmId;
		this.state = state;
		this.page = page;
		this.size = size;
		this.startRow = startRow;
	}
	public String getaName() {
		return aName;
	}
	public void setaName(String aName) {
		this.aName = aName;
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
		return "QueryAdmin [aName=" + aName + ", cmId=" + cmId + ", state=" + state + ", page=" + page + ", size="
				+ size + ", startRow=" + startRow + "]";
	}
	
}
