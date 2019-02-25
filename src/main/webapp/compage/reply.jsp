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
<title>智能家居控制系统</title>
<script type="text/javascript">
	$(function() {
		validateForm();
	});
	function addmsg() {
		var bv = $("#addmsgform").data('bootstrapValidator');
		bv.validate();
		if (!bv.isValid()) {
			return;
		}
		var cnId = $("select[name='conid']").val();
		var message = $("textarea[name='msgcontents']").val();
		var typeid = $("select[name='typeid']").val();
		if (typeid == "2") {
			$.ajax({
				url : "feedback/addFeedback",
				type : "POST",
				async : "true",
				data : {
					"action" : "addFix",
					"message" : message,
					"cnId" : cnId
				},
				dataType : "json",
				success : function(data) {
					if (data == 1) {
						alert("报修成功");
						window.location.reload();
					} else if (data == 0) {
						alert("报修失败,该报修记录已存在");
						window.location.reload();
					}

				}
			});
		} else if (typeid == "1") {
			cnId = 0;
			$.ajax({
				url : "feedback/addFeedback",
				type : "POST",
				async : "true",
				data : {
					"action" : "addSug",
					"message" : message,
					"cnId" : cnId
				},
				dataType : "json",
				success : function(data) {
					if (data == 1) {
						alert("建议提交成功");
						window.location.reload();
					} else if (data == 0) {
						alert("建议提交失败");
						window.location.reload();
					}
				}
			});
		}
	}
	function locked() {
		var typeid = $("select[name='typeid']").val();
		if (typeid == 1) {
			$("#conid").empty();
			//$("#conid").prepend("<option value='0' disabled='disabled'>请选择</option>");
		}
		if (typeid == 2) {
			window.location.reload();
		}
		//$("select[name='conid']:option").val("");
	}
	function validateForm() {
		$("#addmsgform").bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {/*输入框不同状态，显示图片的样式*/
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {/*验证*/
				msgcontents : {
					message : 'The msgcontents is not valid',
					validators : {
						notEmpty : {
							message : '描述内容不能为空'
						},
						stringLength : {
							min : 6,
							max : 50,
							message : '描述内容长度必须在6到50之间'
						}
					}
				}
			}
		});
	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false>
	<jsp:include flush="fasle" page="head2.jsp" />
	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>用户反馈</h1>
			<span>在这里可以向管理员发布您的需求，或对本网站的建议。</span>
			<p>本网站致力于向用户提供行业领先的服务，所以请您务必如实填写</p>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-sm-12 text-center"></div>
		</div>
		<form class="form-horizontal col-sm-offset-2" id="addmsgform"
			method="post">
			<div class="form-group">
				<label for="typeid" class="col-sm-2 control-label">类型：</label>
				<div class="col-sm-6">
					<select class="form-control" name="typeid" id="typeid"
						onchange="locked()">
						<option value="2">控件报修</option>
						<option value="1">网站反馈</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="conid" class="col-sm-2 control-label">控件：</label>
				<div class="col-sm-6">
					<select class="form-control" name="conid" id="conid">
						<c:forEach var="state" items="${stateList}">
							<option value="${state.cnId}">${state.cnName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="msgcontents" class="col-sm-2 control-label">描述：</label>
				<div class="col-sm-6">
					<textarea class="form-control" rows="5" name="msgcontents"
						id="msgcontents"></textarea>
				</div>
			</div>
			<div class="form-group has-error">
				<div class="col-sm-offset-2 col-sm-4 col-xs-6 ">
					<span class="text-warning"></span>
				</div>
			</div>
			<div class="form-group">

				<div class="col-sm-offset-2 col-sm-3 col-xs-10">
					<button type="reset" style="float: left;" class="btn btn-warning "
						onclick="javascript:window.location.href='compage/homepage.jsp'">返回标题</button>
				</div>
				<div class="col-sm-offset-1 col-sm-2 col-xs-12" style="margin-left: 100px;">
					<button type="button" onclick="window.location.reload();"
						class="btn btn-primary">重置</button>
					<button class="btn btn-success" onclick="addmsg();">提交</button>
				</div>
			</div>
		</form>
	</div>
	<jsp:include flush="fasle" page="foot.jsp" />
</body>
</html>