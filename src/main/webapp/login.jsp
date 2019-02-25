<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>
<!-- 表单验证 -->
<script src="bootstrapvalidator/js/bootstrapValidator.js"
	type="text/javascript"></script>
<title>小区管理员登录</title>
<script type="text/javascript">
	$(function(){	
		validateForm();
	});
	
	function validateForm(){
		// 验证表单
		$("#loginform").bootstrapValidator({
		 	message: 'This value is not valid',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                username: {/*键名username和input name值对应*/
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '用户名不能为空'
                        },
                        regexp: {
                        	regexp: /^[a-zA-Z0-9_\.]+$/,
                        	message: '用户名不合法, 请重新输入'
                        },
                        stringLength: {/*长度提示*/
                            min: 6,
                            max: 30,
                            message: '用户名长度必须在6到30之间'
                        }/*最后一个没有逗号*/
                        
                    }
                },
                password: {
                    message:'密码无效',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        regexp: {
                        	regexp: /^[a-zA-Z0-9_\.]+$/,
                        	message: '密码不合法, 请重新输入'
                        },
                        stringLength: {
                            min: 6,
                            max: 30,
                            message: '密码长度必须在6到30之间'
                        }
                    }
                }
            }
        });
	}
	
	function keyLogin() {
		if (event.keyCode == 13) //回车键的键值为13  
			$("#btn").click(); //调用登录按钮的登录事件  
	}
	
	function login(){
		var bv = $("#loginform").data('bootstrapValidator');
		bv.validate();
		if (!bv.isValid()) {
			return;
		}
		// Ajax 异步请求登录
		var aName = $("input[name='username']").val();
		var aPwd = $("input[name='password']").val();
		$.ajax({
			url : "<%=basePath%>admin/login.action",
			type : "POST",
			async : "true",
			data : {
				"aName" : aName,
				"aPwd" : aPwd
			},
			dataType : "json",
			success : function(data) {
				var data = eval("(" + data + ")");
				if (data == "1") {
					window.location.href = "user2/list";
				} else {
					alert("账号或密码错误，请重新输入！");
					$(".text-warning").text(data.info);
					$("input[name='username']").val("");
					$("input[name='password']").val("");
				}
			}
		});
		return false;
	}
</script>
</head>
<body onkeydown="keyLogin();">
	<div class="container" style="position: absolute; top: 30%;left: 13%">
		<div class="row">
			<div class="col-sm-offset-3 col-sm-6 text-center">
				<h3>小区管理员登录</h3>
			</div>
		</div>
		<form class="form-horizontal col-sm-offset-3" id="loginform"
			method="post">
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label">账号：</label>
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
			<div class="form-group has-error">
				<div class="col-sm-offset-2 col-sm-4 col-xs-6 ">
					<span class="text-warning"></span>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-4 col-xs-6">
					<button class="btn btn-success btn-block" onclick="login();" id="btn">登录</button>
				</div>
			</div>
		</form>
	</div>
	<!-- 增加网页特效 -->
	<script type="text/javascript" src="js/canvas-nest.min.js"
		color="47,135,193" count="500"></script>
</body>
</html>