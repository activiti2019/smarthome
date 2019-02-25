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


<title>控件状态列表-Home_Auto</title>

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
<!-- jQuery -->
	<script src="<%=basePath%>js/jquery.min.js"></script>

</head>

<body>
	<div id="wrapper">

		<jsp:include page="adminleft.jsp" />

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">控件状态管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" name="formSubmit" onsubmit="return false;" action="${pageContext.request.contextPath }/state2/list.action" method="post">
						<div class="form-group">
							<label for="uName">用户名</label> 
							<input type="text" class="form-control" id="uName" placeholder="请输入查询的用户名" value="${uName}"  name="uName"/>
						</div>
						<div class="form-group">
							<label for="controls">控件名</label>
							<select	class="form-control" id="cnId" name="cnId">
								<option value="">--请选择--</option>
								<c:forEach items="${controlsList}" var="item">
									<option value="${item.cnId}"<c:if test="${item.cnId == cnId}"> selected</c:if>>${item.cnName }</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="state">控件状态</label> 
								<select	class="form-control" id="state" name="state">
									<option value="-1">--请选择--</option>
									<option value="1"<c:if test="${state == 1}"> selected</c:if>>异常</option>
									<option value="0"<c:if test="${state == 0}"> selected</c:if>>正常</option>
								</select>
						</div>
						
						<div class="form-group">
							<label for="onoff">控件开关</label> 
								<select	class="form-control" id="onoff" name="onoff">
									<option value="-1">--请选择--</option>
									<option value="1"<c:if test="${onoff == 1}"> selected</c:if>>开启</option>
									<option value="0"<c:if test="${onoff == 0}"> selected</c:if>>关闭</option>
								</select>
						</div>
						<button type="submit" class="btn btn-primary" onclick="search();">查询</button>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">控件状态信息列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped" >
							<thead>
								<tr>
									<th>ID</th>
									<th>用户名</th>
									<th>小区名</th>
									<th>控件名</th>
									<th>控件状态</th>
									<th>控件开关</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td>${row.stId}</td>
										<c:forEach items="${userList}" var="item">
											<c:if test="${item.uId == row.uId}"><td>${item.uName }</td> </c:if>
										</c:forEach>
										<c:forEach items="${userList}" var="item">
											<c:if test="${row.uId==item.uId }">
												<c:forEach items="${cmList}" var="items">
													<c:if test="${item.cmId==items.cmId }">
														<td>${items.cmName}</td>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
										<c:forEach items="${controlsList}" var="item">
											<c:if test="${item.cnId == row.cnId}"><td>${item.cnName }</td> </c:if>
										</c:forEach>
										<c:if test="${row.state == 1 }"><td style="color: red">异常</td></c:if>
										<c:if test="${row.state == 0 }"><td style="color: blue">正常</td></c:if>
										<c:if test="${row.onoff == 1}"><td style="color: blue">开启</td></c:if>
										<c:if test="${row.onoff == 0}"><td style="color: red">关闭</td></c:if>
										<td>
											<c:if test="${row.state == 1 }">
												<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#stateEditDialog" onclick="editState(${row.stId})">处理异常</a>
											</c:if>
											<c:if test="${row.state == 0 }">
												<a disabled="true" class="btn btn-primary btn-xs">无异常</a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="col-md-12 text-right">
							<p:page url="${pageContext.request.contextPath }/state2/list.action" />
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
	<!-- 控件状态修改对话框 -->
	<div class="modal fade" id="stateEditDialog" tabindex="-1" role="dialog"
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
					<form class="form-horizontal" id="edit_state_form">
						<input type="hidden" id="edit_stId" name="stId"/>
						<input type="hidden" id="edit_uId" name="uId"/>
						<input type="hidden" id="edit_cnId" name="cnId"/>
						<div class="form-group">
							<label for="state" style="float:left;padding:7px 15px 0 27px;">控件状态</label> 
								<div class="col-sm-8">
									<select	class="form-control" id="edit_state" name="state">
										<option value="${1}">异常</option>
										<option value="${0}">正常</option>
									</select>
								</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateState()">保存修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	
	<jsp:include page="changepwd.jsp" />

	

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
		function editState(stId) {
			$.ajax({
				type:"get",
				url:"<%=basePath%>state2/edit.action",
				data:{"stId":stId},
				success:function(data) {
					$("#edit_stId").val(data.stId);
					$("#edit_cnId").val(data.cnId);
					$("#edit_uId").val(data.uId);
					$("#edit_state").val(data.state);
				}
			});
		}
		
		
		function updateState() {
			$.post("<%=basePath%>state2/update.action",$("#edit_state_form").serialize(),function(data){
				alert("控件状态信息更新成功！");
				window.location.reload();
			});
		}
		
		
		
		function search(){
			var uName=$("input[name='uName']").val();
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
				document.formSubmit.action="${pageContext.request.contextPath }/state2/list.action?page="+pagenum+"&rows=10";
			}
			if(uName.length!=0 && !reg.test(uName)){
				alert("用户名存在非法字符，仅能输入数字或字母或.或_");
				$("input[name='uName']").val("");
				return;
			}
			document.formSubmit.submit();
		}
	
	</script>
</body>

</html>
