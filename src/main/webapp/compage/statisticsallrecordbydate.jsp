<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="css/site.css">



<link href="asset/css/style.css" rel="stylesheet">
<link href="asset/css/restype.css" rel="stylesheet">
<link href="asset/css/Benefits.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/echarts.js"></script>
<title>智能家居控制系统</title>

<script type="text/javascript">
	$(document).ready(function() {
		var mychart = echarts.init(document.getElementById("main"));
		option = {
			title : {
				text : '每天异常变化',
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
			url : "record/selectByEveryDay",
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
</script>



</head>
<body oncontextmenu=self.event.returnValue=false >

	<div
		style="height: 410px; min-height: 100px; width: 700px; margin: 0 auto;"
		id="main"></div>

</body>
</html>