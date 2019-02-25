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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body oncontextmenu=self.event.returnValue=false>

	<!--detail footer-->
	<div class="detail-footer">
		<div class="content">
			<ul>
				<li>
					<p class="d-ft-l1">&nbsp;</p> KESHSA
					<p>
						<a href="four.jsp">体验中心</a><br /> <a href="four.jsp">企业介绍</a><br />
						<a href="four.jsp">企业新闻</a><br /> </a>
					</p>
				</li>
				<li>
					<p class="d-ft-l2">&nbsp;</p> APP
					<p>
						<a href="four.jsp">天眼</a><br />
				</li>
				<li>
					<p class="d-ft-l3">&nbsp;</p> 商城
					<p>
						<a href="four.jsp" target="_blank">天猫</a>
					</p>
				</li>
				<li>
					<p class="d-ft-l4">&nbsp;</p> 关于我们
					<p>
						<a href="four.jsp">总裁寄语</a><br /> <a href="four.jsp">招贤纳士</a><br />
						<a href="four.jsp">联系我们</a><br />
					</p>
				</li>
			</ul>
			<p class="weixin">
				<span class="contact-pos">联系我们 <strong>17862976307</strong>
				</span><span class="wxline"><img src="images/icon-swx.png" />
					扫码向我付款<br /> <img src="images/zfb.png" width="86" height="86"
					alt="" /></span>
			</p>
		</div>
	</div>
	<!--detail footer end-->
	<!--content end-->

	<!--footer-->
	<div
		style="width: 100%; background-color: #181818; float: left; padding: 12px 0;">
		<div
			style="width: 1190px; margin: auto; overflow: hidden; font-size: 12px; color: #fff;">
			<span style="float: left;"><a
				style="color: #fff; text-decoration: none;"
				href="index.jsp">回到首页</a>／<a
				style="color: #fff; text-decoration: none;" href="four.jsp">免责声明</a>／<a
				style="color: #fff; text-decoration: none;" href="four.jsp">友情链接</a></span><span
				style="float: right;" class="fr"> Copyright©2017-3017 KESHSA
				Inc. 保留所有权利 ICP备案号: *********</span>
		</div>
	</div>
	<script type="text/javascript">
		function gotoTop(min_height) {
			//预定义返回顶部的html代码，它的css样式默认为不显示
			var gotoTop_html = '<div id="gotoTop" style="display:none; position:fixed; right:125px; bottom:250px; cursor:pointer"><img style="width:50px; height:50px" title="回到顶部" src="http://www.vanelife.com/data/HTML/images/backtop.png" /></div>';
			//将返回顶部的html代码插入页面上id为page的元素的末尾 
			$("body").append(gotoTop_html);
			$("#gotoTop").click(//定义返回顶部点击向上滚动的动画
			function() {
				$('html,body').animate({
					scrollTop : 0
				}, 700);
			}).hover(//为返回顶部增加鼠标进入的反馈效果，用添加删除css类实现
			function() {
				$(this).addClass("hover");
			}, function() {
				$(this).removeClass("hover");
			});
			//获取页面的最小高度，无传入值则默认为600像素
			min_height ? min_height = min_height : min_height = 600;
			//为窗口的scroll事件绑定处理函数
			$(window).scroll(function() {
				//获取窗口的滚动条的垂直位置
				var s = $(window).scrollTop();
				//当窗口的滚动条的垂直位置大于页面的最小高度时，让返回顶部元素渐现，否则渐隐
				if (s > min_height) {
					$("#gotoTop").fadeIn(100);
				} else {
					$("#gotoTop").fadeOut(200);
				}
				;
			});
		};
		gotoTop();
	</script>
	<!--footer end-->
</body>
</html>