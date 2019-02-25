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
<title>露台</title>

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
			url : "state/queryBalState",
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
					if (id == 22) {

						if (data[i].state == 1) {
							var sid = "state" + id;
							$("#" + sid).attr("style", "");
							$("#" + id).addClass("gantan");
							$("#" + ncid).attr("style", "display:none");

						} else if (data[i].state == 0) {
							$("#" + id).removeClass("gantan");
							//根据控件是否拥有active来判断是否添加haveclass
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
						if (id == 23) {
							$("select").attr("disabled", "disabled");
							$("#kgpt").attr("src", "images/ltbgwg.png");
						}

					} else if (data[i].onoff == 1) {
						onoff1 = "关闭";
					}
					$("#button" + id).html(onoff1);
					if (id == 23) {
						$("select").val(data[i].light);
						switch (data[i].light) {
						case 0:
							$("#kgpt").attr("src", "images/ltbgwg.png");
							break;
						case 1:
							$("#kgpt").attr("src", "images/ltbg.png");
							break;
						case 2:
							$("#kgpt").attr("src", "images/ltbgrg.png");
							break;
						case 3:
							$("#kgpt").attr("src", "images/ltbgml.png");
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
					$("#kt" + i).addClass("gantan");
				} 
				/* if (i == 22) {
					$("#" + i).removeClass("gantan");
				} */
				getall();
			}
		});
	}
	//修改控件状态,含有额外属性
	function update(e, i) {
		//设置button的开启关闭显示
		var onoff = $("#button" + i + "").html();
		//获得灯光亮度
		var light = $("select").val();
		if (i == 23 && light == 0) {
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
				if (data.onoff == 1) {
					onoff1 = "关闭";
				} else if (data.onoff == 0) {
					onoff1 = "开启";
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
						if (i == 23) {
							$("select").val(0);
						}
					} else if (data.onoff == 1) {
						onoff1 = "关闭";
						if (i == 23) {
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
					layer.msg('控件删除成功', {
						icon : 1
					});
					$("#" + cid).attr("style", "display:none");
					$("#" + ncid).attr("style", "");
					$("#" + i).removeClass("have");
					if (i == 22) {
						$("#" + i).removeClass("gantan");
					}
				}
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
				getallstate();
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				$("#" + sid).attr("style", "display:none");
				if (i == 22) {
					$("#" + i).removeClass("gantan");
				}
				getall();
				
			}
		});
	}
</script>
</head>

<body oncontextmenu=self.event.returnValue=false >
	<!--header-->
	<jsp:include page="head.jsp">
		<jsp:param value="balcony" name="page" /></jsp:include>
	<!--header end-->
	<!--content-->

	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>露台</h1>
			<span>享受多一点阳光</span>
			<p>一个面积大小适中的露台，一杯咖啡，一米阳光，坐在摇椅上，放眼四周，在不知不觉中察觉生活原来如此美好，尽情享受智能带来的安全与舒适生活。</p>
		</div>
	</div>
	<div class="page-container">
		<div class="show-box grey clearfix" id="body">
			<!-- 露台门磁 -->
			<a class="more-info" data-next-image="images/lt-hw.png"
				style="top: 14%; left: 13%;" id="22" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">门&nbsp;&nbsp;磁</div>
				<div class="bubble southeast">
					<img src="images/lt-hw-pic.png" />

					<div id="nothave22">
						<button onclick="add(event,22)" class="btn btn-success">添加</button>
					</div>

					<div id="have22" style="display: none;">
						<div>

							<button id="button22" onclick="update1(event,22)"
								class="btn btn-info">开启</button>
							<button onclick="del(event,22)" class="btn btn-danger">删除</button>
						</div>
						<div id="state22" style="display: none;">
							<button onclick="handle(event,22)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>

				</div>
			</a>
			<!-- 露台灯 -->
			<a class="more-info dp" style="top: 14%; left: 69%;" id="23"
				onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">灯&nbsp;&nbsp;光</div>
				<div class="bubble southwest">
					<img src="images/lt-gyd-pic.png" />
					<div id="nothave23" onclick="f1(event)">
						<button onclick="add(event,23)" class="btn btn-success">添加</button>
					</div>
					<div id="have23" style="display: none;">
						<div>

							<button id="button23" class="zdybutton btn btn-info"
								onclick="update1(event,23)">开启</button>
						</div>
						<div onclick="f1(event)">
							亮度:<select id="lt" onchange="update(event,23)">
								<option value="0">无光</option>
								<option value="1">暗淡</option>
								<option value="2">柔光</option>
								<option value="3">明亮</option>
							</select>
						</div>

						<button onclick="del(event,23)" class="btn btn-danger">删除</button>
					</div>
					<div id="state23" style="display: none;">
						<button onclick="handle(event,23)" style="width: 80px"
							class="	btn btn-primary">处理</button>
					</div>
				</div>
			</a>
			<!-- 露台音乐播放器 -->
			<a class="more-info" data-next-image="images/lt-music.jpg"
				style="top: 70%; left: 70%;" id="24" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">音&nbsp;&nbsp;乐</div>
				<div class="bubble">
					<img src="images/lt-music-pic.png" />
					<div id="nothave24">
						<button onclick="add(event,24)" class="btn btn-success">添加</button>
					</div>
					<div id="have24" style="display: none;">

						<button id="button24" onclick="update1(event,24)"
							class="btn btn-info">开启</button>
						<button onclick="del(event,24)" class="btn btn-danger">删除</button>
						<div id="state24" style="display: none;">
							<button onclick="handle(event,24)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>

			<!-- 露台花洒 -->
			<a class="more-info" data-next-image="images/lt-hw.png"
				style="top: 60%; left: 20%;" id="25" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">花&nbsp;&nbsp;洒</div>
				<div class="bubble southeast">
					<img src="images/lt-hs-pic.png" />
					<div id="nothave25">
						<button onclick="add(event,25)" class="btn btn-success">添加</button>
					</div>
					<div id="have25" style="display: none;">

						<button id="button25" onclick="update1(event,25)"
							class="btn btn-info">开启</button>
						<button onclick="del(event,25)" class="btn btn-danger">删除</button>
						<div id="state25" style="display: none;">
							<button onclick="handle(event,25)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>
			<div class="overlay" id="loaded"></div>
			<div class="background-image">
				<img src="images/lt-hw.png" style="width: 100%;" id="kgpt" />
			</div>
		</div>
	</div>

	<script charset="UTF-8" src="js/jquery-2.2.4.min.js"></script>
	<script charset="UTF-8" src="js/2.js"></script>
	<script type="text/javascript">
		//$("#loaded").hide(); 
		var benefits = false;
		$(function() {
			$.preload([ 'images/lt-hw.png', 'images/lt-music.jpg',
					'images/lt-gyd.png' ]);
		});
	</script>

	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>