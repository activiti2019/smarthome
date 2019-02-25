<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="p" uri="http://com.hp.page/common/"%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
<link rel="stylesheet"
	href="bootstrapvalidator/css/bootstrapValidator.css">
<link rel="stylesheet" href="css/site.css">
<link rel="stylesheet"
	href="bootstrap-datetimepicker/css/bootstrap-datetimepicker.css">
<script src="js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script
	src="bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">
<!-- bootstrap的下拉选项 -->
<link
	href="https://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/css/bootstrap-select.min.css"
	rel="stylesheet">
<link href="css/base.css" type="text/css" rel="stylesheet">
<script
	src="https://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/js/bootstrap-select.min.js"></script>
<!-- 引入下拉框结束 -->
<!-- 表单验证 -->
<script src="bootstrapvalidator/js/bootstrapValidator.js"
	type="text/javascript"></script>
<link href="css/button.css" rel="stylesheet">
<script type="text/javascript" src="js/echarts.js"></script>
<title>智能家居控制系统</title>
<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String dateStr = sdf.format(date);
	request.setAttribute("date", dateStr);
%>
<script type="text/javascript">
	$(function() {

		$(".subNav").click(
				function() {

					$(this).toggleClass("currentDd").siblings(".subNav")
							.removeClass("currentDd")

					$(this).toggleClass("currentDt").siblings(".subNav")
							.removeClass("currentDt")

					$(this).next(".navContent").slideToggle(300).siblings(
							".navContent").slideUp(500)

				})

		$(".form_datetime").datetimepicker({
			format : 'yyyy-mm-dd',
			minView : 'month',
			language : 'zh-CN',
			autoclose : true,//选中自动关闭
			startDate : '1990-01-01',
			endDate:new Date(),
			todayBtn : true
		//显示今日按钮
		});

		var mychart = echarts.init(document.getElementById("main"));
		option = {
			title : {
				text : '自定义时间段内每天异常变化',
				subtext : '来源：数据库数据'
			},
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				data : [ '异常数' ]
			},
			toolbox : {
				show : true,
				feature : {
					dataZoom : {
						yAxisIndex : 'none'
					},
					dataView : {
						readOnly : false
					},
					magicType : {
						type : [ 'line', 'bar' ]
					},
					restore : {},
					saveAsImage : {}
				}
			},
			xAxis : {
				type : 'category',
				boundaryGap : false,
				data : []
			},
			yAxis : {
				type : 'value',
				axisLabel : {
					formatter : '{value}'
				}
			},
			series : [ {
				name : '异常数',
				type : 'line',
				data : [],
				markPoint : {
					data : [ {
						type : 'max',
						name : '最大值'
					}, {
						type : 'min',
						name : '最小值'
					} ]
				},
				markLine : {
					data : [ {
						type : 'average',
						name : '平均值'
					}, [ {
						symbol : 'none',
						x : '90%',
						yAxis : 'max'
					}, {
						symbol : 'circle',
						label : {
							normal : {
								position : 'start',
								formatter : '最大值'
							}
						},
						type : 'max',
						name : '最高点'
					} ], [ {
						symbol : 'none',
						x : '90%',
						yAxis : 'min'
					}, {
						symbol : 'circle',
						label : {
							normal : {
								position : 'start',
								formatter : '最小值'
							}
						},
						type : 'min',
						name : '最低点'
					} ]

					]
				}
			} ]
		};
		//在数据为动态加载之前加载loading动画
		mychart.showLoading();
		//对数据进行更新，变成动态数据
		var errorsum = [];
		var alldate = [];

		$.ajax({
			type : "post",
			async : true,
			url : "record/selectByCustomEveryDay",
			date : {},
			dateType : "json",
			success : function(data) {
				if (data.errorlist != null && data.errorlist.length > 0) {
					if (data.datelist != null && data.datelist.length > 0) {
						for (var i = 0; i < data.errorlist.length; i++) {
							if (!isNaN(data.errorlist[i])) {
								errorsum.push(data.errorlist[i]);
							}
						}
						for (var i = 0; i < data.datelist.length; i++) {
							alldate.push(data.datelist[i]);
						}

					}
					//隐藏动画
					mychart.hideLoading();
					mychart.setOption({
						xAxis : {
							data : alldate
						},
						series : [ {
							name : '异常数',
							type : 'line',
							data : errorsum
						} ]
					})
				} else {
					mychart.hideLoading();
					mychart.setOption({
						title : {
							text : '暂无数据',
							subtext : '来源：数据库数据'
						}
					})

				}
			}
		});
		mychart.setOption(option);

	});

	function search() {
		var mychart = echarts.dispose(document.getElementById("main"));
		mychart = echarts.init(document.getElementById("main"));
		option = {
			title : {
				text : '本年度每天异常变化',
				subtext : '来源：数据库数据'
			},
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				data : [ '异常数' ]
			},
			toolbox : {
				show : true,
				feature : {
					dataZoom : {
						yAxisIndex : 'none'
					},
					dataView : {
						readOnly : false
					},
					magicType : {
						type : [ 'line', 'bar' ]
					},
					restore : {},
					saveAsImage : {}
				}
			},
			xAxis : {
				type : 'category',
				boundaryGap : false,
				data : []
			},
			yAxis : {
				type : 'value',
				axisLabel : {
					formatter : '{value}'
				}
			},
			series : [ {
				name : '异常数',
				type : 'line',
				data : [],
				markPoint : {
					data : [ {
						type : 'max',
						name : '最大值'
					}, {
						type : 'min',
						name : '最小值'
					} ]
				},
				markLine : {
					data : [ {
						type : 'average',
						name : '平均值'
					}, [ {
						symbol : 'none',
						x : '90%',
						yAxis : 'max'
					}, {
						symbol : 'circle',
						label : {
							normal : {
								position : 'start',
								formatter : '最大值'
							}
						},
						type : 'max',
						name : '最高点'
					} ], [ {
						symbol : 'none',
						x : '90%',
						yAxis : 'min'
					}, {
						symbol : 'circle',
						label : {
							normal : {
								position : 'start',
								formatter : '最小值'
							}
						},
						type : 'min',
						name : '最低点'
					} ]

					]
				}
			} ]
		};
		//在数据为动态加载之前加载loading动画
		mychart.showLoading();
		//对数据进行更新，变成动态数据
		var errorsum = [];
		var alldate = [];
		var starttime = $("input[name='starttime']").val();
		var endtime = $("input[name='endtime']").val();
		$.ajax({
			type : "post",
			async : true,
			url : "record/selectByCustomEveryDay",
			data : {
				'starttime' : starttime,
				'endtime' : endtime
			},
			dateType : "json",
			success : function(data) {
				if (data.errorlist != null && data.errorlist.length > 0) {
					if (data.datelist != null && data.datelist.length > 0) {
						for (var i = 0; i < data.errorlist.length; i++) {
							if (!isNaN(data.errorlist[i])) {
								errorsum.push(data.errorlist[i]);
							}
						}
						for (var i = 0; i < data.datelist.length; i++) {
							alldate.push(data.datelist[i]);
						}

					}
					//隐藏动画
					mychart.hideLoading();
					mychart.setOption({
						xAxis : {
							data : alldate
						},
						series : [ {
							name : '异常数',
							type : 'line',
							data : errorsum
						} ]
					})
				} else {
					mychart.hideLoading();
					mychart.setOption({
						title : {
							text : '暂无数据',
							subtext : '来源：数据库数据'
						}
					})

				}
			}
		});
		mychart.setOption(option);
	}
</script>
</head>
<body oncontextmenu=self.event.returnValue=false >


	<div class="container">
		<div class="row">

			<div class="col-xs-12">


				<div class="replybtn">
					<button type="button" class="btn btn-info" data-toggle="modal"
						data-target="#search">搜索</button>
				</div>
				<div
					style="height: 410px; min-height: 100px; width: 700px; margin: 0 auto;"
					id="main"></div>

			</div>



		</div>
	</div>



	<!-- 模态框（Modal） -->
	<div class="modal fade" id="search" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content modalcenter">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">搜索&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&times;</button>
				</div>
				<div class="modal-body">
					<form role="form">
						<div class="form-group">
							<label for="starttime" class="col-sm-3 control-label">开始时间：</label>
							<div class="col-sm-8">
								<div class="input-group date form_datetime"
									data-date-format="dd-MM-yyyy" data-link-field="dtp_input1">
									<input class="form-control" value="${date }" size="16"
										type="text" name="starttime" readonly> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-th"></span></span>
								</div>
							</div>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="form-group">
							<label for="endtime" class="col-sm-3 control-label">结束时间：</label>
							<div class="col-sm-8">
								<div class="input-group date form_datetime"
									data-date-format="dd-MM-yyyy" data-link-field="dtp_input1">
									<input class="form-control" size="16" type="text"
										name="endtime" value="${date }" readonly> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-th"></span></span>
								</div>
							</div>
						</div>
						<div class="form-group">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="search();">搜索</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
</html>