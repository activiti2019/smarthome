package com.hp.mapper;

import java.util.List;

import com.hp.pojo.Feedback;
import com.hp.pojo.QueryFeedback;

public interface FeedbackMapper {
    int deleteByPrimaryKey(Integer fId);

    int insert(Feedback record);

    int insertSelective(Feedback record);

    Feedback selectByPrimaryKey(Integer fId);
    
    //查询所有控件报修信息
    List<Feedback> selectCon(QueryFeedback queryFeedback);
    //查询控件报修信息条数
    int countConByQueryFeedback(QueryFeedback queryFeedback);
    
    //查询所有用户反馈信息
    List<Feedback> selectFeedback(QueryFeedback queryFeedback);
    //查询用户反馈信息条数
    int countFeedbackByQueryFeedback(QueryFeedback queryFeedback);
    
    int updateByIdSelective(Integer fId);
    
    int updateByPrimaryKeySelective(Feedback record);

    int updateByPrimaryKey(Feedback record);
    
    Feedback queryInfoByuIdcnId(Feedback feedback);
}