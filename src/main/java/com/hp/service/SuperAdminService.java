package com.hp.service;

import java.util.Set;

import com.hp.pojo.SuperAdmin;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月27日 下午5:25:35 
* 类说明 
*/
public interface SuperAdminService {
	/**
	 * 通过aName和aPwd进行超级管理员登录验证
	 * @param saName
	 * @param saPwd
	 * @return
	 */
	public SuperAdmin selectByNameAndPwd(String saName,String saPwd);
	/*
	 * 通过账号密码查找超级管理员并修改密码
	 */
	int changePwd(String saName,String saPwd,String saPwd2,String saPwd3);
	
	/**
	 * 根据超级管理员名查询
	 * @param saName
	 * @return
	 */
	SuperAdmin selectBySAName(String saName);

	/**
     * 新增根据超级管理员名获取角色
     * @param saName
     * @return
     */
	Set<String> getRoles(String saName);

	/**
     * 新增根据超级管理员名获取权限
     * @param saName
     * @return
     */
	Set<String> getPermissions(String saName);
}
