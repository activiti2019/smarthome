<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
ul li {
	list-style: none;
}

a:link, a:visited {
	text-decoration: none; /*超链接无下划线*/
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="navbar-default sidebar" role="navigation" style="margin-top: 5px;">
		<div class="sidebar-nav navbar-collapse">
			<ul class="nav" id="side-menu">
				<li><a href="../user/list"><i
						class="fa fa-table fa-fw"></i> 用户管理</a></li>
				<li><a href="../community/list"><i
						class="fa fa-dashboard fa-fw"></i> 小区管理</a></li>
				<li><a href="../admin/list"><i class="fa fa-desktop fa-fw"></i>
						小区管理员管理</a></li>
				<li><a href="../controls/list"><i
						class="fa fa-wrench fa-fw"></i> 控件管理</a></li>
				<li><a href="../state/list"><i class="fa fa-edit fa-fw"></i>
						控件状态管理</a></li>
				<li><a href="../record/list"><i
						class="fa fa-bar-chart fa-fw"></i> 异常记录</a></li>
				<li><a href="../map/show"><i class="fa fa-list-alt fa-fw"></i>
						地图查看</a></li>
				<li class="dropdown"><a href="#" class="fa fa-calendar">
						用户反馈 </a>
					<ul class="navContent collapse">
						<br>
						<li><a href="../feedback/conlist">用户控件报修</a></li>
						<br>
						<li><a href="../feedback/feedbacklist">用户建议反馈</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="fa fa-calendar">
						数据统计 </i>
				</a>
					<ul class="navContent collapse">
						<br>
						<li><a href="../statistics/showall">所有异常统计</a></li>
						<br>
						<li><a href="../statistics/showweek">本周异常统计</a></li>
						<br>
						<li><a href="../statistics/showmonth">按月异常统计</a></li>
						<br>
						<li><a href="../statistics/showyear">按年异常统计</a></li>
						<br>
						<li><a href="../statistics/showcustomer">自定义时间</a></li>
						<br>
						<li><a href="../statistics/showcommunity">各小区异常统计</a></li>
					</ul></li>
			</ul>
		</div>
		<!-- /.sidebar-collapse -->
	</div>
	<!-- /.navbar-static-side -->
	</nav>
</body>
</html>