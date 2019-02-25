package com.hp.service.impl;

import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.AdminMapper;
import com.hp.pojo.Admin;
import com.hp.pojo.QueryAdmin;
import com.hp.pojo.User;
import com.hp.service.AdminService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月18日 上午8:42:43 
* 类说明 
*/
@Service("AdminService")
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminMapper adminMapper;
	
	/*
	 * 通过aName和aPwd进行管理员登录验证
	 */
	@Override
	public Admin selectByNameAndPwd(String aName, String aPwd) {
		return adminMapper.selectByNameAndPwd(aName, aPwd);
	}
	
	/*
	 * 通过QueryAdmin查询管理员信息
	 */
	@Override
	public Page<Admin> selectByQueryAdmin(QueryAdmin queryAdmin) {
		Page<Admin> page = new Page<Admin>();
		if (null != queryAdmin) {
			if (null != queryAdmin.getaName() && !"".equals(queryAdmin.getaName().trim())){
				queryAdmin.setaName(queryAdmin.getaName().trim());
			}
			if (null != queryAdmin.getCmId()){
				queryAdmin.setCmId(queryAdmin.getCmId());
			}
			page.setTotal(adminMapper.countByQueryAdmin(queryAdmin));
			if (null != queryAdmin.getPage()) {
				int x=adminMapper.countByQueryAdmin(queryAdmin);
				int y=(int)Math.ceil((double)x/queryAdmin.getSize());
				if(queryAdmin.getPage().intValue()>y && 0!=y){
					queryAdmin.setPage(y);
				}
				page.setPage(queryAdmin.getPage().intValue());
				queryAdmin.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(adminMapper.selectByQueryAdmin(queryAdmin));
		}
		return page;
	}

	/*
	 * 通过id查询管理员
	 */
	@Override
	public Admin selectById(Integer aId) {
		return adminMapper.selectByPrimaryKey(aId);
	}
	
	/*
	 * 通过admin修改管理员
	 */
	@Override
	public int updateByAdmin(Admin admin) {
		return adminMapper.updateByPrimaryKeySelective(admin);
	}

	/*
	 * 通过id删除管理员
	 */
	@Override
	public int deleteById(Integer integer) {
		return adminMapper.deleteByPrimaryKey(integer);
	}
	
	/*
	 * 通过id恢复管理员
	 */
	@Override
	public int restoreById(Integer aId) {
		return adminMapper.restoreByPrimaryKey(aId);
	}
	
	/*
	 * 添加管理员
	 */
	@Override
	public int addAdmin(Admin admin) {
		if(admin!=null){
			if(null!=admin.getaName()&&!"".equals(admin.getaName().trim())){
				admin.setaName(admin.getaName().trim());
			}
			if(null!=admin.getaPwd()&&!"".equals(admin.getaPwd().trim())){
				admin.setaPwd(admin.getaPwd().trim());
			}
			if(null!=admin.getCmId()){
				admin.setCmId(admin.getCmId());
			}
			if(null==adminMapper.selectByAdmin(admin)){
				return adminMapper.insertSelective(admin);
			}
		}
		return 0;
	}

	/**
	 * 根据管理员名查询
	 * @param aName
	 * @return
	 */
	@Override
	public Admin selectByAName(String aName) {
		return adminMapper.selectByAName(aName);
	}

	/**
     * 新增根据管理员名获取角色
     * @param userName
     * @return
     */
	@Override
	public Set<String> getRoles(String aName) {
		return adminMapper.getRoles(aName);
	}

	/*
	 * 通过账号密码查找管理员并修改密码
	 */
	@Override
	public int changePwd(String aName, String aPwd, String aPwd2,String aPwd3) {
		String reg="[a-zA-Z0-9_\\.]{6,30}";//正则验证密码是否为该格式
    	Pattern pattern=Pattern.compile(reg);//创建正则表达式的模式对象
    	Matcher matcher1=pattern.matcher(aPwd);//通过模式对象创建匹配对象
    	Matcher matcher2=pattern.matcher(aPwd2);
    	Matcher matcher3=pattern.matcher(aPwd3);
    	boolean b1=matcher1.matches();//将整个区域与模式匹配。当且仅当整个区域序列匹配与此匹配器的模式时返回true
    	boolean b2=matcher2.matches();
    	boolean b3=matcher3.matches();
		if(null==aPwd||"".equals(aPwd.trim())||null==aPwd2||"".equals(aPwd2.trim())||null==aPwd3||"".equals(aPwd3.trim())){
			return 0;
		}
		if(!b1||!b2||!b3){
			return 0;
		}
		if(aPwd.equals(aPwd2)||!aPwd2.equals(aPwd3)){
			return 0;
		}
		return adminMapper.updateByNameAndPwd(aName, aPwd, aPwd2);
	}
	
	/**
     * 新增根据管理员名获取权限
     * @param userName
     * @return
     */
	@Override
	public Set<String> getPermissions(String aName) {
		return adminMapper.getPermissions(aName);
	}
	
}
