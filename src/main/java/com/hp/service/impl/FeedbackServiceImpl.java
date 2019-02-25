package com.hp.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.FeedbackMapper;
import com.hp.pojo.Feedback;
import com.hp.pojo.QueryFeedback;
import com.hp.service.FeedbackService;
import com.hp.utils.Page;

/**
 * @author 作者 : 王伟
 * @version 创建时间：2017年10月31日 下午3:49:57 类说明
 */
@Service("feedbackService")
public class FeedbackServiceImpl implements FeedbackService {
	@Autowired
	private FeedbackMapper feedbackMapper;
	
	/*
	 *  添加用户报修信息
	 */
	@Override
	public int addFeedback(Feedback feedback) {
		int n = 0;
		if (feedback.getCnId() != 0) {
			// 根据用户id和控件id查询是否有未处理的报修情况
			Feedback feedback1 = feedbackMapper.queryInfoByuIdcnId(feedback);
			if (feedback1 == null) {
				feedbackMapper.insert(feedback);
				n = 1;
			}
		} else {
			feedbackMapper.insert(feedback);
			n = 1;
		}
		return n;
	}

	/*
	 * 通过queryFeedback查询符合条件的控件报修信息 
	 */
	@Override
	public Page<Feedback> selectCon(QueryFeedback queryFeedback) {
		Page<Feedback> page = new Page<Feedback>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if (null != queryFeedback) {
			if (null != queryFeedback.getuId()) {
				queryFeedback.setuId(queryFeedback.getuId());
			}
			if (null != queryFeedback.getCnId()) {
				queryFeedback.setCnId(queryFeedback.getCnId());
			}
			if (null != queryFeedback.getCmId()) {
				queryFeedback.setCmId(queryFeedback.getCmId());
			}
			if (null != queryFeedback.getFixed()) {
				queryFeedback.setFixed(queryFeedback.getFixed());
			}
			if (null != queryFeedback.getStarttime() && !"".equals(queryFeedback.getStarttime())) {
				queryFeedback.setStarttime(queryFeedback.getStarttime());
			}
			if (null != queryFeedback.getEndtime() && !"".equals(queryFeedback.getEndtime())
					&& (null == queryFeedback.getStarttime() || "".equals(queryFeedback.getStarttime()))) {
				queryFeedback.setStarttime("1970-01-01");
			}
			if (null != queryFeedback.getEndtime() && !"".equals(queryFeedback.getEndtime())) {
				queryFeedback.setEndtime(queryFeedback.getEndtime());
			}
			if (null != queryFeedback.getStarttime() && !"".equals(queryFeedback.getStarttime())
					&& (null == queryFeedback.getEndtime() || "".equals(queryFeedback.getEndtime()))) {
				queryFeedback.setEndtime(simpleDateFormat.format(new Date()));
			}
			page.setTotal(feedbackMapper.countConByQueryFeedback(queryFeedback));
			if (null != queryFeedback.getPage()) {
				int x=feedbackMapper.countConByQueryFeedback(queryFeedback);
				int y=(int)Math.ceil((double)x/queryFeedback.getSize());
				if(queryFeedback.getPage().intValue()>y && 0!=y){
					queryFeedback.setPage(y);
				}
				page.setPage(queryFeedback.getPage().intValue());
				queryFeedback.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(feedbackMapper.selectCon(queryFeedback));
		}
		return page;		
	}

	/*
	 *  通过queryFeedback查询符合条件的用户建议反馈信息
	 */
	@Override
	public Page<Feedback> selectFeedback(QueryFeedback queryFeedback) {
		Page<Feedback> page = new Page<Feedback>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if (null != queryFeedback) {
			if (null != queryFeedback.getuId()) {
				queryFeedback.setuId(queryFeedback.getuId());
			}
			if (null != queryFeedback.getCnId()) {
				queryFeedback.setCnId(queryFeedback.getCnId());
			}
			if (null != queryFeedback.getCmId()) {
				queryFeedback.setCmId(queryFeedback.getCmId());
			}
			if (null != queryFeedback.getFixed()) {
				queryFeedback.setFixed(queryFeedback.getFixed());
			}
			if (null != queryFeedback.getStarttime() && !"".equals(queryFeedback.getStarttime())) {
				queryFeedback.setStarttime(queryFeedback.getStarttime());
			}
			if (null != queryFeedback.getEndtime() && !"".equals(queryFeedback.getEndtime())
					&& (null == queryFeedback.getStarttime() || "".equals(queryFeedback.getStarttime()))) {
				queryFeedback.setStarttime("1970-01-01");
			}
			if (null != queryFeedback.getEndtime() && !"".equals(queryFeedback.getEndtime())) {
				queryFeedback.setEndtime(queryFeedback.getEndtime());
			}
			if (null != queryFeedback.getStarttime() && !"".equals(queryFeedback.getStarttime())
					&& (null == queryFeedback.getEndtime() || "".equals(queryFeedback.getEndtime()))) {
				queryFeedback.setEndtime(simpleDateFormat.format(new Date()));
			}
			page.setTotal(feedbackMapper.countFeedbackByQueryFeedback(queryFeedback));
			if (null != queryFeedback.getPage()) {
				int x=feedbackMapper.countConByQueryFeedback(queryFeedback);
				int y=(int)Math.ceil((double)x/queryFeedback.getSize());
				if(queryFeedback.getPage().intValue()>y && 0!=y){
					queryFeedback.setPage(y);
				}
				page.setPage(queryFeedback.getPage().intValue());
				queryFeedback.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(feedbackMapper.selectFeedback(queryFeedback));
		}
		return page;
	}
	
	/*
	 *  通过id修改用户控件维修状态
	 */
	@Override
	public int updateFeedback(Integer fId) {
		return feedbackMapper.updateByIdSelective(fId);
	}

	/*
	 *  通过id查询反馈信息
	 */
	@Override
	public Feedback selectById(Integer fId) {
		return feedbackMapper.selectByPrimaryKey(fId);
	}


	
}
