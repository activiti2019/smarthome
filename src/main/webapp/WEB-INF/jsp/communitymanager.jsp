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


<title>小区列表-Home_Auto</title>

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
					<h1 class="page-header">小区管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" name="formSubmit" onsubmit="return false;"
					   action="${pageContext.request.contextPath }/community/list.action" method="post">
						<div class="form-group">	
							<label for="communityName">小区名称</label> 
							<input type="text" class="form-control" id="communityName" placeholder="请输入查询的小区名称" value="${cmName }" name="cmName">
						</div>
						<div class="form-group">
							<label for="state">小区状态</label> 
								<select	class="form-control" id="state" name="state">
									<option value="">--请选择--</option>
									<option value="1"<c:if test="${state == 1}"> selected</c:if>>存在</option>
									<option value="-1"<c:if test="${state==-1}"> selected</c:if>>已删除</option>
								</select>
						</div>
						<button type="submit" class="btn btn-primary" onclick="search();">查询</button>
						<a style="float:right" class="btn btn-primary" data-toggle="modal" data-target="#communityAddDialog" >添加小区</a>
					</form>						
				</div>
				
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">小区列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>ID</th>
									<th>小区名</th>
									<th>小区位置（经度）</th>
									<th>小区位置（纬度）</th>
									<th>操作</th>
									<th>小区详细信息</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
										<tr>
											<td>${row.cmId}</td>
											<td>${row.cmName}</td>
											<td>${row.longitude}</td>
											<td>${row.latitude}</td>
											<td>
												<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#communityEditDialog" onclick="editCommunity(${row.cmId})">修改</a>
												<c:if test="${row.state == 1 }">
													<a href="#" class="btn btn-danger btn-xs" onclick="deleteCommunity(${row.cmId})">禁用</a>
												</c:if>
												<c:if test="${row.state == -1 }">
													<a href="#" class="btn btn-warning btn-xs" onclick="restoreCommunity(${row.cmId})">恢复</a>
												</c:if>
											</td>
											<td>
												<c:if test="${row.state == -1 }">
													<a  disabled="true" class="btn btn-primary btn-xs">进入地图查看</a>
												</c:if>
												<c:if test="${row.state == 1 }">
													<a href="<%=basePath%>map/show?cmId=${row.cmId}"  class="btn btn-primary btn-xs">进入地图查看</a>
												</c:if>
											</td>
										</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="col-md-12 text-right">
							<p:page url="${pageContext.request.contextPath }/community/list.action" />
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
	<!-- 修改小区对话框 -->
	<div class="modal fade" id="communityEditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改小区信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_community_form">
						<input type="hidden" id="edit_cmId" name="cmId"/> 
						<div class="form-group">
							<label for="edit_cmName" class="col-sm-2 control-label">小区名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_cmName" placeholder="请输入2-15位字符的小区名称" name="cmName">
							</div>
						</div>
						<div class="form-group">
							<label for="edit_longitude" class="col-sm-2 control-label">小区位置（经度）</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_longitude" placeholder="经度请输入73-136范围内的数字或小数(最多约到小数点后六位)" name="longitude">
							</div>
						</div>
						<div class="form-group">
							<label for="edit_latitude" class="col-sm-2 control-label">小区位置（纬度）</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_latitude" placeholder="纬度请输入3-54范围内的数字或小数(最多约到小数点后六位)" name="latitude">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateCommunity()">保存修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	
	<!-- 增加小区对话框 -->
	<div class="modal fade" id="communityAddDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">增加小区</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="add_community_form">
						<div class="form-group">
							<label for="add_cmName" class="col-sm-2 control-label">小区名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="add_cmName" placeholder="请输入2-15位字符的小区名称" name="cmName">
							</div>
						</div>
						<div class="form-group">
							<label for="add_longitude" class="col-sm-2 control-label">小区位置（经度）</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="add_longitude" placeholder="经度请输入73-136范围内的数字或小数(最多约到小数点后六位)" name="longitude">
							</div>
						</div>
						<div class="form-group">
							<label for="add_latitude" class="col-sm-2 control-label">小区位置（纬度）</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="add_latitude" placeholder="纬度请输入3-54范围内的数字或小数(最多约到小数点后六位)" name="latitude">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addCommunity()">确认添加</button>
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
				document.formSubmit.action="${pageContext.request.contextPath }/community/list.action?page="+pagenum+"&rows=10";
			}
			document.formSubmit.submit();
		}
	
		function editCommunity(cmId) {
			$.ajax({
				type:"get",
				url:"<%=basePath%>community/edit.action",
				data:{"cmId":cmId},
				success:function(data) {
					$("#edit_cmId").val(data.cmId);
					$("#edit_cmName").val(data.cmName);
					$("#edit_longitude").val(data.longitude);
					$("#edit_latitude").val(data.latitude)
				}
			});
		}
		
		function addCommunity(){
			var reg=/^[0-9\.]+$/;
			var reg2=/^[1-5][0-9]\.[0-9]{0,6}$/;
			var longitude=document.getElementById("add_longitude").value;
			var latitude=document.getElementById("add_latitude").value;
			var cmName=document.getElementById("add_cmName").value;
			if(""==cmName){
				alert("小区名不能为空");
				return;
			}
			if(""==longitude){
				alert("经度不能为空");
				return;
			}
			if(""==latitude){
				alert("维度不能为空");
				return;
			}
			if(cmName.length<2||cmName.length>15){
				alert("请输入2-15位字符的小区名称");
				return;
			}
			if(!reg.test(longitude)||longitude<73||longitude>136){
				alert("经度请输入73-136范围内的数字或小数");
				return;
			}
			if(!reg.test(latitude)||latitude<3||latitude>54){
				alert("纬度请输入3-54范围内的数字或小数");
				return;
			}
			$.post("<%=basePath%>community/add.action",$("#add_community_form").serialize(),function(data){
				alert("小区添加成功！");
				window.location.reload();
			});
		}
		
		function updateCommunity() {
			var reg=/^[0-9]+\.[0-9]+$/;
			var longitude=document.getElementById("edit_longitude").value;
			var latitude=document.getElementById("edit_latitude").value;
			var cmName=document.getElementById("edit_cmName").value;
			if(""==cmName){
				alert("小区名不能为空");
				return;
			}
			if(""==longitude){
				alert("经度不能为空");
				return;
			}
			if(""==latitude){
				alert("维度不能为空");
				return;
			}
			if(cmName.length<2||cmName.length>15){
				alert("请输入2-15位字符的小区名称");
				return;
			}
			if(!reg.test(longitude)||longitude<73||longitude>136){
				alert("经度请输入73-136范围内的数字或小数");
				return;
			}
			if(!reg.test(latitude)||latitude<3||latitude>54){
				alert("纬度请输入3-54范围内的数字或小数");
				return;
			}
			$.post("<%=basePath%>community/update.action",$("#edit_community_form").serialize(),function(data){
				alert("小区信息更新成功！");
				window.location.reload();
			});
		}
	
		function deleteCommunity(cmId) {
			if(confirm('是否确认禁用该小区?')) {
				$.post("<%=basePath%>community/delete.action",{"cmId":cmId},function(data){
					alert("禁用成功！");
					window.location.reload();
				});
			}
		}
		
		function restoreCommunity(cmId) {
			if(confirm('是否确认恢复该小区?')) {
				$.post("<%=basePath%>community/restore.action",{"cmId":cmId},function(data){
					alert("恢复成功！");
					window.location.reload();
				});
			}
		}
		
	</script>
</body>

</html>
