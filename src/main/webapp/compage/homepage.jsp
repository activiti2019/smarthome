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
<style type="text/css">
.flex-caption {
	width: 100%;
	padding: 2%;
	margin: 0;
	position: absolute;
	left: 0;
	bottom: 0;
	background: rgba(0, 0, 0, .3);
	color: #fff;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, .3);
	font-size: 28px;
	line-height: 18px;
}

.left {
	cursor: url("../images/left.ico");
}
</style>
<base href="<%=basePath%>">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>首页</title>
<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">
<script charset="UTF-8" src="js/jquery-2.2.4.min.js"
	type="text/javascript"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="js/drag.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
<script type="text/javascript">
	$(function() {

		getAnnounce();

	});
	function getAnnounce() {
		$.ajax({
			url : "announce/queryAnnouncement",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				$("#gonggao").html(data.message);
			}
		});
		$.ajax({
			url : "announce/queryWarning",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				for ( var i in data) {
					$("#tixing").append(data[i].message + "<br>");
				}
			}
		});
	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false>
	<!--header-->
	<div style="width: 100%;">
		<jsp:include page="head2.jsp"></jsp:include>
		<!--header end-->
	</div>


	<!--content-->

	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>首页</h1>
			<span>欢迎使用本系统</span>
		</div>
	</div>




	<div class="container" style="width: 100%; height: 40%;">

		<div id="myCarousel" class="carousel slide">
			<!-- 轮播（Carousel）指标 -->
			<ol class="carousel-indicators">

				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
				<li data-target="#myCarousel" data-slide-to="4"></li>
				<li data-target="#myCarousel" data-slide-to="5"></li>

			</ol>
			<!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/ktbg.jpg" style="width: 100%; cursor: pointer;"
						onclick="location.href='compage/parlour.jsp'">
					<p class="flex-caption">点击图片进入客厅</p>
				</div>
				<div class="item">
					<img src="images/wsbg.png" style="width: 100%; cursor: pointer;"
						onclick="location.href='compage/bedroom.jsp'">
					<p class="flex-caption">点击图片进入卧室</p>
				</div>
				<div class="item">
					<img src="images/cfbg.png" style="width: 100%; cursor: pointer;"
						onclick="location.href='compage/kitchen.jsp'">
					<p class="flex-caption">点击图片进入厨房</p>
				</div>

				<div class="item">
					<img src="images/ctbg.png" style="width: 100%; cursor: pointer;"
						onclick="location.href='compage/diningroom.jsp'">
					<p class="flex-caption">点击图片进入餐厅</p>
				</div>
				<div class="item">
					<img src="images/ltbg.png" style="width: 100%; cursor: pointer;"
						onclick="location.href='compage/balcony.jsp'">
					<p class="flex-caption">点击图片进入露台</p>
				</div>
				<div class="item">
					<img src="images/ysbg.png" style="width: 100%; cursor: pointer;"
						onclick="location.href='compage/bathroom.jsp'">
					<p class="flex-caption">点击图片进入浴室</p>
				</div>
			</div>
			<!-- 轮播（Carousel）导航 -->
			<a class="carousel-control left" href="#myCarousel" data-slide="prev"><img
				style="padding-top: 200px;" src="images/left.ico"></a> <a
				class="carousel-control right" href="#myCarousel" data-slide="next"><img
				style="padding-top: 200px;" src="images/right.ico"></a>
		</div>

	</div>
	<div class="col-xs-12" style="height: 30px;"></div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="col-sm-8 col-xs-8">
				<div class="tabbable" id="tabs-109614">
					<ul class="nav nav-tabs" style="width: 900px; margin: none;">
						<li class="active"><a data-toggle="tab" href="#panel-768021"><strong>控件图标解释</strong></a>
						</li>
						<li><a data-toggle="tab" href="#panel-869292"><strong>情景模式</strong></a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="panel-768021">
							<p>
								<img style="float: left; margin-left: 20px;" alt="11"
									src="images/kt-close - detail.png">

							</p>
						</div>
						<div class="tab-pane" id="panel-869292" style="height: 158px;">
							<ul style="margin-left: 30px;">
								<li>&nbsp;&nbsp;&nbsp;所有的情景模式都可以在用户中心的情景模式中进一步的个性定制。</li>
								<br>
								<li>（1）在家模式：当您要归家或在家中时，可以选择此模式，当选择此模式时将自动的开启客厅空调，开启热水器，开启影音</li>
								<li>（2）离家模式：当您要离家时，可以选择此模式，当选择此模式时将自动的关闭所有的灯光，关闭空调，关闭电视机，关闭音乐播放器</li>
								<li>（3）睡眠模式：当您要睡眠时，可以选择此模式，当选择此模式时将自动的关闭窗帘，关闭灯，关闭电视，关闭音乐播放器，关闭客厅空调</li>
								<li>（4）起床模式：当您醒来时可以选择此模式，当选择此模式时将自动的开启热水器，开启卧室窗帘</li>
								<li>（5）自定义模式：用户可以完全自定义一个属于自己的情景模式。</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-4 col-xs-4">
				<h3 class="modal-title" id="replyLabel">公告：</h3>
				<h4 class="modal-title" id="gonggao"></h4>
				<hr>
				<h3 class="modal-title" id="replyLabel">提醒：</h3>
				<h4 class="modal-title" id="tixing"></h4>
			</div>
		</div>
	</div>


	<script src="js/main.js"></script>
	<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>