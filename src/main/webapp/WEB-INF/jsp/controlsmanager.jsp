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

<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content=""/>
<meta name="author" content=""/>


<title>控件列表-Home_Auto</title>

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
	
<style type="text/css">
	td{text-align:center; }
</style>
</head>

<body>
	<div id="wrapper">

		<jsp:include page="head.jsp" />

		<jsp:include page="left.jsp" />
		
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">控件管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline"  name="formSubmit" onsubmit="return false;"
					action="${pageContext.request.contextPath }/controls/list.action" method="post">
						<div class="form-group">
							<label for="controlsName">控件名</label> 
							<input type="text" class="form-control" id="controlsName" placeholder="请输入查询的控件名" value="${cnName }" name="cnName">
						</div>
						<button type="submit" class="btn btn-primary" onclick="search();">查询</button>
<!-- 						<a style="float:right" class="btn btn-primary" data-toggle="modal" data-target="#controlsAddDialog" >添加控件</a> -->
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">控件信息列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>ID</th>
									<th>所在场景</th>
									<th>控件名</th>
<!-- 									<th>操作</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td>${row.cnId}</td>
										<c:if test="${row.roomId==1 }"><td>客厅</td></c:if>
										<c:if test="${row.roomId==2 }"><td>卧室</td></c:if>
										<c:if test="${row.roomId==3 }"><td>厨房</td></c:if>
										<c:if test="${row.roomId==4 }"><td>餐厅</td></c:if>
										<c:if test="${row.roomId==5 }"><td>露台</td></c:if>
										<c:if test="${row.roomId==6 }"><td>浴室</td></c:if>
										<td>${row.cnName}</td>
<!-- 										<td> -->
<%-- 											<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#controlsEditDialog" onclick="editControls(${row.cnId})">修改</a> --%>
<%-- 											<a href="#" class="btn btn-danger btn-xs" onclick="deleteControls(${row.cnId})">删除</a> --%>
<!-- 									</td> -->
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="col-md-12 text-right">
							<p:page url="${pageContext.request.contextPath }/controls/list.action" />
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- 控件修改对话框 -->
	<div class="modal fade" id="controlsEditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改控件信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_controls_form">
						<input type="hidden" id="edit_cnId" name="cnId"/>
						<div class="form-group">
							<label for="edit_cnName" class="col-sm-2 control-label">控件名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_cnName" placeholder="控件名" name="cnName">
							</div>
						</div>
						<div class="form-group">
							<label for="edit_roomId" class="col-sm-2 control-label">控件场景</label>
							<div class="col-sm-10">
								<select	class="form-control" id="edit_roomId"  name="roomId">
									<option value="1"<c:if test="${roomId==1}"> selected</c:if>>客厅</option>
									<option value="2"<c:if test="${roomId==2}"> selected</c:if>>卧室</option>
									<option value="3"<c:if test="${roomId==3}"> selected</c:if>>厨房</option>
									<option value="4"<c:if test="${roomId==4}"> selected</c:if>>餐厅</option>
									<option value="5"<c:if test="${roomId==5}"> selected</c:if>>露台</option>
									<option value="6"<c:if test="${roomId==6}"> selected</c:if>>浴室</option>
								</select>
							</div>
					    </div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateControls()">保存修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	
	<!-- 添加控件对话框 -->
	<div class="modal fade" id="controlsAddDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加控件</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="add_controls_form">
						<div class="form-group">
							<label for="add_cnName" class="col-sm-2 control-label">控件名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="add_cnName" placeholder="控件名" name="cnName">
							</div>
					    </div>
					    <div class="form-group">
							<label for="add_roomId" class="col-sm-2 control-label">控件场景</label>
							<div class="col-sm-10">
								<select	class="form-control" id="add_roomId"  name="roomId">
									<option value="">--请选择--</option>
									<option value="1">客厅</option>
									<option value="2">卧室</option>
									<option value="3">厨房</option>
									<option value="4">餐厅</option>
									<option value="5">露台</option>
									<option value="6">浴室</option>
								</select>
							</div>
					    </div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addControls()">确认添加</button>
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
		function search(){
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
				document.formSubmit.action="${pageContext.request.contextPath }/controls/list.action?page="+pagenum+"&rows=10";
			}
			document.formSubmit.submit();
		}
	
		function editControls(cnId) {
			$.ajax({
				type:"get",
				url:"<%=basePath%>controls/edit.action",
				data:{"cnId":cnId},
				success:function(data) {
					$("#edit_cnId").val(data.cnId);
					$("#edit_roomId").val(data.roomId);
					$("#edit_cnName").val(data.cnName);
				}
			});
		}
		
		function addControls(){
			var cnName=document.getElementById("add_cnName").value;
			var roomId=document.getElementById("add_roomId").value;
			if(""==cnName){
				alert("控件名不能为空");
				return;
			}
			if(""==roomId){
				alert("控件场景不能为空");
				return;
			}
			if(cnName.length>15){
				alert("请输入15位字符以下的控件名");
				return;
			}
			$.post("<%=basePath%>controls/add.action",$("#add_controls_form").serialize(),function(data){
				var data=eval("("+data+")");
				if(data=="1"){
					alert("控件添加成功！");
				}else{
					alert("控件添加失败,请重试！");
				}
				window.location.reload();
			});
		}
		
		function updateControls() {
			var cnName=document.getElementById("edit_cnName").value;
			if(""==cnName){
				alert("控件名不能为空");
				return;
			}
			if(cnName.length>15){
				alert("请输入15位字符以下的控件名");
				return;
			}
			$.post("<%=basePath%>controls/update.action",$("#edit_controls_form").serialize(),function(data){
				alert("控件信息更新成功！");
				window.location.reload();
			});
		}
	
// 		function deleteControls(cnId) {
// 			if(confirm('确实要删除该控件吗?')) {
<%-- 				$.post("<%=basePath%>controls/delete.action",{"cnId":cnId},function(data){ --%>
// 					alert("控件删除更新成功！");
// 					window.location.reload();
// 				});
// 			}
// 		}
		
		
	</script>
</body>

</html>
