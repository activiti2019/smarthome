package com.hp.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.UserMapper;
import com.hp.pojo.QueryUser;
import com.hp.pojo.User;
import com.hp.pojo.UserExample;
import com.hp.service.UserService;
import com.hp.utils.Page;

/**
 * @author 作者 : 陈燕君
 * @version 创建时间：2017年10月13日 上午11:30:58
 * @description
 */
@Service("UserService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public int insertSelective(User record) {
		return userMapper.insertSelective(record);
	}

	@Override
	public User selectByPrimaryKey(Integer uId) {
		return userMapper.selectByPrimaryKey(uId);
	}
	
	@Override
	public int updateByPrimaryKeySelective(User record) {
		return userMapper.updateByPrimaryKeySelective(record);
	}

	/*
	 *  新增的登录方法
	 */ 
	@Override
	public User selectByNameAndPwd(String userName, String password) {
		return userMapper.selectByNameAndPwd(userName, password);
	}

	/*
	 *  新增验证用户名是否存在
	 */ 
	@Override
	public User selectByUserName(String userName) {
		return userMapper.selectByUserName(userName);
	}
	
	/*
	 *  通过QueryUser查询用户信息
	 */
	@Override
	public Page<User> selectByQueryUser(QueryUser queryUser) {
		Page<User> page = new Page<User>();
		if (null != queryUser) {
			if (null != queryUser.getuName() && !"".equals(queryUser.getuName().trim())){
				queryUser.setuName(queryUser.getuName().trim());
			}
			if (null != queryUser.getRealname() && !"".equals(queryUser.getRealname().trim())){
				queryUser.setRealname(queryUser.getRealname().trim());
			}
			if (null != queryUser.getAddress() && !"".equals(queryUser.getAddress().trim())){
				queryUser.setAddress(queryUser.getAddress().trim());
			}
			if (null != queryUser.getCmId()){
				queryUser.setCmId(queryUser.getCmId());
			}
			page.setTotal(userMapper.countByQueryUser(queryUser));
			if (null != queryUser.getPage() ) {
				int x=userMapper.countByQueryUser(queryUser);
				int y=(int)Math.ceil((double)x/queryUser.getSize());
				if(queryUser.getPage().intValue()>y && 0!=y){
					queryUser.setPage(y);
				}
				page.setPage(queryUser.getPage().intValue());
				queryUser.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(userMapper.selectByQueryUser(queryUser));
		}
		return page;
	}
	
	/*
	 *  通过id查询用户
	 */
	@Override
	public User selectById(Integer uId) {
		return userMapper.selectByPrimaryKey(uId);
	}
	
	/*
	 *  通过user修改用户
	 */
	@Override
	public int updateByUser(User user) {
		return userMapper.updateByPrimaryKeySelective(user);
	}
	
	/*
	 *  通过id删除用户
	 */
	@Override
	public int deleteById(Integer id) {
		return userMapper.deleteByPrimaryKey(id);
	}
	
	/*
	 *  通过id恢复用户
	 */
	@Override
	public int restoreById(Integer id) {
		return userMapper.restoreByPrimaryKey(id);
	}
	
	/*
	 *  查询所有用户
	 */
	@Override
	public List<User> selectAll() {
		UserExample example=new UserExample();
		return userMapper.selectByExample(example);
	}

	/**
     * 新增根据用户名获取角色
     * @param userName
     * @return
     */
	@Override
	public Set<String> getRoles(String userName) {
		return userMapper.getRoles(userName);
	}

	/**
     * 新增根据用户名获取权限
     * @param userName
     * @return
     */
	@Override
	public Set<String> getPermissions(String userName) {
		return userMapper.getPermissions(userName);
	}

	@Override
	public List<Integer> selectListByUserName(String uName) {
		return userMapper.selectListByUserName(uName);
	}

}
