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
<title>客厅</title>
<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">

<script src="js/drag.min.js" type="text/javascript"></script>
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

.diyType {
	border: 0px solid #CCD3DD;
	border-right: 0px solid #CCD3DD;
	border-bottom: 0px solid #CCD3DD;
	line-height: 21px;
	position: absolute;
	height: auto;
	width: 155px;
	margin-left: 0px;
	*margin-left: -100px;
	margin-top: 0px;
	*margin-top: 24px;
	background-color: #FF3030;
	padding-left: 21px;
	font-weight: bold;
}

.camera {
	bottom: 10px;
	right: 10px;
	position: fixed;
	z-index: 9999;;
	border-radius: 10px;
}
</style>
<script type="text/javascript">
	$(function() {
		document.getElementById("loaded").style.display = "none";
		var lo = document.getElementById("loaded");
		lo.parentNode.removeChild(lo);
		//getall()方法在页面加载的时候就执行
		getall();
		getallError();

		//点击按钮之后，首先进行按钮状态的判断，如果当前class拥有have 则删除have，进入红色X状态，然后没有have，则异步刷新
		$(".more-info").click(function() {
			if ($(".more-info").hasClass("have")) {
				$(".more-info").removeClass("have");
			} else {
				getall();
			}
		});
		//模拟用户点击按钮
		$("#gg").trigger("click");

	});

	function getallError() {
		$.ajax({
			url : "state/queryStateName",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				for ( var i in data) {
					$("#diyType1").append(data[i] + "有异常<br/>");
				}
			}
		});
	}
	//刷新界面时调用此方法:
	//对该场景的数据库数据进行读取并填入
	function getall() {
		$.ajax({
			url : "state/queryParState",
			type : "POST",
			data : {},
			dataType : "json",
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					var id = data[i].cnId;
					var cid = "have" + id;
					var ncid = "nothave" + id;
					$("#" + cid).attr("style", "");
					$("#" + ncid).attr("style", "display:none;");
					if (id == 2 || id == 7 || id == 8) {
						if (data[i].state == 1) {
							//添加感叹号
							var sid = "state" + id;
							$("#" + sid).attr("style", "");
							$("#kt" + id).addClass("gantan");
							$("#" + ncid).attr("style", "display:none");
						} else if (data[i].state == 0) {
							$("#kt" + id).removeClass("gantan");
							//根据控件是否存在更改按钮样式图片
							if (!$("#kt" + id).hasClass("active")) {
								$("#kt" + id).addClass("have");
							}
						}
					} else {
						//根据控件是否存在更改按钮样式图片
						if (!$("#kt" + id).hasClass("active")) {
							$("#kt" + id).addClass("have");
						}
					}
					var onoff1 = null;
					if (data[i].onoff == 0) {
						onoff1 = "开启";
						if (id == 7) {
							$("#camera").attr("style", "display:none");
						}
						if (id == 4) {
							$("#tem").val("0");
						} else if (id == 1) {
							$("select").attr("disabled", "disabled");
							$("#kgpt").attr("src", "images/ktbgwg.png");

						}

					} else if (data[i].onoff == 1) {
						if (id == 7) {
							$("#camera").attr("style", "");
						}
						onoff1 = "关闭";
						if (id == 4) {
							$("#tem").val(data[i].temperature);
						} else if (id == 1) {
							$("select").val(data[i].light);
							switch (data[i].light) {
							case 0:
								$("#kgpt").attr("src", "images/ktbgwg.png");
								break;
							case 1:
								$("#kgpt").attr("src", "images/ktbg.jpg");
								break;
							case 2:
								$("#kgpt").attr("src", "images/ktbgrg.png");
								break;
							case 3:
								$("#kgpt").attr("src", "images/ktbgml.png");

								break;

							default:
								break;
							}

						}
					}
					$("#button" + id).html(onoff1);
				}
				if ($("#button3").html() == "关闭") {
					var gtv = $("#kt").val();

					switch (gtv) {
					case '0':
						$("#kgpt").attr("src", "images/ktbgwg-video.png");
						break;
					case '1':
						$("#kgpt").attr("src", "images/ktbg-video.png");
						break;
					case '2':
						$("#kgpt").attr("src", "images/ktbgrg-video.png");
						break;
					case '3':
						$("#kgpt").attr("src", "images/ktbgml-video.png");

						break;

					default:
						break;
					}
				}
			}

		});

		//添加感叹号
		//	$("#27").addClass("gantan");

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
					$("#kt" + i).addClass("gantan");
				}
				/* if (i == 2 || i == 7 || i == 8) {
					$("#kt" + i).removeClass("gantan");
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
		//获取空调的温度
		var tem = $("#tem").val();
		var tm = /^\d*(\.(5|0))?$/;
		//var tm = /^([1-3][0-9])|([1-3]+\.[5])$/;
		if (onoff == "关闭") {
			if(i==4){
			if (tem >= 32.5 || tem <= 15.5 || !tm.test(tem)) {
				layer.msg('空调温度异常', function() {});
			}else{
				if (i == 4 && tem == 0) {
					onoff = "开启";
				}
				if (i == 1 && light == 0) {
					onoff = "开启";
				}
				$.ajax({
					url : "state/modState",
					type : "POST",
					data : {
						"action" : "modState",
						"cnId" : i,
						"onoff" : onoff,
						"light" : light,
						"tem" : tem
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
						$("#tem").val(data.temperature);
					}
				});
			}
			} else {
				if (i == 4 && tem == 0) {
					onoff = "开启";
				}
				if (i == 1 && light == 0) {
					onoff = "开启";
				}
				$.ajax({
					url : "state/modState",
					type : "POST",
					data : {
						"action" : "modState",
						"cnId" : i,
						"onoff" : onoff,
						"light" : light,
						"tem" : tem
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
						$("#tem").val(data.temperature);
					}
				});
			}
		}
		getall();
		e.cancelBubble = true;

	}
	//修改状态
	function update1(e, i) {
		//设置button的开启关闭显示
		if ($("#kt" + i).hasClass("gantan")) {

			layer.msg('控件异常，无法操作', function() {

			});
		} else {
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
						if (i == 4) {
							$("#tem").val("0");
						}
						if (i == 1) {
							$("select").val(0);
							$("#kgpt").attr("src", "images/ktbgwg.png");
						}
						if (i == 7) {
							$("#camera").attr("style", "display:none");
						}
					} else if (data.onoff == 1) {
						onoff1 = "关闭";
						if (i == 4) {
							$("#tem").val("26");
						}
						if (i == 1) {
							$("select").val(1);
							$("#kgpt").attr("src", "images/ktbg.jpg");
						}
						if (i == 7) {
							$("#camera").attr("style", "");
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
					$("#kt" + i).removeClass("have");
					if (i == 2 || i == 7 || i == 8) {
						$("#kt" + i).removeClass("gantan");
						if (i == 7) {
							$("#camera").attr("style", "display:none");
						}
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
				
				layer.msg('异常处理成功!', {icon: 6});
				getallstate();
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				$("#" + sid).attr("style", "display:none");
				if (i == 2 || i == 7 || i == 8) {
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
	<div style="width: 100%;">
		<jsp:include page="head.jsp"><jsp:param value="parlour"
				name="page" /></jsp:include>
		<!--header end-->
	</div>

	<div id="diyType1" class="diyType"
		style="top: 17%; position: fixed; z-index: 9999; float: left; border-radius: 10px; opacity: 0.8;">
	</div>
	<!--content-->

	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>客厅</h1>
			<span>缔造难忘回忆</span>
			<p>休闲的时候，约上三五好友，欣赏最新的3D大片，客厅立即变成影音室，窗帘会自动关闭，灯光、电视、音响溶于一体，准备好纸巾，彻底投入剧情。</p>
		</div>
	</div>
	<button type="button" data-toggle="modal" data-target="#replymodal"
		id="gg" style="display: none;"></button>
	<button id="ggg" style="display: none;"></button>
	<div class="page-container">
		<div class="show-box grey clearfix" id="body">
			<!-- 客厅灯开关 -->
			<a class="more-info dp" id="kt1" data-next-image="images/kt-kg.jpg"
				onclick="getall()" style="top: 29%; left: 29%;">
				<div class="xuanfu"
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">灯&nbsp;&nbsp;光</div>
				<div class="bubble southeast">
					<img src="images/kt-kg-pic.png" />
					<div id="nothave1" onclick="f1(event)">
						<button onclick="add(event,1)" class="btn btn-success">添加</button>
					</div>
					<div id="have1" style="display: none;">
						<div>

							<button class="zdybutton btn btn-info" id="button1"
								onclick="update1(event,1)">开启</button>
						</div>
						<div onclick="f1(event)">
							亮度:<select id="kt" style="size: 20px;" onchange="update(event,1)">
								<option value="0">无光</option>
								<option value="1">暗淡</option>
								<option value="2">柔光</option>
								<option value="3">明亮</option>
							</select>
						</div>

						<button onclick="del(event,1)" class="btn btn-danger">删除</button>
						<div id="state1" style="display: none;">
							<button onclick="handle(event,1)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>

			</a>
			<!-- 客厅摄像头 -->
			<a class="more-info" data-next-image="images/kt-mc.jpg"
				style="top: 90%; left: 41%;" id="kt7" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">摄&nbsp;&nbsp;像</div>

				<div class="bubble northwest">
					<img src="images/kt-mc-pic.png" />
					<div id="nothave7">
						<button onclick="add(event,7)" class="btn btn-success">添加</button>
					</div>
					<div id="have7" style="display: none;">
						<button class="btn btn-info" id="button7"
							onclick="update1(event,7)">开启</button>
						<button onclick="del(event,7)" class="btn btn-danger">删除</button>
						<div id="state7" style="display: none;">
							<button onclick="handle(event,7)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>

				</div>
				<div class="bubble" style="bottom: 350px; left: -100px;">
					<img src="images/kt-mc2-pic.png" />
				</div>
				<div class="bubble" style="bottom: 350px; left: -100px;">
					<img src="images/kt-mc2-pic.png" />
				</div>
			</a>
			<!-- 客厅空调 -->
			<a class="more-info" data-next-image="images/ktbg.jpg"
				style="top: 30%; left: 50%;" id="kt4" onclick="getall()">
				<div class="xuanfu"
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">空&nbsp;&nbsp;调</div>
				<div class="bubble southwest">
					<img src="images/kt-kongtiao.png" />
					<div id="nothave4" onclick="add(event,4)">
						<button class="btn btn-success">添加</button>
					</div>
					<div id="have4" style="display: none;">
						<div>

							<button id="button4" class="btn btn-info"
								onclick="update1(event,4)">开启</button>
						</div>
						<div>
							温度：<input style="width: 45px;" type="number" step="0.5"
								name="tem" id="tem" value="0" onclick="f1(event)"
								onfocus="layer.tips('16≤ 温度范围≤ 32', '#tem',{tips: [2, '#3595CC'],time: 4000});">度
						</div>
						<div>
							<div>
								<button onclick="update(event,4)" class="	btn btn-success">修改</button>
								&nbsp;&nbsp;
								<button onclick="del(event,4)" class="btn btn-danger">删除</button>
							</div>

						</div>
						<div id="state4" style="display: none;">
							<button onclick="handle(event,4)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>

			</a>
			<!-- 客厅加湿器 -->
			<a class="more-info" data-next-image="images/kt-gyq.jpg"
				style="top: 71%; left: 56%;" id="kt6" onclick="getall()">
				<div class="xuanfu"
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">加&nbsp;湿</div>
				<div class="bubble northwest">
					<img src="images/kt-gyq-pic.png" />
					<div id="nothave6">
						<button onclick="add(event,6)" class="btn btn-success">添加</button>
					</div>
					<div id="have6" style="display: none;">

						<button id="button6" class="btn btn-info"
							onclick="update1(event,6)">开启</button>
						<button onclick="del(event,6)" class="btn btn-danger">删除</button>
						<div id="state6" style="display: none;">
							<button onclick="handle(event,6)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>
			<!-- 客厅烟感 -->
			<a class="more-info" data-next-image="images/kt-gyq.jpg"
				style="top: 3%; left: 40%;" id="kt8" onclick="getall()">
				<div class="xuanfu"
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">烟&nbsp;&nbsp;感</div>
				<div class="bubble southwest">
					<img src="images/yangan.png" />
					<div id="nothave8">
						<button onclick="add(event,8)" class="btn btn-success">添加</button>
					</div>
					<div id="have8" style="display: none;">

						<button id="button8" class="btn btn-info"
							onclick="update1(event,8)">开启</button>
						<button onclick="del(event,8)" class="btn btn-danger">删除</button>
						<div id="state8" style="display: none;">
							<button onclick="handle(event,8)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>
			<!-- 客厅门磁 -->
			<a class="more-info" data-next-image="images/kt-mc.jpg"
				style="top: 20%; left: 63%;" id="kt2" onclick="getall()">
				<div class="xuanfu"
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">门&nbsp;&nbsp;磁</div>
				<div class="bubble southwest">
					<img src="images/kt-mc2-pic.png" />
					<div id="nothave2">
						<button onclick="add(event,2)" class="btn btn-success">添加</button>
					</div>
					<div id="have2" style="display: none;">

						<button id="button2" class="btn btn-info"
							onclick="update1(event,2)">开启</button>
						<button onclick="del(event,2)" class="btn btn-danger">删除</button>
						<div id="state2" style="display: none;">
							<button onclick="handle(event,2)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
				<div class="bubble" style="bottom: -240px; left: -680px;">
					<img src="images/kt-mc-pic.png" />
				</div>
			</a>
			<!-- 客厅影音 -->
			<a class="more-info dp" style="top: 24%; left: 69%;" id="kt3"
				onclick="getall()">
				<div class="xuanfu"
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">影&nbsp;&nbsp;音</div>
				<div class="bubble southwest">

					<img src="images/kt-zncj-pic.png" />
					<div id="nothave3">
						<button onclick="add(event,3)" class="btn btn-success">添加</button>
					</div>
					<div id="have3" style="display: none;">

						<button id="button3" class="btn btn-info"
							onclick="update1(event,3)">开启</button>
						<button onclick="del(event,3)" class="btn btn-danger">删除</button>
						<div id="state3" style="display: none;">
							<button onclick="handle(event,3)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>

			<div class="overlay" id="loaded"></div>
			<div class="background-image">
				<img id="kgpt" src="images/ktbg.jpg" style="width: 100%;" />
			</div>
		</div>
	</div>
	<div id="camera" class="camera" style="display: none;"><jsp:include
			page="camera.jsp"></jsp:include></div>



	<script charset="UTF-8" src="js/jquery-2.2.4.min.js"></script>
	<script charset="UTF-8" src="js/2.js"></script>
	<script type="text/javascript">
		var benefits = false;
		$(function() {
			$.preload([ 'images/kt-fj.jpg', 'images/kt-kg.jpg',
					'images/kt-mc.jpg', 'images/kt-gyq.jpg',
					'images/kt-zncj.jpg' ]);

		});
		$(".diyType").on("mouseout", function() {
			$(".diyType").fadeOut(3000);

		});
		$(".diyType").on("mouseenter", function() {
			$(".diyType").stop();
			$(".diyType").fadeIn(500);

		});
		var oBox = document.getElementById("camera");
		var oBar = document.getElementById("camera");
		startDrag(oBar, oBox);
	</script>
	<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>