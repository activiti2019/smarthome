package com.hp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hp.pojo.ModeRecord;

public interface ModeRecordMapper {
    int deleteByPrimaryKey(Integer dId);

    int insert(ModeRecord record);

    int insertSelective(ModeRecord record);

    ModeRecord selectByPrimaryKey(Integer dId);

    int updateByPrimaryKeySelective(ModeRecord record);

    int updateByPrimaryKey(ModeRecord record);
    //批量增加
    int insertModeRecords(List<ModeRecord> modeRecords);
    //查询当前用户该模式下的所有控件
	List<ModeRecord> queryRecordsByUID(Integer uId,Integer mId);
	//删除该模式下全部控件
	int  deleteRecordsByUID(Integer uId ,Integer mId);
	
//	int insertModeRecord(ModeRecord record);
	ModeRecord queryRecordByCnId(Integer uId,Integer cnId,Integer mId);
	//根据用户id、控件id和模式id批量删除
	int deleteRecordsByCnId(@Param("uid")Integer uId,@Param("nums") int [] nums,@Param("mid") Integer mId);
	
	int deleteRecordByCnId(Integer uId,Integer cnId);
}