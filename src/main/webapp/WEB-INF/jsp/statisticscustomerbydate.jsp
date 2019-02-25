<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="p" uri="http://com.hp.page/common/"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%-- <base href="<%=basePath%>"> --%>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content=""/>
<meta name="author" content=""/>

<title>数据统计</title>
<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet"/>
<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet"/>

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet"/>

<!-- Custom CSS -->
<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet"/>

<!-- Custom Fonts -->
<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet"
	type="text/css"/>
<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet"
	type="text/css"/>
<link rel="stylesheet"
	href="<%=basePath%>bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>	
<script src="<%=basePath%>js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="<%=basePath%>bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath%>bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script
	src="<%=basePath%>bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>

<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String dateStr = sdf.format(date);
	request.setAttribute("date", dateStr);
%>

</head>
<body>



<jsp:include page="head.jsp" />

		<jsp:include page="left.jsp" />
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">数据统计</h1>
				</div>
			</div>
		

		<div class="row">
			<div class="col-xs-10">

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

<!-- jQuery -->


	<!-- Metis Menu Plugin JavaScript -->
	<script src="<%=basePath%>js/metisMenu.min.js"></script>

	<script src="<%=basePath%>js/echarts.js"></script>
	<!-- Custom Theme JavaScript -->
	<script src="<%=basePath%>js/sb-admin-2.js"></script>


	<!-- 模态框（Modal） -->
	<div class="modal fade" id="search" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content modalcenter">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="replyLabel">搜索</h4>
				</div>
				<div class="modal-body">
					<form role="form">
						<div class="form-group">
							<label for="starttime" class="col-sm-3 control-label">开始时间：</label>
							<div class="col-sm-8">
								<div class="input-group date form_datetime"
									data-date-format="dd-MM-yyyy" data-link-field="dtp_input1">
									<input class="form-control" value="${date }" size="16" type="text"
										name="starttime" readonly> <span
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
		</div>
	</div>
	
	<jsp:include page="changesuperadminpwd.jsp" />
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
			startDate: '1990-01-01',
			endDate:new Date(),
			todayBtn : true
		//显示今日按钮
		});

		var mychart = echarts.init(document.getElementById("main"));
		option = {
			title : {
				text : '自定义时间统计',
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
			url : "../record/selectByCustomEveryDayManager",
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
			url : "../record/selectByCustomEveryDayManager",
			data : {'starttime':starttime,'endtime':endtime},
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
</body>
</html>