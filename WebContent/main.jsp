<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	if(session.getAttribute("cUser")==null){
		response.sendRedirect("index.jsp");
		return;
	}
%>
<head>
	<meta charset="UTF-8">
	<title>Basic Layout - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="assets/javascripts/jquery-easyui-1.5.5.2/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="assets/javascripts/jquery-easyui-1.5.5.2/themes/icon.css">
	<script type="text/javascript" src="assets/javascripts/jquery-easyui-1.5.5.2/jquery.min.js"></script>
	<script type="text/javascript" src="assets/javascripts/jquery-easyui-1.5.5.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="assets/javascripts/jquery-easyui-1.5.5.2/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		$(function(){
			var treeData=[{
				text:"根",
				children:[{
					text:"学生信息管理",
					attributes:{
						url:"studentManage.jsp"
					}
				},{
					text:"班级信息管理",
					attributes:{
						url:"gradeManage.jsp"
					}
				}]
			}];
			
			$("#tree").tree({
				data:treeData,
				lines:"true",
				onClick:function(node){
					if(node.attributes){
						openTab(node.text, node.attributes.url)
					}
				}
			});
			
			function openTab(text,url){
				if($("#tabs").tabs("exists",text)){
					$("#tabs").tabs("select",text);
				}else{
					var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src="+url+"></iframe>";
					$("#tabs").tabs("add",{
						title:text,
						closable:"true",
						content:content
					});	
				}
			}
			
		});
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height: 80px;background-color: #E0EDFF">
		<img alt="" src="assets/images/main.jpg">
		<div style="float: right; padding-top: 20px; padding-right: 10px">
			当前用户：<font color="red">${cUser.userName }</font><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;<input id="loginout" type="button" value="退出登录" style="color: red; background-color: #E0EDFF;">
		</div>
	</div>
	<div data-options="region:'south',split:true" style="height: 50px;padding-top: 10px;" align="center">
		shidejun
	</div>
	<div data-options="region:'west',split:true" title="导航" style="width: 200px;">
		<ul id="tree"></ul>
	</div>
	<div data-options="region:'center'">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页">
				<div align="center" style="padding-top: 20px">
					<font size="10" color="red">欢迎使用</font>
				</div>
			</div>
		</div>
	</div>
</body>
</html>