package com.hp.service;

import java.util.List;

import com.hp.pojo.Announcement;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月29日 下午4:05:11 
* 类说明 
*/
public interface AnnouncementService {
	/**
	 * 管理员发布公告
	 */
	int addAnnouncement(Announcement announcement);
	/**
	 * 查询最新公告
	 */
	Announcement queryAnnouncement(int cmId);
	/**
	 * 查询来自管理员的提醒前三条
	 */
	List<Announcement> queryWarning(int uId,int cmId);
	
	Announcement queryUpdate();
	
}
