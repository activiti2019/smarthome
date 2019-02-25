package com.hp.realm;


import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.hp.pojo.Admin;
import com.hp.pojo.SuperAdmin;
import com.hp.pojo.User;
import com.hp.service.AdminService;
import com.hp.service.SuperAdminService;
import com.hp.service.UserService;
import com.hp.service.impl.UserServiceImpl;

/** 
* @author 作者 : 陈燕君
* @version 创建时间：2017年10月27日 上午9:44:10 
* @description
*/
public class MyRealmSuperAdmin extends AuthorizingRealm{
	
	@Autowired
	private SuperAdminService superAdminService;

	/**
	 * 为当前登录成功的管理员授予角色和权限
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String saName = (String) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		authorizationInfo.setRoles(superAdminService.getRoles(saName));
		authorizationInfo.setStringPermissions(superAdminService.getPermissions(saName));
		return authorizationInfo;
	}

	/**
	 * 验证当前登录的管理员
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String saName = (String) token.getPrincipal();
		SuperAdmin superAdmin = superAdminService.selectBySAName(saName);
		if(superAdmin!=null){
			AuthenticationInfo authcInfo=new SimpleAuthenticationInfo(superAdmin.getSaName(),superAdmin.getSaPwd(),"xx");
			return authcInfo;
		}else {
			return null;
		}
	}

}
