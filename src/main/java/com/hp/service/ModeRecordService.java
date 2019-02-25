package com.hp.service;

import java.util.List;

import com.hp.pojo.ModeRecord;
import com.hp.pojo.User;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年11月8日 下午5:32:33 
* 类说明 本类为情景模式详细存储类
*/
public interface ModeRecordService {
	
	/**
	 * 根据用户id和情景模式id批量插入控件状态
	 * @param user用户id
	 * @param modeRecords批量
	 * @param mId情景模式id
	 * @return
	 */
	
	int addModeRecord(User user,List<ModeRecord> modeRecords,Integer mId);
	
	/**
	 * 根据用户id和情景模式id查询该情景模式控件状态
	 * @param uId
	 * @param mId
	 * @return
	 */
	List<ModeRecord> queryRecordsByUID(Integer uId,Integer mId);
	
	int deleteRecordByCnId(Integer uId,Integer cnId);
	
	
}
