package com.hp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.AnnouncementMapper;
import com.hp.pojo.Announcement;
import com.hp.service.AnnouncementService;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月29日 下午4:23:34 
* 类说明 
*/
@Service("AnncouncementService")
public class AnnouncementServiceImpl implements AnnouncementService {
	@Autowired
	AnnouncementMapper announcementMapper;
	@Override
	/**
	 * 管理员发布公告
	 */
	public int addAnnouncement(Announcement announcement) {
		
		return announcementMapper.insert(announcement);
	}
	@Override
	public Announcement queryAnnouncement(int cmId) {
		Announcement queryAnnouncement = announcementMapper.queryAnnouncement(cmId);
		if(queryAnnouncement==null){
			queryAnnouncement = new Announcement();
			queryAnnouncement.setMessage("本小区物业致力于服务于住户,给住户提供一个温馨安全的居住所");
		}
		return queryAnnouncement;
	}
	@Override
	public List<Announcement> queryWarning(int uId, int cmId) {
		List<Announcement> list=announcementMapper.queryWarning(uId,cmId);
		Announcement announcement = new Announcement();
		if(list.isEmpty()){
			announcement.setMessage("欢迎入住本小区，携手共建一个温馨的家园");
			list.add(announcement);
		}
		return list;
	}
	@Override
	public Announcement queryUpdate() {
		// TODO Auto-generated method stub
		return announcementMapper.queryUpdate();
	}

}
