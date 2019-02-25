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
<head>
<style type="text/css">
	td{text-align:center; }
</style>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content=""/>
<meta name="author" content=""/>


<title>异常记录-Home_Auto</title>
<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet"/>
<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet"/>

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet"/>

<!-- Custom CSS -->
<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet"/>


<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet"
	type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>css/site.css"/>

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
	<link rel="stylesheet"
	href="<%=basePath%>bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>
	<script src="<%=basePath%>bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
		type="text/javascript"></script>
	<!-- Custom Fonts -->
<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet"
	type="text/css"/>
</head>

<body>
	<div id="wrapper">

		<jsp:include page="adminleft.jsp" />

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">异常记录</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" name="formSubmit" onsubmit="return false;" action="${pageContext.request.contextPath }/record2/list.action" method="post">
						<div class="form-group">
							<label for="uName">&nbsp;&nbsp;&nbsp;&nbsp;用户名</label> 
							<input type="text" class="form-control" id="uName" placeholder="请输入查询的用户名" value="${uName}"  name="uName"/>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="form-group">
							<label for="controls">控件名</label>
							<select	class="form-control" id="cnId" name="cnId">
								<option value="">--请选择--</option>
								<c:forEach items="${controlsList}" var="item">
									<option value="${item.cnId}"<c:if test="${item.cnId == cnId}"> selected</c:if>>${item.cnName }</option>
								</c:forEach>
							</select>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="form-group">
							<label for="state">异常状态</label> 
								<select	class="form-control" id="handle" name="handle">
									<option value="-1">--请选择--</option>
									<option value="1"<c:if test="${handle == 1}"> selected</c:if>>已处理</option>
									<option value="0"<c:if test="${handle == 0}"> selected</c:if>>未处理</option>
								</select>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class=" form-group">
							<label for="handler">处理人</label> 
							<select	class="form-control" id="handler" name="handler">
									<option value="">--请选择--</option>
									<option value="管理员"<c:if test="${handler=='管理员'}"> selected</c:if>>管理员</option>
									<option value="用户"<c:if test="${handler=='用户'}"> selected</c:if>>用户</option>
								</select>
						</div>
						
						<div class="form-group">
							<label for="starttime" class="col-sm-8 control-label">开始日期</label>
							<div class="col-sm-10">
								<div class="input-group date form_datetime"
									data-date-format="dd-MM-yyyy" data-link-field="dtp_input1">
									<input class="form-control" size="16" type="text" name="starttime"
										value="${starttime }" readonly>
										 <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-remove"></span></span> <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-th"></span></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="endtime" class="col-sm-8 control-label">结束日期</label>
							<div class="col-sm-10">
								<div class="input-group date form_datetime"
									data-date-format="dd-MM-yyyy" data-link-field="dtp_input2">
									<input class="form-control" size="16" type="text" name="endtime"
										value="${endtime }" readonly>
										 <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-remove"></span></span> <span
											class="input-group-addon"><span
											class="glyphicon glyphicon-th"></span></span>
								</div>
							</div>
						</div>
						<button type="submit" style="float:right" class="btn btn-primary" onclick="search();">查询</button>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">异常记录列表</div>
						<!-- /.panel-heading -->
						<table class="table table-bordered table-striped" style="font-size: 14px;">
							<thead>
								<tr>
									<th>ID</th>
									<th>用户名</th>
									<th>控件名</th>
									<th>小区名</th>
									<th>产生时间</th>
									<th>处理时间</th>
									<th>处理状态</th>
									<th>处理人</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td>${row.rId}</td>
										<c:forEach items="${userList}" var="item">
											<c:if test="${item.uId == row.uId}"><td>${item.uName }</td> </c:if>
										</c:forEach>
										<c:forEach items="${controlsList}" var="item">
											<c:if test="${item.cnId == row.cnId}"><td>${item.cnName }</td> </c:if>
										</c:forEach>
										<c:forEach items="${cmList}" var="item">
											<c:if test="${item.cmId == row.cmId}"><td>${item.cmName }</td> </c:if>
										</c:forEach>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${row.createtime}" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${row.handletime}" /></td>
										<c:if test="${row.handle == 1 }"><td style="color: blue">已处理</td></c:if>
										<c:if test="${row.handle == 0 }"><td style="color: red">未处理</td></c:if>
										<td>${row.handler}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="col-md-12 text-right">
							<p:page url="${pageContext.request.contextPath }/record2/list.action" />
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
	
	<jsp:include page="changepwd.jsp" />
	
	

	<script type="text/javascript">
		$(function(){
			$(".form_datetime").datetimepicker({
				format : 'yyyy-mm-dd',
				minView : 'month',
				language : 'zh-CN',
				autoclose : true,//选中自动关闭
				startDate : '1900-01-01',
				endDate:new Date(),
				todayBtn : true
			//显示今日按钮
			});
		});
		
		
		
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
				document.formSubmit.action="${pageContext.request.contextPath }/record2/list.action?page="+pagenum+"&rows=10";
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