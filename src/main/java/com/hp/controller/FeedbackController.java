package com.hp.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Feedback;
import com.hp.pojo.User;
import com.hp.service.FeedbackService;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月31日 下午3:41:07 
* 类说明 
*/
@Controller
@RequestMapping("feedback")
public class FeedbackController {
	@Autowired
	private FeedbackService feedbackService;
	
	
	@RequestMapping("addFeedback")
	public @ResponseBody int addFeedback(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentuser");
		String action = request.getParameter("action");
		int cnId = Integer.parseInt(request.getParameter("cnId"));
		String message = request.getParameter("message");
		Feedback feedback = new Feedback();
		feedback.setuId(user.getuId());
		feedback.setCreatetime(new Date());
		feedback.setFixed(0);
		feedback.setMessage(message);
		switch(action){
		case "addFix":
			feedback.setCnId(cnId);
			break;
		case "addSug":
			feedback.setCnId(0);
			break;
		}
		int n = feedbackService.addFeedback(feedback);
		return n;
	}
	
}
