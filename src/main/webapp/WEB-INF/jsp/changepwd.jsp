<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<!-- 修改密码框 -->
	<div class="modal fade" id="amdinEditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="padding-top: 100px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改管理员密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_admin_form">
						<input type="hidden" id="edit_saId" name="saId"/>
						<div class="form-group">
							<label for="edit_aName" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" readonly="readonly" id="edit_aName" placeholder="用户名" value="${admin.aName }" name="aName"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_aPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="edit_aPwd" placeholder="请输入原密码" name="aPwd"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_aPwd2" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="edit_aPwd2" placeholder="请输入6-30位含大小写英文字母或数字或_或.的密码" name="aPwd2"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_aPwd3" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="edit_aPwd3" placeholder="请输入6-30位含大小写英文字母或数字或_或.的密码" name="aPwd3"/>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateAdmin()">确认修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	
	<script type="text/javascript">
			function updateAdmin(){
				var aName=document.getElementById("edit_aName").value;
				var aPwd=document.getElementById("edit_aPwd").value;
				var aPwd2=document.getElementById("edit_aPwd2").value;
				var aPwd3=document.getElementById("edit_aPwd3").value;
				var reg=/^[a-zA-Z0-9_\.]{6,30}$/;  //非法字符验证
				if(""==aPwd){
					alert("原密码不能为空");
					return;
				}
				if(""==aPwd2){
					alert("密码不能为空");
					return;
				}
				if(""==aPwd3){
					alert("确认密码不能为空");
					return;
				}
				if(!reg.test(aPwd)){
					alert("原密码必须6-30位且无非法字符");
					return;
				}
				if(!reg.test(aPwd2)){
					alert("密码必须为6-30位且无非法字符");
					return;
				}
				if(!reg.test(aPwd3)){
					alert("确认密码必须为6-30位且无非法字符");
					return;
				}
				if(aPwd2 != aPwd3){
					alert("密码与确认密码输入不一致");
					return;
				}
				if(aPwd==aPwd2){
					alert("新密码不能与原密码相同");
					return;
				}
				$.post("<%=basePath%>admin/update",$("#edit_admin_form").serialize(),function(data){
					if(data=="1"){
						alert("密码修改成功！");
						window.location.reload();
					}else{
						alert("密码修改失败，请确认账号密码后重试！");
						return;
					}
				});
			}
	</script>
</body>
</html>