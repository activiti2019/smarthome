package com.hp.pojo;

/** 
* @author 作者: 王文帅
* @version 创建时间：2017年10月16日 下午8:08:19 
* 类说明 
*/
public class QueryCommunity {
	private String cmName;//小区id
	private Integer state;//小区状态
	private Integer page=1;//第几页
	private Integer size=10;//每页显示数据条数
	private Integer startRow;//从第几条数据开始查询
    public QueryCommunity() {
		// TODO Auto-generated constructor stub
	}
	public QueryCommunity(String cmName, Integer state, Integer page, Integer size, Integer startRow) {
		super();
		this.cmName = cmName;
		this.state = state;
		this.page = page;
		this.size = size;
		this.startRow = startRow;
	}
	public String getCmName() {
		return cmName;
	}
	public void setCmName(String cmName) {
		this.cmName = cmName;
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
		return "QueryCommunity [cmName=" + cmName + ", state=" + state + ", page=" + page + ", size=" + size
				+ ", startRow=" + startRow + "]";
	}
	
}
