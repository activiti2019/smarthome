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

		

		var mychart = echarts.init(document.getElementById("main"));
		option = {
			    title: {
			        text: '场景异常组成',
			        subtext: 'From DateBase',
			    },
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        },
			        formatter: function (params) {
			            var tar = params[1];
			            return tar.name + '<br/>' + tar.seriesName + ' : ' + tar.value;
			        }
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			      grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },  
			    xAxis: {
			        type : 'category',
			        splitLine: {show:false},
			        axisLabel :{  
			            interval:0   
			        } ,
			        data : []
			    },
			    yAxis: {
			        type : 'value'
			    },
			    series: [
			        {
			            name: '辅助',
			            type: 'bar',
			            stack:  '总量',
			            itemStyle: {
			                normal: {
			                    barBorderColor: 'rgba(0,0,0,0)',
			                    color: 'rgba(0,0,0,0)'
			                },
			                emphasis: {
			                    barBorderColor: 'rgba(0,0,0,0)',
			                    color: 'rgba(0,0,0,0)'
			                }
			            },
			            data: []
			        },
			        {
			            name: '异常数',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'inside'
			                }
			            },
			            data:[]
			        }
			    ]
			};

		//在数据为动态加载之前加载loading动画
		mychart.showLoading();
		//对数据进行更新，变成动态数据
		var errorsum = [];
		var alldate = [];
		var diff = [];
		var sceneid = <%=request.getParameter("sceneid")%>;
		$.ajax({
			type : "post",
			async : true,
			url : "record/selectByScene",
			data : {"sceneid":sceneid},
			dateType : "json",
			success : function(data) {
				if (data.errorlist != null && data.errorlist.length > 0) {
					if (data.connamelist != null && data.connamelist.length > 0) {
						var sum = 0;
						for(var i = 0; i < data.errorlist.length; i++){
							sum = sum + data.errorlist[i]
						}
						errorsum.push(sum);
						for (var i = 0; i < data.errorlist.length; i++) {
							if (!isNaN(data.errorlist[i])) {
								errorsum.push(data.errorlist[i]);
							}
						}
						alldate.push("异常总数");
						for (var i = 0; i < data.connamelist.length; i++) {
							alldate.push(data.connamelist[i]);
						}
						diff.push(0);
							var fudiff = data.errorlist[0];
						for (var i = 0; i < data.errorlist.length; i++) {
							
							diff.push(sum-fudiff);
							fudiff = fudiff+data.errorlist[i+1];
						}

					}
					//隐藏动画
					mychart.hideLoading();
					mychart.setOption({
						xAxis : {
							data :alldate
						},
						series: [
							        {
							            name: '辅助',
							            type: 'bar',
							            data: diff
							        },
							        {
							            name: '异常数',
							            type: 'bar',
							            data:errorsum
							        }
							    ]
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