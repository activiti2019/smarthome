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
<!-- 表单验证 -->
<script src="bootstrapvalidator/js/bootstrapValidator.js"
	type="text/javascript"></script>
<!-- 提示框 -->
<script src="layer/layer.js" type="text/javascript"></script>
<title>智能家居控制系统</title>

<script type="text/javascript">
	$(function() {
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
		getUser();
	});
	function getCommunity(cmId) {

		// Ajax异步请求所有的小区
		$.ajax({
			url : "user/getComList",
			type : "POST",
			data : {},
			async : false,
			dataType : "json",
			async : false,
			success : function(data) {

				var Data = data;
				for ( var key in Data) {
					if (key == cmId) {
						$("#community").append(
								'<option value="'+key+'">' + Data[key]
										+ '</option>');

					} else {
						$("#community").append(
								'<option  value="'+key+'">' + Data[key]
										+ '</option>');
					}
				}
			}
		});
	}
	function validateForm() {
		// 验证表单
		$("#updateform").bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {/*输入框不同状态，显示图片的样式*/
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {/*验证*/
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
						}
					/*最后一个没有逗号*/

					}
				},
				email : {
					message : '邮箱不合法, 请重新输入',
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
							regexp : /^[1-9][0-9]{10}$/,
							message : '个人电话不合法, 请重新输入'
						}
					}
				}
			}
		});
	}
	function getUser() {
		// ajax 异步请求 获取个人信息

		$
				.ajax({
					url : "user/getUserInfo",
					data : {},
					dataType : 'json',
					type : 'post',

					success : function(date) {
						/* */
						var Data = date;
						for ( var key in Data) {
							$("input[name='realname']").val(Data[key].realname);
							if ("女" == Data[key].sex) {
								$("input[name='sex'][value='男']").removeAttr(
										"checked");
								$("input[name='sex'][value='女']").prop(
										"checked", true);
							} else {
								$("input[name='sex'][value='男']").prop(
										"checked", true);
							}
							$("input[name='birthday']").val(
									format(Data[key].birthday, 'yyyy-MM-dd'));

							$("input[name='address']").val(Data[key].address);
							$("input[name='phone']").val(Data[key].phone);
							$("input[name='email']").val(Data[key].email);
						}

						$("input[name='birthday']").val(
								format(Data[key].birthday, 'yyyy-MM-dd'));

						$("select").val(Data[key].cmId);
						$("input[name='address']").val(Data[key].address);
						$("input[name='phone']").val(Data[key].phone);
						$("input[name='email']").val(Data[key].email);
					}
				});

	}

	var format = function(time, format)

	{
		var t = new Date(time);
		var tf = function(i) {
			return (i < 10 ? '0' : "") + i
		};
		return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
			switch (a) {
			case 'yyyy':
				return tf(t.getFullYear());
				break;
			case 'MM':
				return tf(t.getMonth() + 1);
				break;
			case 'mm':
				return tf(t.getMinutes());
				break;
			case 'dd':
				return tf(t.getDate());
				break;
			case 'HH':
				return tf(t.getHours());
				break;
			case 'ss':
				return tf(t.getSeconds());
				break;
			}
		})
	};

	function update() {
		// ajax 异步请求Controller 更新个人信息
		//点击修改按钮时需要进行表单验证
		var bv = $("#updateform").data('bootstrapValidator');
		bv.validate();
		if (!bv.isValid()) {
			return;
		}

		var realname = $("input[name='realname']").val();
		var sex = $("input[name='sex']:checked").val();
		var birthday = $("input[name='birthday']").val();
		var community = $("#community").val();
		var address = $("input[name='address']").val();
		var phone = $("input[name='phone']").val();
		var email = $("input[name='email']").val();
		$.ajax({
			url : "user/updateUserInfo",
			data : {
				'realname' : realname,
				'sex' : sex,
				'birthday' : birthday,
				'cmId' : community,
				'address' : address,
				'phone' : phone,
				'email' : email
			},
			dataType : 'json',
			type : 'post',

			success : function(date) {

				if (date.msg == "成功") {
					layer.msg('信息修改成功', {icon: 1});
					getUser();
					//window.location.href = "user/loginSuccess";

				} else {
					layer.msg('修改失败', {icon: 5});
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
<body oncontextmenu=self.event.returnValue=false
	style="overflow-x: hidden; overflow-y: auto;">
	<div class="benefits-wrap" style="padding-top: 0px;">
		<div class="benefits-summary" style="padding: 20px;">
			<h1>修改您的个人信息</h1>
			<span>您在这里可以对自己的个人信息进行修改</span>
			<p></p>
		</div>
	</div>
	<div class="page-container">
		<div class="row">
			<div class="col-sm-offset-3 col-sm-6 text-center"></div>
		</div>
		<form class="form-horizontal col-sm-offset-3" id="updateform"
			method="post">


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

					<select class="selectpicker  form-control" name="community"
						id="community">
						<c:forEach items="${comlist }" var="com">
							<c:if test="${com.cmId == currentuser.cmId }">
								<option selected="selected" value="${com.cmId }">${com.cmName }</option>
							</c:if>
							<c:if test="${com.cmId != currentuser.cmId }">
								<option value="${com.cmId }">${com.cmName }</option>
							</c:if>
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
						placeholder="请输入联系电话">
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
				<div class="col-sm-offset-2 col-sm-4 col-xs-6">
					<button class="btn btn-success btn-block" onclick="update();">修改</button>
				</div>
			</div>
		</form>
	</div>
	<!-- 增加网页特效 -->
	<script type="text/javascript" src="js/canvas-nest.min.js"
		color="47,135,193" count="300"></script>
</body>
</html>