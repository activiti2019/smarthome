package com.hp.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.RecordMapper;
import com.hp.mapper.StateMapper;
import com.hp.pojo.QueryState;
import com.hp.pojo.Record;
import com.hp.pojo.State;
import com.hp.service.StateService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月16日 上午11:10:55 
* 类说明 
*/
@Service("StateService")
public class StateServiceImpl implements StateService {
	@Autowired
	private StateMapper stateMapper;
	@Autowired
	private RecordMapper recordMapper;
	
	/*
	 *  通过用户id查询用户控件状态信息
	 */
	@Override
	public List<State> selectStateByUId(Integer uid) {
		
		return stateMapper.selectStateByUId(uid);
	}
	
	/*
	 *  添加用户控件状态
	 */
	@Override
	public void addStateById(State s) {
		
		stateMapper.addStateById(s);
	}
	
	/*
	 *  通过用户信息查询用户空间状态信息
	 */
	@Override
	public State queryStateById(Integer uid, Integer cnId) {
		// TODO Auto-generated method stub
		return stateMapper.queryStateById(uid, cnId);
	}
	@Override
	public void delStateById(Integer uid,Integer cnId) {
		// TODO Auto-generated method stub
		stateMapper.delStateById(uid,cnId);
		
	}
	@Override
	public List<State> queryParState(Integer uid) {
		// TODO Auto-generated method stub
		return stateMapper.queryParState(uid);
	}
	@Override
	public List<State> queryBedState(Integer uid) {
		// TODO Auto-generated method stub
		return stateMapper.queryBedState(uid);
	}
	@Override
	public List<State> queryKitState(Integer uid) {
		// TODO Auto-generated method stub
		return stateMapper.queryKitState(uid);
	}
	@Override
	public List<State> queryDinState(Integer uid) {
		// TODO Auto-generated method stub
		return stateMapper.queryDinState(uid);
	}
	@Override
	public List<State> queryBalState(Integer uid) {
		// TODO Auto-generated method stub
		return stateMapper.queryBalState(uid);
	}
	@Override
	public List<State> queryBathState(Integer uid) {
		// TODO Auto-generated method stub
		return stateMapper.queryBathState(uid);
	}
	@Override
	public int modState( State state) {
		// TODO Auto-generated method stub
		return stateMapper.modState(state);
	}
	
	/*
	 *  通过queryState进行多条件查询
	 */
	@Override
	public Page<State> selectByQueryState(QueryState queryState){
		Page<State> page = new Page<State>();
		if (null != queryState) {
			if (null != queryState.getStId()){
				queryState.setStId(queryState.getStId());
			}
			if (null != queryState.getuId()){
				queryState.setuId(queryState.getuId());
			}
			if (null != queryState.getCnId()){
				queryState.setCnId(queryState.getCnId());
			}
			if (null != queryState.getCmId()){
				queryState.setCmId(queryState.getCmId());
			}
			if (null != queryState.getState()){
				queryState.setState(queryState.getState());
			}
			if (null != queryState.getOnoff()){
				queryState.setOnoff(queryState.getOnoff());
			}
			page.setTotal(stateMapper.countByQueryState(queryState));
			if (null != queryState.getPage()) {
				int x=stateMapper.countByQueryState(queryState);
				int y=(int)Math.ceil((double)x/queryState.getSize());
				if(queryState.getPage().intValue()>y && 0!=y){
					queryState.setPage(y);
				}
				page.setPage(queryState.getPage().intValue());
				queryState.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(stateMapper.selectByQueryState(queryState));
		}
		return page;
	}
	
	/*
	 *  通过用户id和控件id修改状态
	 */
	@Override
	public int updateByUidAndCnid(State state,Record record) {
		record.setCnId(state.getCnId());
		record.setuId(state.getuId());
		record.setHandle(1);
		record.setHandletime(new Date());
		recordMapper.modRecordByUser(record);
		return stateMapper.updateByUidAndCnidSelective(state);
	}
	
	/*
	 *  通过id查询状态信息
	 */
	@Override
	public State selectById(Integer stId) {
		return stateMapper.selectByPrimaryKey(stId);
	}
	
	/*
	 * 通过用户id查询用户控件状态 
	 */
	@Override
	public List<Integer> selectStateIdByUId(Integer uid) {
		
		return stateMapper.selectStateIdByUId(uid);
	}
	@Override
	public String queryStateName(State s) {
		
		return stateMapper.queryStateName(s);
	}
	@Override
	public State queryStateByUidCnid(Integer uid, Integer cnId) {
		// TODO Auto-generated method stub
		return stateMapper.queryStateByUidCnid(uid,cnId);
	}

}
