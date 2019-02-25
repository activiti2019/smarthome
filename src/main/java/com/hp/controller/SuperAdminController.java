package com.hp.controller;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.hp.pojo.SuperAdmin;
import com.hp.service.SuperAdminService;


/** 
* @author 作者 : 王文帅
* @version 创建时间：2017年10月27日 下午5:21:09 
* 类说明 
*/
@Controller
public class SuperAdminController {
	@Autowired 
	private SuperAdminService superAdminService;
	/*超级管理员登录*/
	@RequestMapping("/superadmin/login")
	@ResponseBody
	public int login(String saName,String saPwd,HttpSession session){
		Subject subject=SecurityUtils.getSubject();
		UsernamePasswordToken token=new UsernamePasswordToken(saName,saPwd);  
			try{
				subject.login(token);
				SuperAdmin superAdmin=null;
				superAdmin=superAdminService.selectByNameAndPwd(saName, saPwd);
				if(null==superAdmin){
					return 0;
				}else{
					session.setAttribute("superadmin",superAdmin);  
					return 1;
				}
			}catch(Exception e){
				return 0;
			}
	}
	/*超级管理员退出系统*/
	@RequestMapping("/superlogout")
	public String logout(){
		Subject subject=SecurityUtils.getSubject(); 
 		subject.logout();
		return "redirect:superlogin.jsp";
	}
	/*超级管理员修改密码*/
	@RequestMapping("/superadmin/update")
	@ResponseBody
	public int updateSuperadmin(String saName,String saPwd,String saPwd2,String saPwd3){
		int x=superAdminService.changePwd(saName, saPwd, saPwd2,saPwd3);
		if(x==1){
			return 1;
		}else{
			return 0;
		}
	}
	
}
