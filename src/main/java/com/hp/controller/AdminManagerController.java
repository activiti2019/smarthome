package com.hp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Admin;
import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.QueryAdmin;
import com.hp.service.AdminService;
import com.hp.service.CommunityService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月18日 上午10:36:40 
* 类说明 
*/
@Controller
public class AdminManagerController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private CommunityService communityService;
	
	/*查询所有小区管理员信息*/
	@RequestMapping("/admin/list")
	public String list(QueryAdmin queryAdmin,Model model){
		List<Community> cmList = communityService.selectAllCommunity();
		model.addAttribute("cmList", cmList);
		Page<Admin> page=adminService.selectByQueryAdmin(queryAdmin);
		model.addAttribute("page", page);
		model.addAttribute("cmId", queryAdmin.getCmId());
		model.addAttribute("aName", queryAdmin.getaName());
		model.addAttribute("state",queryAdmin.getState());
		return "adminmanager";
	}
	
	/*根据id查询小区管理员信息*/
	@RequestMapping("/admin/edit.action")
	@ResponseBody
	public Admin edit(Integer aId){
		return adminService.selectById(aId);
	}
	
	/*修改管理员信息*/
	@RequestMapping("/admin/update.action")
	@ResponseBody
	public String update(Admin admin){
		adminService.updateByAdmin(admin);
		return "OK";
	}

	/*删除管理员*/
	@RequestMapping("/admin/delete.action")
	@ResponseBody
	public int delete(Integer aId){
		int x=0;
		x=adminService.deleteById(aId);
		return x;
	}
	
	/*恢复管理员*/
	@RequestMapping("/admin/restore.action")
	@ResponseBody
	public int restore(Integer aId){
		int x=0;
		x=adminService.restoreById(aId);
		return x;
	}
	
	/*添加小区管理员*/
	@RequestMapping("/admin/add.action")
	@ResponseBody
	public int addAdmin(Admin admin){
		if(1==adminService.addAdmin(admin)){
			return 1;
		}else{
			return 0;
		}
	}
}
