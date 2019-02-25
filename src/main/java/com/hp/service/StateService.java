package com.hp.service;

import java.util.List;

import com.hp.pojo.QueryState;
import com.hp.pojo.Record;
import com.hp.pojo.State;
import com.hp.utils.Page;

/**
 * @author 作者 : 王伟
 * @version 创建时间：2017年10月16日 上午11:09:37 类说明
 */
public interface StateService {
	
	/**
	 * 查询用户当前控件的状态
	 * @param uid 用户id
	 * @return 
	 */
	List<State> selectStateByUId(Integer uid);
	
	/**
	 * 查询用户当前所安装控件的id
	 * @param uid
	 * @return
	 */
	List<Integer> selectStateIdByUId(Integer uid);
	
	/**
	 * 通过QueryState进行多条件查询
	 * @param queryState
	 * @return
	 */
	Page<State> selectByQueryState(QueryState queryState);
	
	/**
	 * 通过用户id和控件id修改状态
	 * @param state
	 * @param record
	 * @return
	 */
	int updateByUidAndCnid(State state,Record record);

	/**
	 * 根据控件id和用户id增加控件
	 * @param state
	 * @param record
	 * @return
	 */
	void addStateById(State s);

	/**
	 * 根据控件id和用户id查询控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	State queryStateById(Integer uid, Integer cnId);

	/**
	 * 通过id查询信息
	 * @param state
	 * @param record
	 * @return
	 */
	State selectById(Integer integer);
	
	/**
	 * 根据控件id和用户id删除控件
	 * @param state
	 * @param record
	 * @return
	 */
	void delStateById(Integer uid, Integer cnId);

	/**
	 * 根据用户id查询客厅的控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	List<State> queryParState(Integer uid);

	/**
	 * 根据用户id查询卧室的控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	List<State> queryBedState(Integer uid);

	/**
	 * 根据用户id查询厨房的控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	List<State> queryKitState(Integer uid);

	/**
	 * 根据用户id查询餐厅的控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	List<State> queryDinState(Integer uid);

	/**
	 * 根据用户id查询阳台的控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	List<State> queryBalState(Integer uid);

	/**
	 * 根据用户id查询浴室的控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	List<State> queryBathState(Integer uid);
	/**
	 * 根据用户id与cnid修改控件状态
	 * @param state
	 * @param record
	 * @return
	 */
	int modState(State state);
	
	/**
	 * 根据用户id与cnid返回异常控件名字
	 * @param state
	 * @param record
	 * @return
	 */
	String queryStateName(State s);
	
	/**
	 * 根据用户id查询摄像头控件状态
	 * @param uid
	 * @param cnId
	 * @return
	 */
	State queryStateByUidCnid(Integer uid ,Integer cnId);
	
	
}
