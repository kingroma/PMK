<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.java.wedding.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/mobile/1.5.0-alpha.1/jquery.mobile-1.5.0-alpha.1.min.js"></script>  
<title>Calendar main</title>
<%
	String user_id = (String)request.getSession().getAttribute("user_id");
	String date = request.getParameter("date");
	String location_number = request.getParameter("location_number");
	
	String[] splitDate = date.split("/");
	
	String year = splitDate[0];
	String month = splitDate[1];
	String day = splitDate[2];
	
	if(month.length()==1){
		month = "0"+month;
	}
	if(day.length()==1){
		day = "0"+day;
	}
	String showDate = year+" - "+month+" - "+day;
%>
<style>

/*  calendar css  */ 
::-webkit-scrollbar { 
    display: none; 
}
body{
	font-size:30pt;
	padding:0px;
	margin:0px;
	padding:2%;
}
iframe{
	position:fixed;
	padding:0px;
	margin:0px;
	border:0px solid black;
	width:100%;
	height:75vh;
}
.ihead{
	width:100%;
	height:10%;
	font-size:50pt;
}
.showFullDate{
	background-color:white;
}
</style>

<script>
// init function
<%
if(user_id == null){
	%>
		<%="location.href=\"/Login\""%>
	<%
}
%>


function goLoginPage(){
	location.href="/Login";
}

$(document).ready(function(){
	init();
	
	
});

function reloadFromChildrend(){
	location.reload();
}
//init function

var date = new Date('<%=date%>');
var nextDate;
var previousDate;

var location_number = <%=location_number%>
function init(){
	$.mobile.loading().hide();
	$.mobile.loader.prototype.options.textVisible = false;
	//setPreviousDateNextDate();
	initIframe();
	//clickCalendarAndFollow();
	
}

function initIframe(){
	//$('#leftIframe').attr("src","/Main_ClickDay?date="+previousDate.getFullYear()+"/"+(previousDate.getMonth()+1)+"/"+previousDate.getDate()+""+"&location_number=<%=location_number%>");
	//$('#rightIframe').attr("src","/Main_ClickDay?date="+nextDate.getFullYear()+"/"+(nextDate.getMonth()+1)+"/"+nextDate.getDate()+""+"&location_number=<%=location_number%>");
	//$('#weddingIframe').attr("src","/Main_ClickDayWedding?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");
	$('#issueIframe').attr("src","/Main_ClickDayIssue?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");
	//$('#positionIframe').attr("src","/Main_ClickDayPosition?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");
	//$('#chatIframe').attr("src","/Main_ClickDayChat?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");
}

function setPreviousDateNextDate(){
	var tempMonth = date.getMonth()+1;
	var tempYear = date.getFullYear();
	var tempDate = new Date(""+tempYear+"/"+tempMonth+"/1");
	tempDate.setDate(tempDate.getDate()-1);
	previousDate = tempDate;
	tempDate = new Date(""+tempYear+"/"+tempMonth+"/1");
	tempDate.setDate(tempDate.getDate()+1);
	nextDate = tempDate;
}

var intervalVar; 
var intervalTime;
var startPointX;
var startPointY;
var endPointX;
var endPointY;
var status = 0;
var calendarWidth;
var calAnimating  = 0;


function clickCalendarAndFollow(){
	
	
	
	var mainIframeIBody = $('#mainIframe').contents().find("#ibody");
	setTimeout(function(){
		$('#mainIframe').contents().find("#ibody").on("touchstart vmousedown",
			function(event){
			if(status!=1 && calAnimating==0){
	 			intervalTime = 0;
	 			intervalVar = setInterval(function(){
	 				intervalTime += 1;
	 				//clickAndFollowCalendar(event.clientX);
	 				},10);
	 			startPointX = event.originalEvent.touches[0].pageX;
	 			startPointY = event.originalEvent.touches[0].pageX;
	 			$(".showFullDate").html(startPointX);
	 			status = 1;
	 		}
			
		});
		$('#mainIframe').contents().find("#ibody").on("touchmove vmousemove",
				function(event){
					if(status==1&&calAnimating==0){
			 			var gab = event.originalEvent.touches[0].pageX-startPointX;
			 			var width = $('#mainIframe').contents().find("#ibody").width();
						
			 			endPointX = event.originalEvent.touches[0].pageX;
			 			endPointY = event.originalEvent.touches[0].pageX;
			 			
			 			$('#mainIframe').css("left",""+(event.originalEvent.touches[0].pageX-startPointX)+""+"px");
			 			$('#mainIframeLeft').css("left",""+(event.originalEvent.touches[0].pageX-startPointX-width)+""+"px");
			 			$('#mainIframeRight').css("left",""+(event.originalEvent.touches[0].pageX-startPointX+width)+""+"px");
			 			
			 			$(".showFullDate").html(endPointX);
	 			//alert(event.clientX-startPointX);

	 				}
				
			});	
	},
	500);
	
// 	$('#mainIframe').contents().find("#ibody").on("click",function(){
// 		alert("touchstart");
// 		if(status!=1 && calAnimating==0){
// 			intervalTime = 0;
// 			intervalVar = setInterval(function(){
// 				intervalTime += 1;
// 				//clickAndFollowCalendar(event.clientX);
// 				},10);
// 			//startPointX = event.originalEvent.touches[0].pageX;
// 			//startPointY = event.originalEvent.touches[0].pageX;
// 			//$(".showFullDate").html(startPointX);
// 			status = 1;
// 		}
// 	});
// 	$('.mainIframe').on("touchmove vmousemove",function(event){
// 		if(status==1&&calAnimating==0){
// 			var gab = event.originalEvent.touches[0].pageX-startPointX;
// 			var width = $('.mainIframe').width();
			
// 			endPointX = event.originalEvent.touches[0].pageX;
// 			endPointY = event.originalEvent.touches[0].pageX;
// 			$('.mainIframe').css("left",""+(event.originalEvent.touches[0].pageX-startPointX)+""+"px");
// 			$('.mainIframeLeft').css("left",""+(event.originalEvent.touches[0].pageX-startPointX-width)+""+"px");
// 			$('.mainIframeRight').css("left",""+(event.originalEvent.touches[0].pageX-startPointX+width)+""+"px");
			
// 			//alert(event.clientX-startPointX);

// 		}
// 	})
	
// 	$('.mainIframe').on("touchend",function(event){
// 		calAnimating=1;
// 		clearInterval(intervalVar);
// 		//alert(""+startPointX+"/"+endPointX+"/"+intervalTime+"");
// 		//changeCalendarResult();
// 		setTimeout(function(){
// 			status=0;
// 			calAnimating=0;
// 		},800)
// 	})
	
}
var isSelectMenuSelectorOn = 0;
var currentMenuSelectorPoint = 1;
function selectMenuSelector(number,event){
	var issue = $('#issueIframe');
	var wedding = $('#weddingIframe');
	var chat = $('#chatIframe');
	var position = $('#positionIframe');
	var iframeSelectorTd = $('#iframeSelector td');
	
	
	var issueLeft;
	var weddingLeft;
	var chatLeft;
	var positionLeft;
	if(currentMenuSelectorPoint!=number){
		if(isSelectMenuSelectorOn==0){
			iframeSelectorTd.css("border","1px solid white");
			iframeSelectorTd.css("border-bottom","1px solid black");
			issue.fadeOut(100);
			wedding.fadeOut(100);
			chat.fadeOut(100);
			position.fadeOut(100);

			$('#issueIframe').attr("src","");
			$('#weddingIframe').attr("src","");
			$('#chatIframe').attr("src","");
			$('#positionIframe').attr("src","");
				
			isSelectMenuSelectorOn=1;
			switch(number){
			case 1 :
				//issue
				issueLeft = "0%";
				weddingLeft = "100%";
				chatLeft = "200%";
				positionLeft = "300%";
				$('#issueIframe').attr("src","/Main_ClickDayIssue?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");
				currentMenuSelectorPoint = 1;
				break;
			case 2:
				//wedding
				issueLeft = "-100%";
				weddingLeft = "0%";
				chatLeft = "100%";
				positionLeft = "200%";
				$('#weddingIframe').attr("src","/Main_ClickDayWedding?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");
				currentMenuSelectorPoint =2 ;
				break;
			case 3:
				//chat
				issueLeft = "-200%";
				weddingLeft = "-100%";
				chatLeft = "0%";
				positionLeft = "100%";
				$('#chatIframe').attr("src","/Main_ClickDayChat?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");

				
				//document.body.scrollTop = document.body.scrollHeight;
				currentMenuSelectorPoint = 3;
				break;
			case 4:
				//position
				issueLeft = "-300%";
				weddingLeft = "-200%";
				chatLeft = "-100%";
				positionLeft = "0%";
				$('#positionIframe').attr("src","/Main_ClickDayPosition?date="+date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate()+"&location_number="+location_number+"");
				currentMenuSelectorPoint = 4;
				break;
			}
			if($(event.target).attr("class")=="menuBtn"){
				$(event.target).parent().css("border-top","1px solid black");
				$(event.target).parent().css("border-left","1px solid black");
				$(event.target).parent().css("border-right","1px solid black");
				$(event.target).parent().css("border-bottom","1px solid white");
				//$(event.target).parent().css("background-color","black");
			}else{
				$(event.target).css("border-top","1px solid black");
				$(event.target).css("border-left","1px solid black");
				$(event.target).css("border-right","1px solid black");
				$(event.target).css("border-bottom","1px solid white");
				//$(event.target).css("background-color","black");
			}
			
			setTimeout(function(){
				issue.css("left",issueLeft);
				wedding.css("left",weddingLeft);
				chat.css("left",chatLeft);
				position.css("left",positionLeft);
				
				issue.fadeIn(300);
				wedding.fadeIn(300);
				chat.fadeIn(300);
				position.fadeIn(300);
			},150);
		}
		
		//issue.animate({"left":issueLeft},300);
		//wedding.animate({"left":weddingLeft},300);
		//chat.animate({"left":chatLeft},300);
		//position.animate({"left":positionLeft},300);
		
		
		
		
		
		setTimeout(function(){isSelectMenuSelectorOn=0},400);
	}
}
</script>

<script>
//function

//function

</script>
<style>
*:focus {
    outline: none;
}
.showFullDate{
	text-align:center;
}

#issueIframe{
	position:fixed;
	left:0%;
}

#weddingIframe{
	position:fixed;
	left:100%;
}

#chatIframe{
	position:fixed;
	left:200%;
}

#positionIframe{
	position:fixed;
	left:300%;
}

#iframeSelector{
	width:100%;
	margin-top:3%;
}
#iframeSelector td{
	text-align:center;
	border:1px solid white;
	border-bottom:1px solid black;

}

.menuBtn{
	width:100px;
	height:100px;
}
</style>
</head>
<body>
	<div class="wrapper" >
		<div class="ihead">
			<div style="position:fixed">
				<img onclick="location.href='/Main'" style="margin-top:3%;margin-left:3%;width:20%;height:20%;"src="/img/homeBtn.png">
			</div>
			<div class="showFullDate">
				<%=showDate %>
			</div>
			<div>
				<table id="iframeSelector" cellspacing=0>
					<tr>
						<td onclick="selectMenuSelector(1,event)" style="border:1px solid black;border-bottom:1px solid white">
							<img class="menuBtn" src="/img/issueMenuBtn.png" >
						</td>
						<td onclick="selectMenuSelector(2,event)">
							<img class="menuBtn" src="/img/weddingMenuBtn.png" >
						</td>
						<td onclick="selectMenuSelector(3,event)">
							<img class="menuBtn" src="/img/chatMenuBtn.png" >
						</td>
						<td onclick="selectMenuSelector(4,event)">
							<img class="menuBtn" src="/img/positionMenuBtn.png" >
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="ibody" >
			<iframe id="issueIframe"></iframe>
			<iframe id="weddingIframe"></iframe>
			<iframe id="chatIframe"></iframe>
			<iframe id="positionIframe"></iframe>
		</div>
		<div class="ifooter">
		
		</div>
	</div>
</body>
</html>