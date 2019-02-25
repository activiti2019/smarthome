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
<!-- 表单验证 -->
<script src="bootstrapvalidator/js/bootstrapValidator.js"
	type="text/javascript"></script>
<script src="layer/layer.js" type="text/javascript"></script>
<title>智能家居控制系统</title>
<script type="text/javascript">
	$(function() {

		validateForm();

	});

	function validateForm() {
		// 验证表单
		$("#modifyform").bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {/*输入框不同状态，显示图片的样式*/
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {/*验证*/

				newpassword : {
					message : 'The password is not valid',
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
						},
						different : {
							field : 'oldpassword',
							message : '新密码不能与旧密码相同'
						},
						identical : {
							field : 'newpassword2',
							message : '两次密码必须一致'
						}
					}
				},
				oldpassword : {
					message : 'The password is not valid',
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
						},
						different : {
							field : 'newpassword',
							message : '新密码不能与旧密码相同'
						}

					}
				},
				newpassword2 : {
					message : 'The password is not valid',
					validators : {
						notEmpty : {
							message : '确认密码不能为空'
						},
						identical : {
							field : 'newpassword',
							message : '两次密码必须一致'
						}
					}
				}

			}
		});

	}

	function updatePW() {
		// ajax 异步请求修改密码
		var bv = $("#modifyform").data('bootstrapValidator');
		bv.validate();
		if (!bv.isValid()) {
			return;
		}

		var opwd = $("input[name='oldpassword']").val();
		var npwd = $("input[name='newpassword']").val();
		//alert(opwd+npwd);
		$.ajax({
			url : "user/updateUserpwd",
			data : {
				'oldpassword' : opwd,
				'newpassword' : npwd
			},
			dataType : 'json',
			type : 'post',

			success : function(date) {

				if (date.msg == "成功") {

					layer.msg('密码修改成功',
					{icon : 1});
					$.ajax({
						url : "user/userLogout",
						type : "POST",
						data : {},
						dataType : "json",
						success : function(data) {
							top.location.replace("index.jsp");
						}
					})
				} else if (date.msg == "原密码错误") {

					layer.msg('原密码错误', {
						icon : 2
					});
					$("input[name='oldpassword']").val("");
					$("input[name='newpassword']").val("");
					$("input[name='newpassword2']").val("");
					$("#modifyform").data('bootstrapValidator').destroy();
					$('#modifyform').data('bootstrapValidator', null);
					validateForm();
					$("input[name='oldpassword']").focus();

				} else if (date.msg == "失败") {
					layer.msg('密码修改失败', {
						icon : 5
					});
				}

			}
		});

	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false
	style="overflow-x: hidden; overflow-y: auto;">
	<div class="benefits-wrap" style="padding-top: 0px;">
		<div class="benefits-summary" style="padding: 20px;">
			<h1>修改密码</h1>
			<span>您在这里可以修改自己的登录密码</span>
			<p></p>
		</div>
	</div>
	<div class="page-container">
		<div class="row">
			<div class="col-sm-offset-3 col-sm-6 text-center"></div>
		</div>
		<form class="form-horizontal col-sm-offset-3" id="modifyform"
			method="post">

			<div class="form-group">
				<label for="oldpassword" class="col-sm-2 control-label">旧密码：</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="oldpassword"
						placeholder="请输入旧密码">
				</div>
			</div>
			<div class="form-group">
				<label for="newpassword" class="col-sm-2 control-label">新密码：</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="newpassword"
						placeholder="请输入新密码">
				</div>
			</div>
			<div class="form-group">
				<label for="newpassword2" class="col-sm-2 control-label">确认密码：</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="newpassword2"
						placeholder="请确认新密码">
				</div>
			</div>
			<div class="form-group has-error">
				<div class="col-sm-offset-2 col-sm-4 col-xs-6 ">
					<span class="text-warning"></span>
				</div>
			</div>
			<div class="form-group">

				<div class="col-sm-offset-2 col-sm-4 col-xs-6">
					<button class="btn btn-success btn-block" onclick="updatePW();">修改</button>
				</div>

			</div>
		</form>
	</div>
	<!-- 增加网页特效 -->
	<script type="text/javascript" src="js/canvas-nest.min.js"
		color="47,135,193" count="300"></script>
</body>
</html>