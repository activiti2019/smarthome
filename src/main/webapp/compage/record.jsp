<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="p" uri="http://com.hp.page/common/"%>
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
<script src="js/pagetool.js" type="text/javascript"></script>
<link href="css/button.css" rel="stylesheet">
<title>智能家居控制系统</title>

<script type="text/javascript">
	var page = 1;//当前页面的页码
	$(function() {
		getmsg(page);
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
		$(".currentpage").click(function() {
			var current=$(this).find("a").text();
			$(this).find("a").html("<input  type=\"text\" style=\"color:black;width:auto;height:24px;\" value=\"1\">");
		});
	});

	function getmsg(pageNum) {

		var cnName = $("input[name='cnName']").val();
		var roomId = $("#roomId").val();
		var starttime = $("input[name='starttime']").val();
		var endtime = $("input[name='endtime']").val();
		var handle = $("#handle").val();
		var handler = $("#handler").val();

		$.ajax({
			url : "user/recordlist",
			type : "POST",
			data : {
				'cnName' : cnName,
				'roomId' : roomId,
				'starttime' : starttime,
				'endtime' : endtime,
				'handle' : handle,
				'handler' : handler,
				'page' : pageNum
			},
			dataType : "json",
			success : function(data) {
				if (data.msg != "error") {
					var num = 1;
					$(".list1").html("");
					$.each(data.msg.rows, function(index, xxItem) {
						var xx = $(".template").clone();
						xx.show();
						xx.removeClass("template");
						xx.find(".num").text(index + 1);
						xx.find(".name").text(xxItem.cnName);
						xx.find(".createtime").text(xxItem.starttime);
						xx.find(".handlertime").text(xxItem.endtime);
						if (xxItem.handle != 1) {
							xx.find(".handle").text("未处理");
						} else {
							xx.find(".handle").text("已处理");
						}

						xx.find(".handler").text(xxItem.handler);
						$(".list1").append(xx);
					});
					var user = $(".template").clone();
					user.show();
					$(".list1").prepend(user);
					setPage(pageNum, data.total, "getmsg");
				} else {
					alert("失败");
				}
			}
		});

	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false
	style="overflow-x: hidden; overflow-y: hidden;">


	<div class="container" style="height: 500px">
		<div class="row">
			<div class="col-sm-12 msgtitle">
				<h3>
					<span class="title">异常记录查询</span>
				</h3>
				<div class="replybtn">
					<button type="button" class="btn btn-success" data-toggle="modal"
						data-target="#search">搜索</button>
				</div>
			</div>
		</div>
		<div class="col-sm-12">
			<table class="table table-striped">
				<tbody class="list1">
					<tr class="" style="display: table-row;">
				</tbody>
			</table>
		</div>

		<table class="table table-striped">
			<tbody>
				<!-- 模板 -->
				<tr class="template">
					<td class="userinfo num">记录条数</td>
					<td class="title name">控件名称</td>
					<td class="userinfo createtime">产生时间</td>
					<td class="userinfo handlertime">处理时间</td>
					<td class="userinfo handle">是否处理</td>
					<td class="userinfo handler">处理人</td>
				</tr>
			</tbody>
		</table>


	</div>

	<div class="row" style="text-align: center">
		<jsp:include page="/page/pagetool.jsp"></jsp:include>
	</div>

	<!-- 模态框（Modal） -->
	<div class="modal fade" id="search" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog"
			style="margin-top: 0px; margin-bottom: auto;">
			<div class="modal-content modalcenter">
				<div class="modal-header">

					<h4 class="modal-title" id="replyLabel">搜索</h4>
				</div>
				<div class="modal-body">
					<form role="form">
						<div class="form-group">
							<label for="cnName">控件名称：</label> <input type="text"
								class="form-control" id="cnName" name="cnName"
								placeholder="请输入关键字">
						</div>

						<div class="form-group">
							<label for="roomId">场景：</label> <select class="form-control"
								name="roomId" id="roomId">
								<option value="">不选择</option>
								<option value="1">客厅</option>
								<option value="2">卧室</option>
								<option value="3">厨房</option>
								<option value="4">餐厅</option>
								<option value="5">露台</option>
								<option value="6">浴室</option>
							</select>
						</div>
						<div class="form-group">
							<label for="starttime" class="col-sm-4 control-label">开始时间：</label>
							<div class="col-sm-8">
								<div class="input-group date form_datetime"
									data-date-format="dd-MM-yyyy" data-link-field="dtp_input1">
									<input class="form-control" size="16" type="text"
										name="starttime" readonly> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-th"></span></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="endtime" class="col-sm-4 control-label">结束时间：</label>
							<div class="col-sm-8">
								<div class="input-group date form_datetime"
									data-date-format="dd-MM-yyyy" data-link-field="dtp_input1">
									<input class="form-control" size="16" type="text"
										name="endtime" readonly> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-th"></span></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="handle">是否处理：</label> <select class="form-control"
								name="handle" id="handle">
								<option value="-1">不选择</option>
								<option value="0">未处理</option>
								<option value="1">已处理</option>
							</select>
						</div>
						<div class="form-group">
							<label for="handler">处理人：</label> <select class="form-control"
								name="handler" id="handler">
								<option value="">不选择</option>
								<option value="用户">用户</option>
								<option value="管理员">管理人</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="getmsg(1)">搜索</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 增加网页特效 -->
	<script type="text/javascript" src="js/canvas-nest.min.js"
		color="47,135,193" count="300"></script>
</body>
</html>