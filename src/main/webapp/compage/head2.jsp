<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="layer/layer.js" type="text/javascript"></script>
<title>用户中心的头文件</title>
<script type="text/javascript">
	function logout() {
		layer.confirm('确定要退出吗？', {
			btn : [ '是的', '算了' ],
			offset : [ '320px', '600px' ]
		//按钮
		}, function() {
			$.ajax({
				url : "user/userLogout",
				type : "POST",

				data : {},
				dataType : "json",
				success : function(data) {
					if (data.res == 1) {
						layer.msg('成功退出登录', {
							icon : 1
						});
						window.location.replace("index.jsp");
					} else {
						alert("退出登录失败");
						$(".text-warning").text(data.info);
						$("input[name='username']").val("");
						$("input[name='password']").val("");
					}
				}
			});
		}, function() {
			layer.msg('明智的选择', {
				icon : 1
			});
		});

	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false>
	<!-- header  -->
	<div class="nav_menu">
		<div class="nav">
			<a href="./compage/homepage.jsp" class="logo"><img
				src="images/logo.png" width="220" height="70" alt="" /></a>

			<div class="list" id="navlist">

				<ul style="float: right;">
					<div class="welcome">欢迎，${currentuser.uName }使用本系统</div>
					<li class="dropdown"><a
						style="text-decoration: none; float: left; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px; background-color: #000000;"
						href="./compage/userback.jsp">用户中心 </a></li>
					<li class="dropdown"><a
						style="text-decoration: none; float: left; display: block; text-align: center; line-height: 36px; color: #fff; padding: 17px 30px; cursor: pointer; font-size: 25px; background-color: #000000;"
						href="javascript:logout()">退出系统 </a></li>
				</ul>
			</div>
			<div class="sec-bl" id="navbox">
				<div class="cont">
					<div class="sec">
						<ul>
							<li></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- header end -->
</body>
</html>