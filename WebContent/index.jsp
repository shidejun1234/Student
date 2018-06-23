<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>用户登录</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link href="assets/stylesheets/bootstrap.min.css" rel="stylesheet">
<style>
body{
font-family:'microsoft yahei'
}

.bg-img{
position:absolute;
top:49px;
z-index:0;
left:0;
right:0;
bottom:0;
background:url(assets/images/login.jpg)
}

.head-top{
    height: 49px;
    background: #252525;
    border-bottom: 0;
    position: relative;
    padding: 0;
    box-shadow: 0 0 5px #333;
    color:#fff
    }

</style>

</head>
<body class="course-dashboard-page" onkeydown="keyLogin();">
<div class="head-top"></div>
    <div class="bg-img"></div>
    <div id="content-container" class="container" style="margin-top: 100px;">
        <div class="row row-6">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default panel-page" style="background-color: rgba(255,255,255,0.9);">
                    <div class="panel-heading">
                        <h2 style="font-size:22px">用户登录</h2>
                    </div>
                    <form action="login" method="post" class="form-vertical" accept-charset="utf-8" novalidate="novalidate" data-widget-cid="widget-0" style="padding: 24px;">
                    <!-- <div id="login-form" class="form-vertical" method="post" novalidate="novalidate" data-widget-cid="widget-0" style="padding: 24px;"> -->
                        <div class="form-group">
                            <label class="control-label" for="username">帐号</label>
                            <div class="controls">
                                <input class="form-control" id="username" type="text" name="username" value="${username}" required=""
                                    data-widget-cid="widget-1" data-explain="请输入用户昵称">
                                <div class="help-block">请输入用户昵称</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="password">密码</label>
                            <div class="controls">
                                <input class="form-control" id="password" type="password" name="password" value="${password}" required=""
                                    data-widget-cid="widget-2" data-explain="">
                                <div class="help-block" style="display:none;"></div>
                            </div>
                        </div>
                        <div align="center">
                        	<font color="red" >${error}</font>
                        </div>
                        <br/>
                        <div class="form-group">
                            <div class="controls">
                            	<input type="submit" value="登录" style="width:49%" id="_login" class="btn btn-fat btn-primary btn-large">
                            	<input type="reset"  name= "Reset"  value= "重置" style="width:49%" id="reset" class="btn btn-fat btn-primary btn-large"> 
                                <!-- <button style="width:100%" id="_login" class="btn btn-fat btn-primary btn-large" onclick="login();return false;">登录</button> -->
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="ptl">
                         		<span class="text-muted">还没有注册帐号？</span>
                        		<a href="../register/register2.html">立即注册</a>
                    		</div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--    javascript   -->
    <script src="../javascripts/jquery.min.js"></script>
    <script type="text/javascript">
        //回车登陆
        function keyLogin() {
            if (event.keyCode == 13)
                document.getElementById("_login").click();
        }
        //登陆
        function login() {
            var $username = $("#username").val();
            var $password = $("#password").val();
            var data = {
                username : $username,
                password : $password
            };
            $.ajax({
                url : "login",
                type : "post",
                data : data,
                success : function(s) {
                    if (s.success) {
                        location.href = "2.html";
                    } else {
                        alert(s.msg);
                    }
                }
            });
        } 
    </script>
</body>
</html>
