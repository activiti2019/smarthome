package com.hp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.AdminMapper;
import com.hp.mapper.CommunityMapper;
import com.hp.mapper.UserMapper;
import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.QueryCommunity;
import com.hp.service.CommunityService;
import com.hp.utils.Page;

/** 
* @author 作者 : 陈燕君
* @version 创建时间：2017年10月15日 下午3:46:33 
* @description
*/
@Service("CommunityService")
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityMapper communityMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private AdminMapper adminMapper;
	
	/*
	 * 查询所有小区
	 */
	@Override
	public List<Community> selectAll() {
		return communityMapper.selectAll();
	}
	
	/*
	 * 通过QueryCommunity查询信息条数
	 */
	@Override
	public int countByQueryCommunity(QueryCommunity queryCommunity) {
		return communityMapper.countByQueryCommunity(queryCommunity);
	}
	
	/*
	 * 通过QueryAdmin查询符合条件的所有小区
	 */
	@Override
	public Page<Community> selectByQueryCommunity(QueryCommunity queryCommunity) {
		Page<Community> page=new Page<Community>();
		if (null != queryCommunity) {
			if (null != queryCommunity.getCmName() && !"".equals(queryCommunity.getCmName().trim())){
				queryCommunity.setCmName(queryCommunity.getCmName().trim());
			}
			page.setTotal(communityMapper.countByQueryCommunity(queryCommunity));
			if (null != queryCommunity.getPage()) {
				int x=communityMapper.countByQueryCommunity(queryCommunity);
				int y=(int)Math.ceil((double)x/queryCommunity.getSize());
				if(queryCommunity.getPage().intValue()>y && 0!=y){
					queryCommunity.setPage(y);
				}
				page.setPage(queryCommunity.getPage().intValue());
				queryCommunity.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(communityMapper.selectByQueryCommunity(queryCommunity));
		}
		return page;
	}
	
	/*
	 * 查询所有小区信息
	 */
	@Override
	public List<Community> selectByExample(CommunityExample communityExample) {
		return communityMapper.selectByExample(communityExample);
	}
	
	/*
	 * 通过community修改小区信息
	 */
	@Override
	public int updateByCommunity(Community community) {
		return communityMapper.updateByPrimaryKeySelective(community);
	}
	
	/*
	 * 通过cmID删除小区
	 */
	@Override
	public int deleteByCmid(Integer cmId) {
		//删除小区的同时，禁用小区管理员，将该小区所有用户重置为无小区
		userMapper.updateUserCommunity(cmId);
		adminMapper.deleteByCmid(cmId,-1);
		int x=communityMapper.deleteByPrimaryKey(cmId);
		return x;
	}
	
	/*
	 * 通过cmID恢复小区
	 */
	@Override
	public int restoreByCmid(Integer cmId) {
		//恢复小区的同时，恢复小区管理员
		adminMapper.deleteByCmid(cmId, 1);
		int x=communityMapper.restoreByPrimaryKey(cmId);
		return x;
	}
	
	/*
	 * 通过cmId查找小区
	 */
	@Override
	public Community selectByCmId(Integer cmId) {
		return communityMapper.selectByPrimaryKey(cmId);
	}
	
	/*
	 * 添加小区
	 */
	@Override
	public int addCommunity(Community community) {
		return communityMapper.insertSelective(community);
	}
	
	/*
	 * 通过管理员ID查询小区
	 */
	@Override
	public Community selectByAId(int aId) {
		return communityMapper.selectByAId(aId);
	}
	
	/*
	 * 查询所有小区信息（包括被禁用的小区）
	 */
	@Override
	public List<Community> selectAllCommunity() {
		return communityMapper.selectAllCommunity();
	}
	

}
