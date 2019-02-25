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
<title>卧室</title>



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

	//刷新界面时调用此方法:
	//对该场景的数据库数据进行读取并填入

	function getall() {
		$.ajax({
			url : "state/queryBedState",
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
					if (id == 10 || id == 13 || id == 15) {
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
						if (id == 29) {
							$("#tem").val("0");
						} else if (id == 14) {
							$("#kgpt").attr("src", "images/wsbgwg.png");
							$("select").attr("disabled", "disabled");

						}

					} else if (data[i].onoff == 1) {
						onoff1 = "关闭";
						if (id == 29) {
							$("#tem").val(data[i].temperature);
						} else if (id == 14) {
							$("select").val(data[i].light);
							switch (data[i].light) {
							case 0:
								$("#kgpt").attr("src", "images/wsbgwg.png");
								break;
							case 1:
								$("#kgpt").attr("src", "images/wsbg.png");
								break;
							case 2:
								$("#kgpt").attr("src", "images/wsbgrg.png");
								break;
							case 3:
								$("#kgpt").attr("src", "images/wsbgml.png");

								break;

							default:
								break;
							}
						}

					}

					$("#button" + id).html(onoff1);

				}
				//窗帘关闭状态
				if ($("#button9").html() == "开启") {
					var gtv = $("#ws").val();

					switch (gtv) {
					case '0':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/ws-kcq-wg-tv.png");
						} else {
							$("#kgpt").attr("src", "images/ws-kcq-wg.png");
						}
						break;
					case '1':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/ws-kcq-ad-tv.png");
						} else {
							$("#kgpt").attr("src", "images/ws-kcq-ad.png");
						}
						break;
					case '2':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/ws-kcq-rg-tv.png");
						} else {
							$("#kgpt").attr("src", "images/ws-kcq-rg.png");
						}
						break;
					case '3':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/ws-kcq-ml-tv.png");
						} else {
							$("#kgpt").attr("src", "images/ws-kcq-ml.png");
						}

						break;

					default:
						break;
					}
				}
				//窗帘处于开启状态
				if ($("#button9").html() == "关闭") {
					var gtv = $("#ws").val();

					switch (gtv) {
					case '0':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/wsbgwg-tv.png");
						} else {
							$("#kgpt").attr("src", "images/wsbgwg.png");
						}
						break;
					case '1':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/wsbg-tv.png");
						} else {
							$("#kgpt").attr("src", "images/wsbg.png");
						}
						break;
					case '2':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/wsbgrg-tv.png");
						} else {
							$("#kgpt").attr("src", "images/wsbgrg.png");
						}
						break;
					case '3':
						if ($("#button11").html() == "关闭") {
							$("#kgpt").attr("src", "images/wsbgml-tv.png");
						} else {
							$("#kgpt").attr("src", "images/wsbgml.png");
						}

						break;

					default:
						break;
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
				layer.msg('控件添加成功', {
					icon : 1
				});
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				if (data.state == 1) {
					$("#" + i).addClass("gantan");
				}
				/*if (i == 10 || i == 13 || i == 15) {
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

		//获取热水器的温度
		var tem = $("#tem").val();
		var tm = /^\d*(\.(5|0))?$/;
		if (onoff == "关闭") {
			if (i == 29) {
				if (tem >= 32.5 || tem <= 15.5 || !tm.test(tem)) {
					layer.msg('空调温度异常', function() {
					});
				} else {
					if (i == 14 && light == 0) {
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
							layer.msg('控件修改成功', {
								icon : 1
							});
							$("#button" + i).html(onoff1);
							$("select").val(data.light);
							$("#tem").val(data.temperature);
						}
					});
				}
			} else {
				if (i == 14 && light == 0) {
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
						layer.msg('控件修改成功', {
							icon : 1
						});
						$("#button" + i).html(onoff1);
						$("select").val(data.light);
						$("#tem").val(data.temperature);
					}
				});
				//$("#27").removeClass("gantan");

				//添加感叹号
				//$("#27").addClass("gantan");
			}
		}
		e.cancelBubble = true;
	}
	//修改状态
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
						if (i == 29) {
							$("#tem").val("0");
						}
						if (i == 14) {
							$("select").val(0);
						}
					} else if (data.onoff == 1) {
						onoff1 = "关闭";
						if (i == 29) {
							$("#tem").val("26");
						}
						if (i == 14) {
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
					if (i == 10 || i == 13 || i == 15) {
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
				layer.msg('异常处理成功', {
					icon : 1
				});
				
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				$("#" + sid).attr("style", "display:none");
				if (i == 10 || i == 13 || i == 15) {
					$("#" + i).removeClass("gantan");
				}
				getallstate();
				getall();
			}
		});
	}
</script>
</head>

<body oncontextmenu=self.event.returnValue=false>
	<!--header-->
	<jsp:include page="head.jsp">
		<jsp:param value="bedroom" name="page" /></jsp:include>
	<!--header end-->
	<!--content-->

	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>卧室</h1>
			<span>打造家里最爱的房间</span>
			<p>卧室并非只是睡觉的地方，有温暖的灯光营造氛围，您可以蜷缩在床上看电影，在背景音乐中完成最后一点工作，窗帘能让您与太阳公公同时起床，或一觉睡到中午。</p>
		</div>
	</div>
	<div class="page-container">

		<div class="show-box grey clearfix" id="body">

			<!-- 窗帘开关 -->
			<a class="more-info dp" style="top: 39%; left: 34%;" id="9"
				onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">窗&nbsp;&nbsp;帘</div>
				<div class="bubble northwest">
					<img src="images/ws-kcq-pic.png" />
					<div id="nothave9">
						<button onclick="add(event,9)" class="btn btn-success">添加</button>
					</div>
					<div id="have9" style="display: none;">

						<button id="button9" onclick="update1(event,9)"
							class="btn btn-info">开启</button>
						<button onclick="del(event,9)" class="btn btn-danger">删除</button>
						<div id="state9" style="display: none;">
							<button class="	btn btn-primary" onclick="handle(event,9)"
								style="width: 80px">处理</button>
						</div>
					</div>
				</div>
			</a>
			<!-- 烟感 -->
			<a class="more-info" data-next-image="images/wsbg.png"
				style="top: 3%; left: 20%;" id="10" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">烟&nbsp;&nbsp;感</div>
				<div class="bubble southeast">
					<img src="images/yangan.png" />
					<div id="nothave10">
						<button onclick="add(event,10)" class="btn btn-success">添加</button>
					</div>
					<div id="have10" style="display: none;">
						<div>

							<button id="button10" onclick="update1(event,10)"
								class="btn btn-info">开启</button>
							<button onclick="del(event,10)" class="btn btn-danger">删除</button>
						</div>
						<div id="state10" style="display: none;">
							<button onclick="handle(event,10)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>

				</div>
			</a>
			<!-- 电视开关 -->
			<a class="more-info dp" style="top: 20%; left: 89%;" id="11"
				onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">电&nbsp;&nbsp;视</div>
				<div class="bubble southwest">
					<img src="images/ws-tv-pic.png" />
					<div id="nothave11">
						<button onclick="add(event,11)" class="btn btn-success">添加</button>
					</div>
					<div id="have11" style="display: none;">

						<button id="button11" onclick="update1(event,11)"
							class="btn btn-info">开启</button>
						<button onclick="del(event,11)" class="btn btn-danger">删除</button>
						<div id="state11" style="display: none;">
							<button onclick="handle(event,11)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>
			<!-- 空气净化器 -->
			<a class="more-info" data-next-image="images/ws-kj.png"
				style="top: 85%; left: 24%;" id="12" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">净&nbsp;&nbsp;化</div>
				<div class="bubble">
					<img src="images/ws-kj-pic.png" />
					<div id="nothave12">
						<button onclick="add(event,12)" class="btn btn-success">添加</button>
					</div>
					<div id="have12" style="display: none;">

						<button id="button12" onclick="update1(event,12)"
							class="	btn btn-info">开启</button>
						<button onclick="del(event,12)" class="btn btn-danger">删除</button>
						<div id="state12" style="display: none;">
							<button onclick="handle(event,12)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>

				</div>
			</a>

			<!-- 保险柜 -->
			<a class="more-info" data-next-image="images/ws-jgq.png"
				style="top: 85%; left: 9%;" id="13" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">隐&nbsp;&nbsp;私</div>
				<div class="bubble">
					<img src="images/ws-jgq-pic.png" />


					<div id="nothave13">
						<button onclick="add(event,13)" class="btn btn-success">添加</button>
					</div>
					<div id="have13" style="display: none;">
						<div>

							<button id="button13" onclick="update1(event,13)"
								class="btn btn-info">开启</button>
							<button onclick="del(event,13)" class="btn btn-danger">删除</button>
						</div>
						<div id="state13" style="display: none;">
							<button onclick="handle(event,13)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>



				</div>
			</a>
			<!-- 灯开关 -->
			<a class="more-info dp" style="top: 33%; left: 10%;" id="14"
				onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1zpx; position: absolute; text-align: center;">灯&nbsp;&nbsp;光</div>
				<div class="bubble southeast">
					<img src="images/kt-kg-pic.png" />
					<div id="nothave14" onclick="f1(event)">
						<button onclick="add(event,14)" class="btn btn-success">添加</button>
					</div>
					<div id="have14" style="display: none;">
						<div>

							<button id="button14" class="zdybutton btn btn-info"
								onclick="update1(event,14)">开启</button>
						</div>
						<div onclick="f1(event)">
							亮度:<select id="ws" onchange="update(event,14)">
								<option value="0">无光</option>
								<option value="1">暗淡</option>
								<option value="2">柔光</option>
								<option value="3">明亮</option>
							</select>
						</div>
						<button onclick="del(event,14)" class="btn btn-danger">删除</button>
						<div id="state14" style="display: none;">
							<button onclick="handle(event,14)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>
				</div>
			</a>
			<!-- 窗磁 -->
			<a class="more-info" data-next-image="images/wsbg.png"
				style="top: 30%; left: 60%;" id="15" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">窗&nbsp;&nbsp;磁</div>
				<div class="bubble southeast">
					<img src="images/ws-sm-pic.png" />
					<div id="nothave15">
						<button onclick="add(event,15)" class="btn btn-success">添加</button>
					</div>
					<div id="have15" style="display: none;">
						<div>

							<button id="button15" onclick="update1(event,15)"
								class="btn btn-info">开启</button>
							<button onclick="del(event,15)" class="btn btn-danger">删除</button>
						</div>
						<div id="state15" style="display: none;">
							<button onclick="handle(event,15)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>


				</div>
			</a>


			<!-- 卧室空调 -->
			<a class="more-info" data-next-image="images/ws-kt.png"
				style="top: 5%; left: 89%;" id="29" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">空&nbsp;&nbsp;调</div>
				<div class="bubble southwest">
					<img src="images/ws-kt-pic.png" />

					<div id="nothave29" onclick="add(event,29)">
						<button class="btn btn-success">添加</button>
					</div>
					<div id="have29" style="display: none;">
						<div>

							<button id="button29" onclick="update1(event,29)"
								class="btn btn-info">开启</button>
						</div>
						<div>
							温度：<input style="width: 45px;" type="number" step="0.5" id="tem"
								value="0" onclick="f1(event)"
								onfocus="layer.tips('16≤ 温度范围≤ 32', '#tem',{tips: [2, '#3595CC'],time: 4000});">
						</div>
						<div>
							<div>

								<button onclick="update(event,29)" class="	btn btn-success">修改</button>
								&nbsp;&nbsp;
								<button onclick="del(event,29)" class="btn btn-danger">删除</button>
							</div>
							<div id="state26" style="display: none;">
								<button onclick="handle(event,26)" style="width: 80px"
									class="	btn btn-primary">处理</button>
							</div>

						</div>
					</div>
				</div>
			</a>



			<div class="overlay" id="loaded"></div>
			<div class="background-image">
				<img src="images/wsbg.png" style="width: 100%;" id="kgpt" />
			</div>
		</div>
	</div>


	<script charset="UTF-8" src="js/jquery-2.2.4.min.js"></script>
	<script charset="UTF-8" src="js/2.js"></script>
	<script type="text/javascript">
		//$("#loaded").hide(); 
		var benefits = false;
		$(function() {
			$.preload([ 'images/ws-jgq.png', 'images/ws-sm.png',
					'images/ws-kj.png', 'images/ws-kcq.png',
					'images/ws-cldj.png' ]);
		});
	</script>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>