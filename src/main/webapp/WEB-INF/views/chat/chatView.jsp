<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>채팅</title>
        <style>
			.chat-containerK {
				/* overflow: hidden; */
				width : 100%;
				/* max-width : 200px; */
			}
			.chatcontent {
				height: 700px;
				width : 100%;
				/* width:300px; */
				overflow-y: scroll;
			}
			.chat-fix {
				position: fixed;
				bottom: 0;
				width: 100%;
			}
			#alertK{
				display : none;
			}
			#msgi{	
				resize: none;
			}
			.myChat{
				background-color : #E0B1D0;
			}
			li{
				list-style-type:none;
			}
			.chatBox{
				display : inline-block;
			}
			.chatBox dateK{
				vertical-align: text-bottom;
			} 
			.me{
				text-align : right;
				/* text-align:center; */
			}
			.chat-box{
				max-width : 200px;
				display: inline-block;
				border-radius: 15px;
			}
			.notification{
				text-align : center;
			}
		</style>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
                <div id="chat-containerK">
					<div class="chatWrap">
						<div class="main_tit">
							<h1>방 정보: [${room.roomNo } 번방 ${room.roomName }] </h1>
						</div>
						<div class="content chatcontent border border-secondary" data-room-no="${room.roomNo }" >
							<div id="list-guestbook" class="">
							     <c:forEach items="${chatList }" var="chat">
									<!-- 내 채팅일 경우 -->
									<c:if test="${sessionScope.login.memId eq chat.memId }">
										<li data-no="" class="me Rpr-2">
											<strong class="">${chat.memNm}</strong>
											<div class="me">
												<p class='myChat chat-box text-left p-3'>${chat.chatMsg}</p>
     											<strong style="display : inline;" 
     											class="align-self-end">${chat.sendDate }</strong>
											</div>
										</li>
									</c:if>
									<!-- 다른사람의 채팅일 경우 -->
									<c:if test="${sessionScope.login.memId ne chat.memId}">
										<li data-no="" class="pl-2">
											<strong>${chat.memNm}</strong>
											<div>
												<p class='chat-box bg-light p-3'>${chat.chatMsg}</p>
												<strong style="display : inline;" 
												class="align-self-center">${chat.sendDate }</strong>
											</div>
										</li>
									</c:if>
							</c:forEach>
							</div>
						</div>
						
						<div>
							<div class="d-flex justify-content-center" style="height: 60px">
								<input type="text" id="msgi" name="msg" class="form-control" style="width: 75%; height: 100%">
								<button type="button" id="btnSend" class="send btn btn-primary" style="width: 25%; height: 100%">보내기</button>
								<button type="button" id="btnOut" class="btn btn-secondary " style="width: 25%; height: 100%">나가기</button>
							</div>
						</div>
					</div>
				</div>
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include>
		<!-- sockjs.min.js -->
		<script src="<c:url value='/js/sockjs.min.js' />"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>	
		<script>
		  $(document).ready(function(){
			  	let client;
			  	let chatBox =$(".box");
			  	let messageInput = $("#msgi");
			  	let roomNo = "${room.roomNo}";
			  	let member = $(".content").data("member");
			  	// 소켓통신 객체 생성
			  	let sock = new SockJS("<c:url value='/endpoint' />");
			  	client = Stomp.over(sock);
			  	// 최초 연결이 맺어지면 실행
			  	client.connect({"userId":"${sessionScope.login.memId}"
			  				,"roomId":roomNo},function(){
			  		
			  		// 상대방이 보낸 메세지를 전달 받을시 실행
			  		client.subscribe("/subscribe/chat/" + roomNo, function(chat){
			  			let body = JSON.parse(chat.body);
			  			if(body.type === "notification"){
			  				let html = "<div class='notification' >"+ body.message+"</div>";
			  				$("#list-guestbook").append(html);
			  				}else{
			  					$("#list-guestbook").append(renderList(body));
			  			}
			  			// 스크롤 내려가게
			  			$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
			  		});
			  	});
			  	// 나가기 버튼
			  	$("#btnOut").click(function(){
			  		disconnect();
			  		location.href="<c:url value='/chatListView' />";
			  	});
			  	// 메세지 전송버튼 클릭
			  	$("#btnSend").click(function(){
			  		sendMsg();
			  	});
			  	//엔터
			  	$("#msgi").keydown(function(e){
			  		if(e.keyCode == 13){
			  			sendMsg();
			  		}
			  	});
			  	// 창을 나가기 직전
			  	window.onbeforeunload = function(){
			  		disconnect();
			  	}
			  	function disconnect(){
			  		if(client != null){
			  			// 종료 직전 메세지를 방 참여자들에게 전달.
			  			client.send("/subscribe/chat/" + roomNo, {} ,
			  					JSON.stringify({
			  						type:"notification"
			  					   ,message : "${sessionScope.login.memId} 님이 나가셨습니다."
			  					}));
			  			client.disconnect();
			  		}
			  	}
			  	function sendMsg(){
			  		let message = messageInput.val();
			  		if(message == ""){
			  			return false;
			  		}
			  		// 메세지 전달
			  		client.send("/app/hello/" + roomNo, {}, JSON.stringify({
			  			chatMsg : message
			  		   ,memId : "${sessionScope.login.memId}"	
			  		   ,memNm : "${sessionScope.login.memNm}"
			  		   ,roomNo : roomNo
			  		}));
			  		messageInput.val('');
			  	}
			  	
			  	function renderList(vo){
			  		let date = vo.sendDate;
			  		let html = "";
			  		let content = "";
			  		// 내가 보낸 내용
			  		if(vo.memId == "${sessionScope.login.memId}" ){
			  			content = "<p class='myChat chat-box text-left p-3'>"+vo.chatMsg + "</p>";
			  			html = "<li class='me pr-2'>"
			  				+"<strong>" + vo.memNm + "</strong>"
			  				+"<div>" + content+ "</div>"
			  				+"<strong>" + date + "</strong>"
			  				+"</li>";
			  		// 다른 사람이 보낸 경우
			  		}else{
			  			content = "<p>"+vo.chatMsg + "</p>";
			  			html =  "<li class='pl-2'>"
			  				+"<strong>" + vo.memNm + "</strong>"
			  				+"<div>" + content+ "</div>"
			  				+"<strong>" + date + "</strong>"
			  				+"</li>";
			  		}
			  		return html;
			  	}
		  });	
		</script>
    </body>
</html>


