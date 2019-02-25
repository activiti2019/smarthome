package com.hp.pojo;

import java.util.List;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月19日 上午10:03:58 
* 类说明 
*/
public class QueryState {
	private Integer stId;//控件状态id
    private Integer cnId;//控件id
    private Integer cmId;//小区id
    private Integer state;//控件状态
    private Integer onoff;//控件开关
    private Integer page=1;//第几页
	private Integer size=10;//每页显示数据条数
	private Integer startRow;//从第几条数据开始查询
    private List<Integer> uId;//用户名模糊查询得出的用户id集合
    public QueryState() {
		// TODO Auto-generated constructor stub
	}
	public QueryState(Integer stId, Integer cnId, Integer cmId, Integer state, Integer onoff, Integer page,
			Integer size, Integer startRow, List<Integer> uId) {
		super();
		this.stId = stId;
		this.cnId = cnId;
		this.cmId = cmId;
		this.state = state;
		this.onoff = onoff;
		this.page = page;
		this.size = size;
		this.startRow = startRow;
		this.uId = uId;
	}
	public Integer getStId() {
		return stId;
	}
	public void setStId(Integer stId) {
		this.stId = stId;
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
		return "QueryState [stId=" + stId + ", cnId=" + cnId + ", cmId=" + cmId + ", state=" + state + ", onoff="
				+ onoff + ", page=" + page + ", size=" + size + ", startRow=" + startRow + ", uId=" + uId + "]";
	}
	
}
