package com.hp.pojo;

import java.util.List;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月31日 下午9:37:47 
* 类说明 
*/
public class QueryFeedback {
    private Integer cnId;//控件id
    private Integer cmId;//小区id
    private String starttime;//查询开始时间
    private String endtime;//查询结束时间
    private Integer fixed;//维修状态
    private Integer page=1;//第几页
	private Integer size=10;//每页显示数据条数
	private Integer startRow;//从第几条数据开始查询
	private List<Integer> uId;//用户名模糊查询得出的用户id集合
	public QueryFeedback() {
		// TODO Auto-generated constructor stub
	}
	public QueryFeedback(Integer cnId, Integer cmId, String starttime, String endtime, Integer fixed, Integer page,
			Integer size, Integer startRow, List<Integer> uId) {
		super();
		this.cnId = cnId;
		this.cmId = cmId;
		this.starttime = starttime;
		this.endtime = endtime;
		this.fixed = fixed;
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
	public Integer getFixed() {
		return fixed;
	}
	public void setFixed(Integer fixed) {
		this.fixed = fixed;
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
		return "QueryFeedback [cnId=" + cnId + ", cmId=" + cmId + ", starttime=" + starttime + ", endtime=" + endtime
				+ ", fixed=" + fixed + ", page=" + page + ", size=" + size + ", startRow=" + startRow + ", uId=" + uId
				+ "]";
	}
	
}
