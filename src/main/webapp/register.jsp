<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
<link rel="stylesheet"
	href="bootstrapvalidator/css/bootstrapValidator.css">
<link rel="stylesheet" href="css/site.css">
<link rel="stylesheet"
	href="bootstrap-datetimepicker/css/bootstrap-datetimepicker.css">
<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script
	src="bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">
<!-- bootstrap的下拉选项 -->
<link
	href="https://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/css/bootstrap-select.min.css"
	rel="stylesheet">
<script
	src="https://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/js/bootstrap-select.min.js"></script>
<!-- 引入下拉框结束 -->
<link href="css/multiple-select.css" rel="stylesheet">
<script src="js/multiple-select.js"></script>
<!-- 引入下拉框结束 -->
<!-- 表单验证 -->
<script src="bootstrapvalidator/js/bootstrapValidator.js"
	type="text/javascript"></script>
<title>智能家居控制系统</title>
<script type="text/javascript">
	$(function() {
		//getCommunity();
		validateForm();

		$(".form_datetime").datetimepicker({
			format : 'yyyy-mm-dd',
			minView : 'month',
			language : 'zh-CN',
			autoclose : true,//选中自动关闭
			startDate : '1900-01-01',
			endDate : new Date(),
			todayBtn : true
		//显示今日按钮
		});

	});
	function getCommunity() {

		// Ajax异步请求所有的小区
		$.ajax({
			url : "user/getComList",
			type : "POST",
			data : {},
			dataType : "json",
			async : false,
			success : function(data) {

				var Data = data;
				for ( var key in Data) {
					$("#community").append(
							'<option value="'+key+'">' + Data[key]
									+ '</option>');
				}
			}
		});
	}

	function validateForm() {
		$("#registerform").bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {/*输入框不同状态，显示图片的样式*/
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {/*验证*/
				username : {/*键名username和input name值对应*/
					message : 'The username is not valid',
					validators : {

						notEmpty : {/*非空提示*/
							message : '用户名不能为空'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_\.]+$/,
							message : '用户名只允许使用大小写字母,数字,下划线,英文., 请重新输入用户名'
						},
						stringLength : {/*长度提示*/
							min : 6,
							max : 30,
							message : '用户名长度必须在6到30之间'
						},
						threshold : 6, //有6字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
						remote : {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}  
							url : 'user/userNameExsits',//验证地址
							message : '用户已存在',//提示消息
							delay : 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
							type : 'POST'//请求方式
						/**自定义提交数据，默认值提交当前input value
						 *  data: function(validator) {
						      return {
						          password: $('[name="passwordNameAttributeInYourForm"]').val(),
						          whatever: $('[name="whateverNameAttributeInYourForm"]').val()
						      };
						   }
						 */
						}
					/*最后一个没有逗号*/

					}
				},
				password : {
					message : 'The password is not valid',
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_\.]+$/,
							message : '密码只允许使用大小写字母,数字,下划线,英文., , 请重新输入'
						},
						stringLength : {
							min : 6,
							max : 30,
							message : '密码长度必须在6到30之间'
						},
						identical : {
							field : 'password2',
							message : '两次密码必须一致'
						}
					}
				},
				password2 : {
					message : 'The password is not valid',
					validators : {
						notEmpty : {
							message : '确认密码不能为空'
						},
						identical : {
							field : 'password',
							message : '两次密码必须一致'
						}
					}
				},
				realname : {
					message : 'The realname is not valid',
					validators : {
						notEmpty : {/*非空提示*/
							message : '姓名不能为空'
						},
						stringLength : {/*长度提示*/
							min : 2,
							max : 4,
							message : '姓名长度必须在2到4之间'
						},
						regexp : {
							regexp : /^[\u4e00-\u9fa5]+$/,
							message : '真实姓名请输入中文字符'
						}
					/*最后一个没有逗号*/

					}
				},
				birthday : {
					message : 'The birthday is not valid',
					validators : {
						notEmpty : {/*非空提示*/
							message : '生日不能为空'
						}
					}
				},
				address : {
					message : 'The city is not valid',
					validators : {
						notEmpty : {/*非空提示*/
							message : '地址不能为空'
						},
						stringLength : {/*长度提示*/
							min : 2,
							max : 30,
							message : '地址长度必须在2到30之间'
						},
						regexp : {
							regexp : /^[\u4E00-\u9FA5A-Za-z0-9_]+$/,
							message : '地址不合法, 请重新输入'
						}
					/*最后一个没有逗号*/

					}
				},
				email : {
					validators : {
						notEmpty : {/*非空提示*/
							message : '邮箱不能为空'
						},
						stringLength : {/*长度提示*/
							min : 0,
							max : 30,
							message : '邮箱长度必须在30之内'
						}

					}
				},
				phone : {
					message : 'The qq is not valid',
					validators : {
						notEmpty : {/*非空提示*/
							message : '个人电话不能为空'
						},
						regexp : {
							regexp : /^1[0-9]{10}$/,
							message : '个人手机电话由1开头的11位数字组成, 请重新输入您的电话'
						}
					}
				}
			}
		});
	}

	function register() {
		// 异步注册用户
		//validateForm();

		var bv = $("#registerform").data('bootstrapValidator');
		bv.validate()
		if (!bv.isValid()) {
			return;
		}
		var uName = $("input[name='username']").val();
		var uPwd = $("input[name='password']").val();
		var realname = $("input[name='realname']").val();
		var sex = $("input[name='sex']:checked").val();
		var birthday = $("input[name='birthday']").val();
		var phone = $("input[name='phone']").val();
		var address = $("input[name='address']").val();
		var email = $("input[name='email']").val();
		var community = $("#community").val();
		$.ajax({
			url : "user/userRegister",
			data : {
				'uName' : uName,
				'uPwd' : uPwd,
				'realname' : realname,
				'sex' : sex,
				'birthday' : birthday,
				'phone' : phone,
				'address' : address,
				'email' : email,
				'cmId' : community
			},
			dataType : 'json',
			type : 'post',

			success : function(data) {

				if (data.msg == "成功") {
					alert("注册成功");
					window.location.href = "index.jsp";
				} else {
					alert("注册失败");
					$(".text-warning").text(data.info);
					$("input[name='username']").val("");
					$("input[name='password']").val("");
					$("input[name='realname']").val("");
					$("input[name='sex']").val("");
					$("input[name='birthday']").val("");
					$("input[name='phone']").val("");
					$("input[name='address']").val("");
					$("input[name='email']").val("");
					$("input[name='community']").val("");
				}

			}
		});
	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false>
	<!-- header  -->
	<div class="nav_menu">
		<div class="nav">
			<a href="index.jsp" class="logo"><img src="images/logo.png"
				width="220" height="70" alt="" /></a>

			<div class="list" id="navlist" style="float: right">
				<ul id="navfouce">
					<li><a href="index.jsp"
						style="float: left; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px;">登录</a></li>
					<li><a href="register.jsp"
						style="float: left; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px;">注册</a></li>
				</ul>
			</div>
			<div class="sec-bl" id="navbox">
				<div class="cont">
					<div class="sec">
						<ul>
							<li></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- header end -->
	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>用户注册</h1>
			<span>在这里注册一个新的账号</span>
			<p>本网站致力于打造最安全，最舒适的家庭管理系统，为用户提供行业领先的先进技术和最优的体验。</p>
		</div>
	</div>
	<div class="page-container">
		<div class="row">
			<div class="col-sm-offset-3 col-sm-6 text-center"></div>
		</div>
		<form class="form-horizontal col-sm-offset-3" id="registerform"
			method="post">
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label">用户名：</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="username" id="name"
						placeholder="用户名由大小写字母,数字,下划线,英文.,组成">

				</div>
			</div>
			<div class="form-group">
				<label for="password" class="col-sm-2 control-label">密码：</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="password"
						placeholder="密码由大小写字母,数字,下划线,英文.,组成">
				</div>
			</div>
			<div class="form-group">
				<label for="password2" class="col-sm-2 control-label">确认密码：</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="password2"
						placeholder="请重复输入密码">
				</div>
			</div>
			<div class="form-group">
				<label for="realname" class="col-sm-2 control-label">真实姓名：</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="realname"
						placeholder="请输入真实姓名">
				</div>
			</div>
			<div class="form-group">
				<label for="sex" class="col-sm-2 control-label">性别：</label>
				<div class="col-sm-4">
					<label class="radio-inline"> <input type="radio" name="sex"
						value="男" checked> 男
					</label> <label class="radio-inline"> <input type="radio"
						name="sex" value="女"> 女
					</label>
				</div>
			</div>

			<div class="form-group">
				<label for="birthday" class="col-sm-2 control-label">生日：</label>
				<div class="col-sm-4">
					<div class="input-group date form_datetime"
						data-date-format="dd-MM-yyyy" data-link-field="dtp_input1">
						<input class="form-control" size="16" type="text" name="birthday"
							value="2000-01-01" readonly> <span
							class="input-group-addon"><span
							class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>
	
			<div class="form-group">

				<label for="community" class="col-sm-2 control-label">小区：</label>
				<div class="col-sm-4">

					<select class="selectpicker form-control" name="community"
						id="community">
						<c:forEach items="${comlist1 }" var="com">

							<option value="${com.cmId }">${com.cmName }</option>
						</c:forEach>
					</select>

				</div>
			</div>
			<div class="form-group">
				<label for="address" class="col-sm-2 control-label">详细地址：</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="address"
						placeholder="请输入详细地址">
				</div>
			</div>



			<div class="form-group">
				<label for="phone" class="col-sm-2 control-label">电话：</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="phone" maxlength="11"
						placeholder="电话由1开头的11位数字组成">
				</div>
			</div>

			<div class="form-group">

				<label for="email" class="col-sm-2 control-label">邮箱：</label>
				<div class="col-sm-4">
					<input type="email" class="form-control" name="email"
						placeholder="请输入邮箱">
				</div>
			</div>

			<div class="form-group has-error">
				<div class="col-sm-offset-2 col-sm-4 col-xs-6 ">
					<span class="text-warning"></span>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-4 col-xs-12">
					<button class="btn btn-success btn-block" type="button"
						onclick="register();">注册</button>
				</div>
			</div>
		</form>
	</div>

	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>