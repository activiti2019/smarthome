package com.hp.mapper;

import java.util.List;

import com.hp.pojo.Announcement;

public interface AnnouncementMapper {
    int deleteByPrimaryKey(Integer anId);

    int insert(Announcement record);

    int insertSelective(Announcement record);

    Announcement selectByPrimaryKey(Integer anId);

    int updateByPrimaryKeySelective(Announcement record);

    int updateByPrimaryKey(Announcement record);

	Announcement queryAnnouncement(int cmId);

	List<Announcement> queryWarning(int uId, int cmId);
	
	Announcement queryUpdate();
}