package com.hp.mapper;

import com.hp.pojo.SuperAdmin;
import com.hp.pojo.SuperAdminExample;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

public interface SuperAdminMapper {
    int countByExample(SuperAdminExample example);

    int deleteByExample(SuperAdminExample example);

    int deleteByPrimaryKey(Integer saId);

    int insert(SuperAdmin record);

    int insertSelective(SuperAdmin record);
    
 // 通过aName和aPwd进行超级管理员登录验证
 	SuperAdmin selectByNameAndPwd(@Param("saName") String saName, @Param("saPwd") String saPwd);

    List<SuperAdmin> selectByExample(SuperAdminExample example);

    SuperAdmin selectByPrimaryKey(Integer saId);

    int updateByExampleSelective(@Param("record") SuperAdmin record, @Param("example") SuperAdminExample example);

    int updateByExample(@Param("record") SuperAdmin record, @Param("example") SuperAdminExample example);

    int updateByPrimaryKeySelective(SuperAdmin record);

    int updateByPrimaryKey(SuperAdmin record);
    
//	通过账号密码查找管理员并修改密码
	int updateByNameAndPwd(@Param("saName") String saName,@Param("saPwd") String saPwd,@Param("saPwd2") String saPwd2);

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