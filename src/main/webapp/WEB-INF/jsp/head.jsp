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
<title>Insert title here</title>
<style type="text/css">
	.modal-backdrop {
  opacity: 0 !important;
  filter: alpha(opacity=0) !important;
}
</style>
<script type="text/javascript">

function ProAnnounce(){
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
			"action":"addAnnounBySuper",
			"message" : message,
		},
		dataType : "json",
		success : function(data) {
			alert("公告发布成功");
			window.location.reload();
		}
	});
}
	
</script>
</head>
<body>
	<!-- Navigation -->
		
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse"/>
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
<!-- 			<a class="navbar-brand" href="index.html">智能家居控制系统V1.0</a> -->
			<h4 class="navbar-brand">智能家居控制系统</h4>
			<h5 class="navbar-brand" style="color: maroon;">超级管理员，${superadmin.saName}</h5>
			
		</div>
		
		<!-- /.navbar-header -->
		

		<ul class="nav navbar-top-links navbar-right">
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-envelope fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-user">
				     <li><a href="#" data-toggle="modal"
					data-target="#adminProAnnoun"> <i class="fa fa-gear fa-fw"></i>
						发布公告
				    </a></li>
				</ul> <!-- /.dropdown-messages --></li>
			<!-- /.dropdown -->
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
					<i class="fa fa-caret-down"></i>
			</a>
				<ul class="dropdown-menu dropdown-user">
					<li><a href="#" data-toggle="modal" data-target="#superamdinEditDialog"  >
					<i class="fa fa-gear fa-fw"></i> 修改密码</a></li>
					<li class="divider"></li>
					<li><a href="<%=basePath%>superlogout"><i class="fa fa-sign-out fa-fw"></i>
							退出登录</a></li>
				</ul> <!-- /.dropdown-user --></li>
			<!-- /.dropdown -->
		</ul>
		</nav>
		<!-- /.navbar-top-links -->
		<!-- 超级管理员发布公告对话框 -->
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
							onclick="ProAnnounce()">发布公告</button>
					</div>
				</div>
			</div>
		</div>
		
</body>
</html>