<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.java.user.*" %>
<%@ page import="com.java.location.*" %>
<%@ page import="com.java.hall.*" %>
<%@ page import="com.java.wedding.*" %>

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/mobile/1.5.0-alpha.1/jquery.mobile-1.5.0-alpha.1.min.js"></script>
<script src="/js/jQueryRotate_v_2_3.js"></script>
<title>Calendar main</title>
<%
	Location location = (Location)request.getAttribute("location");
	String work_date = (String)request.getAttribute("work_date");
	ArrayList<Hall> halls = location.getHalls();
	ArrayList<LocationPosition> locationPositions = (ArrayList<LocationPosition>)request.getAttribute("locationPositions");
	ArrayList<UserWorkDate> userWorkDates = (ArrayList<UserWorkDate>)request.getAttribute("userWorkDates");
	ArrayList<UserLocation> userLocations = (ArrayList<UserLocation>)request.getAttribute("userLocations");
	String user_id = (String)request.getSession().getAttribute("user_id");
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
.addBtn{
	position:fixed;
	top:90%;
	margin-left:87%;
	width:auto;
	padding:10px;
	border-radius:50px;
	background-color:#abcdef;
	text-align:center;
	font-size:35pt;
	vertical-align:middle;
}

.positionTitle{
	margin:1%;
	margin-top:3%;
	background-color:#e2e2e2;
	text-align:center;
	padding:2%;
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
	$.mobile.loading().hide();
	$.mobile.loader.prototype.options.textVisible = false;
}
</script>

<script>
//function

//function

</script>
<style>
.hallName{
	padding:10px;
	font-size:30pt;
	padding-left:10%;
}
.positionLeft{
	width:65%;
}
.showPositionDiv{
	padding-left:5%;
}
.showPositionUser{
	position:absolute;
	top:5%;
	left:70%;
	width:30%;
	background-color:white;
	vertical-align:text-top;
	height:400px;
}
.userWorkDate{
	background-color:#abcdef;
	text-align:center;
	margin:1%;
}
.userLocation{
	background-color:red;
	text-align:center;
}
.positionDetailDiv{
	padding-left:5%;
	font-size:25pt;
}

.userPositionSpan{
	width:33%;
	text-align:center;
} 

#adminPositionSetting{
	display:none;
	
}
</style>
<script>
//position shake
var shakeTargetUserStatus = false;
var shakeTargetUserTo = -2;
var shakeTargetPrevious = null;
var shakeTargetInterval = null;
var currentUserId = null;
function shakeUser(event){
	var target = $(event.target);
	currentUserId = target.attr('user_id');
	if(shakeTargetInterval==null){
		shakeTargetInterval = setInterval(function(){
			target.rotate({
			      duration:80,
			      angle: 0,
			      animateTo: shakeTargetUserTo
			});
			shakeTargetUserTo = -shakeTargetUserTo;
		},120);
		shakeTargetPrevious = target;
		
	}else{
		clearInterval(shakeTargetInterval);
		shakeTargetInterval = null;
		
		shakeTargetPrevious.rotate({
		      duration:80,
		      angle: 0,
		      animateTo: 0
		});
		
		
		if(shakeTargetPrevious.attr('user_id')==target.attr('user_id')){
			shakeTargetPrevious=null;
			currentUserId = null;
		}else{
			shakeTargetInterval = setInterval(function(){
				target.rotate({
				      duration:80,
				      angle: 0,
				      animateTo: shakeTargetUserTo
				});
				shakeTargetUserTo = -shakeTargetUserTo;
			},120);
			shakeTargetPrevious = target;
		}
		
	}
}



function removePosition(event){
	var target = $(event.target);
	var confirmRemove = confirm(target.attr('position')+" / "+target.attr('user_id')+" / "+target.html()+" \n 지우시겠습니까 ? ");
	if(confirmRemove){
		target.attr('user_id');
		var tempLocationNumber = target.attr('location_number');
		var tempHallNumber = target.attr("hall_number")
		var tempUser_id = target.attr('user_id');
		var tempPosition = target.attr('position');
		
		var positionIfarme = $('#adminPositionSetting');
		var tempSrc = "/Main_AdminPositionSetting?method=delete&user_id="+tempUser_id+"&location_number="+tempLocationNumber+"&hall_number="+tempHallNumber+"&work_date=<%=work_date%>&position="+tempPosition;
		positionIfarme.attr("src",tempSrc);
		
		target.remove();
	}
	
}

//onclick="whenShakeClickPosition(event,'hall.getLocation_number()','hall.getHall_number()','work_date','팀장')">
function whenShakeClickPosition(event,location_number,hall_number,work_date,position){
	//alert(location_number+"/"+hall_number+"/"+work_date+"/"+name);
	var target = $(event.target);
	var targetDetail = target.parent().children();
	if(currentUserId!=null){
		//("<span user_id='"+locationPosition.getUser().getUser_id()+"' onclick=\"removePosition(event)\"> (" + locationPosition.getUser().getName() + "/" + locationPosition.getUser().getNickname() + ")</span>");
		var tempUser_id = shakeTargetPrevious.attr("user_id");
		var tempName = shakeTargetPrevious.attr("name");
		var tempNickname = shakeTargetPrevious.attr("nickname");
			
		var tempText =	//"<span class='userPositionSpan' user_id="+tempUser_id+" onclick=\"removePosition(event)\">("+tempName+"/"+tempNickname+")</span>"; 		
			"<span class='userPositionSpan' position='"+position+"' location_number='"+location_number+"' hall_number='"+hall_number+"' user_id='"+tempUser_id+"' onclick=\"removePosition(event)\">(" + tempName + "/" + tempNickname + ")</span>";
		
		for(var i = 0 ; i < targetDetail.length ; i++){
			if($(targetDetail[i]).attr('class')=='positionDetailDiv'){
				var targetDetailHtml =  $(targetDetail[i]).html();
				if(!targetDetailHtml.includes("(" + tempName + "/" + tempNickname + ")")){
					$(targetDetail[i]).html(targetDetailHtml+tempText);	
					var positionIfarme = $('#adminPositionSetting');
					var tempSrc = "/Main_AdminPositionSetting?method=add&user_id="+tempUser_id+"&location_number="+location_number+"&hall_number="+hall_number+"&work_date="+work_date+"&position="+position;
					positionIfarme.attr("src",tempSrc);
				}else{
					alert('exist');
				}
			}
		}
		
		clearInterval(shakeTargetInterval);
		shakeTargetInterval = null;
		
		shakeTargetPrevious.rotate({
		      duration:80,
		      angle: 0,
		      animateTo: 0
		});
	
		
	}
	
	
}

</script>
</head>

<body>
	<div class="wrapper" >
		<div class="ihead">
		
		</div>
		<div class="showPositionUser">
			<%if(admin){
				for(UserWorkDate userWorkDate : userWorkDates){
					%>
						<div name="<%=userWorkDate.getUser().getName() %>" nickname="<%=userWorkDate.getUser().getNickname() %>" user_id='<%=userWorkDate.getUser_id() %>' onclick="shakeUser(event)" class="userWorkDate">
							<%=userWorkDate.getUser_id() %>
						</div>
					<%
				}%>
				<%for(UserLocation userLocation : userLocations){
					%>
						<div user_id='<%=userLocation.getUser_id() %>' onclick="shakeUser(event)" class="userLocation">
							<%=userLocation.getUser_id() %>
						</div>
					<%
				}
			}%>
		</div>
		<div id="ibody" >
		<!-- position
			팀장 임기택 ㅁ
			스캔 김성욱
			예도 ( )
			예도 ( )
			안내 ( )
			2부 ( )
		 -->
		 	<%
		 	int hallIndex = 0;
		 	for(Hall hall : halls){
		 		%>
		 		<div class="hallName">
					<%=hall.getName() %>
				</div>
				<div class="positionLeft">
					<%
					String chief = "";
				 	String scan = "";
				 	String bridesmaid = "";
				 	String guard = "";
				 	String ebu = "";
					
				 	
					for(LocationPosition locationPosition : locationPositions){
						
						if(locationPosition.getHall_number()==hall.getHall_number()){
							String spanText = ("<span class='userPositionSpan' position='' location_number='"+hall.getLocation_number()+"' hall_number='"+hall.getHall_number()+"' user_id='"+locationPosition.getUser().getUser_id()+"' onclick=\"removePosition(event)\"> (" + locationPosition.getUser().getName() + "/" + locationPosition.getUser().getNickname() + ")</span>");		
							switch(locationPosition.getTitle()){
							case "팀장" : 
								chief += //spanText;
									("<span class='userPositionSpan' position='팀장' location_number='"+hall.getLocation_number()+"' hall_number='"+hall.getHall_number()+"' user_id='"+locationPosition.getUser().getUser_id()+"' onclick=\"removePosition(event)\"> (" + locationPosition.getUser().getName() + "/" + locationPosition.getUser().getNickname() + ")</span>");
								break;
							case "스캔" :
								scan += //spanText;
									("<span class='userPositionSpan' position='스캔' location_number='"+hall.getLocation_number()+"' hall_number='"+hall.getHall_number()+"' user_id='"+locationPosition.getUser().getUser_id()+"' onclick=\"removePosition(event)\"> (" + locationPosition.getUser().getName() + "/" + locationPosition.getUser().getNickname() + ")</span>");
								break;
							case "예도" :
								bridesmaid += //spanText;
									("<span class='userPositionSpan' position='예도' location_number='"+hall.getLocation_number()+"' hall_number='"+hall.getHall_number()+"' user_id='"+locationPosition.getUser().getUser_id()+"' onclick=\"removePosition(event)\"> (" + locationPosition.getUser().getName() + "/" + locationPosition.getUser().getNickname() + ")</span>");
								break;
							case "안내" : 
								guard += //spanText;
									("<span class='userPositionSpan' position='안내' location_number='"+hall.getLocation_number()+"' hall_number='"+hall.getHall_number()+"' user_id='"+locationPosition.getUser().getUser_id()+"' onclick=\"removePosition(event)\"> (" + locationPosition.getUser().getName() + "/" + locationPosition.getUser().getNickname() + ")</span>");
								break;
							case "2부" :
								ebu += //spanText;
									("<span class='userPositionSpan' position='2부' location_number='"+hall.getLocation_number()+"' hall_number='"+hall.getHall_number()+"' user_id='"+locationPosition.getUser().getUser_id()+"' onclick=\"removePosition(event)\"> (" + locationPosition.getUser().getName() + "/" + locationPosition.getUser().getNickname() + ")</span>");
								break;
							}
						}
					}
					%>
					<div class="showPositionDiv">
						<div>
							<div class="positionTitle" 
								onclick="whenShakeClickPosition(event,'<%=hall.getLocation_number() %>','<%=hall.getHall_number()%>','<%=work_date%>','팀장')">
								팀장
							</div>
							<div class="positionDetailDiv">
								<%=chief%>
							</div>
						</div>
						<div>
							<div class="positionTitle"
								onclick="whenShakeClickPosition(event,'<%=hall.getLocation_number() %>','<%=hall.getHall_number()%>','<%=work_date%>','스캔')">
								스캔
							</div>
							<div class="positionDetailDiv"> 
								<%=scan %>
							</div> 
						</div>
						<div>
							<div class="positionTitle"
								onclick="whenShakeClickPosition(event,'<%=hall.getLocation_number() %>','<%=hall.getHall_number()%>','<%=work_date%>','예도')">
								예도
							</div> 
							<div  class="positionDetailDiv">
								<%=bridesmaid %> 
							</div>
						</div>
						<div>
							<div class="positionTitle"
								onclick="whenShakeClickPosition(event,'<%=hall.getLocation_number() %>','<%=hall.getHall_number()%>','<%=work_date%>','안내')">
								안내
							</div>
							<div class="positionDetailDiv"> 
								<%=guard %>
							</div>
						</div>
						<div>
							<div class="positionTitle"
								onclick="whenShakeClickPosition(event,'<%=hall.getLocation_number() %>','<%=hall.getHall_number()%>','<%=work_date%>','2부')">
								2부 
							</div>
							<div class="positionDetailDiv">
								<%=ebu %> 
							</div>
						</div>
					</div>
				</div>
				
		 		<%
		 	} %>
			
		</div>
		<div style="clear:both;"></div>
		
		<div class="ifooter">
		</div>
		<%if(admin){%>
			<iframe id="adminPositionSetting">
			
			</iframe>
			<!-- 
				<div class="addBtn" onclick="">
				</div>
			 -->
		<%} %>
	</div>
</body>
</html>