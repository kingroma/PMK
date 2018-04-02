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
<script src="https://code.jquery.com/mobile/1.5.0-alpha.1/jquery.mobile-1.5.0-alpha.1.min.js"></script>
<title>Calendar main</title>
<%
	Location location = (Location)request.getAttribute("location");
	ArrayList<LocationIssue> issues = location.getLocationIssues(); 
	boolean admin = (boolean)request.getAttribute("admin");
	String work_date = (String)request.getAttribute("work_date");
	int location_number = location.getLocation_number();
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
.addBtn{
	position:fixed;
	top:90%;
	margin-left:87%;
	width:100px;
	height:100px;
	border-radius:50px;
	background-color:#abcdef;
	text-align:center;
	font-size:53pt;
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
	$.mobile.loading().hide();
	$.mobile.loader.prototype.options.textVisible = false;
	issueNameColorSet();
}	

function reloadFromChildrend(){
	location.reload();
}
</script>

<script>
//function
var color = ["red","orange","yellow","green","skyblue","blue"];
//function
function issueNameColorSet(){
	var index = 0;
	$.each($('.issueText'),function(){
		$(this).css("color",color[index%color.length]);
		index++;
	});
}

var clickAddBtnStatus = false;
function clickAddBtn(){
	var iframe = $('.adminAddIframe');
	if(clickAddBtnStatus==false){
		clickAddBtnStatus = true;
		if(iframe.css("display")=="none"){
			iframe.attr("src","/Main_AdminAddIssue?work_date=<%=work_date%>&location_number=<%=location_number%>");
			//alert("/Main_AdminAddIssue?work_date=<%=work_date%>&location_number=<%=location_number%>");
			$('.ibody').fadeTo( "slow", 0.1 );
			setTimeout(function(){
				iframe.fadeIn("slow");
				
				clickAddBtnStatus = false;
			},800);
		}else{
			iframe.attr("src","");
			iframe.fadeOut("slow");
			setTimeout(function(){
				$('.ibody').fadeTo( "slow", 1.0 );
				
				clickAddBtnStatus = false;
			},800);
		}
	}
	//alert("TEST");
}
function removeLocationIssue(event,issue_number){
	alert('test');
	var deleteIframe = $('.adminDeleteIframe');
	
	var tempSrc = "/Main_AdminDeleteIssue?issue_number="+issue_number;
	deleteIframe.attr('src',tempSrc);
}
</script>
<style>
.issueHead{
	background-color:black;
	text-align:center;
	font-size:40pt;
}
.issueDiv{
	padding:5px;
	border-top:1px solid #e2e2e2;
	border-bottom:1px solid #e2e2e2;
	margin-top:10px;
	margin-bottom:10px;
}
.issueTitle{
	text-align:center;
	font-size:30pt;
	
}
.adminAddIframe{
	position:fixed;
	padding:0px;
	margin:0px;
	border:1px solid black;
	background-color:white;
	width:90%;
	height:80vh;
	display:none;
	left:5%;
	top:2%;
	z-index:99;	
}
.adminDeleteIframe{
	display:none;
}
.adminRemoveIssue{
	padding-left:95%;
	color:red;
	font-size:40pt;
}
</style>
</head>
<body>
	<div class="wrapper" >
		<%if(admin){
			%>
			<iframe class="adminAddIframe" >
			</iframe>
			<iframe class="adminDeleteIframe">
			</iframe>
			<%
		}%>
		<div class="ihead">
			<div class="issueHead">
				<!-- <span class="issueText">오</span><span class="issueText">늘</span><span class="issueText">의</span> -->
				<span class="issueText">대</span><span class="issueText">표</span><span class="issueText">님</span><span class="issueText">의</span>
				<span class="issueText">말</span><span class="issueText">씀</span>
			</div>
		</div>
		<div id="ibody" >
			
		 	<%for(Object issueObj : issues.toArray()){
		 		LocationIssue issue = (LocationIssue)issueObj;
		 		%>
			 		<div class="issueDiv">
			 			
			 			<h1 class="issueTitle"><%=issue.getTitle() %></h1>
			 			<div class="issueTexst"><%=issue.getText() %></div>
			 			<%if(admin){ %>
			 				<div onclick="removeLocationIssue(event,'<%=issue.getIssue_number() %>')" class='adminRemoveIssue'>x</div>
			 			<%} %>
			 		</div>
		 		<%
		 	} %>
		</div>
		<div style="clear:both;"></div>
		
		<div class="ifooter">
		</div>
		<%if(admin){%>
				<div class="addBtn" onclick="clickAddBtn()">
					+					
				</div>
		<%} %>
	</div>
</body>
</html>