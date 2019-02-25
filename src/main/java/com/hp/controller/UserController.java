package com.hp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Community;
import com.hp.pojo.Controls;
import com.hp.pojo.State;
import com.hp.pojo.User;
import com.hp.service.CommunityService;
import com.hp.service.ControlsService;
import com.hp.service.StateService;
import com.hp.service.UserService;

/**
 * @author 作者 : 陈燕君
 * @version 创建时间：2017年10月14日 上午11:45:00
 * @description
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private StateService stateService;
	@Autowired
	private ControlsService controlsService;
	Random r = new Random();

	// 用户登录
	@RequestMapping("/login")
	public @ResponseBody Map<String, Object> login(String username, String password, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		// 得到当前执行的用户
		Subject subject = SecurityUtils.getSubject();
		// System.out.println(username+">>>>"+password);
		// 创建token令牌,用户名/密码
		UsernamePasswordToken token = new UsernamePasswordToken(username, password);
		try {
			// 用户身份认证
			subject.login(token);
			User user = userService.selectByNameAndPwd(username, password);
			if (user != null && user.getState() == 1) {
				request.getSession().setAttribute("currentuser", user);
				User user2 = (User) request.getSession().getAttribute("currentuser");
				map.put("msg", "成功");
			} else if (user != null && user.getState() != 1) {
				map.put("msg", "用户被禁用");
			} else {
				map.put("msg", "失败");
			}
		} catch (Exception e) {
			// request.getSession().setAttribute("user",user);
			map.put("msg", "失败");
		}
		return map;
	}

	// 登录成功后跳转
	/**
	 * 在此部分添加了随机产生异常的处理,便于测试系统
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/loginSuccess")
	public void loginSuccess(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// 在此部分添加随机,便于系统测试
		User currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = stateService.selectStateByUId(currentUser.getuId());
		State sxt = stateService.queryStateByUidCnid(currentUser.getuId(), 7);
		int[] num = { 2, 8, 10, 13, 15, 16, 17, 20, 22 };
		int[] mc = { 2, 15, 17, 22 };
		for (State state : list) {
			for (Integer i : num) {
				if (state.getCnId() == i) {
					if (state.getState() != 1 && state.getOnoff() == 1) {
						state.setState(r.nextInt(2));
						stateService.modState(state);
					}
				}
			}
			for (Integer id : mc) {
				if (sxt != null) {
					if (state.getCnId() == id && state.getState() == 1) {
						sxt.setOnoff(1);
						stateService.modState(sxt);

					}
				}
			}
		}

		// 查询用户已安装的所有控件
		List<State> stateList = stateService.selectStateByUId(currentUser.getuId());
		List<Controls> list123 = new ArrayList();
		for (State state : stateList) {
			Controls control = controlsService.selectById(state.getCnId());
			list123.add(control);
		}
		session.setAttribute("stateList", list123);
		request.getRequestDispatcher("/compage/homepage.jsp").forward(request, response);
	}

	// 验证用户名是否存在
	@RequestMapping("/userNameExsits")
	public @ResponseBody Map<String, Object> userNameExsits(String username, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		User selectByUserName = userService.selectByUserName(username);
		if (selectByUserName != null) {
			map.put("valid", false); // 用户名已存在
		} else {
			map.put("valid", true);// 用户名可用
		}
		return map;
	}

	// 用户注册
	@RequestMapping("/userRegister")
	public @ResponseBody Map<String, Object> userRegister(User user, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();

		String username = user.getuName();
		User selectByUserName = userService.selectByUserName(username);
		if (selectByUserName != null) {
			map.put("valid", false); // 用户名已存在
		} else {
			int insertSelective = userService.insertSelective(user);
			if (insertSelective > 0) {
				User selectByPrimaryKey = userService.selectByUserName(user.getuName());
				request.getSession().setAttribute("currentuser", selectByPrimaryKey);
				map.put("msg", "成功");
			} else {
				map.put("msg", "失败");
			}
		}

		return map;
	}

	// 所有小区
	@RequestMapping("/getComList1")
	public @ResponseBody void getComList1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Community> stuClassList = communityService.selectAll();
		request.setAttribute("comlist1", stuClassList);
		request.getRequestDispatcher("../register.jsp").forward(request, response);
	}

	// 所有小区
	@RequestMapping("/getComList")
	public @ResponseBody void getComList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Community> stuClassList = communityService.selectAll();
		request.setAttribute("comlist", stuClassList);
		request.getRequestDispatcher("/compage/usercenter.jsp").forward(request, response);
	}

	// 用户退出登录
	@RequestMapping("/userLogout")
	public @ResponseBody Map<String, Object> userLogout(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		request.getSession().removeAttribute("currentuser");
		Object attribute = request.getSession().getAttribute("currentuser");
		if (attribute == null) {
			map.put("res", 1);
		} else {
			map.put("res", 0);
		}
		return map;
	}

	// 获取用户信息，用于更新
	@RequestMapping("/getUserInfo")
	public @ResponseBody Map<Integer, Object> getUserInfo(HttpServletRequest request) throws Exception {
		Map<Integer, Object> map = new HashMap<>();
		User user = (User) request.getSession().getAttribute("currentuser");
		User selectById = userService.selectById(user.getuId());
		map.put(user.getuId(), selectById);
		return map;
	}

	// 查询用户的情景模式
	@RequestMapping("/getUserMode")
	public @ResponseBody int getUserMode(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("currentuser");
		return user.getMode();
	}

	// 更新用户信息
	@RequestMapping("/updateUserInfo")
	public @ResponseBody Map<String, Object> updateUserInfo(User user, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		User u = (User) request.getSession().getAttribute("currentuser");
		int uId = u.getuId();
		int mode = u.getMode();
		int rId = u.getrId();
		user.setuId(uId);
		user.setMode(mode);
		user.setrId(rId);
		int updateByPrimaryKeySelective = userService.updateByPrimaryKeySelective(user);
		if (updateByPrimaryKeySelective > 0) {
			User selectByPrimaryKey = userService.selectByPrimaryKey(uId);
			request.getSession().setAttribute("currentuser", selectByPrimaryKey);
			System.out.println(request.getSession().getAttribute("currentuser"));
			map.put("msg", "成功");
		} else {
			map.put("msg", "失败");
		}
		return map;
	}

	// 更新用户密码
	@RequestMapping("/updateUserpwd")
	public @ResponseBody Map<String, Object> updateUserPwd(String oldpassword, String newpassword,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		User u = (User) request.getSession().getAttribute("currentuser");
		if (u == null) {
			return null;
		}
		int uId = u.getuId();
		User userafter = userService.selectByPrimaryKey(uId);
		String pwd = userafter.getuPwd();
		if (!pwd.equals(oldpassword)) {
			map.put("msg", "原密码错误");
		} else {
			User user = new User();
			user.setuId(uId);
			user.setuPwd(newpassword);
			int updateByPrimaryKeySelective = userService.updateByPrimaryKeySelective(user);
			if (updateByPrimaryKeySelective > 0) {
				User selectByPrimaryKey = userService.selectByPrimaryKey(uId);
				request.getSession().setAttribute("currentuser", selectByPrimaryKey);
				map.put("msg", "成功");
			} else {
				map.put("msg", "失败");
			}
		}
		return map;
	}

}
