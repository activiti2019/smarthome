<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="p" uri="http://com.hp.page/common/"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />


<title>数据统计-Home_Auto</title>

<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" />
<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet" />

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet" />

<!-- Custom CSS -->
<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet" />

<!-- Custom Fonts -->
<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet"
	type="text/css" />
<link
	href="<%=basePath%>css/bootstrap-theme.min.css"
	rel="stylesheet" type="text/css" />
<!-- jQuery -->
	<script src="<%=basePath%>js/jquery.min.js"></script>

</head>

<body>

	<jsp:include page="adminleft.jsp" />
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">数据统计</h1>
				<div class="btn-group btn-toggle" style="float: right;">
					<button class="btn btn-primary  active" onclick="changetab2();">雷达图</button>
					<button class="btn btn-default" onclick="changetab();">饼图</button>
				</div>
				
			</div>
		</div>

		<div class="row"
			style="height: 550px; min-height: 100px; width: 700px; margin: 0 auto;"
			id="main"></div>
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
	$(function(){

		  $('.btn-toggle').click(function(){
		    var $this = $(this); //找到当前btn-toggle定义的按钮组
		    
		    //这段代码中找到对应的btn-primary定义的按钮并且去掉相关CSS类定义
		    if($this.find('.btn-primary').length>0){
		      $this.find('.btn').toggleClass('btn-primary');
		    }
		    
		    //下面添加其它按钮CSS定义支持
		    if($this.find('.btn-success').length>0){
		      $this.find('.btn').toggleClass('btn-success');
		    }
		    
		    if($this.find('.btn-info').length>0){
		      $this.find('.btn').toggleClass('btn-info');
		    }

		    if($this.find('.btn-danger').length>0){
		      $this.find('.btn').toggleClass('btn-danger');
		    }
		    
		    /* 
		     *  这里我们可以修改btn定义不同的切换按钮样式：danger,info,success,primary
		     */
		    
		    $this.find('.btn').toggleClass('btn-default').toggleClass('active');
		    
		  });

		});
		$(document)
				.ready(
						
						function() {
							var mychart = echarts.init(document
									.getElementById("main"));
							var dataBJ = [ [ 234, 185, 230, 4.09, 123, 69 ] ];
							var lineStyle = {
								normal : {
									width : 1,
									opacity : 0.5
								}
							};

							option = {
								backgroundColor : '#FFFFFF',
								title : {
									text : '异常 - 雷达图',
									left : 'center',
									textStyle : {
										color : '#272727'
									}
								},
								legend : {
									bottom : 5,
									data : [],
									itemGap : 20,
									textStyle : {
										color : '#272727',
										fontSize : 14
									},
									selectedMode : 'single'
								},
								radar : {
									indicator : [ {
										name : '客厅',
										max : 20
									}, {
										name : '卧室',
										max : 20
									}, {
										name : '厨房',
										max : 20
									}, {
										name : '餐厅',
										max : 20
									}, {
										name : '露台',
										max : 20
									}, {
										name : '浴室',
										max : 20
									} ],
									shape : 'circle',
									splitNumber : 5,
									name : {
										textStyle : {
											color : '#A23400'
										}
									},
									splitLine : {
										lineStyle : {
											color : [ '#FFED97', '#FFE66F',
													'#FFDC35', '#EAC100',
													'#C6A300',
													'rgba(238, 197, 102, 1)' ]
													.reverse()
										}
									},
									splitArea : {
										show : false
									},
									axisLine : {
										lineStyle : {
											color : '#FFDC35'
										}
									}
								},
								series : [ {
									name : '小区名',
									type : 'radar',
									lineStyle : lineStyle,
									data : dataBJ,
									symbol : 'none',
									itemStyle : {
										normal : {
											color : '#A23400'
										}
									},
									areaStyle : {
										normal : {
											opacity : 0.1
										}
									}
								} ]
							};
							//在数据为动态加载之前加载loading动画
							mychart.showLoading();
							//对数据进行更新，变成动态数据
							var errorsum = [];
							var alldate = [];
							$
									.ajax({
										type : "post",
										async : true,
										url : "../record2/selectBySceneManager",
										data : {},
										dateType : "json",
										success : function(data) {
											if (data.errorlist != null
													&& data.errorlist.length > 0) {
												if (data.cmname != null) {
													var errorsumin = [];
													for (var i = 0; i < data.errorlist.length; i++) {
														if (!isNaN(data.errorlist[i])) {
															errorsumin
																	.push(data.errorlist[i]);
														}
													}
													errorsum.push(errorsumin);
													alldate.push(data.cmname);
												}
												//隐藏动画
												mychart.hideLoading();
												mychart.setOption({
													legend : {
														data : alldate,
													},
													series : [ {
														name : data.cmname,
														data : errorsum
													} ]
												})
											} else {
												mychart.hideLoading();
												mychart.setOption({
													title : {
														text : '暂无数据'
													}
												})

											}
										}
									});
							mychart.setOption(option);

						});
		function changetab() {
			var mychart = echarts.dispose(document.getElementById("main"));
			//$("#main").empty();
			var mychart = echarts.init(document.getElementById("main"));

			option = {
				backgroundColor : '#FFF',

				title : {
					text : 'Customized Pie',
					left : 'center',
					top : 20,
					textStyle : {
						color : '#28004D'
					}
				},

				tooltip : {
					trigger : 'item',
					formatter : "{a} <br/>{b} : {c} ({d}%)"
				},

				visualMap : {
					show : false,
					min : 80,
					max : 600,
					inRange : {
						colorLightness : [ 0, 1 ]
					}
				},
				series : [ {
					name : '异常分布',
					type : 'pie',
					radius : '55%',
					center : [ '50%', '50%' ],
					data : [],
					roseType : 'radius',
					label : {
						normal : {
							textStyle : {
								color : 'rgba(255, 255, 255, 0.3)'
							}
						}
					},
					labelLine : {
						normal : {
							lineStyle : {
								color : 'rgba(255, 255, 255, 0.3)'
							},
							smooth : 0.2,
							length : 10,
							length2 : 20
						}
					},
					itemStyle : {
						normal : {
							color : '#c23531',
							shadowBlur : 200,
							shadowColor : 'rgba(0, 0, 0, 0.5)'
						}
					},

					animationType : 'scale',
					animationEasing : 'elasticOut',
					animationDelay : function(idx) {
						return Math.random() * 200;
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
				url : "../record2/selectBySceneManagerMap",
				data : {},
				dateType : "json",
				success : function(data) {
					if (data.errorlist != null && data.errorlist.length > 0) {
						for (var i = 0; i < data.errorlist.length; i++) {
							errorsum.push(data.errorlist[i]);

						}
						//隐藏动画
						mychart.hideLoading();
						mychart.setOption({
							title : {
								text : data.cmname
							},
							series : [ {
								name : '异常分布',
								type : 'pie',
								radius : '55%',
								center : [ '50%', '50%' ],
								data : errorsum.sort(function(a, b) {
									return a.value - b.value;
								}),
								roseType : 'radius',
								label : {
									normal : {
										textStyle : {
											color : '#28004D'
										}
									}
								},
								labelLine : {
									normal : {
										lineStyle : {
											color : '#28004D'
										},
										smooth : 0.2,
										length : 10,
										length2 : 20
									}
								},
								itemStyle : {
									normal : {
										color : '#c23531',
										shadowBlur : 200,
										shadowColor : '#FFF'
									}
								},

								animationType : 'scale',
								animationEasing : 'elasticOut',
								animationDelay : function(idx) {
									return Math.random() * 200;
								}
							} ]
						})
					} else {
						mychart.hideLoading();
						mychart.setOption({
							title : {
								text : '暂无数据'
							}
						})

					}
				}
			});
			mychart.setOption(option);
		}
		
		function changetab2() {
			var mychart = echarts.dispose(document.getElementById("main"));
			//$("#main").empty();
			var mychart = echarts.init(document
					.getElementById("main"));
			var dataBJ = [ [ 234, 185, 230, 4.09, 123, 69 ] ];
			var lineStyle = {
				normal : {
					width : 1,
					opacity : 0.5
				}
			};

			option = {
				backgroundColor : '#FFFFFF',
				title : {
					text : '异常 - 雷达图',
					left : 'center',
					textStyle : {
						color : '#272727'
					}
				},
				legend : {
					bottom : 5,
					data : [],
					itemGap : 20,
					textStyle : {
						color : '#272727',
						fontSize : 14
					},
					selectedMode : 'single'
				},
				radar : {
					indicator : [ {
						name : '客厅',
						max : 20
					}, {
						name : '卧室',
						max : 20
					}, {
						name : '厨房',
						max : 20
					}, {
						name : '餐厅',
						max : 20
					}, {
						name : '露台',
						max : 20
					}, {
						name : '浴室',
						max : 20
					} ],
					shape : 'circle',
					splitNumber : 5,
					name : {
						textStyle : {
							color : '#A23400'
						}
					},
					splitLine : {
						lineStyle : {
							color : [ '#FFED97', '#FFE66F',
									'#FFDC35', '#EAC100',
									'#C6A300',
									'rgba(238, 197, 102, 1)' ]
									.reverse()
						}
					},
					splitArea : {
						show : false
					},
					axisLine : {
						lineStyle : {
							color : '#FFDC35'
						}
					}
				},
				series : [ {
					name : '小区名',
					type : 'radar',
					lineStyle : lineStyle,
					data : dataBJ,
					symbol : 'none',
					itemStyle : {
						normal : {
							color : '#A23400'
						}
					},
					areaStyle : {
						normal : {
							opacity : 0.1
						}
					}
				} ]
			};
			//在数据为动态加载之前加载loading动画
			mychart.showLoading();
			//对数据进行更新，变成动态数据
			var errorsum = [];
			var alldate = [];
			$
					.ajax({
						type : "post",
						async : true,
						url : "../record2/selectBySceneManager",
						data : {},
						dateType : "json",
						success : function(data) {
							if (data.errorlist != null
									&& data.errorlist.length > 0) {
								if (data.cmname != null) {
									var errorsumin = [];
									for (var i = 0; i < data.errorlist.length; i++) {
										if (!isNaN(data.errorlist[i])) {
											errorsumin
													.push(data.errorlist[i]);
										}
									}
									errorsum.push(errorsumin);
									alldate.push(data.cmname);
								}
								//隐藏动画
								mychart.hideLoading();
								mychart.setOption({
									legend : {
										data : alldate,
									},
									series : [ {
										name : data.cmname,
										data : errorsum
									} ]
								})
							} else {
								mychart.hideLoading();
								mychart.setOption({
									title : {
										text : '暂无数据'
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
