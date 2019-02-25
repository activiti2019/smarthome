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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>厨房</title>


<script charset="UTF-8" src="js/jquery-2.2.4.min.js"
	type="text/javascript"></script>
<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">



<script charset="UTF-8" src="js/jquery-2.2.4.min.js"
	type="text/javascript"></script>

<script src="layer/layer.js" type="text/javascript"></script>

<style type="text/css">
.bbb {
	transition-delay: 0.5s;
	-moz-transition-delay: 0.5s; /* Firefox 4 */
	-webkit-transition-delay: 0.5s; /* Safari 和 Chrome */
	-o-transition-delay: 0.5s; /* Opera */
	transition-duration: 2s;
}
</style>
<script type="text/javascript">
	$(function() {
		document.getElementById("loaded").style.display = "none";
		var lo = document.getElementById("loaded");
		lo.parentNode.removeChild(lo);
		//getall()方法在页面加载的时候就执行
		getall();

		//点击按钮之后，首先进行按钮状态的判断，如果当前class拥有have 则删除have，进入红色X状态，然后没有have，则异步刷新
		$(".more-info").click(function() {
			if ($(".more-info").hasClass("have")) {
				$(".more-info").removeClass("have");
			} else {
				getall();
			}

		});

	});

	function getall() {

		$.ajax({
			url : "state/queryKitState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				for ( var i in data) {
					//获取已安装的控件id,
					var id = data[i].cnId;
					//使用字符串拼接精确样式
					var cid = "have" + id;
					var ncid = "nothave" + id;
					//根据此id调控后续操作范围
					$("#" + cid).attr("style", "");
					$("#" + ncid).attr("style", "display:none;");
					if (id == 17 || id == 16) {
						if (data[i].state == 1) {
							//添加感叹号
							var sid = "state" + id;
							$("#" + sid).attr("style", "");
							$("#" + id).addClass("gantan");
							$("#" + ncid).attr("style", "display:none");
						} else if (data[i].state == 0) {
							$("#" + id).removeClass("gantan");
							//根据控件是否存在更改按钮样式图片
							if (!$("#" + id).hasClass("active")) {
								$("#" + id).addClass("have");
							}
						}
					} else {
						//根据控件是否存在更改按钮样式图片
						if (!$("#" + id).hasClass("active")) {
							$("#" + id).addClass("have");
						}
					}

					var onoff1 = null;
					if (data[i].onoff == 0) {
						onoff1 = "开启";
						if (id == 18) {
							$("#kgpt").attr("src", "images/cfbgwg.png");
							$("select").attr("disabled", "disabled");
						}
					} else if (data[i].onoff == 1) {
						onoff1 = "关闭";
					}
					$("#button" + id).html(onoff1);
					if (id == 18) {
						$("select").val(data[i].light);
						switch (data[i].light) {
						case 0:
							$("#kgpt").attr("src", "images/cfbgwg.png");
							break;
						case 1:
							$("#kgpt").attr("src", "images/cfbg.png");
							break;
						case 2:
							$("#kgpt").attr("src", "images/cfbgrg.png");
							break;
						case 3:
							$("#kgpt").attr("src", "images/cfbgml.png");

							break;

						default:
							break;
						}
					}

				}
			}
		});


	}

	function f1(e) {
		//取消冒泡 取消子元素对父元素的继承
		e.cancelBubble = true;
	}

	//控制电热水器的开关,并且调控温度为默认值
	function f3(e, i) {
		//设置button的开启关闭显示
		var state = $("#button" + i + "").html();
		if (state == "开启") {
			$("#button" + i + "").html("关闭");
			$("select").val(1);
		}
		if (state == "关闭") {
			$("#button" + i + "").html("开启");
			$("select").val(0);
		}
		//取消冒泡 取消子元素对父元素的继承
		e.cancelBubble = true;
	}

	//添加方法
	function add(e, i) {
		e.cancelBubble = true;
		$.ajax({
			url : "state/addState",
			type : "POST",
			data : {
				"cnId" : i
			},
			dataType : "json",
			success : function(data) {
				var cid = "have" + i;
				var ncid = "nothave" + i;
				layer.msg('控件添加成功', {icon: 1});
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				if(data.state==1){
					$("#" + i).addClass("gantan");
				}
				/* if (i == 17 || i == 16) {
					$("#" + i).removeClass("gantan");
				} */
				getall();
			}
		});
	}
	//修改状态
	function update(e, i) {
		//设置button的开启关闭显示
		var onoff = $("#button" + i + "").html();
		//获得灯光亮度
		var light = $("select").val();
		if (i == 18 && light == 0) {
			onoff = "开启";
		}
		$.ajax({
			url : "state/modState",
			type : "POST",
			data : {
				"action" : "modState",
				"cnId" : i,
				"onoff" : onoff,
				"light" : light
			},
			dataType : "json",
			success : function(data) {
				var onoff1 = null;
				if (data.onoff == 0) {
					onoff1 = "开启";
				} else if (data.onoff == 1) {
					onoff1 = "关闭";
				}
				layer.msg('控件修改成功', {icon: 1});
				$("#button" + i).html(onoff1);
				$("select").val(data.light);
			}
		});
		getall();
		e.cancelBubble = true;
	}
	//对开关属性进行处理
	function update1(e, i) {
		if ($("#" + i).hasClass("gantan")) {
			layer.msg('控件异常，无法操作', function() {

			});
		} else {
			//设置button的开启关闭显示
			var onoff = $("#button" + i + "").html();
			$.ajax({
				url : "state/modState",
				type : "POST",
				data : {
					"action" : "modAction",
					"cnId" : i,
					"onoff" : onoff
				},
				dataType : "json",
				success : function(data) {
					var onoff1 = null;
					if (data.onoff == 0) {
						onoff1 = "开启";
						if (i == 18) {
							$("select").val(0);
						}

					} else if (data.onoff == 1) {
						onoff1 = "关闭";
						if (i == 18) {
							$("select").val(1);
						}
					}
					if (onoff1 == "开启") {
						layer.msg('关闭成功');
					} else if (onoff1 == "关闭") {
						layer.msg('开启成功');
					}
					$("#button" + i).html(onoff1);
				}
			});
		}
		e.cancelBubble = true;
	}
	//删除控件
	function del(e, i) {
		layer.confirm('确定要删除吗？', {
			btn : [ '是的', '算了' ]
		//按钮
		}, function() {
			e.cancelBubble = true;
			$.ajax({
				url : "state/delState",
				type : "POST",
				data : {
					"cnId" : i
				},
				dataType : "json",
				success : function(data) {
					var cid = "have" + i;
					var ncid = "nothave" + i;
					$("#" + cid).attr("style", "display:none");
					$("#" + ncid).attr("style", "");
					$("#" + i).removeClass("have");
					if (i == 17 || i == 16) {
						$("#" + i).removeClass("gantan");
					}
					getall();
				}
			});
			layer.msg('控件删除成功', {
				icon : 1
			});
		}, function() {
			layer.msg('明智的选择', {
				icon : 1
			});
		});


	}
	//处理控件
	function handle(e, i) {
		e.cancelBubble = true;
		$.ajax({
			url : "state/modState",
			type : "POST",
			data : {
				"action" : "handleException",
				"cnId" : i
			},
			dataType : "json",
			success : function(data) {
				var cid = "have" + i;
				var ncid = "nothave" + i;
				var sid = "state" + i;
				layer.msg('异常处理成功', {icon: 1});
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				$("#" + sid).attr("style", "display:none");
				if (i == 17 || i == 16) {
					$("#" + i).removeClass("gantan");
				}
				getall();
				getallstate();
			}
		});
	}
</script>
</head>

<body oncontextmenu=self.event.returnValue=false >
	<!--header-->
	<jsp:include page="head.jsp"><jsp:param value="kitchen"
			name="page" /></jsp:include>
	<!--header end-->

	<!--content-->

	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>厨房</h1>
			<span>将美味和想念留在厨房</span>
			<p>无论多么忙碌，那些用来煮咖啡、做蛋糕、下厨招待朋友的时光却不曾减少。您可像品味美食一般尽情享受与朋友的相聚时刻。</p>
		</div>
	</div>
	<div class="page-container">

		<div class="show-box grey clearfix" id="body">
			<!--厨房灯开关  -->
			<a class="more-info dp" style="top: 39%; left: 34%;" id="18"
				onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">灯&nbsp;&nbsp;光</div>
				<div class="bubble northwest">
					<img src="images/kt-kg-pic.png" />
					<div id="nothave18" onclick="f1(event)">
						<button onclick="add(event,18)" class="btn btn-success">添加</button>
					</div>
					<div id="have18" style="display: none;">
						<div>

							<button id="button18" class="zdybutton btn btn-info"
								onclick="update1(event,18)">开启</button>
						</div>
						<div onclick="f1(event)">
							亮度:<select id="cf" onchange="update(event,18)">
								<option value="0">无光</option>
								<option value="1">暗淡</option>
								<option value="2">柔光</option>
								<option value="3">明亮</option>
							</select>
						</div>

						<button onclick="del(event,18)" class="btn btn-danger">删除</button>
						<div id="state18" style="display: none;">
							<button onclick="handle(event,18)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>

			</a>
			<!-- 厨房窗磁 -->
			<a class="more-info" data-next-image="images/cf-2.png"
				style="top: 30%; left: 50%;" id="17" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">窗&nbsp;&nbsp;磁</div>
				<div class="bubble northwest">
					<img src="images/cc-pic.png" />

					<div id="nothave17">
						<button onclick="add(event,17)" class="btn btn-success">添加</button>
					</div>
					<div id="have17" style="display: none;">

						<div>

							<button id="button17" onclick="update1(event,17)"
								class="btn btn-info">开启</button>
							<button onclick="del(event,17)" class="btn btn-danger">删除</button>
						</div>
						<div id="state17" style="display: none;">
							<button onclick="handle(event,17)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>

				</div>
			</a>
			<!-- 厨房气感-->
			<a class="more-info" data-next-image="images/cfbg.png"
				style="top: 55%; left: 85%;" id="16" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">气&nbsp;&nbsp;感</div>
				<div class="bubble southwest">
					<img src="images/cf-qg.png" />
					<div id="nothave16">
						<button onclick="add(event,16)" class="btn btn-success">添加</button>
					</div>
					<div id="have16" style="display: none;">
						<div>

							<button id="button16" onclick="update1(event,16)"
								class="btn btn-info">开启</button>
							<button onclick="del(event,16)" class="btn btn-danger">删除</button>
						</div>
						<div id="state16" style="display: none;">
							<button onclick="handle(event,16)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>

				</div>

			</a>

			<div class="overlay" id="loaded"></div>
			<div class="background-image">
				<img src="images/cfbg.png" style="width: 100%;" id="kgpt" />
			</div>
		</div>
	</div>

	<script charset="UTF-8" src="js/jquery-2.2.4.min.js"></script>
	<script charset="UTF-8" src="js/2.js"></script>
	<script type="text/javascript">
		//$("#loaded").hide(); 
		var benefits = false;
		$(function() {
			$
					.preload([ 'images/cf-1.png', 'images/cf-2.png',
							'images/cf-3.png' ]);
		});
	</script>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>