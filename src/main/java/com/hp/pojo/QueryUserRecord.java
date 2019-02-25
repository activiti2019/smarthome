package com.hp.pojo;


/**
 * @author 作者 : 姚云鹏
 * @version 创建时间：2017年10月24日09:03:11 类说明
 */
public class QueryUserRecord {
	private Integer uId;// 用户id
	private String cnName;// 控件
	private Integer roomId;// 房间id
	private String starttime;// 异常产生时间的开始
	private String endtime;// 异常产生时间的结束
	private Integer handle;// 是否被处理
	private String handler;// 处理人
	private Integer page ;//第几页
	private Integer size = 10;//每页显示数据条数
	private Integer startRow=0;//从第几条数据开始查询
	public Integer getuId() {
		return uId;
	}
	public void setuId(Integer uId) {
		this.uId = uId;
	}
	public String getCnName() {
		return cnName;
	}
	public void setCnName(String cnName) {
		this.cnName = cnName;
	}
	public Integer getRoomId() {
		return roomId;
	}
	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
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
	@Override
	public String toString() {
		return "QueryUserRecord [uId=" + uId + ", cnName=" + cnName + ", roomId=" + roomId + ", starttime=" + starttime
				+ ", endtime=" + endtime + ", handle=" + handle + ", handler=" + handler + ", page=" + page + ", size="
				+ size + ", startRow=" + startRow + "]";
	}
	public QueryUserRecord(Integer uId, String cnName, Integer roomId, String starttime, String endtime, Integer handle,
			String handler, Integer page, Integer size, Integer startRow) {
		super();
		this.uId = uId;
		this.cnName = cnName;
		this.roomId = roomId;
		this.starttime = starttime;
		this.endtime = endtime;
		this.handle = handle;
		this.handler = handler;
		this.page = page;
		this.size = size;
		this.startRow = startRow;
	}
	public QueryUserRecord() {
		super();
		// TODO Auto-generated constructor stub
	}

}
