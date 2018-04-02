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
body{
	font-size:30pt;
	width:100%;
	height:100%;
	padding:0px;
	margin:0px;
}
#ibody{
}
.wrapper{
	margin:5%;
}
.ihead{
	font-size:50pt;
	text-align:center;
}
iframe{
	border:1px solid white;
	width:90%;
	margin-left:1%;
	height:50px;
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
var isCheckUserId = false;

function joinCheck(){
	var result = true;
	var user_pw = $('#user_pw').val();
	var user_pw_check = $('#user_pw_check').val();
	if(user_pw != user_pw_check){
		alert("비번과 비번 체크가 일치하지 않음");
		result = false;
	}else if(!isCheckUserId){
		alert("아디 체크좀");
		result = false;
	}
	
	return result;
}



function checkUserId(){
	var iframe = $('#checkUserIdIframe');
	var inputUserId = $('#user_id');
	var result = false;
	if(inputUserId.val().trim()==""){
		alert('아이디가 확인되지 않습니다 ');
		inputUserId.focus();
	}else{
		iframe.attr("src","/Join_CheckUserId?user_id="+inputUserId.val());
		iframe.on('load',function(){
			var iframeResult = $('#checkUserIdIframe').contents().find('#user_id').html();
			if(iframeResult == "false"){
				// 존재 
				//alert(' x ');
				$('#checkUserIdMsg').css("color","red");
				$('#checkUserIdMsg').html("존재합니다");
				inputUserId.focus();
				inputUserId.val("");
				isCheckUserId=false;
			}else{
				//가입가능 
				isCheckUserId=true;
				$('#checkUserIdMsg').css("color","green");
				$('#checkUserIdMsg').html("가능합니다.");
			}
			
		});
	}
	//isCheckUserId = result;
}

function isKeyDownUserId(){
	isCheckUserId=false;
}

//function

</script>
<style>
.joinFormDiv{
	margin:5%;
	font-size:40pt;
	border:1px solid black;
	background-color:#e2e2e2;
}
.joinFormDiv div{
	margin:3%;
	margin-left:8%;
	
}
.joinFormDiv input{
	width:90%;
	margin:1%;
	font-size:40pt;
	border:2px solid white;
	background-color:#eeeeee;
	font-size:40pt;
}
#checkUserId{
	border:2px solid white;
	padding-left:2%;
	padding-right:2%;
	margin-left:55%;
}
#checkUserIdMsg{
	font-size:20pt;
	color:red;
	margin:0px;
	padding:0px;
	padding-left:50px;;
	color:#333333;
}
</style>
</head>
<body>
	<div class="wrapper" >
		<div class="ihead">
			회원 가입하기 
		</div>
		
		<div id="ibody" >
			<div class="joinFormDiv">
				<form onsubmit='return joinCheck()' action="/Join" method="post">
				 	<div>
				 		아이뒤 <span id="checkUserId" onclick="checkUserId()">체크</span></br>
				 		<input type="text" onchange="isKeyDownUserId()" id="user_id" name="user_id" placeholder="아뒤" required>
				 		<div id="checkUserIdMsg">
				 		</div>
				 		<iframe id="checkUserIdIframe" style="display:none;"></iframe>
				 	</div>	
				 	<div>
				 		비밀번호 </br>
				 		<input type="text" id="user_pw" name="user_pw" placeholder="비번" required>
				 	</div>
					<div>
						비밀번호 확인 </br>
						<input type="text" id="user_pw_check" name="user_pw_check" placeholder="비번 확인" required> 
					</div>
					
					<div>
						본명 </br>
						<input type="text" id="name" name="name" placeholder="본명" required>
					</div>
					
					<div>
						별명 </br>
						<input type="text" id="nickname" name="nickname" placeholder="별명" required> 
					</div>
					
					<div>
						주민등록번호 </br>
						<input type="text" id="registration_number" name="registration_number" placeholder="주민등록번호" required> </br>
					</div>
					
					<div>
						일 장소 </br>
						<input type="text" id="work_site" name="work_site" placeholder="일 장소" required>					
					</div>
					
					<div>
						핸드폰 </br>
						<input type="text" id="phone" name="phone" placeholder="핸드폰" required> 
					</div>
					<div>
						<input type="submit" value="가입하기">
					</div>
					
				
				</form>
			</div>
		
		</div>
		<div class="ifooter">
		</div>
	</div>
</body>
</html>