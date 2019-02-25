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
<!-- jQuery -->
	<script src="<%=basePath%>js/jquery.min.js"></script>	


</head>

<body>

		<jsp:include page="adminleft.jsp" />
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">数据统计</h1>
				</div>
			</div>
		
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
	
	<jsp:include page="changepwd.jsp" />
	<script type="text/javascript">
	$(document).ready(function() {
		var mychart = echarts.init(document.getElementById("main"));
		

			option = {
			    tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'none'
			        },
			        formatter: function (params) {
			            return params[0].name + ': ' + params[0].value;
			        }
			    },
			    xAxis: {
			        data: [],
			        axisTick: {show: false},
			        axisLine: {show: false},
			        axisLabel: {
			            textStyle: {
			                color: '#e54035'
			            }
			        }
			    },
			    yAxis: {
			        splitLine: {show: false},
			        axisTick: {show: false},
			        axisLine: {show: false},
			        axisLabel: {show: false}
			    },
			    color: ['#e54035'],
			    series: [{
			        name: '异常数',
			        type: 'pictorialBar',
			        barCategoryGap: '-130%',
			        // symbol: 'path://M0,10 L10,10 L5,0 L0,10 z',
			        symbol: 'path://M0,10 L10,10 C5.5,10 5.5,5 5,0 C4.5,5 4.5,10 0,10 z',
			        itemStyle: {
			            normal: {
			                opacity: 0.5
			            },
			            emphasis: {
			                opacity: 1
			            }
			        },
			        data: [123],
			        z: 10
			    }, {
			        name: 'glyph',
			        type: 'pictorialBar',
			        barGap: '-100%',
			        symbolPosition: 'end',
			        symbolSize: 50,
			        symbolOffset: [0, '-120%'],
			        data: []
			    }]
			};
		//在数据为动态加载之前加载loading动画
		mychart.showLoading();
		//对数据进行更新，变成动态数据
		var errorsum = [];
		var alldate = [];
		$.ajax({
			type : "post",
			async : true,
			url : "../record2/selectTopTen",
			date : {},
			dateType : "json",
			success : function(data) {
				if (data.errorlist != null && data.errorlist.length > 0) {
					if (data.uname != null && data.uname.length > 0) {
						for (var i = 0; i < data.errorlist.length; i++) {
							if (!isNaN(data.errorlist[i])) {
								errorsum.push(data.errorlist[i]);
							}
						}
						for (var i = 0; i < data.uname.length; i++) {
							alldate.push(data.uname[i]);
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
							data : errorsum
						} ]
					})
				} else {
					mychart.hideLoading();
					mychart.setOption({
						title : {
							text : '暂无数据',
							subtext : '来源：数据库数据'
						},
						xAxis : {
							data : alldate
						},
						series : [ {
							name : '异常数',
							data : errorsum
						} ]
					})

				}
			}
		});
		mychart.setOption(option);

	});
	</script>
</body>

</html>
