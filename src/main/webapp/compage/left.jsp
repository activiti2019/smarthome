<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<meta charset="utf-8">

<title>侧边导航</title>

<link href="css/base.css" type="text/css" rel="stylesheet">

<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>

<style>
</style>

<script type="text/javascript">
	$(function() {

		$(".subNav").click(
				function() {

					$(this).toggleClass("currentDd").siblings(".subNav")
							.removeClass("currentDd")

					$(this).toggleClass("currentDt").siblings(".subNav")
							.removeClass("currentDt")

					$(this).next(".navContent").slideToggle(300).siblings(
							".navContent").slideUp(500)

				})

	})
</script>



</head>
<body oncontextmenu=self.event.returnValue=false>

	<div class="subNavBox">
		<div class="subNav">修改信息</div>

		<ul class="navContent "
			style="display: none; font-size: 15px; padding-left: 30px;">


			<li><a href="user/getComList" target="BoardRight">&nbsp;&nbsp;修改个人信息</a></li>

			<li><a href="compage/changepwd.jsp" target="BoardRight">&nbsp;&nbsp;修改密码</a></li>

		</ul>
		<div class="subNav">情景模式</div>

		<ul class="navContent "
			style="display: none; font-size: 15px; padding-left: 30px;">


			<li><a href="compage/moderecord.jsp?mId=1" target="BoardRight">&nbsp;&nbsp;在家模式</a></li>

			<li><a href="compage/moderecord.jsp?mId=2" target="BoardRight">&nbsp;&nbsp;离家模式</a></li>
			<li><a href="compage/moderecord.jsp?mId=3" target="BoardRight">&nbsp;&nbsp;睡眠模式</a></li>
			<li><a href="compage/moderecord.jsp?mId=4" target="BoardRight">&nbsp;&nbsp;起床模式</a></li>
			<li><a href="compage/moderecord.jsp?mId=5" target="BoardRight">&nbsp;&nbsp;自定义模式</a></li>
		</ul>
		<div class="subNav">
			<a href="compage/record.jsp" target="BoardRight" style="color: #999">异常记录</a>
		</div>

		<div class="subNav">数据统计</div>
		<ul class="navContent " style="display: none;">


			<div class="subNav" style="font-size: 15px; padding-left: 30px;">按时间段查询</div>

			<ul class="navContent "
				style="display: none; font-size: 15px; padding-left: 30px;">

				<li><a href="compage/statisticsweekbydate.jsp"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本周</a></li>

				<li><a href="compage/statisticsmonthrecordbydate.jsp"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本月</a></li>

				<li><a href="compage/statisticsyearrecordbydate.jsp"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本年度</a></li>

				<li><a href="compage/statisticscustomerbydate.jsp"
					target="BoardRight">&nbsp;&nbsp;自定义时间查询</a></li>

			</ul>


			<div class="subNav" style="font-size: 15px; padding-left: 30px;">按场景查询</div>

			<ul class="navContent"
				style="display: none; font-size: 15px; padding-left: 30px;">

				<li><a href="compage/statisticsrecordbyscene.jsp?sceneid=1"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客厅</a></li>

				<li><a href="compage/statisticsrecordbyscene.jsp?sceneid=2"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;卧室</a></li>

				<li><a href="compage/statisticsrecordbyscene.jsp?sceneid=3"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;厨房</a></li>

				<li><a href="compage/statisticsrecordbyscene.jsp?sceneid=4"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;餐厅</a></li>

				<li><a href="compage/statisticsrecordbyscene.jsp?sceneid=5"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;露台</a></li>

				<li><a href="compage/statisticsrecordbyscene.jsp?sceneid=6"
					target="BoardRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;浴室</a></li>

			</ul>

		</ul>
		<div class="subNav">
			<a href="compage/homepage.jsp" target="_top" style="color: #999">返回首页</a>
		</div>



	</div>







</body>

</html>