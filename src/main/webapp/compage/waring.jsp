<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>
<body oncontextmenu=self.event.returnValue=false >

<style>
.diyType {
	border: 1px solid #CCD3DD;
	border-right: 2px solid #CCD3DD;
	border-bottom: 2px solid #CCD3DD;
	line-height: 21px;
	position: absolute;
	height: auto;
	width: 470px;
	margin-left: 240px;
	*margin-left: -100px;
	margin-top: 0px;
	*margin-top: 24px;
	background-color: #FF0000;
	padding-left: 21px;
	font-weight: bold;
}
</style>

	<div id="diyType1" class="diyType" onmouseout="show()">
		卧室的窗磁出现了异常！！！<br /> 客厅的空调出现了异常！！！
	</div>




	<script>
		function show() {
			setTimeout(function test() {
				document.getElementById("diyType1").style.display = "none";

			}, 1000);
		}
		setTimeout(function test() {
			document.getElementById("diyType1").style.display = "none";

		}, 5000);
	</script>
</body>
</html>