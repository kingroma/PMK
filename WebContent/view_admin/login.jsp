<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin_Login</title>
<style>
.body{
	padding:0px;
	margin:0px;
	width:100%;
}
.loginDiv{
	width:100%;
	text-align:center;
}
.loginDiv input{
	margin:5%;
	width:60%;
	font-size:40pt;
	padding:1%;
}
.ihead{
	text-align:center;
	font-weight:bold;
	font-size:60pt;
	margin:50px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="ihead">
			Admin Login
		</div>
		<div class="ibody">
			<div class="loginDiv">
				<form action="/Admin_Login" method="post">
					<input type="text" name="user_id" placeholder="아이디" required>
					<input type="password" name="user_pw" placeholder="패스워드" required>
					<input type="submit" value="로그인">
				</form>
			</div>
		</div>
		<div class="ifooter">
		
		</div>
	</div>
</body>
</html>