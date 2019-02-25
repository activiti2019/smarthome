<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
i {
	position: absolute;
	top: 5px;
	z-index: 1;
	width: 16px;
	height: 16px;
	line-height: 16px;
	font-size: 12px;
	font-style: normal;
	text-align: center;
	border-radius: 100%;
	background: #f8645c;
	overflow: inherit;
	color: #fff;
}

#mode1, #mode2, #mode3, #mode4, #mode5 {
	width: 14px;
	height: 14px;
}
</style>
<base href="<%=basePath%>">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
<link rel="stylesheet"
	href="bootstrapvalidator/css/bootstrapValidator.css">
<link rel="stylesheet" href="css/site.css">
<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="layer/layer.js" type="text/javascript"></script>
<title>页面头</title>

<script type="text/javascript">
	function logout() {
		layer.confirm('确定要退出吗？', {
			btn : [ '是的', '算了' ]
		//按钮
		}, function() {
			$.ajax({
				url : "user/userLogout",
				type : "POST",

				data : {},
				dataType : "json",
				success : function(data) {
					if (data.res == 1) {
						layer.msg('成功退出登录', {
							icon : 1
						});
						window.location.replace("index.jsp");
					} else {
						alert("退出登录失败");
						$(".text-warning").text(data.info);
						$("input[name='username']").val("");
						$("input[name='password']").val("");
					}
				}
			});
		}, function() {
			layer.msg('明智的选择', {
				icon : 1
			});
		});
	}
	$(function() {
		getallstate();
		getMode();
	});
	function getMode() {
		$.ajax({
			url : "user/getUserMode",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				$("#mode" + data).attr("style", "");
			}
		});
	}
	//客厅
	function getallstate() {
		$.ajax({
			url : "state/queryParState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				var num = 0;
				for ( var i in data) {
					//获取已安装的控件id,
					var id = data[i].cnId;
					if (data[i].state == 1) {
						num++;
					}
				}
				if (num != 0) {
					//删除默认的隐藏样式
					$("#1").attr("style", "");
					//为消息提示添加数字
					$("#1").html(num);
				}
				if (num == 0) {
					$("#1").attr("style", "display:none;");
				}
			}
		});
		//利用ajax异步获取卧室id下的异常数量
		$.ajax({
			url : "state/queryBedState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				var num = 0;
				for ( var i in data) {
					//获取已安装的控件id,
					var id = data[i].cnId;
					if (data[i].state == 1) {
						num++;
					}
				}
				if (num != 0) {
					//删除默认的隐藏样式
					$("#2").attr("style", "");
					//为消息提示添加数字
					$("#2").html(num);
				}
				if (num == 0) {
					$("#2").attr("style", "display:none;");
				}
			}
		});
		//厨房
		$.ajax({
			url : "state/queryKitState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				var num = 0;
				for ( var i in data) {
					//获取已安装的控件id,
					var id = data[i].cnId;
					if (data[i].state == 1) {
						num++;
					}
				}
				if (num != 0) {
					//删除默认的隐藏样式
					$("#3").attr("style", "");
					//为消息提示添加数字
					$("#3").html(num);
				}
				if (num == 0) {
					$("#3").attr("style", "display:none;");
				}
			}
		});
		//餐厅
		$.ajax({
			url : "state/queryDinState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				var num = 0;
				for ( var i in data) {
					//获取已安装的控件id,
					var id = data[i].cnId;
					if (data[i].state == 1) {
						num++;
					}
				}
				if (num != 0) {
					//删除默认的隐藏样式
					$("#4").attr("style", "");
					//为消息提示添加数字
					$("#4").html(num);
				}
				if (num == 0) {
					$("#4").attr("style", "display:none;");
				}
			}
		});
		//露台
		$.ajax({
			url : "state/queryBalState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				var num = 0;
				for ( var i in data) {
					//获取已安装的控件id,
					var id = data[i].cnId;
					if (data[i].state == 1) {
						num++;
					}
				}
				if (num != 0) {
					//删除默认的隐藏样式
					$("#5").attr("style", "");
					//为消息提示添加数字
					$("#5").html(num);
				}
				if (num == 0) {
					$("#5").attr("style", "display:none;");
				}
			}
		});
		//浴室
		$.ajax({
			url : "state/queryBathState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				var num = 0;
				for ( var i in data) {
					//获取已安装的控件id,
					var id = data[i].cnId;
					if (data[i].state == 1) {
						num++;
					}
				}
				if (num != 0) {
					//删除默认的隐藏样式
					$("#6").attr("style", "");
					//为消息提示添加数字
					$("#6").html(num);
				}
				if (num == 0) {
					$("#6").attr("style", "display:none;");
				}
			}
		});
	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false>
	<div class="nav_menu" style="width: 100%;">
		<div class="nav">
			<a href="./compage/homepage.jsp" class="logo"><img
				src="images/logo.png" width="220" height="70" alt="智能家居控制系统" /></a>

			<div class="list" id="navlist">

				<ul style="float: right;" id="menu">
					<li class="dropdown"><a class="dropdown-toggle"
						style="text-decoration: none; float: left; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px; background-color: #000000;"
						data-toggle="dropdown" href="#">情景模式<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<!--  -->
							<li><a href="modeController/modeAction?action=atHome">在家模式&nbsp;&nbsp;&nbsp;&nbsp;
									<img alt="该情景模式被选中" src="images/check.png"
									style="display: none;" id="mode1">
							</a></li>
							<!-- href="modeController/modeAction?action=leave" -->
							<li><a href="modeController/modeAction?action=leave">离家模式&nbsp;&nbsp;&nbsp;&nbsp;
									<img alt="该情景模式被选中" src="images/check.png"
									style="display: none;" id="mode2">
							</a></li>
							<!-- href="modeController/modeAction?action=sleep" -->
							<li><a href="modeController/modeAction?action=sleep">睡眠模式&nbsp;&nbsp;&nbsp;&nbsp;
									<img alt="该情景模式被选中" src="images/check.png"
									style="display: none;" id="mode3">
							</a></li>
							<!-- <a href="modeController/modeAction?action=wakeUp"> -->
							<li><a href="modeController/modeAction?action=wakeUp">起床模式&nbsp;&nbsp;&nbsp;&nbsp;
									<img alt="该情景模式被选中" src="images/check.png"
									style="display: none;" id="mode4">
							</a></li>
							<li><a href="modeController/modeAction?action=diy">自定义模式&nbsp;&nbsp;&nbsp;&nbsp;
									<img alt="该情景模式被选中" src="images/check.png"
									style="display: none;" id="mode5">
							</a></li>
						</ul></li>
					<li><a href="./compage/userback.jsp"
						style="text-decoration: none; float: left; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px; background-color: #000000;">用户中心</a></li>
					<li class="dropdown"><a
						style="text-decoration: none; float: right; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px; background-color: #000000;"
						href="javascript:logout()">退出系统 </a></li>
				</ul>
			</div>

			<div class="sec-bl" id="navbox" style="width: 100%;">
				<div class="cont">
					<div class="sec">
						<ul>
							<!-- 对前台点击传来的数值进行判断，对标题进行格式修改 -->
							<%
								String name = request.getParameter("page");
								session.setAttribute("name", name);
							%>

							<li></li>
							<li></li>
							<c:if test="${name eq 'parlour'}">
								<li id="parlour" class="curr"><a href="compage/parlour.jsp">
										客厅<i id="1" style="display: none"></i>
								</a></li>
							</c:if>
							<c:if test="${!(name eq 'parlour')}">
								<li id="parlour"><a href="compage/parlour.jsp">客厅<i
										id="1" style="display: none"></i>
								</a></li>
							</c:if>
							<c:if test="${name eq 'bedroom'}">
								<li id="bedroom" class="curr"><a href="compage/bedroom.jsp">卧室<i
										id="2" style="display: none"></i></a></li>
							</c:if>
							<c:if test="${!(name eq 'bedroom')}">
								<li id="bedroom"><a href="compage/bedroom.jsp">卧室<i
										id="2" style="display: none"></i>
								</a></li>
							</c:if>
							<c:if test="${name eq 'kitchen'}">
								<li id="kitchen" class="curr"><a href="compage/kitchen.jsp">厨房<i
										id="3" style="display: none"></i></a></li>
							</c:if>
							<c:if test="${!(name eq 'kitchen')}">
								<li id="kitchen"><a href="compage/kitchen.jsp">厨房<i
										id="3" style="display: none"></i></a></li>
							</c:if>
							<c:if test="${name eq 'diningroom'}">
								<li id="diningroom" class="curr"><a
									href="compage/diningroom.jsp">餐厅<i id="4"
										style="display: none"></i></a></li>
							</c:if>
							<c:if test="${!(name eq 'diningroom')}">
								<li id="diningroom"><a href="compage/diningroom.jsp">餐厅<i
										id="4" style="display: none"></i></a></li>
							</c:if>
							<c:if test="${name eq 'balcony'}">
								<li id="lutai" class="curr"><a href="compage/balcony.jsp">露台<i
										id="5" style="display: none"></i></a></li>
							</c:if>
							<c:if test="${!(name eq 'balcony')}">
								<li id="lutai"><a href="compage/balcony.jsp">露台<i
										id="5" style="display: none"></i></a></li>
							</c:if>
							<c:if test="${name eq 'bathroom'}">
								<li id="bathroom" class="curr"><a
									href="compage/bathroom.jsp">浴室<i id="6"
										style="display: none"></i></a></li>
							</c:if>
							<c:if test="${!(name eq 'bathroom')}">
								<li id="bathroom"><a href="compage/bathroom.jsp">浴室<i
										id="6" style="display: none"></i></a></li>
							</c:if>


						</ul>


					</div>

				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js" type="text/javascript"></script>
	<script
		src="https://cdn.bootcss.com/bootstrap-hover-dropdown/2.2.1/bootstrap-hover-dropdown.min.js"></script>
	<script>
		jQuery(function($) {
			$("#menu").dropdownHover();
		});
	</script>
</body>
</html>