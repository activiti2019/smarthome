package com.hp.mapper;

import com.hp.pojo.QueryUser;
import com.hp.pojo.User;
import com.hp.pojo.UserExample;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {
	int countByExample(UserExample example);
    
	/**
	 * 通过QueryUser查询信息条数
	 * @param queryuser
	 * @return
	 */
    int countByQueryUser(QueryUser queryuser);
    
    //查询每个小区的用户数量
    List<Map<Integer,Object>> selectCountByCommunity();

	int deleteByExample(UserExample example);

	int deleteByPrimaryKey(Integer uId);
	
	int restoreByPrimaryKey(Integer uId);

	int insert(User record);

	int insertSelective(User record);

	List<User> selectByExample(UserExample example);
	/**
	 * 通过QueryUser查询符合条件的所有用户
	 * @param queryuser
	 * @return
	 */
    List<User> selectByQueryUser(QueryUser queryuser);

	User selectByPrimaryKey(Integer uId);
	
	/*
	 *通过用户名模糊查询用户信息
	 */
	List<Integer> selectListByUserName(String uName);

	int updateByExampleSelective(@Param("record") User record, @Param("example") UserExample example);

	int updateByExample(@Param("record") User record, @Param("example") UserExample example);

	int updateByPrimaryKeySelective(User record);

	int updateByPrimaryKey(User record);
	
	int updateUserCommunity(Integer cmId);

	/**
	 * 新增的登录方法
	 * @param userName
	 * @param password
	 * @return
	 */
	User selectByNameAndPwd(@Param("userName") String userName, @Param("password") String password);

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
	
	

}