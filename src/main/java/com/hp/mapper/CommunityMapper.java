package com.hp.mapper;

import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.QueryCommunity;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CommunityMapper {
    int countByExample(CommunityExample example);
    
    //通过QueryCommunity查询信息条数
    int countByQueryCommunity(QueryCommunity queryCommunity);

    int deleteByExample(CommunityExample example);

    int deleteByPrimaryKey(Integer cmId);
    
    int restoreByPrimaryKey(Integer cmId);

    int insert(Community record);

    int insertSelective(Community record);

    List<Community> selectByExample(CommunityExample example);

    Community selectByPrimaryKey(Integer cmId);
    
    //通过QueryAdmin查询符合条件的所有小区
    List<Community> selectByQueryCommunity(QueryCommunity queryCommunity);

    int updateByExampleSelective(@Param("record") Community record, @Param("example") CommunityExample example);

    int updateByExample(@Param("record") Community record, @Param("example") CommunityExample example);

    int updateByPrimaryKeySelective(Community record);

    int updateByPrimaryKey(Community record);
    
    //新增查询所有小区的方法
    List<Community> selectAll();
    //查询所有小区（包含被禁用的小区）
    List<Community> selectAllCommunity();
    

  //通过管理员ID查询小区
	Community selectByAId(int aId);
}