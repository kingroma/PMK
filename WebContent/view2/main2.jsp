<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.java.user.*" %>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	ArrayList<UserLocation> userLocations = (ArrayList<UserLocation>)request.getAttribute("userLocations");
	User user = (User)request.getAttribute("user");
	String user_id = (String)request.getSession().getAttribute("user_id");
	Location location = (Location)request.getAttribute("location");
	int location_number = location.getLocation_number();
	int currentYear = new Date().getYear();
	boolean isAdmin = (boolean)request.getAttribute("isAdmin");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/js/jQueryRotate_v_2_3.js"></script>
<title>Insert title here</title>
<script>
var user_id = '<%=user_id%>';
var currentCalendar = new Date();
//var currentYear = currentCalendar.getFullYear();
//var currentMonth = currentCalendar.getMonth()+1;
//var currentDate = currentCalendar.getDate();

$(document).ready(function(){
	init();
});

function init(){
	macChecker();
	setIframeHeight();
	setCalendarIframe(currentCalendar);
	
}

function macChecker(){
	if(/(iPhone|iPod|iPad)/i.test(navigator.userAgent)) { 
	    if(/OS [2-4]_\d(_\d)? like Mac OS X/i.test(navigator.userAgent)) {  
	        // iOS 2-4 so Do Something   
	    } else if(/CPU like Mac OS X/i.test(navigator.userAgent)) {
	        // iOS 1 so Do Something 
	    } else {
	        // iOS 5 or Newer so Do Nothing
	    }
	    $('body').css("font-size","30pt");
	}else{
		//alert('android');
	}
}
function setCalendarIframe(calendar){
	var iframe = $('#calendarIframe');
	var year = calendar.getFullYear();
	var month = calendar.getMonth()+1;
	var date = calendar.getDate();
	var parameterCal = year+"_"+month+"_"+date;
	
	iframe.attr("src","/Main2Calendar?year="+year+"&month="+month+"&location_number=<%=location_number%>");
}

function setIframeHeight(height){
	var iframe = $('#calendarIframe');
	iframe.css("height",height+"px")
	//alert($(window).height());
	//iframe.css("height",$(window).height()+"px");
	//alert(iframe.css("height"));
}


</script>
<script>
function refreshPage(){
	location.reload();
}

function clickMenu(event){
	var menuDiv = $('.menuDiv');
	var ihead = $('.ihead');
	var ibody = $('.ibody');
	var target = $(event.target);
	
	target.animate({"opacity":0.3},300);
	target.animate({"opacity":1.0},300);
	
	setTimeout(function(){
		if(menuDiv.css("display") == "block"){
			menuDiv.fadeOut("slow");
			ibody.css("opacity",'1.0');
		}else{
			menuDiv.fadeIn("slow");
			ibody.css("opacity",'0.3');
		}
	},600);
}

function changeCalendar(way,event){
	var target = $(event.target);
	target.animate({"opacity":0.1},200);
	target.animate({"opacity":1.0},200);
	
	var iframe = $('#calendarIframe');
	//iframe.animate({"opacity":0.0},100);
	//iframe.animate({"opacity":1.0},300);
	if(way=='left'){
		currentCalendar.setDate(0);
		setCalendarIframe(currentCalendar);
	}else if(way=='right'){
		var month = currentCalendar.getMonth();
		
		while(currentCalendar.getMonth()==month){
			currentCalendar.setDate(currentCalendar.getDate()+1);
		}
		setCalendarIframe(currentCalendar);
	}
	
	setTimeout(function(){
	},500);
}

function calendarRefresh(event){
	var target = $(event.target);
	var iframe = $('#calendarIframe');
	target.rotate({
	      duration:1000,
	      angle: 0,
	      animateTo: 360
	});
	//iframe.animate({"opacity":0.0},100);
	//iframe.animate({"opacity":1.0},300);
	var iframe = $('#calendarIframe');
	//var year = calendar.getFullYear();
	//var month = calendar.getMonth()+1;
	//var date = calendar.getDate();
	//var parameterCal = year+"_"+month+"_"+date;
	iframe.attr("src",iframe.attr("src"));
	//iframe.attr("src","/Main2Calendar?year="+year+"&month="+month+"&location_number=<%=location_number%>");
	
}
function clickCalendarIcon(event){
	var target = $(event.target);
	//alert(target.offset().left+" / "+target.offset().top);
	var x = target.offset().left-300;
	var y = target.offset().top+70;
	
	target.animate({"opacity":0.0},200);
	target.animate({"opacity":1.0},200);
	
	setTimeout(function(){
		var subCalendar = $('#selectCalendarDay');
		var subCalendarWidth = subCalendar.css("width");
		//alert(subCalendarWidth);
		if(subCalendar.css("display")=="block"){
			subCalendar.fadeOut(200);
			//subCalendar.css("left",x);
			//subCalendar.css("top",y);
		}else{
			subCalendar.fadeIn(300);
			subCalendar.css("right",30);
			subCalendar.css("top",y);	
		}
	},400);
}

function searchSubCalendar(event){
	var target = $(event.target);
	var iframe = $('#calendarIframe');
	
	target.animate({"opacity":0.0},200);
	target.animate({"opacity":1.0},200);
	
	var subCalendarYear = $('#subCalendarYear').val();
	var subCalendarMonth = $('#subCalendarMonth').val();
	
	setTimeout(function(){
		iframe.attr("src","/Main2Calendar?year="+subCalendarYear+"&month="+subCalendarMonth+"&location_number=<%=location_number%>");
		var subCalendar = $('#selectCalendarDay');
		subCalendar.fadeOut(400);
	},400);
}

function clickAddIcon(event){
	var target = $(event.target);
	var addWeddingDiv = $('#addWeddingDiv');
	var ibody = $('.ibody');
	target.animate({"opacity":0.0},200);
	target.animate({"opacity":1.0},200);
	
	
	setTimeout(function(){
		if(addWeddingDiv.css("display")=="block"){
			addWeddingDiv.fadeOut(200);
			ibody.animate({"opacity":1.0},200);
		}else{
			addWeddingDiv.fadeIn(200);
			ibody.animate({"opacity":0.3},200);
		}
	},400);
}

function clickWeddingRedirect(location_number,year,month,day){
	year = "20"+year.substring(1,3);
	//alert(location_number + " _ " + year + " _ " + month + " _ " + day);
	alert(month.length);
	if(month.length == 1){
		month = "0"+month;
	}
	if(day.length == 1){
		day = "0"+day;
	}
	var work_date = year+month+day;
//	location.href='';
//	location.href = "/Main2Wedding?wedding_number="+wedding_number;
}

</script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
img{
	vertical-align:bottom;
}
body{
	font-family: 'Nanum Gothic';
	margin:0px;
	padding:0px;
	width:100%;
	height:100%;
	font-size:40pt;
}
.wrapper{
	
}

.ihead{
	width:100%;
}

iframe{
	padding:0px;
	margin:0px;
	border:1px solid black;
	width:100%;
	height:80vh;
	outline:0px solid white;
}

.fixed{
	position:fixed;
	width:100%;
	height:auto;
	z-index:99;
}
</style>


<style>
/* menu css */
.menuBtn{
	width:60px;
	height:60px;
	margin-left:30px;
	margin-right:20px;
}
.menuCloseBtn{
	width:60px;
	height:60px;
	margin:5px;
	padding:5px;
}
.menuUserInfo{
	margin:5px;
	padding:5px;
	
}
.menuDiv{
	width:70%;
	height:auto;
	background-color:#e2e2e2;
	display:none;
	padding:3%;
}

.menuBody{
	margin-top:10px;
	padding:5px;
}
.locationName{
	margin-left:10px;
	margin-right:10px;
}
.calendarLeftRight{
	padding-left:10px;
	padding-right:10px;
	margin-left:10px;
	margin-right:10px;
	width:63px;
	height:63px;
}

.calendarRefresh{
	padding:5px;
	padding-left:25px;
	padding-right:25px;
	margin-left:10px;
	margin-right:10px;
	width:55px;
	height:55px;
}
.calendarIcon{
	padding-left:10px;
	padding-right:7px;
	margin-left:5px;
	margin-right:0px;
	width:60px;
	height:60px;
}
.selectCalendarDay{
	position:absolute;
	display:none;
	background-color:white;
	border:5px solid #eeeeee;
	padding:20px;
	margin:0px;
}
.selectCalendarDay select{
	font-size:40pt;
	margin-left:20px;
	margin-right:20px;
	background-color:white;
	border:0px solid white;
}
#subCalendarSearch{
	width:60px;
	height:60px;
	padding:0px;
	margin:0px;
	margin-left:10px;
	vertical-align:bottom;
}
.addIcon{
	padding-left:10px;
	padding-right:15px;
	margin-left:10px;
	margin-right:20px;
	width:55px;
	height:55px;
}
.addWeddingDiv{
	padding:10px;
	position:absolute;
	left:0px;
	top:120px;
	width:80%;
	margin-left:7%;
	background-color:white;
	border:5px solid #e2e2e2;
	display:none;	
	z-index:97;
}
.addWeddingDiv select{
	font-size:40pt;
	margin-left:20px;
	margin-right:20px;
	background-color:white;
	border:0px solid white;
}
.addWeddingDiv div{
	padding:20px;
}
.addWeddingDiv input{
	width:90%;
	font-size:40pt;
	margin-left:20px;
	margin-right:20px;
	background-color:white;
	border:3px solid #abcdef;
}
.addWeddingSubmit{
	width:90%;
	height:70px;
	border:0px solid #abcdef;
	margin-left:20px;
	margin-right:20px;
	background-image: url(/img/couple.png);
}
/* menu css */
</style>
</head>
<body>
	<div class="wrapper">
		<div class="ihead">
			<!-- fixed -->
			<%if(isAdmin){
				%>
				<div id="addWeddingDiv" class="addWeddingDiv">
					<form action="/Main2AddWedding" method="post">
						<div style="display:none;">
							<input type="text" name="location_number" value="<%=location_number %>">
						</div>
						<div>
							<select class="selectHall" name="hall_number">
								<%for(Hall hall : location.getHalls()){
									%>
										<option value="<%=hall.getHall_number()%>"><%=hall.getName() %></option>
									<%
								} %>
							</select>
						</div>
						<div>
							<select name="year" >
								<%
								Date todayDate = new Date();
								int todayYear = todayDate.getYear()+1900;
								int todayMonth = todayDate.getMonth()+1;
								for(int i = 2017 ; i < 2020 ; i ++){
									String selected = "";
									if(todayYear==i){
										selected = "selected";
									}%>
										<option value="<%=i%>" <%=selected %>><%=i%></option>		
									<%
								} %>
							</select>
							<select name="month" >
								<%for(int i = 1 ; i < 13 ; i ++){
									String selected = "";
									if(todayMonth==i){
										selected = "selected";
									}%>
									<option value="<%=i%>" <%=selected %>><%=i %></option>
									<%
								}%>
							</select>
							<select name="day" >
								<%for(int i = 1 ; i < 31 ; i ++){
									%>
									<option value="<%=i%>"><%=i %></option>
									<%
								}%>
							</select>
							<select name="time" >
								<%for(int i = 10 ; i < 22 ; i ++){
									%>
									<option value="<%=i%>00"><%=i %>:00</option>
									<option value="<%=i%>30"><%=i %>:30</option>
									<%
								}%>
							</select>
						</div>
						<div>
							<input type="text" name="boy" placeholder="신랑이름">
						</div>
						<div>
							<input type="text" name="girl" placeholder="신부이름">
						</div>
						<div>
							<input class="addWeddingSubmit" type="submit" value="">
						</div>
					</form>
				</div>
				<%	
			} %>
			
			<div id="selectCalendarDay" class="selectCalendarDay">
				<select id="subCalendarYear">
					<%
					Date todayDate = new Date();
					int todayYear = todayDate.getYear()+1900;
					int todayMonth = todayDate.getMonth()+1;
					for(int i = 2017 ; i < 2020 ; i ++){
						String selected = "";
						if(todayYear==i){
							selected = "selected";
						}%>
							<option value="<%=i%>" <%=selected %>><%=i%></option>		
						<%
					} %>
				</select>
				<select id="subCalendarMonth">
					<%for(int i = 1 ; i < 13 ; i ++){
						String selected = "";
						if(todayMonth==i){
							selected = "selected";
						}%>
						<option value="<%=i%>" <%=selected %>><%=i %></option>
						<%
					}%>
				</select>
				<img onclick="searchSubCalendar(event)" id="subCalendarSearch" src="/img/search.png">
			</div>
			<div class="fixed">
				<div class="menuDiv">
					<div class="menuHead">
						<div class="menuUserInfo" style="float:left;">
							<%=user_id %>/<%=user.getName() %>/<%=user.getNickname() %>
						</div>
						
						<div style="float:right;">
							<img class="menuCloseBtn" src="/img/close.png" onclick="clickMenu(event);" >
						</div>
						<div style="clear:both"></div>
					</div>
					
					<div class="menuBody">
						<div>
							<%for(UserLocation userLocation : userLocations){%>
								<%=userLocation.getLocation().getName() %>
							<% }%>
						</div>
					</div>
						
					<div class="menuFooter"></div>
				</div>
			</div>
			<!-- fixed -->
			<div style="height:30px;"><!-- gab --></div>
			<div style="float:left;">
				<img class="menuBtn"src="/img/menu-button.png" onclick="clickMenu(event);">
			</div>
			<div class="locationName"style="float:left;">
					<%
						if(location!=null){%>
							<%=location.getName()%>
						<%}
					%>
			</div>
			<div id="yearmonth" style="float:left">
				
			</div>
			
			<div style="float:right;">
				<!-- <img src="/img/right.png" class="calendarLeftRight" id="calendarLeftBtn" onclick="changeCalendar('right',event)"> -->
				<!-- <span class="calendarLeftRight" id="calendarRightBtn" onclick="changeCalendar('right',event)">></span> -->
			</div>
			<!-- <div style="float:right;width:10px;">gab &nbsp</div> -->
			<div style="float:right">
				<!-- <img src="/img/left.png" class="calendarLeftRight" id="calendarLeftBtn" onclick="changeCalendar('left',event)"> -->
				
				<!-- <span class="calendarLeftRight" id="calendarLeftBtn" onclick="changeCalendar('left',event)">
				<
				</span>
				-->
			</div>
			<div style="float:right;" >
				<img src="/img/refresh-button.png" id="calendarRefresh" class="calendarRefresh" onclick="calendarRefresh(event)">
			</div>
			<div style="float:right;" >
				<img src="/img/calendar.png" id="calendarIcon" class="calendarIcon" onclick="clickCalendarIcon(event)">
			</div>
			<%if(isAdmin){
				%>
				<div style="float:right" id="addIcon" class="addIcon" onclick="clickAddIcon(event)">
					<img src="/img/add.png">
				</div>
				<%	
			} %>
			
			<!-- 
				1. 메뉴
				2. 날짜 
				3. 출근 날짜
			 -->
			<div style="clear:both"></div>
			<div style="height:30px;"><!-- gab --></div>
		</div>
		<div class="ibody">
			<div class="selectorBody">
			</div>
			<div class="iframeDiv">
				<iframe id="calendarIframe">
					
				</iframe>
			</div>
		</div>
		<div class="ifooter">
		</div>
	</div>
</body>
</html>