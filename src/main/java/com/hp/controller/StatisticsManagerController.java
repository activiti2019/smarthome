package com.hp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月22日 下午3:02:35 
* 类说明 
*/
@Controller
public class StatisticsManagerController{
	@RequestMapping("/statistics/showall")
	public String showAll(){
		return "statisticsallrecordbydate";
	}
	
	@RequestMapping("/statistics/showweek")
	public String showWeek(){
		return "statisticsweekrecordbydate";
	}
	
	@RequestMapping("/statistics/showmonth")
	public String showMonth(){
		return "statisticsmonthrecordbydate";
	}
	
	@RequestMapping("/statistics/showyear")
	public String showYear(){
		return "statisticsyearrecordbydate";
	}
	@RequestMapping("/statistics/showcustomer")
	public String showCustomer(){
		return "statisticscustomerbydate";
	}
	@RequestMapping("/statistics/showcommunity")
	public String showCommunity(){
		return "statisticsrecordbycommunity";
	}
	@RequestMapping("/statistics/showeverypart")
	public String showEveryPart(){
		return "statisticsallrecordbyscenemanager";
	}
	@RequestMapping("/statistics/showtopten")
	public String showTopTen(){
		return "statisticstopten";
	}
}
