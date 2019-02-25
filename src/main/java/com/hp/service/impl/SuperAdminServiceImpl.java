package com.hp.service.impl;

import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.SuperAdminMapper;
import com.hp.pojo.SuperAdmin;
import com.hp.service.SuperAdminService;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月27日 下午5:27:12 
* 类说明 
*/
@Service("SuperAdminService")
public class SuperAdminServiceImpl implements SuperAdminService{
@Autowired
private SuperAdminMapper superAdminMapper;

	/*
	 * 超级管理员登录验证
	 */
	@Override
	public SuperAdmin selectByNameAndPwd(String saName, String saPwd) {
		return superAdminMapper.selectByNameAndPwd(saName, saPwd);
	}
	
	/*
	 * 超级管理员修改密码
	 */
	@Override
	public int changePwd(String saName, String saPwd, String saPwd2,String saPwd3) {
		String reg="[a-zA-Z0-9_\\.]{6,30}";//正则验证密码是否为该格式
    	Pattern pattern=Pattern.compile(reg);//创建正则表达式的模式对象
    	Matcher matcher1=pattern.matcher(saPwd);//通过模式对象创建匹配对象
    	Matcher matcher2=pattern.matcher(saPwd2);
    	Matcher matcher3=pattern.matcher(saPwd3);
    	boolean b1=matcher1.matches();//将整个区域与模式匹配。当且仅当整个区域序列匹配与此匹配器的模式时返回true
    	boolean b2=matcher2.matches();
    	boolean b3=matcher3.matches();
		if(null==saPwd||"".equals(saPwd.trim())||null==saPwd2||"".equals(saPwd2.trim())||null==saPwd3||"".equals(saPwd3.trim())){
			return 0;
		}
		if(!b1||!b2||!b3){
			return 0;
		}
		if(saPwd.equals(saPwd2)||!saPwd2.equals(saPwd3)){
			return 0;
		}
		return superAdminMapper.updateByNameAndPwd(saName, saPwd, saPwd2);
	}

	/**
	 * 根据超级管理员名查询
	 * @param saName
	 * @return
	 */
	@Override
	public SuperAdmin selectBySAName(String saName) {
		return superAdminMapper.selectBySAName(saName);
	}

	/**
     * 新增根据超级管理员名获取角色
     * @param saName
     * @return
     */
	@Override
	public Set<String> getRoles(String saName) {
		return superAdminMapper.getRoles(saName);
	}

	/**
     * 新增根据超级管理员名获取权限
     * @param saName
     * @return
     */
	@Override
	public Set<String> getPermissions(String saName) {
		return superAdminMapper.getPermissions(saName);
	}

	
	
}
