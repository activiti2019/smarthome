package com.hp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Controls;
import com.hp.pojo.QueryControls;
import com.hp.service.ControlsService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月18日 下午7:17:27 
* 类说明 
*/ 
@Controller
public class ConManagerController {
	@Autowired
	private ControlsService controlsService;
	/*查询所有控件信息*/
	@RequestMapping("/controls/list")
	public String list(QueryControls queryController,Model model){
		Page<Controls> page=controlsService.selectByQueryControls(queryController);
		model.addAttribute("page",page);
		model.addAttribute("cnName",queryController.getCnName()); 
		return "controlsmanager";
	}
	/*根据id查询控件信息*/
	@RequestMapping("/controls/edit.action")
	@ResponseBody
	public Controls edit(Integer cnId){
		return controlsService.selectById(cnId);
	}
	/*修改控件信息*/
	@RequestMapping("/controls/update.action")
	@ResponseBody
	public String update(Controls controls){
		controlsService.updateByControls(controls);
		return "OK";
	}
	/*删除控件*/
	@RequestMapping("/controls/delete.action")
	@ResponseBody
	public String delete(Integer cnId){
		controlsService.deleteById(cnId);
		return "OK";
	}
	/*添加控件*/
	@RequestMapping("/controls/add.action")
	@ResponseBody
	public int addControls(Controls controls){
		if(1==controlsService.addControls(controls)){
			return 1;
		}else{
			return 0;
		}
	}
}
