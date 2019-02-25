package com.hp.pojo;
/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月18日 下午6:11:20 
* 类说明 
*/
public class QueryControls {
	private String cnName;//控件名
	private Integer page=1;//第几页
	private Integer size=10;//每页显示数据条数
	private Integer startRow;//从第几条数据开始查询
	public QueryControls() {
		// TODO Auto-generated constructor stub
	}
	public QueryControls(String cnName, Integer page, Integer size, Integer startRow) {
		super();
		this.cnName = cnName;
		this.page = page;
		this.size = size;
		this.startRow = startRow;
	}
	public String getCnName() {
		return cnName;
	}
	public void setCnName(String cnName) {
		this.cnName = cnName;
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
		return "QueryController [cnName=" + cnName + ", page=" + page + ", size=" + size + ", startRow=" + startRow
				+ "]";
	}
	
}
