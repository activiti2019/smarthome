<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>

<!-- 公共文件 -->
<link href="css/public.css" rel="stylesheet">
<!-- 待整合css -->
<script src="js/all.min.js"></script>
<!-- 结束新增的 -->
<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">

<!-- 表单验证 -->
<script src="bootstrapvalidator/js/bootstrapValidator.js"
	type="text/javascript"></script>
<title>智能家居控制系统</title>
<style type="text/css">
.bbb {
	transition-delay: 0.5s;
	-moz-transition-delay: 0.5s; /* Firefox 4 */
	-webkit-transition-delay: 0.5s; /* Safari 和 Chrome */
	-o-transition-delay: 0.5s; /* Opera */
	transition-duration: 2s;
}
</style>

<script type="text/javascript">
	$(function() {
		validateForm();
		
		//提交表单的时候判断是否
		document.getElementById('input1').onclick = function() {
			
				login();
			
		}
	});
	function validateForm() {
		// 验证表单
		$("#loginform").bootstrapValidator({
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
							message : '用户名不合法, 请重新输入'
						},
						stringLength : {/*长度提示*/
							min : 6,
							max : 30,
							message : '用户名长度必须在6到30之间'
						}
					/*最后一个没有逗号*/

					}
				},
				password : {
					message : '密码无效',
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_\.]+$/,
							message : '密码不合法, 请重新输入'
						},
						stringLength : {
							min : 6,
							max : 30,
							message : '密码长度必须在6到30之间'
						}
					}
				}
			}
		});
	}

	function login() {
		// Ajax 异步请求登录
		var bv = $("#loginform").data('bootstrapValidator');
		bv.validate();
		if (!bv.isValid()) {
			return;
		}
		var username = $("input[name='username']").val();
		var password = $("input[name='password']").val();
		$.ajax({
			url : "user/login",
			type : "POST",
			async : "true",
			data : {
				"username" : username,
				"password" : password
			},
			dataType : "json",
			success : function(data) {

				if (data.msg == "成功") {
					window.location.href = "user/loginSuccess";
				} else if(data.msg=="用户被禁用"){
					$("#result").html("用户已被禁用！");
				}else {
					$("input[name='username']").val("");
					$("input[name='password']").val("");
					$("#result").html("用户名或密码错误，请重新输入！");
					setTimeout('refresh()', 800);
				}
			},
			error : function(data) {
				alert("出错了！！:" + data.msg);
			}
		});

		return false;
	}
	function refresh() {
		window.location.reload();
	}
	function keyLogin() {
		if (event.keyCode == 13) //回车键的键值为13  
			$("#input1").click(); //调用登录按钮的登录事件  
	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false onkeydown="keyLogin();">
	<!-- header  -->
	<div class="nav_menu">
		<div class="nav">
			<a href="index.jsp" class="logo"><img src="images/logo.png"
				width="220" height="70" alt="" /></a>

			<div class="list" id="navlist" style="float: right">
				<ul id="navfouce">

					<li><a href="index.jsp"
						style="float: left; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px;">登录</a></li>
					<li><a href="user/getComList1"
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
			<h1>用户登录</h1>
			<span>在这里进行登录或者注册一个新的账号</span>
			<p>本网站致力于打造最安全，最舒适的家庭管理系统，为用户提供行业领先的先进技术和最优的体验。</p>
		</div>
	</div>
	<div class="page-container">

		<div class="show-box grey clearfix">

			<form class="form-horizontal col-sm-offset-3" id="loginform"
				method="post">
				<div class="form-group">
					<div id="result" style="color: red; margin-left: 150px;"></div>
					<br> <label for="username" class="col-sm-2 control-label">账号：</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="username"
							placeholder="请输入账号">
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-sm-2 control-label">密码：</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" name="password"
							placeholder="请输入密码">
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-sm-2 control-label"></label>
					<!-- jQuery 写法-->
					<div class="col-sm-4">
						<div id="target2" style="background-image: images/loading.svg"></div>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-2 col-xs-6">
						<button id="input1" class="btn btn-success btn-block">登录</button>
					</div>

					<div class="col-sm-2  col-xs-6">
						<a class="btn btn-warning btn-block" href="user/getComList1">注册</a>
					</div>
				</div>

			</form>
		</div>
		<!-- 咨询模块 -->
		<ul class="window-touch">
			<li class="index-qq">
				<!-- 营销QQ --> <a class="marketingBtn"> </a>
			</li>
			<li class="index-flock">
				<!-- QQ群 --> <a target="_blank"
				href="https://jq.qq.com/?_wv=1027&k=5bl5KSW"> </a>
			</li>
			<!-- 电话 -->
			<li class="index-tel"><a href=""> </a></li>
			<!-- 回到顶部 -->
			<li class="index-top" id="pageTop"></li>
			<iframe class="marketing" src="" id="marketing"> </iframe>
		</ul>

	</div>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>