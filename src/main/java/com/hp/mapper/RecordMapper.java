package com.hp.mapper;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.annotations.Param;

import com.hp.pojo.QueryRecord;
import com.hp.pojo.QueryUserRecord;
import com.hp.pojo.Record;
import com.hp.pojo.RecordExample;
@SuppressWarnings("rawtypes")
public interface RecordMapper {
	int countByExample(RecordExample example);

	// 通过QueryRecord查询信息条数
	int countByQueryRecord(QueryRecord queryRecord);

	// 通过QueryUserRecord查询信息条数
	int countByQueryUserRecord(QueryUserRecord queryUserRecord);

	int deleteByExample(RecordExample example);

	int deleteByPrimaryKey(Integer rId);

	int insert(Record record);

	List<Record> selectByExample(RecordExample example);

	/**
	 * 通过QueryRecord进行多条件查询
	 * 
	 * @param queryRecord
	 * @return
	 */
	List<Record> selectByQueryRecord(QueryRecord queryRecord);

	int insertSelective(Record record);

	// 通过QueryUserRecord进行多条件查询
	List<QueryUserRecord> selectByQueryUserRecord(QueryUserRecord queryUserRecord);

	Record selectByPrimaryKey(Integer rId);

	int updateByExampleSelective(@Param("record") Record record, @Param("example") RecordExample example);

	int updateByExample(@Param("record") Record record, @Param("example") RecordExample example);

	int updateByPrimaryKeySelective(Record record);

	int updateByPrimaryKey(Record record);

	Record queryRecordByInfo(Integer uId, Integer cnId, Integer cmId);
	
	/*
	 * 通过record修改异常记录表中信息
	 */
	void modRecordByUser(Record record);

	/**
	 * 查询本周每一天的异常数
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectByWeekEveryDay(String starttime, String endtime, @Param("uId") int uId);

	/**
	 * 统计本周有哪些日期有异常
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectByWeekDate(String starttime, String endtime, @Param("uId") int uId);

	/**
	 * 统计从注册到当前时间每天的异常数
	 * 
	 * @param uId
	 * @return
	 */
	List selectByAllErrors(@Param("uId") int uId);

	/**
	 * 统计从注册到当前时间有哪些日期有异常，作为图表的x轴
	 * 
	 * @param uId
	 * @return
	 */
	List selectAllDate(@Param("uId") int uId);

	/**
	 * 查询本月、本年每一天的异常数
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectByMonthEveryDay(String starttime, String endtime, @Param("uId") int uId);

	/**
	 * 统计本月、本年有哪些日期有异常
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectByMonthDate(String starttime, String endtime, @Param("uId") int uId);
	/**
	 * 查询本年每月的异常数
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectRecordByEveryMonthSuperManager(String starttime, String endtime);

	/**
	 * 统计本年有哪些月份有异常
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectMonthSuperManager(String starttime, String endtime);
	/**
	 * 查询每年的异常数
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectRecordByEveryYearSuperManager();

	/**
	 * 统计有哪些年份有异常
	 * 
	 * @param starttime
	 * @param endtime
	 * @param uId
	 * @return
	 */
	List selectYearSuperManager();
	/**
	 * 根据场景id查询每个控件的异常数
	 * 
	 * @param 场景id
	 * @param uId
	 * @return
	 */
	List selectBySceneId(@Param("sceneid") int sceneid,@Param("uId") int uId);
	
	/**
	 * 根据场景id查询每个控件的控件名
	 * 
	 * @param 场景id
	 * @param uId
	 * @return
	 */
	List selectConNameBySceneId(@Param("sceneid") int sceneid,@Param("uId") int uId);
	
	/**
	 * 超级管理员根据小区对异常分组
	 * 
	 * @param 场景id
	 * @param uId
	 * @return
	 */
	List selectByCommunity();
	
	/**
	 * 所有有异常的小区名
	 * 
	 * @param 场景id
	 * @param uId
	 * @return
	 */
	List selectCommName();
	
	/*
	 * 查询所有小区异常记录数和小区id
	 * */
	List<Map<Integer,Object>> selectAllCountByCmid();
	
	/*
	 * 查询所有小区未处理异常记录数和小区id
	 * */
	List<Map<Integer,Object>> selectAllNotRestoreByCmid();

	//分场景查询异常记录表
	List selectByScene(int cmId);
	 //分场景查询异常记录表,结果为有异常的场景集合
	List selectScene(int cmId);
	//查询一个小区里异常排名前十的用户名
	List selectTopTenUName(Integer cmId);
	//查询一个小区里异常排名前十的异常数
	List selectTopTenSum(Integer cmId);
}