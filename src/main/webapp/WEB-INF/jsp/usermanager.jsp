<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="p" uri="http://com.hp.page/common/"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
td {
	text-align: center;
}
</style>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />


<title>用户列表-Home_Auto</title>

<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" />
<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet" />

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet" />

<!-- Custom CSS -->
<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet" />

<!-- Custom Fonts -->
<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet"
	type="text/css" />


</head>

<body>
	<div id="wrapper">

		<jsp:include page="head.jsp" />

		<jsp:include page="left.jsp" />

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">用户管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default" style="min-width: 600px;">
				<div class="panel-body">
					<form class="form-inline" id="searchFrom" name="formSubmit"
						onsubmit="return flase;"
						action="${pageContext.request.contextPath }/user/list.action"
						method="post">
						<div class="form-group">
							<label for="userName">用户名</label> <input type="text"
								class="form-control" id="userName" placeholder="请输入查询的用户名"
								value="${uName }" name="uName" />
						</div>
						<div class="form-group">
							<label for="userRealname">姓名</label> <input type="text"
								class="form-control" id="userRealname" placeholder="请输入查询的姓名"
								value="${realname }" name="realname" />
						</div>
						<div class="form-group">
							<label for="userAdderss">地址</label> <input type="text"
								class="form-control" id="userAdderss" placeholder="请输入查询的地址"
								value="${address }" name="address" />
						</div>
						<div class="form-group">
							<label for="community">所在小区</label> <select class="form-control"
								id="cmId" name="cmId">
								<option value="">--请选择--</option>
								<c:forEach items="${cmList}" var="item">
									<option value="${item.cmId}"
										<c:if test="${item.cmId == cmId}"> selected</c:if>>${item.cmName }</option>
								</c:forEach>
							</select>
						</div>
						<br><br>
								<div class="form-group">
									<label for="state">用户状态</label> <select class="form-control"
										id="state" name="state">
										<option value="">--请选择--</option>
										<option value="1" <c:if test="${state == 1}"> selected</c:if>>可用</option>
										<option value="-1" <c:if test="${state==-1}"> selected</c:if>>禁用</option>
									</select>
								</div>
								<button type="submit" class="btn btn-primary"
									onclick="search();">查询</button>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="min-width: 600px;">
						<div class="panel-heading">用户信息列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>ID</th>
									<th>用户名</th>
									<th>姓名</th>
									<th>性别</th>
									<th>出生日期</th>
									<th>所在小区</th>
									<th>tel</th>
									<th>地址</th>
									<th>eamil</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td>${row.uId}</td>
										<td>${row.uName}</td>
										<td>${row.realname}</td>
										<td>${row.sex}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd"
												value="${row.birthday}" /></td>
										<c:forEach items="${cmList}" var="item">
											<c:if test="${item.cmId == row.cmId}">
												<td>${item.cmName }</td>
											</c:if>
										</c:forEach>
										<td>${row.phone}</td>
										<td>${row.address}</td>
										<td>${row.email}</td>
										<td><a href="#" class="btn btn-primary btn-xs"
											data-toggle="modal" data-target="#userEditDialog"
											onclick="editUser(${row.uId})">修改</a> <c:if
												test="${row.state==1 }">
												<a href="#" class="btn btn-danger btn-xs"
													onclick="deleteUser(${row.uId})">禁用</a>
											</c:if> <c:if test="${row.state==-1 }">
												<a href="#" class="btn btn-warning btn-xs"
													onclick="restoreUser(${row.uId})">恢复</a>
											</c:if></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="col-md-12 text-right">
							<p:page
								url="${pageContext.request.contextPath }/user/list.action" />
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- 修改用户对话框 -->
	<div class="modal fade" id="userEditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_user_form">
						<input type="hidden" id="edit_uId" name="uId" />
						<div class="form-group">
							<label for="edit_uName" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10">
								<input type="text" disabled="true" class="form-control"
									id="edit_uName" placeholder="用户名" name="uName">
							</div>
						</div>
						<div class="form-group">
							<label for="edit_realname" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_realname"
									placeholder="请输入2-4位汉字的姓名" name="realname">
							</div>
						</div>
						<div class="form-group">
							<label for="edit_sex" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<select class="form-control" id="edit_sex" name="sex">
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_cmId"
								style="float: left; padding: 7px 15px 0 27px;">所在小区</label>
							<div class="col-sm-10">
								<select class="form-control" id="edit_cmId" placeholder="所在小区"
									name="cmId">
									<c:forEach items="${cmList}" var="item">
										<option value="${item.cmId}"
											<c:if test="${item.cmId == cmId}"> selected</c:if>>${item.cmName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_phone" class="col-sm-2 control-label">联系方式</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_phone"
									placeholder="联系方式" name="phone">
							</div>
						</div>
						<div class="form-group">
							<label for="edit_address" class="col-sm-2 control-label">地址</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_address"
									placeholder="请输入2-30位字符的地址" name="address">
							</div>
						</div>
						<div class="form-group">
							<label for="edit_email" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_email"
									placeholder="请输入5-30位字符符合格式的邮箱  例：****@**.***" name="email">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						onclick="updateUser()">保存修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	<jsp:include page="changesuperadminpwd.jsp" />
	<!-- jQuery -->
	<script src="<%=basePath%>js/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="<%=basePath%>js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="<%=basePath%>js/metisMenu.min.js"></script>

	<!-- DataTables JavaScript -->
	<script src="<%=basePath%>js/jquery.dataTables.min.js"></script>
	<script src="<%=basePath%>js/dataTables.bootstrap.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="<%=basePath%>js/sb-admin-2.js"></script>

	<script type="text/javascript">
	
		
		function editUser(uId) {
			$.ajax({
				type:"get",
				url:"<%=basePath%>user/edit.action",
				data:{"uId":uId},
				success:function(data) {
					$("#edit_uId").val(data.uId);
					$("#edit_uName").val(data.uName);
					$("#edit_realname").val(data.realname);
					$("#edit_sex").val(data.sex);
					$("#edit_cmId").val(data.cmId);
					$("#edit_phone").val(data.phone);
					$("#edit_address").val(data.address);
					$("#edit_email").val(data.email);
					
				}
			});
		}
		
		function updateUser() {
			var reg2=/^[\u4e00-\u9fa5]{2,4}$/;  //汉字验证
			var reg3=/^[1][0-9]{10}$/;  //手机号码验证
			var emailReg= /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;  //邮箱验证
			var realname=document.getElementById("edit_realname").value;
			var address=document.getElementById("edit_address").value;
			var phone=document.getElementById("edit_phone").value;
			var email=document.getElementById("edit_email").value;
			if(""==realname){
				alert("姓名不能为空");
				return;
			}
			if(""==phone){
				alert("联系方式不能为空");
				return;
			}
			if(""==address){
				alert("地址不能为空");
				return;
			}
			if(""==email){
				alert("邮箱不能为空");
				return;
			}
			if(!reg2.test(realname)){
				alert("请输入2-4位汉字的姓名");
				return;
			}
			if(!reg3.test(phone)){
				alert("手机号码不存在");
				return;
			}
			if(address.length<2||address.length>30){
				alert("请输入2-30位字符的地址");
				return;
			}
			if(!emailReg.test(email)){
				alert("邮箱格式错误");
				return;
			}
			if(email.length<5||email.length>30){
				alert("请输入5-30位字符的邮箱");
				return;
			}
			$.post("<%=basePath%>user/update.action",$("#edit_user_form").serialize(),function(data){
				alert("用户信息更新成功！");
				window.location.reload();
			});
		}
	
		function deleteUser(uId) {
			if(confirm('是否确认禁用该用户?')) {
				$.post("<%=basePath%>user/delete.action",{"uId":uId},function(data){
					alert("禁用成功！");
					window.location.reload();
				});
			}
		}
		
		function restoreUser(uId) {
			if(confirm('是否确认恢复该用户?')) {
				$.post("<%=basePath%>user/restore.action",{"uId":uId},function(data){
					alert("恢复成功！");
					window.location.reload();
				});
			}
		}
		
		function search(){
			var reg=/^[a-zA-Z0-9_/.]+$/;  //非法字符验证
			var reg2=/^[\u4e00-\u9fa5]{1,4}$/;  //汉字验证
			var uName=$("input[name='uName']").val();
			var realname=$("input[name='realname']").val();
			var pagenum=$("input[name='pagenum']").val();
			var regPage=/^[1-9][0-9]*$/;
			var pagetotal=parseInt("${page.total/page.size}");
			var pagetotal2=parseInt("${page.total%page.size}");
			if(!regPage.test(pagenum)){
				alert("请输入正整数！");
				$("input[name='pagenum']").val("");
				return;
			}
			if(pagenum>pagetotal && 0==pagetotal2){
				var pagenum=pagetotal;
			}
			if(pagenum>pagetotal && 0!=pagetotal2){
				var pagenum=pagetotal+1;
			}
			if(""!=pagenum){
				document.formSubmit.action="${pageContext.request.contextPath }/user/list.action?page="+pagenum+"&rows=10";
			}
			if(uName.length!=0 && !reg.test(uName)){
				alert("用户名存在非法字符，仅能输入数字或字母或.或_");
				$("input[name='uName']").val("");
				return;
			}
			if(realname.length!=0 && !reg2.test(realname)){
				alert("请输入1-4位汉字的姓名");
				$("input[name='realname']").val("");
				return;
			}
			document.formSubmit.submit();
		}
		
	</script>
</body>

</html>
