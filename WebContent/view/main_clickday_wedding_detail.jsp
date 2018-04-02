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
	Wedding wedding = (Wedding)request.getAttribute("wedding");
	int wedding_number = wedding.getWedding_number();
	boolean admin = (boolean)request.getAttribute("admin");
%>
<script>

</script>
<style>

/*  calendar css  */ 
body{
	background-color:white;
	font-size:30pt;
	width:100%;
	height:100%;
	padding:0px;
	margin:0px;
}
#ibody{
}
::-webkit-scrollbar { 
    display: none; 
}
.ifooter{
	position:absoulte;
	top:94%;
	width:100%;
	text-align:center;
}
*:focus {
    outline: none;
   }
iframe{
	position:fixed;
	padding:0px;
	margin:0px;
	border:0px solid black;
	width:100%;
	height:75vh;
}

#removeIframeBtn{
	position:fixed;
	left:95%;
	font-size:50pt;
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
	//$.mobile.loading().hide();
	//$.mobile.loader.prototype.options.textVisible = false;
}
function closeIframe(){
	parent.clickWeddingDetail();
	//$('#id', parent.document);
}
</script>

<script>
//function
function openWeddingDetailBody(event){
	var parent = $(event.target).parent();
	
	if(parent.attr("class")=="weddingDetailDiv"){
		parent.children().each(function(){
			var bodyDiv = $(this);
			if(bodyDiv.attr("class")=="weddingDetailBody"){
				if(bodyDiv.css("display")=="none"){
					bodyDiv.fadeIn(300);
				}else{
					bodyDiv.fadeOut(100);	
				}
				
			}
		});
	}
	//$($(event.target).parent()+" .weddingDetailBody").css("display","none");
	//alert("TEST");
}
var user_id = '<%=user_id%>';
function submitWeddingChat(){
	var chatInputText = $('.chatInput').val();
	var weddingCharDivHtml = $('.weddingChatDiv').html();
	$('.chatInputDisplayNone').val(chatInputText);
	$('.chatInput').val("");
	$('.weddingChatDiv').html(
			weddingCharDivHtml+"<div class='weddingDetailText'>"+user_id+":"+chatInputText+"</div>"
			);
	
	$('.weddingChatDiv').focus();
	
	var iframe = $('#weddingChatIframe');
	iframe.attr("src","/Main_ClickDayWeddingChatServer?text="+chatInputText+"&wedding_number=<%=wedding_number%>")
	setTimeout(function(){
		location.reload();
	},1000);
	//alert("TEST");
}

function reloadFromChildrend(){
	location.reload();
	//reloadFromChildrend();
}

function photoChage(){
	var uploadFile = $('#uploadBtn');
	var path = uploadFile.val()
	var lastIndex = path.lastIndexOf("\\");
	if(lastIndex>0){
		
		var filename = path.substring(11+1,path.length);
		var extension = filename.substring(filename.lastIndexOf(".")+1,filename.length);
		
		if(extension=="jpg"||extension=="png"){
			$('.fileName').val(filename);	
		}else{
			alert("jpg png 파일이 아닙니다.");		
			uploadFile.val("");
		}
	}
}

function clickAdminAddWeddingIssueBtn(){
	var div = $('#adminAddWeddingIssueDiv');
	if(div.css("display")=="none"){
		div.fadeIn(300);
	}else{
		div.fadeOut(100);
	}

}

function adminWeddingDetailDelete(issue_number){
	var iframe = $('#weddingIssueIframe');
	//iframe.attr('src','/Main_ClickDayWeddingDetail?method=deleteIssue&issue_number='+issue_number);
	
}
//function
</script>
<style>
.weddingInfo{
}
.weddingTitle{
	text-align:center;
}
.weddingInfo{
	margin:10px;
	border-radius:15px;
	border:5px solid #aaaaaa;
}
.weddingDetailHead{
	border-top-left-radius:10px;
	border-top-right-radius:10px;
	border-radius:10px;
	background-color:#e2e2e2;
	text-align:center;
}
.weddingDetailBody{
}
.weddingDetailTitle{
	margin:5px;
	padding-left:5%;
	font-size:40pt;
}
.weddingDetailText{
	margin:5px;
	font-size:25pt;
}
.weddingPhoto{
	width:auto;
	height:auto;
}
.chatInputDiv{
	
}
.chatInput{
	width:80%;
	margin:3%;
	font-size:40pt;
}
.chatSubmit{
	margin:3%;
	position:absolute;
	margin-left:83%;
	width:10%;
	height:5%;
}
.weddingDetailText{
	margin:3%;
}
.addWeddingPhotoDiv{
	padding:10px;
	margin:10px;
	border-top:1px solid #e2e2e2;
}
.uploadBtn{
	display:none;
	position:absoulte;
	margin-left:60%;
}
.fileName{
	width:50%;
	height:50px;
	margin-left:5%;
	border:2px solid #e2e2e2;
	font-size:35pt;
}
.photoInputTitle{
	width:50%;
	height:50px;
	margin-bottom:1%;
	margin-left:5%;
	border:2px solid #e2e2e2;
	font-size:35pt;
}
.photoInputSubmit{
	margin-top:4%;
	width:40%;
	height:50px;
	margin-left:30%;
	
}
.btn_file{
	display:block;
	position:absolute;
	margin-left:65%;
	width:25%;
	text-align:center;
	background-color:#e2e2e2;
	border:1px solid black;
}
#adminAddWeddingIssueBtn{
	position:absolute;
	margin-left:90%;
}
#adminAddWeddingIssueDiv{
	display:none;
	margin:3%;
	padding:2%;
	border:1px solid black;
}
.adminAddWeddingIssueTitle{
	font-size:40pt;
	width:90%;
	padding:2%;
	margin:2%;
}
.adminAddWeddingIssueText{
	width:90%;
	height:300px;
	padding:2%;
	font-size:40%;
	margin:2%;
}
.adminWeddingDetailDelete{
	font-size:40pt;
	color:red;
	margin-left:90%;
}
.adminWeddingDetailDelete input{
	border:0px solid black;
	color:red;
	font-size:40pt;
}

.weddingDetailIssueDiv{
	border:1px solid black;
}
#weddingIssueIframe{
	display:none;
}
</style>
</head>
<body>
	<div class="wrapper" >
		<iframe id="weddingIssueIframe">
		
		</iframe>
		<div class="ihead">
			<div onclick="closeIframe()" id="removeIframeBtn">
				x
			</div>
		</div>
		<div id="ibody" >
			<div class="weddingTitle">
					<%
					if(wedding!=null){
						%>
							<%=wedding.getTitle() %>
						<%
					}
					%>
			</div>
			<div class="weddingInfo">
				
				
				<!-- wedding issue -->
				<div class="weddingDetailDiv">
					<div onclick="openWeddingDetailBody(event)"class="weddingDetailHead">
						<%if(admin){%>
							<div onclick="clickAdminAddWeddingIssueBtn()" id="adminAddWeddingIssueBtn"> + </div>	
						<%} %>
						웨딩 이슈 
					</div>
					<%if(admin){%>
							<div id="adminAddWeddingIssueDiv">
								<form method="post" action='/Main_ClickDayWeddingDetail?method=addIssue'>
									<input style="display:none" name="wedding_number" value="<%=wedding.getWedding_number() %>">
									<input class='adminAddWeddingIssueTitle' type="text" name="title" placeholder="title" required>
									<textarea class='adminAddWeddingIssueText' name="text" placeholder='text' required></textarea>
									<input type='submit' value='submit'>
								</form>								
							</div>	
					<%} %>
					<div class="weddingDetailBody">
						<%
							for(WeddingIssue weddingIssue :wedding.getWeddingIssues()){
						%>
							<div class="weddingDetailIssueDiv">
								<div class="weddingDetailTitle">
									<%=weddingIssue.getTitle() %>					
								</div>
								<div class="weddingDetailText">
									<%=weddingIssue.getText() %>
								</div>
								<%if(admin){
									%>
										<div onclick="adminWeddingDetailDelete('<%=weddingIssue.getIssue_number() %>')" class="adminWeddingDetailDelete">
											<form action="/Main_ClickDayWeddingDetail?method=deleteIssue&issue_number=<%=weddingIssue.getIssue_number() %>" method="post">
												<input style="display:none;"type="text" value="<%=weddingIssue.getWedding_number() %>" name="wedding_number">
												<input type="submit" value="x">
											</form>
										</div>
									<%	
								} %>
								
							</div>
							
						<%	
							}
						%>
					</div>
				</div>
				<!-- wedding issue -->
			</div>
			<div class="weddingInfo">	
				<!-- wedding chat -->
				<div class="weddingDetailDiv">
					<div onclick="openWeddingDetailBody(event)" class="weddingDetailHead">
						웨딩 게시판
					</div>
					<div class="weddingDetailBody">
						<iframe style="display:none;" id="weddingChatIframe">
						
						</iframe>
						<div class="chatInputDiv">
							<!-- <form action="/Main_ClickDayWeddingChatServer" method="post"> -->
								<input onclick="submitWeddingChat()" class="chatSubmit" type="button" value=">>">
								<input class="chatInputDisplayNone" style="display:none" name="text" type="text">
								<input class="chatInput" type="text">
								<input class="" name="wedding_number" type="text" style="display:none" value="<%=wedding_number%>">
							<!-- </form> -->
						</div>
						<div class="weddingChatDiv">
							<%for(WeddingChat weddingChat : wedding.getWeddingChats()) {
								%>
									<div class="weddingDetailText">
										(<%=weddingChat.getUser().getName()%>/<%=weddingChat.getUser().getNickname() %>):<%=weddingChat.getText() %>
									</div>
								<%
							}%>
						</div>
					</div>
				</div>
				<!-- wedding chat -->
			</div>
			<div class="weddingInfo">
				<!-- wedding photo -->
				<div class="weddingDetailDiv">
					<div onclick="openWeddingDetailBody(event)" class="weddingDetailHead">
						웨딩 포토	
					</div>
					<div class="weddingDetailBody">
						<%
							for(WeddingPhoto weddingPhoto : wedding.getWeddingPhotos()){
								%>
									<div class="weddingDetailTitle">
										<%=weddingPhoto.getTitle() %>
									</div>
									<div class="weddingDetailText">
										<img class="weddingPhoto" src="<%=weddingPhoto.getImgUrl() %>">
									</div>							
								<%
							}
						%>
						<div class="addWeddingPhotoDiv">
							<div>
								웨딩 포토 올리기 
							</div>
							<form name="photoFileUpload" enctype="multipart/form-data" action="/Main_ClickDayWeddingPhotoServer" method="post">
								<input type="text" class="photoInputTitle" name="title" placeholder="제목" required>
								<input onchange="photoChage()" type="file" name="photo" id="uploadBtn" class="uploadBtn" required>
								<input type="text" name="wedding_number" style="display:none" value="<%=wedding_number%>">
								<label for="uploadBtn" class="btn_file">찾아보기</label>
								<input name="justTemp2" type="text" class="fileName" readonly="readonly">
								<input name="justTemp3" type="submit" class="photoInputSubmit" value="올리기" >
							</form>
						</div>
					</div>
					
				</div>
			</div>
				<!-- wedding photo -->
			
		</div>
		<div style="clear:both;"></div>
		
		<div class="ifooter">
		</div>
	</div>
</body>
</html>