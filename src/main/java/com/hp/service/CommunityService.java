package com.hp.service;

import java.util.List;

import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.QueryCommunity;
import com.hp.utils.Page;

/** 
* @author 作者 : 陈燕君
* @version 创建时间：2017年10月15日 下午3:45:29 
* @description
*/
public interface CommunityService {

	/**
	 * 新增查询所有小区的方法
	 * @return
	 */
    List<Community> selectAll();
    
    /**
     * 查询所用小区
     * @param communityExample
     * @return
     */
    List<Community> selectByExample(CommunityExample communityExample);
    
    /**
     * 通过QueryCommunity查询信息条数
     * @param queryCommunity
     * @return
     */
    int countByQueryCommunity(QueryCommunity queryCommunity);
    
    /**
     * 通过cmId查找小区
     * @param cmId
     * @return
     */
    Community selectByCmId(Integer cmId);
    
    /**
     * 添加小区
     * @param community
     * @return
     */
    int addCommunity(Community community);
    
    /**
     * 通过QueryAdmin查询符合条件的所有小区
     * @param queryCommunity
     * @return
     */
    Page<Community> selectByQueryCommunity(QueryCommunity queryCommunity);
    
    /**
     * 通过community修改小区信息
     * @param community
     * @return
     */
    int updateByCommunity(Community community);
    
    /**
     * 通过cmID删除小区
     * @param cmId
     * @return
     */
    int deleteByCmid(Integer cmId);
    
    /**
     * 通过cmID恢复小区
     * @param cmId
     * @return
     */
    int restoreByCmid(Integer cmId);

    /**
     * 通过管理员ID查询小区
     * @param aId
     * @return
     */
	Community selectByAId(int aId);
	/*
	 * 查询所有小区（包含禁用的小区）
	 */
	List<Community> selectAllCommunity();
    
}
