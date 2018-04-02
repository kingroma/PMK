<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- <script src="https://code.jquery.com/mobile/1.5.0-alpha.1/jquery.mobile-1.5.0-alpha.1.min.js"></script> -->
<title>Calendar main</title>
<%

%>
<script>

</script>
<style>

/*  calendar css  */ 
body{
	font-size:30pt;
	width:100%;
	height:100%;
	padding:0px;
	margin:0px;
}
#ibody{
}

</style>

<script>
// init function
$(document).ready(function(){
	init();
});
//init function
var date = new Date();

function init(){
	//$.mobile.loading().hide();
	//$.mobile.loader.prototype.options.textVisible = false;
}
</script>

<script>
//function

//function

</script>
<style>
.loginFormDiv{
	width:100%;
	text-align:center;
}
.mymsg{
	color:red;
	text-align:cetner;
}
input{
	width:70%;
	font-size:40pt;
	border:1px solid black;
	padding:2%;
	margin:5%;
}
.ifooter{
	text-align:center;
	margin:5%;
}
</style>
</head>
<body>
	<div class="wrapper" >
		<div class="ihead">
		</div>
		<%
		
		%>
		
		<div id="ibody" >
			<div class="loginFormDiv">
				<h1>Login</h1>
				<div class="mymsg">${mymsg}</div>
				<form action="/Login" method="post">
					<div>
						<input type="text" name="user_id" placeholder="아이디">
					</div>
					<div>
						<input type="password" name="user_pw" placeholder="패스워드">
					</div>
					<div>
						<input type="submit" value="로그인">
					</div>
				</form>
				
			</div>
			
			
		</div>
		<div class="ifooter">
			<div>
				<a href="/Join">회원가입하기</a> 
			</div>
		</div>
	</div>
</body>
</html>