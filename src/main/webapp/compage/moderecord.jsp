<%@ page import="java.util.*,com.hp.pojo.Controls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="p" uri="http://com.hp.page/common/"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<Controls> list = (List) session.getAttribute("stateList");
	String mId = request.getParameter("mId");
	String title = null;
	String message = null;
	if(mId.equals("1")){
		title = "在家情景模式";
		message = "设计于当您在家或者即将回家时";
	}else if(mId.equals("2")){
		title = "离家情景模式";
		message = "设计于当您即将离家时";
	}else if(mId.equals("3")){
		title = "睡眠情景模式";
		message = "设计于当您即将睡眠时";
	}else if(mId.equals("4")){
		title = "起床情景模式";
		message = "设计于当您刚从睡梦中醒来";
	}else if(mId.equals("5")){
		title = "自定义情景模式";
		message = "您或许想自行设计一个专属于您的模式";
	}
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
<script src="js/pagetool.js" type="text/javascript"></script>
<script src="layer/layer.js" type="text/javascript"></script>
<link href="css/button.css" rel="stylesheet">
<title>智能家居控制系统</title>
<script type="text/javascript">
	var mId =<%=mId%>;
	$(function() {
		getmsg(mId);
		//getmsg1();
		$(".form_datetime").datetimepicker({
			format : 'yyyy-mm-dd',
			minView : 'month',
			language : 'zh-CN',
			autoclose : true,//选中自动关闭
			startDate : '1900-01-01',
			todayBtn : true
		//显示今日按钮 
		});
	});
	function getmsg(mId) {
				$.ajax({
					url : "state/queryStateNameN",
					type : "POST",
					data : {
						"mId" : mId
					},
					dataType : "json",
					success : function(data) {
						$(".list1").html("");
						for ( var i in data.info) {
							var xx = $(".template").clone();
							xx.show();
							xx.removeClass("template");
							xx.find(".name").text(data.info[i].cnName);
							if (data.info[i].cnId == 2
									|| data.info[i].cnId == 7
									|| data.info[i].cnId == 8
									|| data.info[i].cnId == 10
									|| data.info[i].cnId == 13
									|| data.info[i].cnId == 15
									|| data.info[i].cnId == 16
									|| data.info[i].cnId == 17
									|| data.info[i].cnId == 20
									|| data.info[i].cnId == 22) {
								xx.find(".onoff").html("开启<input type = 'radio' id='"+data.info[i].cnId+"' name = '"+data.info[i].cnId+"' value = '"+data.info[i].cnId+"' checked />");
							} else {
								if (data.con.length != 0) {
									xx.find(".onoff").html("开启<input type = 'radio' id='"+data.info[i].cnId+"' name = '"+data.info[i].cnId+"' value = 'on'>关闭<input type = 'radio' id='"+data.info[i].cnId+"'  name = '"+data.info[i].cnId+"' value = 'off' checked >");
									for ( var n in data.con) {
										if (data.info[i].cnId == data.con[n].cnId) {
											xx.find(".onoff").html("开启<input type = 'radio' id='"+data.info[i].cnId+"' name = '"+data.info[i].cnId+"' value = 'on' checked>关闭<input type = 'radio' id='"+data.info[i].cnId+"'  name = '"+data.info[i].cnId+"' value = 'off'  >");
										}
									}
								} else {
									xx.find(".onoff").html("开启<input type = 'radio' id='"+data.info[i].cnId+"' name = '"+data.info[i].cnId+"' value = 'on'>关闭<input type = 'radio' id='"+data.info[i].cnId+"'  name = '"+data.info[i].cnId+"' value = 'off' checked >");
								}
							}
							$(".list1").append(xx);
						}
						var user = $(".template").clone();
						user.show();
						$(".list1").prepend(user);
					}
				});
	}
	function addmsg() {
		var num = [ 1, 3, 4, 5, 6, 9, 11, 12, 14, 18, 19, 21, 23, 24, 25, 26,
				27, 28, 29 ];
		//alert($('input:radio[name=1]:checked').val()); 
		var n = [];
		for (var i = 0; i < num.length; i++) {
			if ($('input:radio[name=' + num[i] + ']:checked').val() == "on") {
				n[i] = num[i];
			}
		}
		if (mId == 1 || mId == 4) {
			if (n.length == 0) {
				alert("该模式控件开关不能全部为空");
			} else if (n.length != 0) {
				$.ajax({
					url : "modeController/addModeRecords",
					traditional : true,
					data : {
						"nums" : n,
						"mId" : mId
					},
					dataType : "json",
					success : function(data) {
						layer.msg('保存成功', {
							icon : 1,
							offset : [ '100px', '400px' ]
						});
					}
				});
			}
		} else {
			$.ajax({
				url : "modeController/addModeRecords",
				traditional : true,
				data : {
					"nums" : n,
					"mId" : mId
				},
				dataType : "json",
				success : function(data) {
					layer.msg('保存成功', {
						icon : 1,
						offset : [ '100px', '400px' ]
					});
				}
			});
		}
	}
	function reset() {
		var n = [];
		$.ajax({
			url : "modeController/addModeRecords",
			traditional : true,
			data : {
				"nums" : n,
				"mId" : mId
			},
			dataType : "json",
			success : function(data) {
				layer.msg('重置成功', {
					icon : 1,
					offset : [ '100px', '400px' ]
				});
				window.location.reload();
			}
		});
	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false
	style="overflow-x: hidden; overflow-y: auto;">
	<div class="benefits-wrap" style="padding-top: 0px;">
		<div class="benefits-summary" style="padding: 20px;">
			<h1><%=title%></h1>
			<span><%=message %></span>
			<p></p>
		</div>
	</div>

	<div id="errormsg" class="errormsg1"></div>

	<div class="container" style="height: 500px">
		<div class="row">
			<div class="col-sm-12 msgtitle">
				<h3>
					<span class="title">控件选择</span>
					<h4 align="right">
						<input class="btn btn-warning" type="button" value="重置" onclick="reset()"> 
						<input class="btn btn-success" type="button" value="保存" onclick="addmsg()">
					</h4>
				</h3>
			</div>
		</div>
		<table class="table table-striped">
			<tbody>
				<tr>
					<td>已安装控件名称</td>
					<td>控件状态</td>
				</tr>
				<!-- 模板 -->
				<tr class="template">
					<td class="title name"></td>
					<td class="userinfo onoff"></td>
				</tr>
			</tbody>
		</table>
		<div class="col-sm-12">
			<table class="table table-striped">
				<tbody class="list1">
					<tr class="" style="display: table-row;"></tr>
				</tbody>
			</table>
		</div>



	</div>

	<!-- 增加网页特效 -->
	<script type="text/javascript" src="js/canvas-nest.min.js"
		color="47,135,193" count="300"></script>
</body>
</html>