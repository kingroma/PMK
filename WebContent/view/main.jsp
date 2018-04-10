<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/mobile/1.5.0-alpha.1/jquery.mobile-1.5.0-alpha.1.min.js"></script>
<title>Calendar main</title>
<%
	ArrayList<String> hallNameList = new ArrayList<String>();
	Location location = (Location)request.getAttribute("location");
	int location_number = location.getLocation_number();
	for(Hall hall : location.getHalls()){
		hallNameList.add(hall.getName());
	}
	
	//hallNameList.add("WaterFall");
	//hallNameList.add("Lily");
	//hallNameList.add("Rose");

	String hallNames = "[";
	for(Object name : hallNameList){
		hallNames += "\""+name+"\",";
	}
	hallNames+="]";
		
	String text = "";
	
	
	ArrayList<String> wList = (ArrayList<String>)request.getAttribute("weddingList");
	ArrayList<String> userWorkDate = (ArrayList<String>)request.getAttribute("userWorkDate");
	
	boolean admin = (boolean)request.getAttribute("admin");
	
%>
<style>

/*  calendar css  */ 
body{
	font-size:30pt;
	padding:0px;
	margin:0px;
}
.calendar{
	position:fixed;
	width:100%;
}
.calendarLeft{
	position:fixed;
	left:-100%;
	width:100%;
}
.calendarRight{
	position:fixed;
	left:200%;
	width:100%;
}
.calendarMonth{
	width:100%;
	text-align:center;
	font-size:40pt;
	margin-bottom:30px;
	margin-top:30px;
}

.calendar thead tr td{
	text-align:center;
	width:100px;
	border:1px solid #e2e2e2;
}
.calendar tbody tr td{
	width:100px;
	border:1px solid #e2e2e2;
	height:150px;
	vertical-align:top;
}
.calendarLeft thead tr td{
	text-align:center;
	width:100px;
	border:1px solid #e2e2e2;
}
.calendarLeft tbody tr td{
	text-align:center;
	width:100px;
	border:1px solid #e2e2e2;
	height:200px;
	vertical-align:top;
}
.calendarRight thead tr td{
	text-align:center;
	width:100px;
	border:1px solid #e2e2e2;
}
.calendarRight tbody tr td{
	width:100px;
	border:1px solid #e2e2e2;
	height:200px;
	vertical-align:top;
}
.hiddenCalendarFormatYear{
	display:none;
}
.hiddenCalendarFormatMonth{
	display:none;
}
.calendarDateMonToFri{
	padding-left:10px;
	text-align:left;
	color:black;
	font-size:20pt;
}
.calendarDateSat{
	padding-left:10px;
	text-align:left;
	color:blue;
	font-size:20pt;
}
.calendarDateSun{
	padding-left:10px;
	text-align:left;
	color:red;
	font-size:20pt;
}
.calendarDateAnotherDay{
	padding-left:10px;
	text-align:left;
	color:#aaaaaa;
	font-size:20pt;
}
.weddingInfoDiv{
	color:black;
	width:auto;
	border-radius:10px;
	text-align:right;
	font-size:15pt;
}

.showWorkDateIcon{
	display:none;
	z-index:98;
	position:fixed;
	padding:0px;
	margin:0px;
	margin-top:5%;
	margin-left:5px;
	width:100px;
	height:100px;
}
.workDateIcon{
	
	
}
</style>

<script>
// init function
$(document).ready(function(){
	init();
	clickCalendarAndFollow();
});
//init function

var location_number = <%=location_number%>;

var date = new Date();
var previousDate;
var nextDate;

function init(){
	setPreviousDateNextDate();
	
	setCalendar(previousDate,$('.calendarLeft'));
	setCalendar(nextDate,$('.calendarRight'));
	setCalendar(date,$('.calendar'));
}
</script>
<script>
function reloadFromChildrend(){
	location.reload();
}

/*calendar effect*/
var intervalVar; 
var intervalTime;
var startPointX;
var startPointY;
var endPointX;
var endPointY;
var status = 0;
var calendarWidth;
var calAnimating  = 0;

function setPreviousDateNextDate(){
	var tempMonth = date.getMonth()+1;
	var tempYear = date.getFullYear();
	var tempDate = new Date(""+tempYear+"/"+tempMonth+"/1");
	tempDate.setDate(tempDate.getDate()-1);
	previousDate = tempDate;
	tempDate = new Date(""+tempYear+"/"+tempMonth+"/1");
	
	while(tempDate.getMonth()==(tempMonth)-1){
		tempDate.setDate(tempDate.getDate()+1);
	}
	nextDate = tempDate;
	
}

function clickCalendarAndFollow(){
	$('.calendar').on("touchstart vmousedown",function(event){
		//alert("TEST");
		if(status!=1&&calAnimating==0){
			intervalTime = 0;
			intervalVar = setInterval(function(){
				intervalTime += 1;
				//clickAndFollowCalendar(event.clientX);
				},10);
			startPointX = event.originalEvent.touches[0].pageX;
			startPointY = event.originalEvent.touches[0].pageX;
			
			
			status = 1;
		}
	});
	
	$('.calendar').on("touchmove vmousemove",function(event){
		if(status==1&&calAnimating==0){
			var gab = event.originalEvent.touches[0].pageX-startPointX;
			var width = $('.calendar').width();
			
			endPointX = event.originalEvent.touches[0].pageX;
			endPointY = event.originalEvent.touches[0].pageX;
			$('.calendar').css("left",""+(event.originalEvent.touches[0].pageX-startPointX)+""+"px");
			$('.calendarLeft').css("left",""+(event.originalEvent.touches[0].pageX-startPointX-width)+""+"px");
			$('.calendarRight').css("left",""+(event.originalEvent.touches[0].pageX-startPointX+width)+""+"px");
			
			//alert(event.clientX-startPointX);

		}
	})
	
	$('.calendar').on("touchend",function(event){
		calAnimating=1;
		clearInterval(intervalVar);
		//alert(""+startPointX+"/"+endPointX+"/"+intervalTime+"");
		changeCalendarResult();
		setTimeout(function(){
			status=0;
			calAnimating=0;
		},800)
	})
	
}


function changeCalendarResult(){
	var cal = $('.calendar');
	var calLeft = $('.calendarLeft');
	var calRight = $('.calendarRight');
	var gab = (startPointX-endPointX);
	var isGabOk = 350;
	var term = gab/intervalTime;
	var isChange = 0;
	if(term>10&&gab>isGabOk){
		//right  오른쪽에서 왼쪽으로 밀때 
		cal.animate({"left":"-100%"},600);
		calLeft.animate({"left":"-200%"},600);
		calRight.animate({"left":"0%"},400);
		date = nextDate;
		isChange=1;
	}
	else if(term<-10&&gab<-isGabOk){
		//left 왼쪽에서 오른쪽으로 밀떄 
		cal.animate({"left":"100%"},600);
		calLeft.animate({"left":"0%"},400);
		calRight.animate({"left":"200%"},600);
		date = previousDate;
		isChange=1;
	}else{
		cal.animate({"left":"0px"},400);
		calLeft.animate({"left":"-100%"},600);
		calRight.animate({"left":"100%"},600);
	}
	
	if(isChange==1){
		clickWorkDateBtnStatus=0;
		$('.showWorkDateIcon').fadeOut(100);
		intervalTime=999;
		startPointX = 999;
		endPointX = 999;
		setTimeout(function(){
			setPreviousDateNextDate();
			
			setCalendar(previousDate,$('.calendarLeft'));
			setCalendar(nextDate,$('.calendarRight'));
			setCalendar(date,$('.calendar'));
			
			cal.css("left","0px");
			calLeft.css("left","-100%");
			calRight.css("left","100%");
		},700);
	}
	
	//cal.attr("class","calendarLeft");
	//calLeft.attr("class","calendar");
	//clickCalendarAndFollow();
}


</script>

<script>
//function
var daysName = ["월","화","수","목","금","토","일"];
var color = ["red","orange","green"];
var hallNames = <%=hallNames%>;
var map_wInfo = new Map();
<%
		for(String hall : wList){
		String[] hallSplit = hall.split("_");
		String hallName = hallSplit[0];
		String[] info = hallSplit[1].split("/");
		//wList.add("WaterFall_2018/1/1/3");
		String year = info[0];
		String month = info[1];
		String day = info[2];
		String number = info[3];
		
		%>
			map_wInfo.set("<%=hallName%>_<%=year%>/<%=month%>/<%=day%>","<%=number%>");
		<%
	}
%>

var map_userWorkDate = new Map();
<%
	//userWorkDate
	for(String date : userWorkDate){
		
		%>
			map_userWorkDate.set("<%=date%>","o");
		<%
	}
%>

function clickWorkDateIcon(event,inputDate){
	var target = $(event.target);	
	var iframe = $('#workDateIframe');
	if(target.attr("value")=="x"){
		map_userWorkDate.set(inputDate,"o");
		iframe.attr("src","/Main_WorkDateSetServer?location_number="+location_number+"&date="+inputDate+"&ox=o");
		target.attr("value","o");
		target.attr("src","/img/workDateOk.png");
	}else if (target.attr("value")=="o"){
		map_userWorkDate.delete(inputDate);
		iframe.attr("src","/Main_WorkDateSetServer?location_number="+location_number+"&date="+inputDate+"&ox=x");
		target.attr("value","x");
		target.attr("src","/img/workDateNoTest.png");
	}
	
	
}
function setCalendar(inputDate,cal){
	//init
	var todayDate = new Date();
	//var cal = $('.calendar');
	var calendarMonth = $('.calendarMonth');
	
	var inputDateYear = inputDate.getFullYear();
	var inputDateMonth = inputDate.getMonth()+1;
	var inputDateDate = inputDate.getDate();
	var inputDateDay = inputDate.getDay();
	//0 1 2 3 4 5 6 
	//일월 화수 목금 토 
	
	var currentFirstDate = new Date(""+inputDateYear+"/"+inputDateMonth+"/1");
	if(currentFirstDate.getDay()==1){
		for(var i = 0 ; i < 7; i ++){
			currentFirstDate.setDate(currentFirstDate.getDate()-1);
		}
	}else{
		while(currentFirstDate.getDay()!=1){
			currentFirstDate.setDate(currentFirstDate.getDate()-1);
		}
	}
	
	// set calendar head
	var tableHead = "<thead>";
	for(var i = 0 ; i < daysName.length ; i ++){
		tableHead+="<td>"+daysName[i]+"</td>";
	}
	tableHead+="</thead>";
	
	var tableBody = "<tbody>";

	var idName = "cal";
	var dayClassName = "";
	for(var i = 0 ; i < 6; i ++){
		tableBody+="<tr>";
		for(var j = 0 ; j < 7 ; j ++){
			//color 토 일 월~금
			switch(currentFirstDate.getDay()){
			case 0:
				dayClassName="calendarDateSun";
				break;
			case 6:
				dayClassName="calendarDateSat";
				break;
			default :
				dayClassName="calendarDateMonToFri";
				break;
			}
			var iframeForm = ""+currentFirstDate.getFullYear()+"/"+(currentFirstDate.getMonth()+1)+"/"+currentFirstDate.getDate()+"";
			var weddingInfo = "<div class='weddingInfoDiv' onclick=\"clickDateIframe(event,'"+iframeForm+"')\">";
			for(var z = 0 ; z < hallNames.length ; z ++){
				var currentHallName = hallNames[z];
				var outputTemp = map_wInfo.get
					(currentHallName+"_"+
					currentFirstDate.getFullYear()+"/"+
					(currentFirstDate.getMonth()+1)+"/"+
					currentFirstDate.getDate());
				if(outputTemp!=undefined){
					weddingInfo += "<div >"+currentHallName+" ["+outputTemp+"]</div>";
				}
			}
			weddingInfo += "</div>";
			
			
			tableBody += 
				("<td id='"+idName+"_"+i+"_"+j+"'>");
			
			var getMapUserWorkdate = map_userWorkDate.get(""+currentFirstDate.getFullYear()+"/"+(currentFirstDate.getMonth()+1)+"/"+currentFirstDate.getDate()+"");
			//alert(""+currentFirstDate.getFullYear()+"/"+(currentFirstDate.getMonth()+1)+"/"+currentFirstDate.getDate()+"");
			//click work date icon set
			if(getMapUserWorkdate!=undefined){
				//<img class='workDateIcon' src='/img/workDateOk.png'>
				tableBody += "<img value='o' src='/img/workDateOk.png' onclick=\"clickWorkDateIcon(event,'"+currentFirstDate.getFullYear()+"/"+(currentFirstDate.getMonth()+1)+"/"+currentFirstDate.getDate()+"')\" class='showWorkDateIcon workDateIcon'>"			
			}else{
				//<img class='workDateIcon' src='/img/workDateNo.png'>
				tableBody += "<img value='x' alt='' src='/img/workDateNoTest.png' onclick=\"clickWorkDateIcon(event,'"+currentFirstDate.getFullYear()+"/"+(currentFirstDate.getMonth()+1)+"/"+currentFirstDate.getDate()+"')\" class='showWorkDateIcon workDateIcon'>"
			}
			
			if((currentFirstDate.getMonth()+1)==inputDateMonth){
				if( (currentFirstDate.getFullYear()==todayDate.getFullYear())&&
						(currentFirstDate.getMonth()==todayDate.getMonth())&&
						(currentFirstDate.getDate()==todayDate.getDate()) ){
					// today
					tableBody += "<div class='"+dayClassName+"' style='background-color:yellow;'>";
					tableBody += currentFirstDate.getDate();
					tableBody += "</div>";
				}else{
					//오늘날짜가 아닌경우 .
					tableBody += "<div class='"+dayClassName+"'>";
					tableBody += currentFirstDate.getDate();
					tableBody += "</div>";
				}
			}else{ // 사용자 입력과 다른 월이면 
				tableBody += "<div class='calendarDateAnotherDay'>";
				tableBody += currentFirstDate.getDate();
				tableBody += "</div>";
			}
			
			tableBody += weddingInfo;
			tableBody += "</td>";
			currentFirstDate.setDate(currentFirstDate.getDate()+1);
		}
		tableBody+="</tr>";
	}
	tableBody+="</tbody>";
	cal.html(tableHead+tableBody);
	calendarMonth.html(inputDateYear+" . "+inputDateMonth);
	$('.hiddenCalendarFormatYear').html(inputDateYear);
	$('.hiddenCalendarFormatMonth').html(inputDateMonth);
}

function clickCalendarChangeBtn(name){
	var gab = 0;
	if(name=="left"){
		gab = -1;
	}else if(name=="right"){
		gab = +1;
	}
	var month = date.getMonth();
	while(month==date.getMonth()){
		date.setDate(date.getDate()+gab);
	}
	setCalendar(date);
}

function clickDateIframe(event,input){
	$(event.target).parent().fadeOut(100);
	$(event.target).parent().fadeIn(500);
	setTimeout(function(){
		//alert(input);
		
		var url = "/Main_ClickDayParent?date="+input+"&location_number="+location_number;
		$(location).attr('href', url);
		//window.location.replace(url);

	},600);
}


var clickAddWeddingBtnStatus = false;
function clickAddWeddingBtn(){
	var iframe = $('.adminAddWeddingIframe');
	if(clickAddWeddingBtnStatus==false){
		clickAddWeddingBtnStatus = true;
		if(iframe.css("display")=="none"){
			iframe.attr("src","/Main_AdminAddWedding?location_number=<%=location_number%>");
			$('.ibody').fadeTo( "slow", 0.1 );
			setTimeout(function(){
				iframe.fadeIn("slow");
				
				clickAddWeddingBtnStatus = false;
			},800);
		}else{
			iframe.attr("src","");
			iframe.fadeOut("slow");
			setTimeout(function(){
				$('.ibody').fadeTo( "slow", 1.0 );
				
				clickAddWeddingBtnStatus = false;
			},800);
		}
	}
	//alert("TEST");
}
//function

</script>
<style>
*:focus {
    outline: none;
}
.work_date{
	position:fixed;
	left:90%;
	top:1%;
}
.menu{
	position:fixed;
	left:3%;
	top:1%;
	z-index:99;
}
.ifooter{
}
.addWeddingBtn{
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
.adminAddWeddingIframe{
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
.menuBar{
	position:fixed;
	background-color:red;
	width:70%;
	height:500px;
	z-index:99;
}
</style>
<script>
// swipte
$(function(){
	$.mobile.loading().hide();
	$.mobile.loader.prototype.options.textVisible = false;
	
	//swipe
// 	$(".mainCalendarDiv").on("swiperight",function(){
// 		clickCalendarChangeBtn("left");
// 	});
// 	$(".mainCalendarDiv").on("swipeleft",function(){
// 		clickCalendarChangeBtn("right");
// 	});
});

var clickWorkDateBtnStatus = 0;
function clickWorkDateBtn(){
	if(clickWorkDateBtnStatus==0){
		$('.calendar .showWorkDateIcon').fadeIn(500);
		clickWorkDateBtnStatus=1;
	}else{
		//$('.showWorkDateIcon').css("display","none");
		$('.showWorkDateIcon').fadeOut(100);
		clickWorkDateBtnStatus=0;
	}
}

function clickMenu(){
	var menu = $('.menu');
	var icon = $('.menu_icon');
	if(menu.attr('value')=='off'){  
		icon.html(">>");
		setTimeout(function(){
			icon.html(">>>");
			setTimeout(function(){
				icon.html(">>>>");
				setTimeout(function(){
					icon.html(">>><");
					setTimeout(function(){
						icon.html(">><<");
						setTimeout(function(){
							icon.html("><<<");
							setTimeout(function(){
								icon.html("<<<<");
							},300);
						},300);
					},300);
				},300);
			},300);
		},300);
		
	}else{
		
	}
}
// test
</script>
</head>
<body>
	<div id="test"></div>
	<!-- 
	<div class="menuBar">
		
	</div>
	 -->
	<%if(admin){
		%>
			<iframe class="adminAddWeddingIframe" >
			</iframe>
		<%
	}%>
	
	<div class="wrapper" >
		
		<div class="ihead">
			<div class="calendarMonth"></div>
			<!-- 
			<div value='off' class="menu" onclick="clickMenu()">
				<span class="menu_icon">></span>
			</div>
			 -->
			<div class="work_date" onclick="clickWorkDateBtn()">
				<img style="width:60px;height:50px;"src="/img/workDateBtn.png" alt="">
			</div>
			<div style="clear:both;"></div>
		</div>
		<iframe style="display:none;"id="workDateIframe"></iframe>
		<div class="ibody" >
			<div class="mainCalendarDiv"  >
				<div class="hiddenCalendarFormatYear"></div>
				<div class="hiddenCalendarFormatMonth"></div>
				<table class="calendar"></table>
				<table class="calendarLeft"></table>
				<table class="calendarRight"></table>
			</div>
		</div>
		<div class="ifooter">
			
		</div>
		
		<%if(admin){%>
				<div class="addWeddingBtn" onclick="clickAddWeddingBtn()">
					+					
				</div>
		<%} %>
	</div>
</body>
</html>