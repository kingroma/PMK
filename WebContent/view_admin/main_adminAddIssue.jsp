<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%

	String work_date = (String)request.getAttribute("work_date");
	String location_number = (String)request.getAttribute("location_number");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function(){
	init();
});

function init(){
}
</script>
<style>
body{
	margin:0px;
	padding:0px;
}
.wrapper{
	padding:1%;
}
.ibody{
	padding:5%;
}
input{
	border:2px solid black;
	margin:3%;
	width:94%;
	font-size:50pt;
}
textarea{
	border:2px solid black;
	font-size:30pt;
	width:90%;
	margin:3%;
	padding:2%;
	height:600px;
}
</style>
<script>


</script>
</head>
<body>
	<div class="wrpper">
		<div class="ihead">
		</div>
		<div class="ibody">
			<form action="/Main_AdminAddIssue" method="post">
				<!-- title -->
				<input type="text" value="<%=work_date %>" name="work_date" style="display:none;">
				<input type="text" value="<%=location_number %>" name="location_number" style="display:none;">
				<div>
					<input class="title" type="text" name="title" placeholder="제목">
				</div>
				<!-- text -->
				<div>
					<textarea name="text"></textarea>
				</div>
				<div>
					<input type="submit" value="추가하기">
				</div>
			</form>			
		</div>
		<div class="ifooter">
		
		</div>
	</div>
</body>
</html>