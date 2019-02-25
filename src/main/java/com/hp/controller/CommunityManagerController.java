package com.hp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Community;
import com.hp.pojo.QueryCommunity;
import com.hp.service.CommunityService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月17日 上午10:56:39 
* 类说明 
*/
@Controller
public class CommunityManagerController {
	@Autowired
	private CommunityService communityService;
	
	/*查询所有小区信息*/
	@RequestMapping("/community/list")
	public String list(QueryCommunity queryCommunity,Model model){
		Page<Community> page=communityService.selectByQueryCommunity(queryCommunity);
		model.addAttribute("page", page);
		model.addAttribute("cmName", queryCommunity.getCmName());
		model.addAttribute("state",queryCommunity.getState());
		return "communitymanager";
	}
	
	/*通过cmId查找小区*/
	@RequestMapping("/community/edit.action")
	@ResponseBody
	public Community edit(Integer cmId){
		return communityService.selectByCmId(cmId);
	}
	
	/*通过community修改小区信息*/
	@RequestMapping("/community/update.action")
	@ResponseBody
	public String updateCommunity(Community community){
		communityService.updateByCommunity(community);
		return "OK";
	}
	
	/*通过cmID删除小区*/
	@RequestMapping("/community/delete.action")
	@ResponseBody
	public String deleteCommunity(Integer cmId){
		communityService.deleteByCmid(cmId);
		return "OK";
	}
	
	/*通过cmID恢复小区*/
	@RequestMapping("/community/restore.action")
	@ResponseBody
	public String restoreCommunity(Integer cmId){
		communityService.restoreByCmid(cmId);
		return "OK";
	}
	
	/*添加小区*/
	@RequestMapping("/community/add.action")
	@ResponseBody
	public String addCommunity(Community community){
		communityService.addCommunity(community);
		return "OK";
	}
}
