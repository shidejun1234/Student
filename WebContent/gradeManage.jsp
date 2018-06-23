<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>DataGrid with Toolbar - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="assets/javascripts/jquery-easyui-1.5.5.2/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="assets/javascripts/jquery-easyui-1.5.5.2/themes/icon.css">
	<script type="text/javascript" src="assets/javascripts/jquery-easyui-1.5.5.2/jquery.min.js"></script>
	<script type="text/javascript" src="assets/javascripts/jquery-easyui-1.5.5.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="assets/javascripts/jquery-easyui-1.5.5.2/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		
		var url;
	
		function searchGrade(){
			$("#dg").datagrid("load",{
				gradeName:$("#s_gradeName").val()
			});
		}
		function deleteGrade(){
			var selectedRows=$("#dg").datagrid("getSelections");
			if(selectedRows==0){
				$.messager.alert("系統提示","请选择要删除的数据！");
				return;
			}
			var strIDs=[];
			for (var i=0;i<selectedRows.length;i++){
				strIDs.push(selectedRows[i].id);
			}
			var ids=strIDs.join(",");
			$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
				if(r){
					$.post("gradeDelete",{delIds:ids},function(result){
						if(result.success){
							$.messager.alert("系统提示","您删除了<font color=red>"+result.delNum+"</font>条数据");
							$("#dg").datagrid("reload");
						}else{
							$.messager.alert("系统提示",result.errMsg);
						}
					},"json");
				}else{
					
				}
			});
		}
		
		function addGrade(){
			$("#dlg").dialog("open").dialog("setTitle","添加班级信息");
			url="gradeSave";
		}
		
		function editGrade(){
			var selectedRows=$("#dg").datagrid("getSelections");
			if(selectedRows.length!=1){
				$.messager.alert("系統提示","请选择一條要編輯的数据！");
				return;
			}
			var row=selectedRows[0];
			$("#dlg").dialog("open").dialog("setTitle","編輯班级信息");
			$("#fm").form("load",row);
			url="gradeSave?id="+row.id;
		}
		
		function closeGrade(){
			$("#dlg").dialog("close");
			resetGrade();
		}
		
		function resetGrade(){
			$("#gradeName").val("");
			$("#gradeDesc").val("");
		}
		
		function saveGrade(){
			$("#fm").form("submit",{
					url:url,
					onSubmit:function(){
						return $(this).form("validate");
					},
					success:function(result){
						if(result.errMsg){
							$.messager.alert("系統提示：",result.errMsg);
							return;
						}else{
							$.messager.alert("系統提示：","保存成功！");
							resetGrade();
							$("#dlg").dialog("close");
							$("#dg").datagrid("reload");
						}
					}
				});
		}
		
	</script>
</head>
<body>
	<table id="dg" class="easyui-datagrid" title="班级信息" pagination="true" 
	rownumbers="true" fitColumns="true" url="gradeList" toolbar="#tb">
		<thead>
			<tr>
				<th data-options="field:'cb',checkbox:true"></th>
				<th data-options="field:'id',width:50,align:'center'">编号</th>
				<th data-options="field:'gradeName',width:80,align:'center'">班级名称</th>
				<th data-options="field:'gradeDesc',width:200,align:'center'">班级描述</th>
			</tr>
		</thead>
	</table>
	
	<div id="tb">
		<a href="javascript:addGrade()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		<a href="javascript:editGrade()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		<a href="javascript:deleteGrade()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">刪除</a>
		<br/>
		<font>&nbsp;班级名称：</font><input type="text" id="s_gradeName" name="s_gradeName">
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="javascript:searchGrade()">搜索</a>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px" closed="true">
		<form method="post" id="fm">
			<table>			
				<tr>
					<td>班级名称：</td>
					<td>
						<input type="text" name="gradeName" id="gradeName" class="easyui-validatebox" required="true">
					</td>
				</tr>
				<tr>
					<td valign="top">班级描述：</td>
					<td>
						<textarea rows="7" cols="30" name="gradeDesc" id="gradeDesc"></textarea>
					</td>
				</tr>
			</table>
		</form>
		<div style="float: right;">
			<a href="javascript:saveGrade()" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
			<a href="javascript:closeGrade()" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">关闭</a>
		</div>
		
	</div>
	
</body>
</html>