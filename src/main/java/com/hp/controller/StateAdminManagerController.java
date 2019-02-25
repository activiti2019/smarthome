package com.hp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Admin;
import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.Controls;
import com.hp.pojo.QueryState;
import com.hp.pojo.Record;
import com.hp.pojo.State;
import com.hp.pojo.User;
import com.hp.service.CommunityService;
import com.hp.service.ControlsService;
import com.hp.service.StateService;
import com.hp.service.UserService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月21日 上午9:34:51 
* 类说明 
*/
@Controller
public class StateAdminManagerController {
	@Autowired
	private StateService stateService;
	@Autowired
	private ControlsService controlsService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private UserService userService;
	/*小区管理员查询该小区所有控件的状态*/
	@RequestMapping("/state2/list")
	public String list(String uName,QueryState queryState,Model model,HttpSession session){
		if(null!=session.getAttribute("admin")){
			Admin admin=(Admin)session.getAttribute("admin");
			queryState.setCmId(admin.getCmId());
		}
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
		List<Community> cmList = communityService.selectAll();
		model.addAttribute("cmList", cmList);
		List<Controls> controlsList=controlsService.selectAll();
		List<User> userList=userService.selectAll();
		model.addAttribute("userList", userList);
		model.addAttribute("controlsList",controlsList);
		Page<State> page=stateService.selectByQueryState(queryState);
		model.addAttribute("page",page);
		model.addAttribute("stId", queryState.getStId());
		model.addAttribute("uName", uName);
		model.addAttribute("cnId", queryState.getCnId());
		model.addAttribute("cmId", queryState.getCmId());
		model.addAttribute("state", queryState.getState());
		model.addAttribute("onoff", queryState.getOnoff());
		return "stateadminmanager";
	}
	/*小区管理员通过id查询控件状态信息*/
	@RequestMapping("/state2/edit.action")
	@ResponseBody
	public State edit(Integer stId){
		return stateService.selectById(stId);
	}
	/*小区管理员修改控件状态*/
	@RequestMapping("/state2/update.action")
	@ResponseBody
	public String update(State state,HttpSession session){
		Record record=null;
		if(null!=session.getAttribute("admin")){
			Admin admin =(Admin) session.getAttribute("admin");
			record=new Record();
			record.setCmId(admin.getCmId());
			record.setHandler("管理员");
		}
		stateService.updateByUidAndCnid(state,record);
		return "OK";
	}
}
