package com.hp.service;


import com.hp.pojo.Feedback;
import com.hp.pojo.QueryFeedback;
import com.hp.utils.Page;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月31日 下午3:26:58 
* 类说明 
*/
public interface FeedbackService {
	
	/*增加反馈数据*/
	int addFeedback(Feedback feedback);
	
	/*查询所有控件报修信息*/
    Page<Feedback> selectCon(QueryFeedback queryFeedback);
    
    /*查询所有用户反馈信息*/
    Page<Feedback> selectFeedback(QueryFeedback queryFeedback);
    
    /*修改用户报修信息*/
    int updateFeedback(Integer fId);
    
    /*通过id查询信息*/
    Feedback selectById(Integer fId);
}
