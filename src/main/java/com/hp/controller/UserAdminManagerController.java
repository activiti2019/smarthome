package com.hp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Admin;
import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.QueryUser;
import com.hp.pojo.User;
import com.hp.service.AdminService;
import com.hp.service.CommunityService;
import com.hp.service.UserService;
import com.hp.utils.Page;

/**
 * @author 作者 : 王文帅
 * @version 创建时间：2017年10月17日 下午9:18:26 类说明
 */
@Controller
public class UserAdminManagerController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private UserService userService;
	@Autowired
	private CommunityService communityService;

	/* 通过aName和aPwd进行管理员登录验证 */
	@RequestMapping("/admin/login")
	@ResponseBody
	public int login(String aName, String aPwd, HttpSession session) {
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(aName, aPwd);
		try {
			subject.login(token);
			Admin admin = null;
			admin = adminService.selectByNameAndPwd(aName, aPwd);
			if (null == admin) {
				return 0;
			} else {
				session.setAttribute("admin", admin);
				if(null!=communityService.selectByCmId(admin.getCmId())){
					session.setAttribute("commnityname", communityService.selectByCmId(admin.getCmId()).getCmName());
				}
				return 1;
			}
		} catch (Exception e) {
			return 0;
		}
	}

	/* 小区管理员退出系统 */
	@RequestMapping("/logout")
	public String logout() {
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "redirect:login.jsp";
	}

	/* 小区管理员修改密码 */
	@RequestMapping("/admin/update")
	@ResponseBody
	public int updateAdmin(String aName, String aPwd, String aPwd2,String aPwd3) {
		int x = adminService.changePwd(aName, aPwd, aPwd2,aPwd3);
		if (x == 1) {
			return 1;
		} else {
			return 0;
		}
	}

	/* 小区管理员查询出该小区所有用户信息 */
	@RequestMapping("/user2/list")
	public String list(QueryUser queryUser, Model model, HttpSession session) {
		System.out.println(queryUser);
		List<Community> cmList = communityService.selectAll();
		model.addAttribute("cmList", cmList);
		Admin admin = (Admin) session.getAttribute("admin");
		queryUser.setCmId(admin.getCmId());
		Page<User> page = userService.selectByQueryUser(queryUser);
		session.setAttribute("page1", page);
		model.addAttribute("page", page);
		model.addAttribute("uName", queryUser.getuName());
		model.addAttribute("address", queryUser.getAddress());
		model.addAttribute("realname", queryUser.getRealname());
		model.addAttribute("state",queryUser.getState());
		return "useradminmanager";
	}

	/* 小区管理员通过id查询用户信息 */
	@RequestMapping("/user2/edit.action")
	@ResponseBody
	public User edit(Integer uId) {
		return userService.selectById(uId);
	}

	/* 小区管理员修改用户信息 */
	@RequestMapping("/user2/update.action")
	@ResponseBody
	public String updateUser(User user) {
		userService.updateByUser(user);
		return "OK";
	}

	/* 小区管理员删除用户 */
	@RequestMapping("/user2/delete.action")
	@ResponseBody
	public String delete(Integer uId) {
		userService.deleteById(uId);
		return "OK";
	}
	
	/* 小区管理员删除用户 */
	@RequestMapping("/user2/restore.action")
	@ResponseBody
	public String restore(Integer uId) {
		userService.restoreById(uId);
		return "OK";
	}

}
