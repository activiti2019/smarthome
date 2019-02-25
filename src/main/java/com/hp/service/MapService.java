package com.hp.service;

import java.util.List;

import com.hp.pojo.MapQueryData;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月24日 下午10:39:36 
* 类说明 
*/
public interface MapService {
	/*
	 * 查询小区表内所有小区，同时查询出每个小区的异常数量、小区异常记录数、管理员名、小区用户数量、小区位置（经纬度）
	 * */
	List<MapQueryData> selectInfo();
}
