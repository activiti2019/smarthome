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
<title>餐厅</title>



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
				getall();
			} else {
				getall();
			}

		});

	});
	function getall() {

		$.ajax({
			url : "state/queryDinState",
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
					if (id == 20) {
						if (data[i].state == 1) {
							var sid = "state" + id;
							//添加感叹号
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
						if (id == 19) {
							$("#kgpt").attr("src", "images/ctbgwg.png");
							$("select").attr("disabled", "disabled");
						}

					} else if (data[i].onoff == 1) {
						onoff1 = "关闭";
					}
					$("#button" + id).html(onoff1);
					if (id == 19) {
						$("select").val(data[i].light);

						switch (data[i].light) {
						case 0:
							$("#kgpt").attr("src", "images/ctbgwg.png");
							break;
						case 1:
							$("#kgpt").attr("src", "images/ctbg.png");
							break;
						case 2:
							$("#kgpt").attr("src", "images/ctbgrg.png");
							break;
						case 3:
							$("#kgpt").attr("src", "images/ctbgml.png");

							break;

						default:
							break;
						}
					}

				}
			}
		});

		//设置style显示
		//$("#have27").attr("style", "");

		//设置style隐藏
		//$("#have27").attr("style", "display:none;");

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
				/* if (i == 20) {
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
		if (i == 19 && light == 0) {
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
						if (i == 19) {
							$("select").val(0);
						}
					} else if (data.onoff == 1) {
						onoff1 = "关闭";
						if (i == 19) {
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
			//$("#27").removeClass("gantan");
		}
		//添加感叹号
		//$("#27").addClass("gantan");

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
					$("#" + ncid).attr("style", "");
					$("#" + cid).attr("style", "display:none");
					$("#" + i).removeClass("have");
					if (i == 20) {
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
				getallstate();
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				$("#" + sid).attr("style", "display:none");
				if (i == 20) {
					$("#" + i).removeClass("gantan");
				}
				getall();
				
			}
		});
	}
</script>
</head>

<body oncontextmenu=self.event.returnValue=false>
	<!--header-->
	<jsp:include page="head.jsp"><jsp:param value="diningroom"
			name="page" /></jsp:include>
	<!--header end-->
	<!--content-->

	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>餐厅</h1>
			<span>享不完的美味，讲不完的故事</span>
			<p>品一杯浓郁醇厚的咖啡，把大家聚集在餐桌旁就是这样简单。灯光温馨，美妙的背景音乐，窗户自动打开，和煦的微风吹进，每个人都愿意多坐一会儿。</p>
		</div>
	</div>
	<div class="page-container">

		<div class="show-box grey clearfix" id="body">

			<!-- 餐厅灯开关 -->
			<a class="more-info dp" style="top: 20%; left: 23%;" id="19"
				onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">灯&nbsp;&nbsp;光</div>
				<div class="bubble southeast">
					<img src="images/ct-znmb-pic.png" />
					<div id="nothave19" onclick="f1(event)">
						<button onclick="add(event,19)" class="btn btn-success">添加</button>
					</div>
					<div id="have19" style="display: none;">
						<div>

							<button id="button19" class="zdybutton btn btn-info"
								onclick="update1(event,19)">开启</button>
						</div>
						<div onclick="f1(event)">
							亮度:<select id="ct" onchange="update(event,19)">
								<option value="0">无光</option>
								<option value="1">暗淡</option>
								<option value="2">柔光</option>
								<option value="3">明亮</option>
							</select>
						</div>

						<button onclick="del(event,19)" class="btn btn-danger">删除</button>
						<div id="state19" style="display: none;">
							<button class="	btn btn-primary" onclick="handle(event,19)"
								style="width: 80px">处理</button>
						</div>
					</div>
				</div>
			</a>
			<!-- 餐厅烟感 -->
			<a class="more-info" data-next-image="images/ct-znmb.png"
				style="top: 4%; left: 50%;" id="20" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">烟&nbsp;&nbsp;感</div>
				<div class="bubble southeast">
					<img src="images/yangan.png" />

					<div id="nothave20">
						<button onclick="add(event,20)" class="btn btn-success">添加</button>
					</div>
					<div id="have20" style="display: none;">
						<div>

							<button id="button20" class="btn btn-info"
								onclick="update1(event,20)">开启</button>
							<button onclick="del(event,20)" class="btn btn-danger">删除</button>
						</div>
						<div id="state20" style="display: none;">
							<button onclick="handle(event,20)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>

				</div>
			</a>
			<!-- 餐厅音乐播放器 -->
			<a class="more-info" data-next-image="images/ct-music.png"
				style="top: 67%; left: 73%;" id="21" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">音&nbsp;&nbsp;乐</div>
				<div class="bubble northwest">
					<img src="images/ct-music-pic.png" />
					<div id="nothave21">
						<button onclick="add(event,21)" class="btn btn-success">添加</button>
					</div>
					<div id="have21" style="display: none;">

						<button id="button21" onclick="update1(event,21)"
							class="btn btn-info">开启</button>
						<button onclick="del(event,21)" class="btn btn-danger">删除</button>
						<div id="state21" style="display: none;">
							<button onclick="handle(event,21)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>



			<div class="overlay" id="loaded"></div>
			<div class="background-image">
				<img src="images/ctbg.png" style="width: 100%;" id="kgpt" />
			</div>
		</div>
	</div>

	<script charset="UTF-8" src="js/jquery-2.2.4.min.js"></script>
	<script charset="UTF-8" src="js/2.js"></script>
	<script type="text/javascript">
		//$("#loaded").hide(); 
		var benefits = false;
		$(function() {
			$.preload([ 'images/ct-znmb.png', 'images/ct-music.png' ]);
		});
	</script>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>