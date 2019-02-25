<%@ page import="com.hp.pojo.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Admin admin = (Admin) session.getAttribute("admin");
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

.modal-backdrop {
	opacity: 0 !important;
	filter: alpha(opacity = 0) !important;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<!-- Navigation -->

	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse" />
		<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
		<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<!-- 			<a class="navbar-brand" href="index.html">智能家居控制系统V1.0</a> -->
		<h4 class="navbar-brand">智能家居控制系统</h4>
		<h5 class="navbar-brand" style="color: maroon;">${commnityname}管理员，${admin.aName}</h5>
	</div>
	<!-- /.navbar-header -->

	<ul class="nav navbar-top-links navbar-right">
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#"> <i class="fa fa-envelope fa-fw"></i>
				<i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-messages">
				<li><a href="#">
						<div>
							<strong>系统管理员</strong> <span class="pull-right text-muted">
								<em id="createtime"></em>
							</span>
						</div>
						<div>
							<span id="msg"></span>
						</div>
				</a></li>
			</ul> <!-- /.dropdown-messages --></li>
		<!-- /.dropdown -->
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
				<i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-user">
			    <li><a href="#" data-toggle="modal"
					data-target="#adminWarnUser"> <i class="fa fa-gear fa-fw"></i>
						提醒用户
				</a></li>
				<li class="divider"></li>
				<li><a href="#" data-toggle="modal"
					data-target="#adminProAnnoun"> <i class="fa fa-gear fa-fw"></i>
						发布公告
				</a></li>
			</ul> <!-- /.dropdown-alerts --></li>
		<!-- /.dropdown -->
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
				<i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#" data-toggle="modal"
					data-target="#amdinEditDialog"> <i class="fa fa-gear fa-fw"></i>
						修改密码
				</a></li>
				<li class="divider"></li>
				<li><a href="<%=basePath%>logout"><i
						class="fa fa-sign-out fa-fw"></i> 退出登录</a></li>
			</ul> <!-- /.dropdown-user --></li>
		<!-- /.dropdown -->
	</ul>
	<!-- /.navbar-top-links -->

	<div class="navbar-default sidebar" role="navigation">
		<div class="sidebar-nav navbar-collapse">
			<ul class="nav" id="side-menu">
				<li class="sidebar-search"></li>
				<li><a href="../user2/list" class="active"><i
						class="fa fa-table fa-fw"></i> 用户管理</a></li>
				<li><a href="../state2/list" class="active"><i
						class="fa fa-edit fa-fw"></i> 控件状态管理</a></li>
				<li><a href="../record2/list" class="active"><i
						class="fa fa-bar-chart fa-fw"></i> 异常记录</a></li>
				<li class="dropdown"><a href="#" class="fa fa-calendar"
					data-toggle="dropdown"> 数据统计 <i class="icon-arrow"></i></a>
					<ul class="navContent collapse">
						<br>
						<li><a href="../statistics/showeverypart">各场景异常分布</a></li>
						<br>
						<li><a href="../statistics/showtopten">总异常记录top10</a></li>
					</ul></li>
			</ul>
		</div>
		<!-- /.sidebar-collapse -->
	</div>
	<!-- /.navbar-static-side --> </nav>
	<!-- 管理员提醒用户对话框 -->
	<div class="modal fade" id="adminWarnUser" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="padding-top: 100px">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">提醒用户</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" id="admin_pro_announ">
						<input type="hidden" id="edit_announ" name="uId" />
						<div class="form-group">
							<label for="edit_uName" class="col-sm-2 control-label">提醒用户</label>
							<div class="col-sm-10">

								<select style="height: 30px" name="selectUser" id="selectUser">
									<c:forEach items="${page1.rows}" var="row">
										<option value="${row.uId}">${row.uId},${row.realname}</option>
									</c:forEach>
								</select><br>
								<br>
								<textarea class="form-control" rows="5" cols="5" name="warning"
									placeholder="提醒内容" id="warning"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<!-- onclick="SendWarn(${row.uId})" -->
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="SendWarn()">发送提醒</button>
				</div>
			</div>

		</div>
	</div>
	<!-- 管理员发布公告对话框 -->
	<div class="modal fade" id="adminProAnnoun" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="padding-top: 100px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">发布公告</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="admin_pro_announ">
						<input type="hidden" id="edit_announ" name="uId" />
						<div class="form-group">
							<label for="edit_uName" class="col-sm-2 control-label">公告内容</label>
							<div class="col-sm-10">
								<textarea class="form-control" rows="5" cols="5"
									name="announcement" placeholder="公告内容" id="announcement"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						onclick="ProAnnounce(<%=admin.getCmId()%>)">发布公告</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	$(function() {
		getAnncounce();
	});
	function getAnncounce(){
		$.ajax({
			url : "<%=basePath%>announce/queryUpdate",
			type : "POST",
			async : "true",
			dataType : "json",
			success : function(data) {
			     var date=new Date(data.createtime);
			     var setDate=date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0"+date.getDate()).slice(-2);
			     $("#createtime").text(setDate);
				$("#msg").text(data.message);
			}
		});
	}
	function ProAnnounce(cmId){
		var message = $("textarea[name='announcement']").val();
		if(message.length<2 || message.length>50){
			alert("请输入2-50位的字符");
			return;
		}
		$.ajax({
			url : "<%=basePath%>announce/addAnnounce",
			type : "POST",
			async : "true",
			data : {
				"action":"addAnnoun",
				"message" : message,
				"cmId" : cmId
			},
			dataType : "json",
			success : function(data) {
				alert("公告发布成功");
				window.location.reload();
			}
		});
	}
	function SendWarn(){
		var warning = $("textarea[name='warning']").val();
		var uId = $("select[name='selectUser']").val();
		if(warning.length<2 || warning.length>50){
			alert("请输入2-50位的字符");
			return;
		}
		$.ajax({
			url : "<%=basePath%>announce/addAnnounce",
			type : "POST",
			async : "true",
			data : {
				"action":"warning",
				"uId" : uId,
				"warning" : warning
			},
			dataType : "json",
			success : function(data) {
				alert("成功发送提醒");
				window.location.reload();
			}
		});
	}
	</script>
</body>
</html>