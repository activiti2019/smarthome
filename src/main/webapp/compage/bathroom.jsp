<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>浴室</title>
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
		//validateForm();
		//点击按钮之后，首先进行按钮状态的判断，如果当前class拥有have 则删除have，进入红色X状态，然后没有have，则异步刷新
		$(".more-info").click(function() {
			if ($(".more-info").hasClass("have")) {
				$(".more-info").removeClass("have");
			} else {
				getall();
			}

		});

	});
	function validateForm() {
		$("#tem").bootbootstrapValidator({
			message : 'This value is not valid',
			fields : {/*验证*/
				tem : {/*键名username和input name值对应*/
					message : "This value is not valid",
					validators : {
						notEmpty : {
							message : '温度不能为空'
						},
						regexp : {
							regexp : /^[0-9]*[1-9][0-9]*$/,
							message : '输入不合法'
						},
						stringLength : {
							min : 1,
							max : 2,
							message : '输入长度仅为1-2位'
						},
						between : {
							max : 32,
							min : 17,
							message : '输入范围为17°-32°'
						}
					}
				}
			}
		});
	}
	//刷新界面时调用此方法:
	//对该场景的数据库数据进行读取并填入
	function getall() {

		$.ajax({

			url : "state/queryBathState",
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
					if (id == 100) {
						if (data[i].state == 1) {
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
						if (id == 28) {
							$("select").attr("disabled", "disabled");
							$("#kgpt").attr("src", "images/ysbgwg.png");
						}
					} else if (data[i].onoff == 1) {
						onoff1 = "关闭";
					}

					$("#button" + id).html(onoff1);
					if (id == 26) {
						$("#tem").val(data[i].temperature);
					} else if (id == 28) {
						$("select").val(data[i].light);
						switch (data[i].light) {
						case 0:
							$("#kgpt").attr("src", "images/ysbgwg.png");
							break;
						case 1:
							$("#kgpt").attr("src", "images/ysbg.png");
							break;
						case 2:
							$("#kgpt").attr("src", "images/ysbgrg.png");
							break;
						case 3:
							$("#kgpt").attr("src", "images/ysbgml.png");
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
		if ((onoff == "关闭")) {
			if (tem >= 100.5 || tem <= -0.5 || !tm.test(tem)) {
				layer.msg('热水器温度异常', function() {

				});
			} else {
				if (i == 26 && tem == 0) {
					onoff = "开启";
				}
				if (i == 28 && light == 0) {
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
						if (i == 26) {
							$("#tem").val("0");
						}
						if (i == 28) {
							$("select").val(0);
						}
					} else if (data.onoff == 1) {
						onoff1 = "关闭";
						if (i == 26) {
							$("#tem").val("55");
						}
						if (i == 28) {
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
				layer.msg('控件处理成功', {icon: 1});
				$("#" + cid).attr("style", "");
				$("#" + ncid).attr("style", "display:none");
				$("#" + sid).attr("style", "display:none");
				if (i == 100) {
					$("#" + i).removeClass("gantan");
				}
				getall();
				getallstate();
			}
		});
	}
</script>
</head>

<body oncontextmenu=self.event.returnValue=false>
	<!--头文件-->
	<jsp:include page="head.jsp">
		<jsp:param value="bathroom" name="page" />
	</jsp:include>
	<!--头文件 结束-->
	<!--正文-->

	<div class="benefits-wrap">
		<div class="benefits-summary">
			<h1>浴室</h1>
			<span>一点私密时间终可实现</span>
			<p>我们每个人都时不时需要给自己一点独处时间。寒冷的冬日，来到浴室泡个热水澡，取暖器早已将浴室温暖，拿出手机调至您最爱的音乐，欣赏最新的高品质音乐。</p>
		</div>
	</div>



	<!-- 每个控件都有增删改查   查是首先要执行的，然后对返回的list<state>进行判断，
	如果userid没有对应的Controllerid则将对应div的style="display：none" 属性删除——将添加选项展示出来,
	如果对应的id拥有对应的Controller，则将have的style="display：none"属性删除 -->
	<div class="page-container">
		<div class="show-box grey clearfix" id="body">

			<!-- 热水器 -->

			<a class="more-info" data-next-image="images/ys-cz.png"
				style="top: 18%; left: 78%;" id="26" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">热&nbsp;&nbsp;水</div>
				<div class="bubble southwest">
					<img src="images/ys-cz-pic.png" />

					<div id="nothave26" onclick="add(event,26)">
						<button class="btn btn-success">添加</button>
					</div>
					<div id="have26" style="display: none;">
						<div>

							<button id="button26" onclick="update1(event, 26)"
								class=" btn btn-info">开启</button>
						</div>
						<div>
							温度：<input style="width: 45px;" name="tem" type="number"
								step="0.5" id="tem" value="55" onclick="f1(event)"
								onfocus="layer.tips('0≤ 温度范围≤ 100', '#tem',{tips: [2, '#3595CC'],time: 4000});">度
						</div>

						<div>
							<div>

								<button onclick="update(event,26)" class="	btn btn-success">修改</button>
								&nbsp;&nbsp;
								<button onclick="del(event,26)" class="btn btn-danger">删除</button>
							</div>
							<div id="state26" style="display: none;">
								<button onclick="handle(event,26)" style="width: 80px"
									class="	btn btn-primary">处理</button>
							</div>
						</div>

					</div>




				</div>
			</a>

			<!-- 音乐播放器 -->

			<a class="more-info" data-next-image="images/ys-xz.png"
				style="top: 80%; left: 69%;" id="27" onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">音&nbsp;&nbsp;乐</div>
				<div class="bubble">
					<img src="images/ys-bfq-pic.png" />

					<div id="nothave27">
						<button onclick="add(event,27)" class="btn btn-success">添加</button>
					</div>
					<div id="have27" style="display: none;">

						<button id="button27" onclick="update1(event,27)"
							class=" btn btn-info">开启</button>
						<div>
							<button onclick="del(event,27)" style="width: 80px"
								class="btn btn-danger">删除</button>
						</div>
						<div id="state27" style="display: none;">
							<button onclick="handle(event,27)" style="width: 80px"
								class="	btn btn-primary">处理</button>
						</div>
					</div>



				</div>

			</a>

			<!-- 开关 -->
			<a class="more-info dp" style="top: 18%; left: 40%;" id="28"
				onclick="getall()">
				<div
					style="bottom: 40px; color: red; font-weight: bold; line-height: 1px; position: absolute; text-align: center;">灯&nbsp;&nbsp;光</div>
				<div class="bubble southwest">
					<img src="images/kt-kg-pic.png" />
					<div id="nothave28">
						<button onclick="add(event,28)" class="btn btn-success">添加</button>
					</div>
					<div id="have28" style="display: none;">
						<div>

							<button id="button28" class="zdybutton btn btn-info"
								onclick="update1(event, 28)">开启</button>
						</div>
						<div onclick="f1(event)">
							亮度:<select id="ys" onchange="update(event,1)">
								<option value="0">无光</option>
								<option value="1">暗淡</option>
								<option value="2">柔光</option>
								<option value="3">明亮</option>
							</select>
						</div>

						<button onclick="del(event,28)" class="btn btn-danger">删除</button>
						<div id="state28" style="display: none;">
							<button class="	btn btn-primary" onclick="handle(event,28)"
								style="width: 80px">处理</button>
						</div>
					</div>
				</div>
			</a>






			<div class="overlay" id="loaded"></div>
			<div class="background-image">
				<img src="images/ysbg.png" style="width: 100%;" id="kgpt" />
			</div>
		</div>
	</div>
	<!-- 正文 结束 -->

	<script charset="UTF-8" src="js/jquery-2.2.4.min.js"></script>
	<script charset="UTF-8" src="js/2.js"></script>
	<script type="text/javascript">
		var benefits = false;
		$(function() {
			$.preload([ 'images/ys-xz.png', 'images/ys-cz.png' ]);
		});
	</script>



	<!-- 页脚 -->
	<jsp:include page="foot.jsp"></jsp:include>
	<!-- 页脚  结束-->
</body>
</html>