package com.hp.service;


import java.util.Set;

import com.hp.pojo.Admin;
import com.hp.pojo.QueryAdmin;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月17日 下午9:24:01 
* 类说明 
*/
public interface AdminService {
	/**
	 * 通过aName和aPwd进行管理员登录验证
	 * @param aName
	 * @param aPwd
	 * @return
	 */
	public Admin selectByNameAndPwd(String aName,String aPwd);
	
	/**
	 * 通过QueryAdmin查询管理员信息
	 * @param queryAdmin
	 * @return
	 */
    Page<Admin> selectByQueryAdmin(QueryAdmin queryAdmin);
    
    /**
     * 通过id查询管理员
     * @param integer
     * @return
     */
	Admin selectById(Integer integer);
	
	/**
	 * 通过admin修改管理员
	 * @param admin
	 * @return
	 */
	int updateByAdmin(Admin admin);
	
	/**
	 * 通过id删除管理员
	 * @param integer
	 * @return
	 */
	int deleteById(Integer integer);
	
	/**
	 * 通过id恢复管理员
	 * @param integer
	 * @return
	 */
	int restoreById(Integer integer);
	
	/**
	 * 添加管理员
	 * @param admin
	 * @return
	 */
	int addAdmin(Admin admin);
	
	/**
	 * 通过admin进行管理员查询
	 */
//	Admin selectByAdmin(Admin admin);
	/**
	 * 根据管理员名查询
	 * @param aName
	 * @return
	 */
	Admin selectByAName(String aName);

	/**
     * 新增根据管理员名获取角色
     * @param userName
     * @return
     */
	Set<String> getRoles(String aName);

	/**
     * 新增根据管理员名获取权限
     * @param userName
     * @return
     */
	Set<String> getPermissions(String aName);
	
	/*
	 * 通过账号密码查找管理员并修改密码
	 */
	int changePwd(String aName,String aPwd,String aPwd2,String aPwd3);
}
