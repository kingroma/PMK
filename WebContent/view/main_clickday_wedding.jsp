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
	String user_id = (String)request.getSession().getAttribute("user_id");
	
	Location location = (Location)request.getAttribute("location");
	ArrayList<Wedding> weddings = (ArrayList<Wedding>)request.getAttribute("weddings");
	
	String date = (String)request.getAttribute("date");
	
	ArrayList<Wedding> weddingTemp  = null;
	
	Map<String,String> colors = new HashMap<String,String>();
	ArrayList<String> colorList = new ArrayList<String>();
	colorList.add("#d99694");
	colorList.add("#c3d69b");
	colorList.add("#b3a2c7");
	int index = 0;
	for(Object hallObj : location.getHalls().toArray()){
		Hall hall = (Hall)hallObj;
		hall.getHall_number();
		colors.put(""+hall.getHall_number(),colorList.get(index%colorList.size()));
		index++;
	}

	
	int width_size = (int)(98/(location.getHalls().size()));
	boolean admin = (boolean)request.getAttribute("admin");
%>
<script>
<%
	if(user_id==null){
		%>
			parent.goLoginPage();
		<%
	}
%>
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
.timestampLeft{
	padding:0px;
	margin:0px;
}
::-webkit-scrollbar { 
    display: none; 
}
.ifooter{
	position:fixed;
	top:94%;
	width:100%;
	text-align:center;
}
*:focus {
    outline: none;
}
.hour{
	width:150px;
	height:100px;
	font-size:25pt;
	text-align:center;
	vertical-align:top;
}
.timestampTable{
	vertical-align:top;
	width:100%;
	padding:0px;
	margin:0px;
}
.weddingInfo{
	border-top:1px solid black;
	margin-top:25px;
	height:90px;
	width:100%;
}
.todayIsuue{
	background-color:yellow;
	z-index:98;
	height:150px;
	vertical-align:top;
}
.wedding{
	height:100px;
	margin:1px;
	border-radius:50px;
	text-align:center;
}
.weddingName{
	font-size:20pt;
}
iframe{
	position:fixed;
	padding:0px;
	margin:0px;
	border:0px solid black;
	width:100%;
	height:100vh;
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
	touchEvent();
}
function touchEvent(){
	$.mobile.loading().hide();
	$.mobile.loader.prototype.options.textVisible = false;
	
}
function clickWeddingDetail(wedding_number){
	var iframe = $('#weddingDetail');
	if(iframe.css("display")=="block"){
		iframe.attr("src","");
		//iframe.css("display","none");
		iframe.fadeOut(100);
	}
	else{
		iframe.attr("src","/Main_ClickDayWeddingDetail?wedding_number="+wedding_number+"");
		//iframe.css("display","block");
		iframe.fadeIn(300);
	}
	
}
</script>

<script>
//function

//function

</script>
<style>

</style>
</head>
<body>
	<div class="wrapper" >
		<div class="ihead">
		
		</div>
		<iframe style="display:none;" id="weddingDetail">
		
		</iframe>
		<div id="ibody" >
			<div class="timestampLeft">
				<%for(int i = 10 ; i < 22 ; i ++){
					%>
						<table class="timestampTable" cellspacing=0>
							<tbody>
								<tr>
									<td class="hour">
										<%=i %>:00
									</td>
									
									<td>
										<div class="weddingInfo">
											<table style="width:100%;">
												<tbody>
													<tr>
													<%for(Object hallObj : location.getHalls()){
														Hall hall = (Hall)hallObj;
														%>
														<td style="width:<%=width_size%>%">
															<%
															Wedding wedding = null;
															for(Object weddingObj : weddings.toArray()){
																if(weddingObj!=null){
																	wedding = (Wedding)weddingObj;
																	if(wedding.getWork_date().equals(date+""+i+"00") && 
																			hall.getHall_number()==wedding.getHall_number()){
																		break;
																	}
																}
																wedding = null;
															}
															if(wedding!=null){
																String colorRGB = colors.get(""+hall.getHall_number());
																%>
																	<div onclick="clickWeddingDetail(<%=wedding.getWedding_number() %>)" class="wedding" style="background-color:<%=colorRGB %>;">
																		<%=hall.getNickname() %>
																		<div class="weddingName">
																			<%=wedding.getTitle() %>
																		</div>
																	</div>
																<%
															}%>
														
														</td>
														<%
													} 
													
													%>
													</tr>
												</tbody>											
											</table>
											
										</div>
									</td>
								</tr>
								<tr>
									<td class="hour">
										<%=i %>:30
									</td>
									<td>
										<div class="weddingInfo">
										
											<table style="width:100%;">
												<tbody>
													<tr>
													<%for(Object hallObj : location.getHalls()){
														Hall hall = (Hall)hallObj;
														%>
														<td style="width:<%=width_size%>%">
															<%
															Wedding wedding = null;
															for(Object weddingObj : weddings.toArray()){
																if(weddingObj!=null){
																	wedding = (Wedding)weddingObj;
																	if(wedding.getWork_date().equals(date+""+i+"30") && 
																			hall.getHall_number()==wedding.getHall_number()){
																		break;
																	}
																}
																wedding = null;
															}
															if(wedding!=null){
																String colorRGB = colors.get(""+hall.getHall_number());
																%>
																	<div onclick="clickWeddingDetail(<%=wedding.getWedding_number() %>)" class="wedding" style="background-color:<%=colorRGB %>;">
																		<%=hall.getNickname() %>
																		<div class="weddingName">
																			<%=wedding.getTitle() %>
																		</div>
																	</div>
																<%
															}%>
														
														</td>
														<%
													} 
													
													%>
													</tr>
												</tbody>											
											</table>
											
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					<%
				} %>
			</div>
		</div>
		<div style="clear:both;"></div>
		
		<div class="ifooter">
		</div>
	</div>
</body>
</html>