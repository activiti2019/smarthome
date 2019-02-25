package com.hp.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hp.pojo.QueryRecord;
import com.hp.pojo.QueryUserRecord;
import com.hp.pojo.Record;
import com.hp.utils.Page;

/**
 * @author 作者 : 王文帅
 * @version 创建时间：2017年10月22日 上午10:13:23 类说明
 */
@SuppressWarnings("rawtypes")
public interface RecordService {
	/**
	 * 通过QueryRecord进行多条件查询
	 * 
	 * @param queryRecord
	 * @return
	 */
	 Page<Record> selectByQueryRecord(QueryRecord queryRecord);

	/**
	 * 控件出现异常时记录到异常记录表
	 * 
	 * @param record
	 * @return
	 */
	int addRecord(Record record);

	/**
	 * 根据控件id和用户id和用户所在小区id查询异常记录表中的记录
	 * 
	 * @param uId
	 * @param cnId
	 * @param cmId
	 * @return
	 */
	Record queryRecordByInfo(Integer uId, Integer cnId, Integer cmId);

	/**
	 * 用户处理控件异常增加记录表中的处理记录
	 * 
	 * @param record
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
	
	/**
	 * 通过QueryUserRecord进行多条件查询
	 * 
	 * @param 用户查询条件
	 * @param QueryUserRecord
	 * @return
	 */
	public Page<QueryUserRecord> selectByQueryUserRecord(QueryUserRecord queryUserRecord);
	
	/**
	 * 分场景查询异常记录表
	 * @return
	 */
	List selectByScene(int cmId);
	/**
	 * 分场景查询异常记录表,结果为有异常的场景集合
	 * @return
	 */
	List selectScene(int cmId);
	/**
	 * 查询一个小区里异常排名前十的用户名
	 * @return
	 */
	List selectTopTenUName(Integer cmId);
	/**
	 * 查询一个小区里异常排名前十的异常数
	 * @return
	 */
	List selectTopTenSum(Integer cmId);

}