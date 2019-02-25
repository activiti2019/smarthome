package com.hp.service;

import java.util.List;
import java.util.Set;

import com.hp.pojo.QueryUser;
import com.hp.pojo.User;
import com.hp.utils.Page;

/** 
* @author 作者 : 陈燕君
* @version 创建时间：2017年10月13日 上午11:30:12 
* @description
*/
public interface UserService {


    int insertSelective(User record);

    User selectByPrimaryKey(Integer uId);
    
    List<User> selectAll();

    int updateByPrimaryKeySelective(User record);
    
    /**
     * 通过QueryUser查询用户信息
     * @param queryuser
     * @return
     */
    Page<User> selectByQueryUser(QueryUser queryuser);
    /**
     * 通过id查询用户
     * @param integer
     * @return
     */
	User selectById(Integer uId);
	/**
	 * 通过user修改用户
	 * @param user
	 * @return
	 */
	int updateByUser(User user);
	/**
	 * 通过id删除用户
	 * @param integer
	 * @return
	 */
	int deleteById(Integer uId);
	
	/**
	 * 通过id恢复用户
	 * @param integer
	 * @return
	 */
	int restoreById(Integer uId);
    
	/**
	 * 新增的登录方法
	 * @param userName
	 * @param password
	 * @return
	 */
    User selectByNameAndPwd(String userName,String password);
    /**
     * 新增验证用户名是否存在
     * @param userName
     * @return
     */
    User selectByUserName(String userName);

    /**
     * 新增根据用户名获取角色
     * @param userName
     * @return
     */
	Set<String> getRoles(String userName);

	/**
     * 新增根据用户名获取权限
     * @param userName
     * @return
     */
	Set<String> getPermissions(String userName);
	
	/*
	 * 通过用户名模糊查询用户信息
	 */
	List<Integer> selectListByUserName(String uName);
}
