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
	<div class="modal fade" id="superamdinEditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="padding-top: 100px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改超级管理员密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_superadmin_form">
						<input type="hidden" id="edit_saId" name="saId"/>
						<div class="form-group">
							<label for="edit_saName" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" readonly="readonly" id="edit_saName" placeholder="用户名" value="${superadmin.saName }" name="saName"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_saPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="edit_saPwd" placeholder="请输入原密码" name="saPwd"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_saPwd2" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="edit_saPwd2" placeholder="请输入6-30位含大小写英文字母或数字或_或.的密码" name="saPwd2"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_saPwd3" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="edit_saPwd3" placeholder="请输入6-30位含大小写英文字母或数字或_或.的密码" name="saPwd3"/>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateSuperadmin();">确认修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->
	
	<script type="text/javascript">
	function updateSuperadmin(){
		var saName=document.getElementById("edit_saName").value;
		var saPwd=document.getElementById("edit_saPwd").value;
		var saPwd2=document.getElementById("edit_saPwd2").value;
		var saPwd3=document.getElementById("edit_saPwd3").value;
		var reg=/^[a-zA-Z0-9_\.]{6,30}$/;  //非法字符验证
		if(""==saPwd){
			alert("原密码不能为空");
			return;
		}
		if(""==saPwd2){
			alert("密码不能为空");
			return;
		}
		if(""==saPwd3){
			alert("确认密码不能为空");
			return;
		}
		if(!reg.test(saPwd)){
			alert("原密码必须6-30位且无非法字符");
			return;
		}
		if(!reg.test(saPwd2)){
			alert("密码必须为6-30位且无非法字符");
			return;
		}
		if(!reg.test(saPwd3)){
			alert("确认密码必须为6-30位且无非法字符");
			return;
		}
		if(saPwd2 != saPwd3){
			alert("密码与确认密码输入不一致");
			return;
		}
		if(saPwd==saPwd2){
			alert("新密码不能与原密码相同");
			return;
		}
		$.post("<%=basePath%>superadmin/update",$("#edit_superadmin_form").serialize(),function(data){
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