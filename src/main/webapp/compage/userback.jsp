<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
<link rel="stylesheet"
	href="bootstrapvalidator/css/bootstrapValidator.css">
<link rel="stylesheet" href="css/site.css">
<link rel="stylesheet"
	href="bootstrap-datetimepicker/css/bootstrap-datetimepicker.css">
<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script
	src="bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">
<link href="css/base.css" type="text/css" rel="stylesheet">
<!-- bootstrap的下拉选项 -->

<!-- 引入下拉框结束 -->
<!-- 表单验证 -->
<script src="bootstrapvalidator/js/bootstrapValidator.js"
	type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/echarts.js"></script>
<title>智能家居控制系统</title>

<script type="text/javascript">
	
</script>
</head>
<body oncontextmenu=self.event.returnValue=false>
	<div class="row ">
		<div class="col-xs-12">
			<jsp:include page="head2.jsp"></jsp:include></div>
	</div>



	<div class="row " style="padding-top: 160px; height: auto;">
		<div class="col-xs-3">
			<iframe src="compage/left.jsp"
				style="height: 500px; width: 400px; border: none;"> </iframe>
		</div>

		<div class="col-xs-9 ">
			<iframe name="BoardRight" src="compage/statisticsallrecordbydate.jsp"
				width="100%" height="1000px;"
				style="border: none; height: 650px; width: 1000px; overflow-y: scroll;overflow-x:hidden;"
				onload="document.all['BoardRight'].style.height=BoardRight.document.body.scrollHeight"></iframe>

		</div>
	</div>

	<div class="row ">
		<div class="col-xs-12"><jsp:include page="foot.jsp"></jsp:include></div>
	</div>
</body>
</html>