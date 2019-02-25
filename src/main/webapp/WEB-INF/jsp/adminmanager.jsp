<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="p" uri="http://com.hp.page/common/"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
	td{text-align:center; }
</style>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content=""/>
<meta name="author" content=""/>


<title>小区管理员列表-Home_Auto</title>

<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet"/>
<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet"/>

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet"/>

<!-- Custom CSS -->
<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet"/>

<!-- Custom Fonts -->
<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet"
	type="text/css"/>
<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet"
	type="text/css"/>
	

</head>

<body>
	<div id="wrapper">

		<jsp:include page="head.jsp" />

		<jsp:include page="left.jsp" />

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">小区管理员管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" name="formSubmit" onsubmit="return false;" action="${pageContext.request.contextPath }/admin/list.action" method="post">
						<div class="form-group">
							<label for="adminName">用户名</label> 
							<input type="text" class="form-control" id="adminName" placeholder="请输入查询的用户名" value="${aName }" name="aName">
						</div>
						<div class="form-group">
							<label for="state">账号状态</label> 
								<select	class="form-control" id="state" name="state">
									<option value="">--请选择--</option>
									<option value="1"<c:if test="${state == 1}"> selected</c:if>>可用</option>
									<option value="-1"<c:if test="${state==-1}"> selected</c:if>>禁用</option>
								</select>
						</div>
						<div class="form-group">
							<label for="community">所管理小区</label>
							<select	class="form-control" id="cmId" name="cmId">
								<option value="">--请选择--</option>
								<c:forEach items="${cmList}" var="item">
									<option value="${item.cmId}"<c:if test="${item.cmId == cmId}"> selected</c:if>>${item.cmName }</option>
								</c:forEach>
							</select>
						</div>
						<button type="submit"  class="btn btn-primary" onclick="search();">查询</button>
						<a style="float:right" class="btn btn-primary" data-toggle="modal" data-target="#adminAddDialog" >添加小区管理员</a>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">小区管理员信息列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>ID</th>
									<th>用户名</th>
									<th>所管理小区</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td>${row.aId}</td>
										<td>${row.aName}</td>
										<c:forEach items="${cmList}" var="item">
											<c:if test="${item.cmId == row.cmId}"><td>${item.cmName }</td> </c:if>
										</c:forEach>
										<td>
											<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#adminEditDialog" onclick="editAdmin(${row.aId})">修改</a>
											<c:if test="${row.state==1 }">
												<a href="#" class="btn btn-danger btn-xs" onclick="deleteAdmin(${row.aId})">禁用</a>
											</c:if>
											<c:if test="${row.state==-1 }">
												<a href="#" class="btn btn-warning btn-xs" onclick="restoreAdmin(${row.aId})">恢复</a>
											</c:if>
									</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="col-md-12 text-right">
							<p:page url="${pageContext.request.contextPath }/admin/list.action" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 管理员修改对话框 -->
	<div class="modal fade" id="adminEditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改管理员信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_admin_form">
						<input type="hidden" id="edit_aId" name="aId"/>
						<div class="form-group">
							<label for="edit_aName" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10">
								<input type="text" disabled="true" class="form-control" id="edit_aName" placeholder="用户名" name="aName">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit_cmId" style="float:left;padding:7px 15px 0 27px;">所在小区</label> 
							<div class="col-sm-10">
								<select	class="form-control" id="edit_cmId" placeholder="所在小区" name="cmId">
									<c:forEach items="${cmList}" var="item">
										<option value="${item.cmId}"<c:if test="${item.cmId == cmId}"> selected</c:if>>${item.cmName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateAdmin()">保存修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	
	<!-- 添加管理员对话框 -->
	<div class="modal fade" id="adminAddDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加小区管理员</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="add_admin_form">
						<div class="form-group">
							<label for="add_aName" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="add_aName" placeholder="请输入6-30位含大小写英文字母或数字或_或.的用户名" name="aName">
							</div>
						</div>
						<div class="form-group">
							<label for="add_aPwd" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10">
								<input  type="text" class="form-control" id="add_aPwd" placeholder="请输入6-30位含大小写英文字母或数字或_或.的密码" value="111111" name="aPwd">
							</div>
						</div>
						<div class="form-group">
							<label for="add_cmId" style="float:left;padding:7px 15px 0 27px;">管理小区</label> 
							<div class="col-sm-10">
								<select	class="form-control" id="add_cmId" placeholder="所管理小区" name="cmId">
									<option value="">--请选择--</option>
									<c:forEach items="${cmList}" var="item">
										<option value="${item.cmId}"<c:if test="${item.cmId == cmId}"> selected</c:if>>${item.cmName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addAdmin()">确认添加</button>
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
		function editAdmin(aId) {
			$.ajax({
				type:"get",
				url:"<%=basePath%>admin/edit.action",
				data:{"aId":aId},
				success:function(data) {
					$("#edit_aId").val(data.aId);
					$("#edit_aName").val(data.aName);
					$("#edit_cmId").val(data.cmId)
				}
			});
		}
		
		function addAdmin(){
			var aName=document.getElementById("add_aName").value;
			var aPwd=document.getElementById("add_aPwd").value;
			var cmId=document.getElementById("add_cmId").value;
			var reg=/^[a-zA-Z0-9_\.]{6,30}$/;  //非法字符验证
			if(""==aName){
				alert("账号不能为空");
				return;
			}
			if(""==aPwd){
				alert("密码不能为空");
				return;
			}
			if(""==cmId){
				alert("管理小区不能为空");
				return;
			}
			if(!reg.test(aName)){
				alert("用户名存在非法字符，仅能输入数字或字母或.或_");
				return;
			}
			if(!reg.test(aPwd)){
				alert("密码存在非法字符，仅能输入数字或字母或.或_");
				return;
			}
			$.post("<%=basePath%>admin/add.action",$("#add_admin_form").serialize(),function(data){
				if(data=="1"){
					alert("管理员添加成功！");
					window.location.reload();
				}else{
					alert("该用户名已存在！");
					return;
				}
				
			});
		}
		
		
		
		function updateAdmin() {
			var aName=document.getElementById("edit_aName").value;
			var cmId=document.getElementById("edit_cmId").value;
			var reg=/^[a-zA-Z0-9_\.]{6,30}$/;  //非法字符验证
			if(""==cmId){
				alert("管理小区不能为空");
				return;
			}
			$.post("<%=basePath%>admin/update.action",$("#edit_admin_form").serialize(),function(data){
				alert("管理员信息更新成功！");
				window.location.reload();
			});
		}
		function deleteAdmin(aId) {
			if(confirm('是否确认禁用该小区管理员?')) {
				$.post("<%=basePath%>admin/delete.action",{"aId":aId},function(data){
					var data = eval("(" + data + ")");
					if(data=="1"){
						alert("禁用成功！");
						window.location.reload();
					}
					if(data=="0"){
						alert("禁用失败！");
						return;
					}
					
				});
			}
		}
		function restoreAdmin(aId) {
			if(confirm('是否确认恢复该小区管理员?')) {
				$.post("<%=basePath%>admin/restore.action",{"aId":aId},function(data){
					var data = eval("(" + data + ")");
					if(data=="1"){
						alert("恢复成功！");
						window.location.reload();
					}
					if(data=="0"){
						alert("恢复失败！");
						return;
					}
				});
			}
		}
		
		function search(){
			
			var aName=$("input[name='aName']").val();
			var reg=/^[a-zA-Z0-9_\.]+$/;
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
				document.formSubmit.action="${pageContext.request.contextPath }/admin/list.action?page="+pagenum+"&rows=10";
			}
			if(aName.length!=0 && !reg.test(aName)){
				alert("用户名存在非法字符，仅能输入数字或字母或.或_");
				$("input[name='aName']").val("");
				return;
			}
			document.formSubmit.submit();
		}
	</script>
</body>

</html>
