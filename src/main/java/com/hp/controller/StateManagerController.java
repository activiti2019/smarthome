package com.hp.controller;

import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.Controls;
import com.hp.pojo.QueryState;
import com.hp.pojo.State;
import com.hp.pojo.User;
import com.hp.service.CommunityService;
import com.hp.service.ControlsService;
import com.hp.service.StateService;
import com.hp.service.UserService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月19日 上午10:56:38 
* 类说明 
*/
@Controller
public class StateManagerController {
	@Autowired
	private StateService stateService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private ControlsService controlsService;
	@Autowired
	private UserService userService;
	/*查询出所有用户控件状态信息*/
	@RequestMapping("/state/list")
	public String list(String uName,QueryState queryState,Model model){
		if(null!=uName && !"".equals(uName)){
			List<Integer> userList=null;
			List<Integer> userNull=new ArrayList<Integer>();
			userNull.add(-1);
			userList=userService.selectListByUserName(uName);
			
			if(userList.isEmpty()){
				queryState.setuId(userNull);
			}else{
				queryState.setuId(userList);
			}
		}
		List<Community> cmList = communityService.selectAllCommunity();
		List<Controls> controlsList=controlsService.selectAll();
		List<User> userList=userService.selectAll();
		model.addAttribute("userList", userList);
		model.addAttribute("controlsList",controlsList);
		model.addAttribute("cmList", cmList);
		Page<State> page=stateService.selectByQueryState(queryState);
		model.addAttribute("page",page);
		model.addAttribute("stId", queryState.getStId());
		model.addAttribute("uName", uName);
		model.addAttribute("cnId", queryState.getCnId());
		model.addAttribute("cmId", queryState.getCmId());
		model.addAttribute("state", queryState.getState());
		model.addAttribute("onoff", queryState.getOnoff());
		return "statemanager";
	}
	
}
