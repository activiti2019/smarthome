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
<title>彩蛋页面</title>
</head>
<body oncontextmenu=self.event.returnValue=false >

	<h1>这是一个彩蛋页面</h1>
	<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;可以试着点击下面的界面</h4>
	<canvas id="canvas" width="100%" height="100%">Canvas is not
	supported in your browser.</canvas>
	<script src="js/texiao.js"></script>

</body>
</html>