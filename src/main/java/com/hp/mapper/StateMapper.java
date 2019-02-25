package com.hp.mapper;

import com.hp.pojo.QueryState;
import com.hp.pojo.State;
import com.hp.pojo.StateExample;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface StateMapper {
	int countByExample(StateExample example);
	
	//通过QueryState查询符合条件的信息数量
	int countByQueryState(QueryState queryState);

	int deleteByExample(StateExample example);

	int deleteByPrimaryKey(Integer stId);

	int insert(State record);

	int insertSelective(State record);

	List<State> selectByExample(StateExample example);
	
	//通过QueryState进行多条件查询
	List<State> selectByQueryState(QueryState queryState);

	State selectByPrimaryKey(Integer stId);

	int updateByExampleSelective(@Param("record") State record, @Param("example") StateExample example);

	int updateByExample(@Param("record") State record, @Param("example") StateExample example);

	int updateByPrimaryKeySelective(State record);
	
	//通过用户id和控件id修改状态
	int updateByUidAndCnidSelective(State state);

	int updateByPrimaryKey(State record);

	// 查询用户当前控件的状态
	List<State> selectStateByUId(Integer uid);

	// 根据控件id和用户id增加控件
	void addStateById(State state);

	// 根据控件id和用户id查询控件状态
	State queryStateById(Integer uid, Integer cnId);

	// 根据控件id和用户id删除控件
	void delStateById(Integer uid, Integer cnId);

	// 根据用户id查询客厅的控件状态
	List<State> queryParState(Integer uid);

	// 根据用户id查询卧室的控件状态
	List<State> queryBedState(Integer uid);

	// 根据用户id查询厨房的控件状态
	List<State> queryKitState(Integer uid);

	// 根据用户id查询餐厅的控件状态
	List<State> queryDinState(Integer uid);

	// 根据用户id查询阳台的控件状态
	List<State> queryBalState(Integer uid);

	// 根据用户id查询浴室的控件状态
	List<State> queryBathState(Integer uid);
	//修改用户id修改控件状态
	int modState(State state);
	//根据用户id查询当前已安装的控件id
	List<Integer> selectStateIdByUId(Integer uid);
	//
	String queryStateName(State s);
	
	//根据用户id查询摄像头控件状态
	State queryStateByUidCnid(Integer uid, Integer cnId);
}