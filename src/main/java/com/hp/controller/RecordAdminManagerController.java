package com.hp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Admin;
import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.Controls;
import com.hp.pojo.QueryRecord;
import com.hp.pojo.Record;
import com.hp.pojo.User;
import com.hp.service.AdminService;
import com.hp.service.CommunityService;
import com.hp.service.ControlsService;
import com.hp.service.RecordService;
import com.hp.service.UserService;
import com.hp.utils.Page;

/**
 * @author 作者 : 王文帅
 * @version 创建时间：2017年10月22日 下午3:02:35 类说明
 */
@Controller
public class RecordAdminManagerController {
	@Autowired
	private RecordService recordService;
	@Autowired
	private ControlsService controlsService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private UserService userService;

	/* 小区管理员查询该小区异常记录信息 */
	@RequestMapping("/record2/list")
	public String list(String uName, QueryRecord queryRecord, Model model, HttpSession session) {
		if (null != session.getAttribute("admin")) {
			Admin admin = null;
			admin = (Admin) session.getAttribute("admin");
			queryRecord.setCmId(admin.getCmId());
		}
		if(null!=uName && !"".equals(uName)){
			List<Integer> userList=null;
			List<Integer> userNull=new ArrayList<Integer>();
			userNull.add(-1);
			userList=userService.selectListByUserName(uName);
			if(userList.isEmpty()){
				queryRecord.setuId(userNull);
			}else{
				queryRecord.setuId(userList);
			}
		}
		List<Community> cmList = communityService.selectAllCommunity();
		List<Controls> controlsList = controlsService.selectAll();
		List<User> userList = userService.selectAll();
		model.addAttribute("userList", userList);
		model.addAttribute("controlsList", controlsList);
		model.addAttribute("cmList", cmList);
		model.addAttribute("starttime", queryRecord.getStarttime());
		model.addAttribute("endtime", queryRecord.getEndtime());
		Page<Record> page = recordService.selectByQueryRecord(queryRecord);
		model.addAttribute("page", page);
		model.addAttribute("uName", uName);
		model.addAttribute("cnId", queryRecord.getCnId());
		model.addAttribute("cmId", queryRecord.getCmId());
		model.addAttribute("handle", queryRecord.getHandle());
		model.addAttribute("handler", queryRecord.getHandler());
		return "recordadminmanager";
	}

	// 查询从系统运营到当前日期每个场景的异常分布
	@RequestMapping("/record2/selectBySceneManager")
	public @ResponseBody Map<String, Object> selectByEveryDayManager(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		int aId = admin.getaId();
		Community community = communityService.selectByAId(aId);
		List selectScene = recordService.selectScene(community.getCmId());
		List selectByScene = recordService.selectByScene(community.getCmId());
		System.out.println(selectScene);
		System.out.println(selectByScene);
		List errorList = new ArrayList<>();
		int num = 0;
		for (int i = 1; i < 7; i++) {
			if (selectScene.contains(i)) {
				errorList.add(selectByScene.get(num));
				num++;
			} else {
				errorList.add(0);
			}
		}
		System.out.println(errorList);
		if (selectByScene != null) {
			map.put("cmname", community.getCmName());
			map.put("errorlist", errorList);
		}
		return map;
	}

	// 查询本小区异常数最多的前十名
	@RequestMapping("/record2/selectTopTen")
	public @ResponseBody Map<String, Object> selectTopTen(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		int cmId = admin.getCmId();
		List selectTopTenUName = recordService.selectTopTenUName(cmId);
		List selectTopTenSum = recordService.selectTopTenSum(cmId);
		System.out.println(selectTopTenUName);
		System.out.println(selectTopTenSum);
		
		if (selectTopTenUName != null&&selectTopTenSum != null) {
			map.put("uname", selectTopTenUName);
			map.put("errorlist", selectTopTenSum);
		}
		return map;
	}
	
	// 查询本小区异常数最多的前十名
		@RequestMapping("/record2/selectTopTenMap")
		public @ResponseBody Map<String, Object> selectTopTenMap(Model model, HttpServletRequest request,
				HttpServletResponse response) {

			Map<String, Object> map = new HashMap<String, Object>();
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			int aId = admin.getaId();
			Community community = communityService.selectByAId(aId);
			List selectTopTenUName = recordService.selectTopTenUName(community.getCmId());
			List selectTopTenSum = recordService.selectTopTenSum(community.getCmId());
			System.out.println(selectTopTenUName);
			System.out.println(selectTopTenSum);
			/*Map<String,Integer> map2 = new HashMap<>();
			for (int i = 0; i < selectTopTenUName.size(); i++) {
				String key = selectTopTenUName.get(i).toString();
				Integer value = (Integer) selectTopTenSum.get(i);
				map2.put(key, value);
			}*/
			List json = new ArrayList<>();
			if (selectTopTenUName != null&&selectTopTenSum != null) {
				for (int i = 0; i < selectTopTenUName.size(); i++) {
					Map<String, Object> map2 = new HashMap<>();
					map2.put("value", selectTopTenSum.get(i));
					map2.put("name", selectTopTenUName.get(i));
					json.add(map2);
				}
			}
			map.put("errorlist", json);
			System.out.println(json);
			return map;
		}
		
		// 查询从系统运营到当前日期每个场景的异常分布
		@RequestMapping("/record2/selectBySceneManagerMap")
		public @ResponseBody Map<String, Object> selectByEveryDayManagerMap(Model model, HttpServletRequest request,
				HttpServletResponse response) {

			Map<String, Object> map = new HashMap<String, Object>();
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			int aId = admin.getaId();
			Community community = communityService.selectByAId(aId);
			List selectScene = recordService.selectScene(community.getCmId());
			List selectByScene = recordService.selectByScene(community.getCmId());
			System.out.println(selectScene);
			System.out.println(selectByScene);
			List errorList = new ArrayList<>();
			int num = 0;
			for (int i = 1; i < 7; i++) {

				if (selectScene.contains(i)) {
					errorList.add(selectByScene.get(num));
					num++;
				} else {
					errorList.add(0);
				}
			}
			List scene = new ArrayList<>();
			
				if (selectScene.contains(1)) {
					scene.add("客厅");
				} 
				if (selectScene.contains(2)) {
					scene.add("卧室");
				} 
				if (selectScene.contains(3)) {
					scene.add("厨房");
				} 
				if (selectScene.contains(4)) {
					scene.add("餐厅");
				} 
				if (selectScene.contains(5)) {
					scene.add("露台");
				} 
				if (selectScene.contains(6)) {
					scene.add("浴室");
				}  
			System.out.println(scene);
			List json = new ArrayList<>();
			if (selectScene != null&&selectByScene != null) {
				for (int i = 0; i < selectByScene.size(); i++) {
					Map<String, Object> map2 = new HashMap<>();
					map2.put("value", selectByScene.get(i));
					map2.put("name", scene.get(i));
					json.add(map2);
				}
			}
			map.put("cmname", community.getCmName());
			map.put("errorlist", json);
			System.out.println(json);
			return map;
		}
}
