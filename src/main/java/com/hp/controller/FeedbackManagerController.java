package com.hp.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.Controls;
import com.hp.pojo.Feedback;
import com.hp.pojo.QueryFeedback;
import com.hp.pojo.User;
import com.hp.service.CommunityService;
import com.hp.service.ControlsService;
import com.hp.service.FeedbackService;
import com.hp.service.UserService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月31日 下午10:34:54 
* 类说明 
*/
@Controller
public class FeedbackManagerController {
	@Autowired
	private FeedbackService feedbackService;
	@Autowired
	private ControlsService controlsService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private UserService userService;
	
	@RequestMapping("/feedback/conlist")
	public String conlist(String uName,QueryFeedback queryFeedback,Model model){
		if(null!=uName && !"".equals(uName)){
			List<Integer> userList=null;
			List<Integer> userNull=new ArrayList<Integer>();
			userNull.add(-1);
			userList=userService.selectListByUserName(uName);
			if(userList.isEmpty()){
				queryFeedback.setuId(userNull);
			}else{
				queryFeedback.setuId(userList);
			}
		}
		List<Community> cmList = communityService.selectAllCommunity();
		List<Controls> controlsList = controlsService.selectAll();
		List<User> userList = userService.selectAll();
		model.addAttribute("userList", userList);
		model.addAttribute("controlsList", controlsList);
		model.addAttribute("cmList", cmList);
		model.addAttribute("starttime", queryFeedback.getStarttime());
		model.addAttribute("endtime", queryFeedback.getEndtime());
		Page<Feedback> page=feedbackService.selectCon(queryFeedback);
		model.addAttribute("page", page);
		model.addAttribute("uName", uName);
		model.addAttribute("cnId", queryFeedback.getCnId());
		model.addAttribute("cmId", queryFeedback.getCmId());
		model.addAttribute("fixed", queryFeedback.getFixed());
		return "confeedbackmanager";
	}
	
	@RequestMapping("/feedback/feedbacklist")
	public String feedbacklist(String uName,QueryFeedback queryFeedback,Model model){
		if(null!=uName && !"".equals(uName)){
			List<Integer> userList=null;
			List<Integer> userNull=new ArrayList<Integer>();
			userNull.add(-1);
			userList=userService.selectListByUserName(uName);
			if(userList.isEmpty()){
				queryFeedback.setuId(userNull);
			}else{
				queryFeedback.setuId(userList);
			}
		}
		List<Community> cmList = communityService.selectAllCommunity();
//		List<Controls> controlsList = controlsService.selectAll();
		List<User> userList = userService.selectAll();
		model.addAttribute("userList", userList);
//		model.addAttribute("controlsList", controlsList);
		model.addAttribute("cmList", cmList);
		model.addAttribute("starttime", queryFeedback.getStarttime());
		model.addAttribute("endtime", queryFeedback.getEndtime());
		Page<Feedback> page=feedbackService.selectFeedback(queryFeedback);
		model.addAttribute("page", page);
		model.addAttribute("uName", uName);
//		model.addAttribute("cnId", queryFeedback.getCnId());
		model.addAttribute("cmId", queryFeedback.getCmId());
//		model.addAttribute("fixed", queryFeedback.getFixed());
		return "fedfeedbackmanager";
	}
	
	
	@RequestMapping("/feedback/update.action")
	@ResponseBody
	public String update(Integer fId){
		feedbackService.updateFeedback(fId);
		return "OK";
	}
}
