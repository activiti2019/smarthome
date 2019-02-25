package com.hp.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.RecordMapper;
import com.hp.pojo.QueryRecord;
import com.hp.pojo.QueryUserRecord;
import com.hp.pojo.Record;
import com.hp.service.RecordService;
import com.hp.utils.Page;

/**
 * @author 作者 : 王文帅
 * @version 创建时间：2017年10月22日 上午10:14:41 类说明
 */
@SuppressWarnings("rawtypes")
@Service("RecordService")
public class RecordServiceImpl implements RecordService {
	@Autowired
	private RecordMapper recordMapper;

	/*
	 *  通过QueryRecord进行多条件查询
	 */
	@Override
	public Page<Record> selectByQueryRecord(QueryRecord queryRecord) {
		Page<Record> page = new Page<Record>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if (null != queryRecord) {
			if (null != queryRecord.getuId()) {
				queryRecord.setuId(queryRecord.getuId());
			}
			if (null != queryRecord.getCnId()) {
				queryRecord.setCnId(queryRecord.getCnId());
			}
			if (null != queryRecord.getCmId()) {
				queryRecord.setCmId(queryRecord.getCmId());
			}
			if (null != queryRecord.getStarttime() && !"".equals(queryRecord.getStarttime())) {
				queryRecord.setStarttime(queryRecord.getStarttime());
			}
			if (null != queryRecord.getEndtime() && !"".equals(queryRecord.getEndtime())
					&& (null == queryRecord.getStarttime() || "".equals(queryRecord.getStarttime()))) {
				queryRecord.setStarttime("1970-01-01");
			}
			if (null != queryRecord.getEndtime() && !"".equals(queryRecord.getEndtime())) {
				queryRecord.setEndtime(queryRecord.getEndtime());
			}
			if (null != queryRecord.getStarttime() && !"".equals(queryRecord.getStarttime())
					&& (null == queryRecord.getEndtime() || "".equals(queryRecord.getEndtime()))) {
				queryRecord.setEndtime(simpleDateFormat.format(new Date()));
			}
			page.setTotal(recordMapper.countByQueryRecord(queryRecord));
			if (null != queryRecord.getPage()) {
				int x=recordMapper.countByQueryRecord(queryRecord);
				int y=(int)Math.ceil((double)x/queryRecord.getSize());
				if(queryRecord.getPage().intValue()>y && 0!=y){
					queryRecord.setPage(y);
				}
				page.setPage(queryRecord.getPage().intValue());
				queryRecord.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(recordMapper.selectByQueryRecord(queryRecord));
		}
		return page;
	}

	/*
	 *  通过QueryUserRecord进行多条件查询
	 */ 
	@Override
	public Page<QueryUserRecord> selectByQueryUserRecord(QueryUserRecord queryUserRecord) {
		Page<QueryUserRecord> page = new Page<QueryUserRecord>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if (null != queryUserRecord.getPage()) {
			page.setPage(queryUserRecord.getPage().intValue());
			queryUserRecord.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
		}
		// 去除模糊搜索字符的首尾空格
		queryUserRecord.setCnName(queryUserRecord.getCnName().trim());
		// 对两个时间有一个未输入的处理
		if (null != queryUserRecord.getEndtime() && !"".equals(queryUserRecord.getEndtime())
				&& (null == queryUserRecord.getStarttime() || "".equals(queryUserRecord.getStarttime()))) {
			queryUserRecord.setStarttime("1970-01-01");
		}
		if (null != queryUserRecord.getStarttime() && !"".equals(queryUserRecord.getStarttime())
				&& (null == queryUserRecord.getEndtime() || "".equals(queryUserRecord.getEndtime()))) {
			queryUserRecord.setEndtime(simpleDateFormat.format(new Date()));
		}
		page.setTotal(recordMapper.countByQueryUserRecord(queryUserRecord));
		page.setRows(recordMapper.selectByQueryUserRecord(queryUserRecord));
		return page;
	}

	/*
	 *  增加异常信息
	 */
	@Override
	public int addRecord(Record record) {
		Record record1 = recordMapper.queryRecordByInfo(record.getuId(), record.getCnId(), record.getCmId());
		System.out.println(record);
		if (record1 == null) {
			recordMapper.insert(record);
		} else {
			recordMapper.modRecordByUser(record);
		}
		return 1;
	}

	/*
	 *  通过用户信息查询异常记录信息
	 */
	@Override
	public Record queryRecordByInfo(Integer uId, Integer cnId, Integer cmId) {
		return recordMapper.queryRecordByInfo(uId, cnId, cmId);
	}

	
	@Override
	public void modRecordByUser(Record record) {
		recordMapper.modRecordByUser(record);
	}

	/*
	 *  查询本周每一天的异常数
	 */ 
	@Override
	public List selectByWeekEveryDay(String starttime, String endtime, int uId) {
		return recordMapper.selectByWeekEveryDay(starttime, endtime, uId);
	}

	/*
	 *  统计本周有哪些日期有异常
	 */ 
	@Override
	public List selectByWeekDate(String starttime, String endtime, int uId) {
		// TODO Auto-generated method stub
		return recordMapper.selectByWeekDate(starttime, endtime, uId);
	}

	/*
	 *  统计从注册到当前时间每天的异常数
	 */ 
	@Override
	public List selectByAllErrors(int uId) {
		return recordMapper.selectByAllErrors(uId);
	}

	/*
	 *  统计从注册到当前时间有哪些日期有异常，作为图表的x轴
	 */ 
	@Override
	public List selectAllDate(int uId) {
		return recordMapper.selectAllDate(uId);
	}

	/*
	 *  查询本月、本年每一天的异常数
	 */ 
	@Override
	public List selectByMonthEveryDay(String starttime, String endtime, int uId) {
		return recordMapper.selectByMonthEveryDay(starttime, endtime, uId);
	}

	/*
	 *  统计本月、本年有哪些日期有异常
	 */ 
	@Override
	public List selectByMonthDate(String starttime, String endtime, int uId) {
		return recordMapper.selectByMonthDate(starttime, endtime, uId);
	}

	/*
	 *  根据场景id查询每个控件的异常数
	 */ 
	@Override
	public List selectBySceneId(int sceneid, int uId) {
		return recordMapper.selectBySceneId(sceneid, uId);
	}

	/*
	 *  根据场景id查询每个控件的控件名
	 */ 
	@Override
	public List selectConNameBySceneId(int sceneid, int uId) {
		return recordMapper.selectConNameBySceneId(sceneid, uId);
	}

	/*
	 *  超级管理员根据小区对异常分组
	 */ 
	@Override
	public List selectByCommunity() {
		return recordMapper.selectByCommunity();
	}

	/*
	 *   所有有异常的小区名
	 */
	@Override
	public List selectCommName() {
		return recordMapper.selectCommName();
	}

	/*
	 *  分场景查询异常记录表
	 */
	@Override
	public List selectByScene(int cmId) {
		return recordMapper.selectByScene(cmId);
	}
	
	/*
	 *  分场景查询异常记录表,结果为有异常的场景集合
	 */
	@Override
	public List selectScene(int cmId){
		return recordMapper.selectScene(cmId);
	}
	
	/*
	 * 查询一个小区里异常排名前十的用户名 
	 */
	@Override
	public List selectTopTenUName(Integer cmId){
		return recordMapper.selectTopTenUName(cmId);
	}
	
	/*
	 *  查询一个小区里异常排名前十的异常数
	 */
	@Override
	public List selectTopTenSum(Integer cmId){
		return recordMapper.selectTopTenSum(cmId);
	}
	
	/*
	 *  查询本年每月的异常数
	 */
	@Override
	public List selectRecordByEveryMonthSuperManager(String starttime, String endtime) {
		return recordMapper.selectRecordByEveryMonthSuperManager(starttime, endtime);
	}
	
	/*
	 *  统计本年有哪些月份有异常
	 */
	@Override
	public List selectMonthSuperManager(String starttime, String endtime) {
		return recordMapper.selectMonthSuperManager(starttime, endtime);
	}
	
	/*
	 *  查询每年的异常数
	 */
	@Override
	public List selectRecordByEveryYearSuperManager() {
		return recordMapper.selectRecordByEveryYearSuperManager();
	}
	
	/*
	 *  统计有哪些年份有异常
	 */
	@Override
	public List selectYearSuperManager() {
		return recordMapper.selectYearSuperManager();
	}
}
