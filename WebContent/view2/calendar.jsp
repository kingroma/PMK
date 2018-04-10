<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<%@ page import="com.java.user.*" %>
<%@ page import="com.java.wedding.*" %>
<%@ page import="com.java.util.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	Location location = (Location)request.getAttribute("location");
	ArrayList<Wedding> weddings = (ArrayList<Wedding>)request.getAttribute("weddings");
	ArrayList<Hall> halls = location.getHalls();
	int location_number = location.getLocation_number();
	String year = (String)request.getAttribute("year");
	String month = (String)request.getAttribute("month");
	
	Map<String,String> weddingInfoMap = (Map<String,String>)request.getAttribute("weddingInfoMap");
	
	int currentMonth = Integer.parseInt(month);
	Date date = MyDate.getDateUsingYearMonth(year, month);
	Date today = new Date();
	date.setDate(0);
	
	while(date.getDay()!=1){
		date.setDate(date.getDate()-1);
	}
	
	ArrayList<UserLocation> members = location.getUserLocations();
		
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<script>

$(document).ready(function(){
	init();
});


function init(){
	macChecker();
	parent.setIframeHeight($('body').height()+50);
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
</script>
<script>
function changeCalendar(way,event){
	parent.changeCalendar(way,event);
}
</script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
span{
}
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
	padding:2%;
	
	margin-top:20px;
	margin-bottom:20px;
}
.ibody{
	width:100%;
}
.calendarDateDiv{
	padding-left:10px;
	font-size:20pt;
}
</style>
<style>
.mainCalendar{
	width:100%;
}
.mainCalendar thead tr td{
	text-align:center;
	font-size:30pt;
}
.mainCalendar tbody tr td{
	vertical-align:text-top;
	height:150px;
	width:13%;
	border:1px solid #eeeeee;
}
.calendarDateDiv{
	background-color:#e2e2e2;
}
.calendarWeddingCount{
	font-size:25pt;
	padding:10px;
	text-align:right;
}
.calendarLeftRight{
	margin-left:20px;
	margin-right:20px;
}
.birthDay{
	font-size:20pt;
}
.birthDay img{
	width:30px;
	height:30px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="ihead">
			<div style="float:left">
			<img src="/img/left.png" class="calendarLeftRight" id="calendarLeftBtn" onclick="changeCalendar('left',event)">
				<span><%=year %> . <%=month %></span>
			<img src="/img/right.png" class="calendarLeftRight" id="calendarLeftBtn" onclick="changeCalendar('right',event)">
			</div>
			<div style="float:right;font-size:30pt;">
				<%
				int tempSize = halls.size();
				int tempIndex = 1;
				for(Hall hall : halls){
					String tempSplit="/";
					if(tempIndex==tempSize){
						tempSplit = "";
					}
					%>
						<span style="color:black"><%=hall.getName().charAt(0)%></span><span style="color:#abcdef"><%=hall.getName().substring(1,hall.getName().length()) %></span> <%=tempSplit %>
					<%tempIndex++;
				} %>
			</div>
			
			<div style="clear:both"></div>
		</div>
		<div class="ibody">
			<table class="mainCalendar">
				<thead>	
					<tr>
						<td>
							Mon
						</td>
						<td>
							Tue
						</td>
						<td>
							Wed
						</td>
						<td>
							Thu
						</td>
						<td>
							Fri
						</td>
						<td style="color:blue">
							Sat
						</td>
						<td style="color:red">
							Sun
						</td>
						
					</tr>
				</thead>
				<tbody>
					<%for(int i = 0 ; i < 6 ; i ++){%>
						<tr>
						<% for(int j = 0 ; j < 7 ; j ++){ %>
							
								<%
								String addStyle="";
								String addStyleCount = "";
								if(currentMonth != date.getMonth()+1) {
									addStyle+="color:#777777;opacity: 0.3;";	
									addStyleCount += "opacity:0.3;";
								}else if(date.getDay()==6){
									addStyle+="color:blue;";
								}else if(date.getDay()==0){
									addStyle+="color:red;";
								}
								if(today.getYear() == date.getYear() && 
										today.getMonth() == date.getMonth() &&
										today.getDate() == date.getDate()){
									addStyle+="background-color:#abcdef;color:white;";
								}
								%>
							<td onclick="parent.clickWeddingRedirect('<%=location_number%>','<%=date.getYear()%>','<%=date.getMonth()%>','<%=date.getDate()%>')">
								<div class="calendarDateDiv" style="<%=addStyle%>">
									<%=date.getDate() %>
								</div>	
								<div class="calendarWeddingCount" style="<%=addStyleCount%>">
									<%
									String tempYear = year;
									String tempMonth = ""+(date.getMonth()+1);
									String tempDate = ""+date.getDate();
									if(tempMonth.length()==1){
										tempMonth = "0"+tempMonth;
									}
									if(tempDate.length()==1){
										tempDate = "0"+tempDate;
									}
									for(Hall hall : halls){
										String keyForm = hall.getNickname()+"_"+tempYear+tempMonth+tempDate;
										String value = weddingInfoMap.get(keyForm);
										if(value!=null){%>
											<div>
												<span><%=hall.getNickname()%></span><span style="color:#abcdef;">_</span><span><%=value%></span>
											</div>
										<%}
									}
									%>
									
									
								</div>
								<%for(UserLocation userLocation : members){
									User birthUser = userLocation.getUser();
									String reg = birthUser.getRegistration_number();
									if(reg!=null && reg.length() >= 6){
										int birthMonth = Integer.parseInt(reg.substring(2, 4));
										int birthDate = Integer.parseInt(reg.substring(4, 6));
										
										if(birthMonth == date.getMonth()+1 && birthDate == date.getDate()){
											%>
												<div class="birthDay">
													<img src="/img/birth.png"><%=birthUser.getName() %>
												</div>
											<%
										}
									}
								} %>
								
								<%date.setDate(date.getDate()+1);	%>
							</td>
						<% }%>
						</tr>
					<%}%>
				</tbody>
			</table>
		</div>
		<div class="ifooter">
		</div>
	</div>
</body>
</html>