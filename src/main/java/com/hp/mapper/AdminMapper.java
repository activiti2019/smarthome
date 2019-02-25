package com.hp.mapper;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.hp.pojo.Admin;
import com.hp.pojo.AdminExample;
import com.hp.pojo.QueryAdmin;

public interface AdminMapper {
	int countByExample(AdminExample example);

	// 通过QueryAdmim查询信息条数
	int countByQueryAdmin(QueryAdmin queryAdmin);

	int deleteByExample(AdminExample example);

	int deleteByPrimaryKey(Integer aId);
	
	int deleteByCmid(@Param("cmId") Integer cmId,@Param("x") Integer x);
	
	int restoreByPrimaryKey(Integer aId);

	int insert(Admin record);

	int insertSelective(Admin record);

	List<Admin> selectByExample(AdminExample example);

	// 通过aName和aPwd进行管理员登录验证
	Admin selectByNameAndPwd(@Param("aName") String aName, @Param("aPwd") String aPwd);

	// 通过QueryAdmin进行多条件查询
	List<Admin> selectByQueryAdmin(QueryAdmin queryAdmin);
	
	//查询所有管理员
	List<Admin> selectAll();

	// 通过admin进行管理员查询
	Admin selectByAdmin(Admin admin);

	Admin selectByPrimaryKey(Integer aId);

	int updateByExampleSelective(@Param("record") Admin record, @Param("example") AdminExample example);

	int updateByExample(@Param("record") Admin record, @Param("example") AdminExample example);

	int updateByPrimaryKeySelective(Admin record);
//	通过账号密码查找管理员并修改密码
	int updateByNameAndPwd(@Param("aName") String aName,@Param("aPwd") String aPwd,@Param("aPwd2") String aPwd2);

	int updateByPrimaryKey(Admin record);
	
	/**
	 * 根据管理员名查询
	 * @param aName
	 * @return
	 */
	Admin selectByAName(String aName);

	/**
     * 新增根据管理员名获取角色
     * @param aName
     * @return
     */
	Set<String> getRoles(String aName);

	/**
     * 新增根据管理员名获取权限
     * @param aName
     * @return
     */
	Set<String> getPermissions(String aName);
}