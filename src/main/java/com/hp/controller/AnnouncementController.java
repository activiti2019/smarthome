package com.hp.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Announcement;
import com.hp.pojo.User;
import com.hp.service.AnnouncementService;
import com.hp.service.UserService;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月29日 下午4:04:02 
* 类说明 
*/
@Controller
@RequestMapping("/announce")
public class AnnouncementController {
	@Autowired
	private AnnouncementService announcementService;
	@Autowired
	private UserService userService;
	
	/**
	 * 小区管理员发布公告或者给用户发送提醒
	 * @param request
	 * @return
	 */
	@RequestMapping("/addAnnounce")
	public @ResponseBody int addAnnounce(HttpServletRequest request){
		String action = request.getParameter("action");
		int n = 0;
		switch(action){
		case "addAnnoun":
			String message = request.getParameter("message");
			int cmId = Integer.parseInt(request.getParameter("cmId"));
			Announcement announcement = new Announcement();
			announcement.setCmId(cmId);
			announcement.setCreatetime(new Date());
			announcement.setMessage(message);
			announcement.setuId(0);
			n =announcementService.addAnnouncement(announcement);
			break;
		case "warning":
			int uId = Integer.parseInt(request.getParameter("uId"));
			String warning = request.getParameter("warning");
			User user = userService.selectById(uId);
			Announcement announcement2 = new Announcement();
			announcement2.setuId(uId);
			announcement2.setCreatetime(new Date());
			announcement2.setMessage(warning);
			announcement2.setCmId(user.getCmId());
			n = announcementService.addAnnouncement(announcement2);
			break;
		case "addAnnounBySuper":
			String message1 = request.getParameter("message");
			Announcement announcement1 = new Announcement();
			announcement1.setMessage(message1);
			announcement1.setCmId(-1);
			announcement1.setuId(0);
			announcement1.setCreatetime(new Date());
			n = announcementService.addAnnouncement(announcement1);
			break;
		}
		return n;
	}
	/**
	 * 用户登录时根据用户的小区id查询当前小区的最新公告
	 * @param request
	 * @return
	 */
	@RequestMapping("/queryAnnouncement")
	public @ResponseBody Announcement queryAnnouncement(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentuser");
		Announcement announcement = announcementService.queryAnnouncement(user.getCmId());
		return announcement;
	}
	/**
	 * 用户登录时根据用户id和小区id查询来自管理的最新的三条提醒
	 * @param request
	 * @return
	 */
	@RequestMapping("/queryWarning")
	public @ResponseBody List<Announcement> queryWarning(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentuser");
		List<Announcement> list = announcementService.queryWarning(user.getuId(), user.getCmId());
		return list;
	}
	@RequestMapping("/queryUpdate")
	public @ResponseBody Announcement  queryUpdate(HttpSession session){
		Announcement announcement = announcementService.queryUpdate();
//		session.setAttribute("announcement", announcement);
		return announcement;
	}
}
