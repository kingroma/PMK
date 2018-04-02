<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	Location location = (Location)request.getAttribute("location");
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
	setDate(new Date());
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
.selectHall{
	font-size:40pt;
	background-color:white;
	outline: 0px dotted green;
	border:1px dotted black;
}
.addWeddingInputText{
	width:60%;
	margin:3%;
	padding:2%;
	font-size:40pt;
	border:2px solid black;
}
.addDate{
	border:2px solid black;
	margin:2%;
	padding:1%;
	font-size:35pt;
}
</style>
<script>
var currentDate;
function setDate(inputDate){
	//currentDate = inputDate;
	
	var selectYear = $('#selectYear');
	var selectMonth = $('#selectMonth');
	var selectDay = $('#selectDay');
	var selectTime = $('#selectTime');
	var inputYear = inputDate.getFullYear();
	var inputMonth = inputDate.getMonth()+1;
	var inputDay = inputDate.getDate();
	
	//year
	var yearHtml = "";
	for(var i = inputYear-1 ; i < inputYear+2 ; i++){
		if(i==inputYear){
			yearHtml += "<option value='"+i+"' selected>"+i+"</option>";
		}else{
			yearHtml += "<option value='"+i+"'>"+i+"</option>";	
		}
	}
	selectYear.html(yearHtml);
	
	//month
	var monthHtml = "";
	for(var i = 1 ; i < 13 ; i++){
		var inputData = ""+i+"";
		if(i<10){
			inputData = "0"+i;
		}
		if(i==inputMonth){
			monthHtml += "<option value='"+inputData+"' selected>"+i+"</option>";
		}else{
			monthHtml += "<option value='"+inputData+"'>"+i+"</option>";	
		}
	}
	selectMonth.html(monthHtml);
	
	//day
	var dayHtml = "";
	for(var i = 1 ; i < 32 ; i ++){
		var inputData = ""+i+"";
		if(i<10){
			inputData = "0"+i;
		}
		
		if(inputDay==i){
			dayHtml += "<option value='"+inputData+"' selected>"+i+"</option>";
		}else{
			dayHtml += "<option value='"+inputData+"'>"+i+"</option>";	
		}
		
	}
	selectDay.html(dayHtml);
	
	var timeHtml = "";
	for(var i = 10 ; i < 22 ; i++){
		timeHtml += "<option value='"+i+"00'>"+i+":00</option>";
		timeHtml += "<option value='"+i+"30'>"+i+":30</option>";
	}
	selectTime.html(timeHtml);
}

</script>
</head>
<body>
	<div class="wrpper">
		<div class="ihead">
		</div>
		<div class="ibody">
			<form action="/Main_AdminAddWedding" method="post">
				<!-- add Wedding hall -->
				<input style="display:none;" type="text" value="<%=location.getLocation_number() %>" name="location_number">
				<select class="selectHall" name="hall_number">
					<%for(Hall hall : location.getHalls()) {%>
						<option value="<%=hall.getHall_number()%>"><%=hall.getName() %></option>	
					<%}%>
				</select>
				<div>
					<!-- calendar -->
					<div>
						<select class="addDate" id="selectYear" name="year" required>
						</select>
						
						<select class="addDate" id="selectMonth" name="month" required>
						</select>
						
						<select class="addDate" id="selectDay" name="day">
						</select>
						
						<select class="addDate" id="selectTime" name="time">
						</select>
					</div>
					<!-- calendar -->
				</div>
				<div>
					<!-- 신랑 / 신부 이름  -->
					<input name="man_name" class="addWeddingInputText"type="text" placeholder="신랑 이름" required></br>
					<input name="woman_name" class="addWeddingInputText"type="text" placeholder="신부 이름" required>
					<!-- 신랑 / 신부 이름  -->
				</div>
				<!-- add Wedding hall -->
				<div>
					<input class="addWeddingInputText" type="submit" value="add">	
				</div>
			</form>			
		</div>
		<div class="ifooter">
		
		</div>
	</div>
</body>
</html>