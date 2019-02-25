package com.hp.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class User {
	private Integer uId;//用户id

	private String uName;//用户名

	private String uPwd;//用户密码

	private String realname;//用户真实姓名

	private String sex;//性别
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;//生日
	private String phone;//联系方式

	private String address;//地址

	private String email;//邮箱

	private Integer cmId;//小区id

	private Integer mode;//用户当前情景模式

	private Integer rId;//用户权限

	private Integer state;//用户账号状态

	public Integer getuId() {
		return uId;
	}

	public void setuId(Integer uId) {
		this.uId = uId;
	}

	public String getuName() {
		return uName;
	}

	public void setuName(String uName) {
		this.uName = uName == null ? null : uName.trim();
	}

	public String getuPwd() {
		return uPwd;
	}

	public void setuPwd(String uPwd) {
		this.uPwd = uPwd == null ? null : uPwd.trim();
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname == null ? null : realname.trim();
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex == null ? null : sex.trim();
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone == null ? null : phone.trim();
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address == null ? null : address.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public Integer getCmId() {
		return cmId;
	}

	public void setCmId(Integer cmId) {
		this.cmId = cmId;
	}

	public Integer getMode() {
		return mode;
	}

	public void setMode(Integer mode) {
		this.mode = mode;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "User [uId=" + uId + ", uName=" + uName + ", uPwd=" + uPwd + ", realname=" + realname + ", sex=" + sex
				+ ", birthday=" + birthday + ", phone=" + phone + ", address=" + address + ", email=" + email
				+ ", cmId=" + cmId + ", mode=" + mode + ", rId=" + rId + ", state=" + state + "]";
	}

}