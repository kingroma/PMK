<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<%@ page import="com.java.wedding.*" %>

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- <script src="https://code.jquery.com/mobile/1.5.0-alpha.1/jquery.mobile-1.5.0-alpha.1.min.js"></script> -->
<title>Calendar main</title>
<%
	String user_id = (String)request.getSession().getAttribute("user_id");
	Location location = (Location)request.getAttribute("location");
	ArrayList<LocationChat> locationChats = (ArrayList<LocationChat>) location.getLocationChats();
	int location_number = location.getLocation_number();		
	String date=(String)request.getAttribute("date");
	boolean admin = (boolean)request.getAttribute("admin");
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
<%
if(user_id == null){
	%>
		<%="parent.location.reload();"%>
	<%
}
%>

// init function
$(document).ready(function(){
	init();
});
//init function
var date = new Date();

function init(){
	//$.mobile.loading().hide();
	//$.mobile.loader.prototype.options.textVisible = false;
	reloadAndCheckIframe();
	scrollDownInit();
	
}
</script>

<script>
//function

function scrollDownInit(){
	document.getElementById("ifooter").focus();
	var offset = $("#ifooter").offset();
    $('html, body').scrollTop(offset.top);
    $('html, body').css("scrollTop",$(this.hash).offset().top);
}

function reloadAndCheckIframe(){
	var frame = $('#reloadIframe');
	//frame.attr("src","/Main_ClickDayChat?location_number=<%=location_number%>&date=<%=date%>");
	frame.attr("src","");
	frame.attr("src","/Main_ClickDayChat?date=<%=date%>&location_number=<%=location_number%>");
	
	frame.on("load",function(){
		var iframeMainChatDiv = $('#reloadIframe').contents().find("#mainChatDiv").html();
		var mainChatDiv = $('#mainChatDiv').html();
		if(iframeMainChatDiv==mainChatDiv){
			
		}else{
			$('#mainChatDiv').html(iframeMainChatDiv);
			scrollDownInit();
		}
	});
	
	setTimeout(function(){
		reloadAndCheckIframe();
	},3000);
	
}
//function

</script>
<style>
.inputChatText{
	margin:5px;
	padding:0px;
	margin-left:3%;
	margin-right:2%;
	width:80%;
	font-size:50pt;
	border:2px solid black;
}
.inputChatSubmit{
	position:absolute;
	margin:10px;
	padding:0px;
	margin-left:85%;
	margin-right:2%;
	width:12%;
	font-size:30pt;
}
.inputChatDiv{
	height:10%;
	background-color:white;
}
.ihead{
	position:fixed;
	top:-5px;
	width:100%;
	
}
.ibody{

}
#reloadIframe{
	display:none;
}
#mainChatDiv{
	width:100%;
	height:80%;
	margin-top:10%;
	background-color:white;
	font-size:30pt;
}
#ifooter{
	height:20%;
	top:90%;
}
</style>
</head>
<body>
	<div class="wrapper" >
		<div class="ihead">
			<div class="inputChatDiv">
			  
				<form action="/Main_ClickDayChat?location_number=<%=location_number%>&date=<%=date %>" method="post">
					<div>
						
						<input class="inputChatSubmit" type="submit" value=">>"/>
						<input class="inputChatText" type="text" name="text" placeholder="message...."/>
					</div>
				</form>
				
			</div>
		</div>
		<iframe id="reloadIframe"></iframe>
		<div id="ibody" >
			<div id="mainChatDiv">
				<%for  (Object chatObj : locationChats.toArray()){
					LocationChat chat = (LocationChat)chatObj;
					%>
						<div>
							<%=chat.getUser().getName() %>/<%=chat.getUser().getNickname() %>:
							<%=chat.getText() %>
						</div>
					<%
				}%>
			</div>
			<div>
			
			</div>
		</div>
		<div style="clear:both;"></div>
		
		<div id="ifooter">
			
		</div>
	</div>
</body>
</html>