package com.hp.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.AdminMapper;
import com.hp.mapper.CommunityMapper;
import com.hp.mapper.RecordMapper;
import com.hp.mapper.StateMapper;
import com.hp.mapper.UserMapper;
import com.hp.pojo.Admin;
import com.hp.pojo.Community;
import com.hp.pojo.MapQueryData;
import com.hp.service.CommunityService;
import com.hp.service.MapService;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月24日 下午10:43:39 
* 类说明 
*/
@Service("MapService")
public class MapServiceImpl implements MapService{
	@Autowired
	private AdminMapper adminMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private CommunityMapper communityMapper;
	@Autowired
	private RecordMapper recordMapper;
	
	/*
	 * 查询所有地图界面显示的信息
	 */
	@Override
	public List<MapQueryData> selectInfo() {
		List<MapQueryData> list=new ArrayList<MapQueryData>();
		//查询所有的小区管理员
		List<Admin> adminList=adminMapper.selectAll();
		//查询出每个小区的用户数量
		List<Map<Integer, Object>> userList=userMapper.selectCountByCommunity();
		//查询所有小区信息（不包括禁用的小区）
		List<Community> communityList=communityMapper.selectAll();
		//移除无小区的数据
		communityList.remove(0);
		//查询每个小区的异常记录数
		List<Map<Integer, Object>> recordList=recordMapper.selectAllCountByCmid();
		//查询每个小区未处理的异常记录数
		List<Map<Integer, Object>> notRestoreRecordList=recordMapper.selectAllNotRestoreByCmid();
		Long long1=new Long(0);
		for(int i=0;i<communityList.size();i++){
				MapQueryData mapQueryData=new MapQueryData(null, null, null, null, null, long1, long1, long1);
				mapQueryData.setCmId(communityList.get(i).getCmId());
				mapQueryData.setCmName(communityList.get(i).getCmName());
				mapQueryData.setLatitude(communityList.get(i).getLatitude());
				mapQueryData.setLongitude(communityList.get(i).getLongitude());
				for(int j=0;j<adminList.size();j++){
					if(adminList.get(j).getCmId().equals(communityList.get(i).getCmId())){
						mapQueryData.setaName(adminList.get(j).getaName());
					}
				}
				for(int j=0;j<userList.size();j++){
					if(userList.get(j).get("cmId").equals(communityList.get(i).getCmId())){
						mapQueryData.setUserCount((Long)userList.get(j).get("count"));
					}
				}
				for(int j=0;j<notRestoreRecordList.size();j++){
					if(notRestoreRecordList.get(j).get("cmId").equals(communityList.get(i).getCmId())){
						mapQueryData.setStateCount((Long)notRestoreRecordList.get(j).get("count"));
					}
				}
				for(int j=0;j<recordList.size();j++){
					if(recordList.get(j).get("cmId").equals(communityList.get(i).getCmId())){
						mapQueryData.setRecordCount((Long)recordList.get(j).get("count"));
					}
				}
				list.add(i, mapQueryData);
		}
		return list;
	}
	
}
