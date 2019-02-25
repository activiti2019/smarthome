package com.hp.controller;

import java.util.List;

import org.aspectj.weaver.Shadow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.MapQueryData;
import com.hp.service.MapService;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月24日 上午10:43:24 
* 类说明 
*/
@Controller
public class MapManagerController {
	@Autowired
	private MapService mapService;
	/*跳转到地图页面*/
	@RequestMapping("/map/show")
	public String show(String cmId,Model model){
		if(null!=cmId || !"".equals(cmId)){
			model.addAttribute("cmId",cmId);
		}
		return "map";
	}
	/*查询出地图页面需要展现的信息*/
	@RequestMapping("/map/info")
	@ResponseBody
	public List<MapQueryData> info(){
		return mapService.selectInfo();
	}
}
