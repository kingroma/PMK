<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.java.user.*" %>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<%@ page import="com.java.wedding.*" %>
<%@ page import="com.java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	ArrayList<Location> locations =(ArrayList<Location>)request.getAttribute("locations");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<script>

$(document).ready(function(){
	init();
});

</script>
<script>
//function
function init(){
	hoverTest();
}

function clickLocationName(selector){
	var selectLocationNumber = selector.value;
}
function addLocationImg(number){
	alert(number);
}

//function
</script>
<style>
body{
	padding:0px;
	margin:0px;
	width:100%;
}
.ihead{
	padding:10px;
}
.locationMenu{
	padding:10px;
}
#locationSelector{
	font-size:30pt;
}

.locationDetailDiv{
	
}
.locationImg{
	margin:3%;
	width:90%;
	height:200px;
	border:2px dashed #e2e2e2;
}
.noLocationImgBtn{
	margin:3%;
	width:94%;
	height:200px;
	border:2px dashed #e2e2e2;
	background-color:#eeeeee;
	vertical-align:bottom;
	text-align:center;
	text-font:40pt;
}
.addLocationImgBtn{
	margin-top:70px;
	font-size:40pt;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="ihead">
			<select id="locationSelector" onchange="clickLocationName(this)">
				<%
				for (Location location : locations) {
					%>
						<option value="<%=location.getLocation_number()%>">
							<%=location.getName()%>
						</option>
					<%
				}
				%>
			</select>
		</div>
		<div class="ibody">
			<div class="locationMenu">
				<%for(Location location : locations){
					%>
						<div class="locationDetailDiv">
							<!-- location info -->
							<div>
								<%if(location.getImgUrl()==null || location.getImgUrl().isEmpty()){
									%>
										<div class="noLocationImgBtn"> 
											<div onclick="addLocationImg('<%=location.getLocation_number()%>')"class="addLocationImgBtn">+</div>
										</div>
									<%
								} else{
									%>
										<img class="locationImg" src="<%=location.getImgUrl() %>" alt="">	
									<%
								}%>
								
								
								<div>
									<div>로케이션 유저 정보</div>
									<table>
										<thead>
											<tr>
												<td>
													번호
												</td>
												<td>
													아이디 
												</td>
												<td>
													이름
												</td>
												<td>
													닉네임
												</td>
											</tr>
										</thead>
										<tbody>
											<%
											int userLocationIndex = 1;
											for (UserLocation userLocation : location.getUserLocations()){
												User user = userLocation.getUser();
												%>
												<tr>
													<td>
														<%=userLocationIndex++ %> 
													</td>
													<td>
														<%=user.getUser_id()%>
													</td>
													<td>
														<%=user.getName() %>
													</td>
													<td>
														<%=user.getNickname() %>
													</td>
												</tr>
												<%
											} %>
										</tbody>
									
										
									</table>
								</div>
							</div>
							<!--  -->
							<div>	
								<div>
									홀 정보 
								</div>
								<div>
									<%for(Hall hall : location.getHalls()){%>
										<div>
											<%=hall.getName() %>
											<%=hall.getNickname() %>
											<input type="text" value="<%=hall.getName() %>" required>
											<input type="text" value="<%=hall.getNickname() %>" required>
										</div>
										<div>
											웨딩 정보 
										</div>
										<div>
											<%for(Wedding wedding : hall.getWeddings()){
												%>
													<%=wedding.getWork_date() %>
												<%
											} %>
										</div>
									<%} %>
								</div>
							</div>
							<!--  -->
							<div>
								<div>
								
								</div>
							</div>
						</div>
					<%
				} %>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div class="ifooter">
		
		</div>
	</div>
</body>
</html>