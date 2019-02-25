package com.hp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.QueryUser;
import com.hp.pojo.User;
import com.hp.service.CommunityService;
import com.hp.service.UserService;
import com.hp.utils.Page;

/** 
* @author 作者 E-mail: 王文帅
* @version 创建时间：2017年10月16日 上午10:05:48 
* 类说明 
*/
@Controller
public class UserManagerController {
	@Autowired
	private UserService userService;
	@Autowired
	private CommunityService communityService;

	/*查询出所有用户的信息*/
	@RequestMapping("/user/list")
	public String list(QueryUser queryUser, Model model){
		List<Community> cmList = communityService.selectAllCommunity();
		model.addAttribute("cmList", cmList);
		Page<User> page = userService.selectByQueryUser(queryUser);
		model.addAttribute("page", page);
		model.addAttribute("uName", queryUser.getuName());
		model.addAttribute("address", queryUser.getAddress());
		model.addAttribute("realname", queryUser.getRealname());
		model.addAttribute("cmId", queryUser.getCmId());
		model.addAttribute("state",queryUser.getState());
		return "usermanager";
	}
	/*通过id查询出该用户信息*/
	@RequestMapping("/user/edit.action")
	@ResponseBody
	public User edit(Integer uId){
		return userService.selectById(uId);
	}
	/*修改用户信息*/
	@RequestMapping("/user/update.action")
	@ResponseBody
	public String update(User user){
		userService.updateByUser(user);
		return "OK";
	}
	/*删除用户*/
	@RequestMapping("/user/delete.action")
	@ResponseBody
	public String delete(Integer uId){
		userService.deleteById(uId);
		return "OK";
	}
	
	/*恢复用户*/
	@RequestMapping("/user/restore.action")
	@ResponseBody
	public String restore(Integer uId){
		userService.restoreById(uId);
		return "OK";
	}
}
