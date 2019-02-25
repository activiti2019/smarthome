<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<base href="<%=basePath%>">

<meta charset="UTF-8">
<title>调用摄像头</title>
<script charset="UTF-8" src="js/jquery-2.2.4.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="js/camera.js"></script>
<style type="text/css">
#camera_errbox {
	width: 320px;
	height: auto;
	border: 1px solid #333333;
	padding: 10px;
	color: #fff;
	text-align: left;
	margin: 20px auto;
	font-size: 14px;
}

#camera_errbox b {
	padding-bottom: 15px;
}

.borderstyle {
	-webkit-box-shadow: 0 0 5px 3px rgba(255, 0, 0, .6), 0 0 5px 6px
		rgba(0, 182, 0, .6), 0 0 5px 10px rgba(255, 255, 0, .6);
	-moz-box-shadow: 0 0 5px 3px rgba(255, 0, 0, .6), 0 0 5px 6px
		rgba(0, 182, 0, .6), 0 0 5px 10px rgba(255, 255, 0, .6);
	-ms-box-shadow: 0 0 5px 3px rgba(255, 0, 0, .6), 0 0 5px 6px
		rgba(0, 182, 0, .6), 0 0 5px 10px rgba(255, 255, 0, .6);
	-o-box-shadow: 0 0 5px 3px rgba(255, 0, 0, .6), 0 0 5px 6px
		rgba(0, 182, 0, .6), 0 0 5px 10px rgba(255, 255, 0, .6);
	box-shadow: 0 0 5px 3px rgba(255, 0, 0, .6), 0 0 5px 6px
		rgba(0, 182, 0, .6), 0 0 5px 10px rgba(255, 255, 0, .6);
}

#navy_video {
	float: left;
}

#canvas {
	float: left;
	margin-left: 20px;
}
</style>
</head>
<body oncontextmenu=self.event.returnValue=false  onLoad="init(this)" oncontextmenu="return false"
	onselectstart="return false">
	<center>
		<video id="navy_video" width="320px" height="240px" autoplay
			class="borderstyle"></video>
		<div id="camera_errbox"></div>
	</center>

</body>
</html>
