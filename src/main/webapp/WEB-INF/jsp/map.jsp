<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"/> -->
<meta name="description" content="" />
<meta name="author" content="" />


<title>地图显示-Home_Auto</title>

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

<style type="text/css">
body, html, 
#showmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
	font-family: "微软雅黑";
}

#selectPoint{
	width:100px;
	height:16px;
	border:none;
	background: RGBA(12,12,23,.4);
	border-radius:3px;	
}
</style>


<script src="<%=basePath%>jquery/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="<%=basePath%>bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=4ALClgaOZafV3VbC8QKOiIeCvGfZLkUU"></script>

</head>

<body>
	<div id="wrapper">

		<jsp:include page="head.jsp" />
		<jsp:include page="left.jsp" />

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">地图显示</h1>
				</div>
			</div>

			<div class="panel panel-default">
				
			</div>
			
			<div class="row" style="height: 500px;width:1200px;padding: 50px;background-color: #CCCCCC">
				<div id="showmap"></div>
			</div>
		</div>
	</div>

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
<jsp:include page="changesuperadminpwd.jsp" />

<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("showmap");
	map.centerAndZoom(new BMap.Point(116.599, 35.395), 13);
	map.setCurrentCity("济宁");
	map.enableScrollWheelZoom(true);
	map.addControl(new BMap.NavigationControl());
	map.addControl(new BMap.ScaleControl());
	map.addControl(new BMap.OverviewMapControl());
	map.addControl(new BMap.MapTypeControl());
	
	

	function makeNewPoint(x, y, info) {

		var city = "";
		var newPoint = new BMap.Marker(new BMap.Point(x, y)); // 创建点
		
		newPoint.addEventListener("click",function(e) {
				var longitude = e.point.lng;
				var latitude = e.point.lat;
				var detial = "</p><p>小区名称:<span>"+ info.cmName+"</p>"
					+"<p>小区管理员:"+ info.aName+"</p>"
					+"<p>小区用户数量:"+ info.userCount+"</p>"
					+"<p>小区未处理异常数量:"+ info.stateCount+"</p>"
					+"<p>小区异常记录数:"+ info.recordCount+"</p>";
				var opts = {
					width : 250, // 信息窗口宽度
					height : 180, // 信息窗口高度
					title : "小区具体信息" // 信息窗口标题
					}
				var infoWindow = new BMap.InfoWindow(detial, opts); // 创建信息窗口对象
				map.openInfoWindow(infoWindow, new BMap.Point(longitude, latitude)); // 打开信息窗口
						
		});//作为参考  
				
		map.addOverlay(newPoint);

		var label = new BMap.Label("<div id='selectPoint'>" + info.cmName
				+ "</div>", {
			offset : new BMap.Size(13, -20)
		});
		newPoint.setLabel(label);
		
	
		if(info.cmId=="${cmId}"){
			label.setStyle({
				color : "RGBA(0,0,139,.8)",
				border : "0",
				fontWeight : "bold",
				display : "block",
			});
			setTimeout(function(){
				map.panTo(new BMap.Point(x,y));   //两秒后移动到此坐标
			}, 800);
		}else{
			label.setStyle({
				color : "RGBA(250,255,246,.8)",
				border : "0",
				fontWeight : "bold",
				display : "block"
			});
		}
	}

	//初始化地图上的所有信息点

	$.get("<%=basePath%>map/info",function(data) {
		for (var i = 0; i < data.length; i++) {
			var longitude=data[i].longitude;
			var latitude=data[i].latitude;
			makeNewPoint(longitude, latitude, data[i]);
		}
	});
	
	
</script>
</body>
</html>
