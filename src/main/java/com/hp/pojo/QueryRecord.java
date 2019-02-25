package com.hp.pojo;

import java.util.List;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月21日 上午9:09:37 
* 类说明 
*/
public class QueryRecord {
    private Integer cnId;//控件id
    private Integer cmId;//小区id
    private String starttime;//查询开始时间
    private String endtime;//查询结束时间
    private Integer handle;//异常是否处理
    private String handler;//异常处理人
    private Integer page=1;//第几页
	private Integer size=10;//每页显示数据条数
	private Integer startRow;//从第几条数据开始查询
    private List<Integer> uId;//用户名模糊查询得出的用户id集合
    public QueryRecord() {
		// TODO Auto-generated constructor stub
	}
	public QueryRecord(Integer cnId, Integer cmId, String starttime, String endtime, Integer handle, String handler,
			Integer page, Integer size, Integer startRow, List<Integer> uId) {
		super();
		this.cnId = cnId;
		this.cmId = cmId;
		this.starttime = starttime;
		this.endtime = endtime;
		this.handle = handle;
		this.handler = handler;
		this.page = page;
		this.size = size;
		this.startRow = startRow;
		this.uId = uId;
	}
	public Integer getCnId() {
		return cnId;
	}
	public void setCnId(Integer cnId) {
		this.cnId = cnId;
	}
	public Integer getCmId() {
		return cmId;
	}
	public void setCmId(Integer cmId) {
		this.cmId = cmId;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public Integer getHandle() {
		return handle;
	}
	public void setHandle(Integer handle) {
		this.handle = handle;
	}
	public String getHandler() {
		return handler;
	}
	public void setHandler(String handler) {
		this.handler = handler;
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
	public List<Integer> getuId() {
		return uId;
	}
	public void setuId(List<Integer> uId) {
		this.uId = uId;
	}
	@Override
	public String toString() {
		return "QueryRecord [cnId=" + cnId + ", cmId=" + cmId + ", starttime=" + starttime + ", endtime=" + endtime
				+ ", handle=" + handle + ", handler=" + handler + ", page=" + page + ", size=" + size + ", startRow="
				+ startRow + ", uId=" + uId + "]";
	}
    
}
