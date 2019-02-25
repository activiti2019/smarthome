<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content=""/>
<meta name="author" content=""/>


<title>数据统计-Home_Auto</title>

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
	

</head>

<body>
		<jsp:include page="head.jsp" />

		<jsp:include page="left.jsp" />
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">数据统计</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
		
<!-- 			<div class="panel panel-default"> -->
					
<!-- 			</div> -->
			<div class="row" 
				style="height: 410px; min-height: 100px; width: 700px; margin: 0 auto;"
				id="main">
			</div>
		</div>
	<!-- jQuery -->
	<script src="<%=basePath%>js/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="<%=basePath%>js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="<%=basePath%>js/metisMenu.min.js"></script>

	<!-- DataTables JavaScript -->
	<script src="<%=basePath%>js/jquery.dataTables.min.js"></script>
	<script src="<%=basePath%>js/dataTables.bootstrap.min.js"></script>
	<script src="<%=basePath%>js/echarts.js"></script>
	<!-- Custom Theme JavaScript -->
	<script src="<%=basePath%>js/sb-admin-2.js"></script>
	<jsp:include page="changesuperadminpwd.jsp" />
	<script type="text/javascript">
	$(document).ready(function() {
		var mychart = echarts.init(document.getElementById("main"));
		option = {
			title : {
				text : '本周异常统计',
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
				data : [ '周一', '周二', '周三', '周四', '周五', '周六', '周日' ]
			},
			yAxis : {
				type : 'value',
				axisLabel : {
					formatter : '{value} '
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
		$.ajax({
			type : "post",
			async : true,
			url : "../record/selectByWeekEveryDayManager",
			date : {},
			dateType : "json",
			success : function(data) {
				if (data != null && data.errorlist.length > 0) {
					for (var i = 0; i < data.errorlist.length; i++) {
						if (!isNaN(data.errorlist[i])) {
							errorsum.push(data.errorlist[i]);
						}
					}
					if (errorsum.length < 7) {
						var j = 7 - errorsum.length;
						for (var i = 0; i < j; i++) {
							errorsum.push(0);
						}
					}
					//隐藏动画
					mychart.hideLoading();
					mychart.setOption({
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
	</script>
</body>

</html>
