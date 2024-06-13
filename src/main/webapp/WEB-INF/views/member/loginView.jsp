<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;	
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.hidden {
	display: none;
}

</style>
</head>
<body>
	<div id="app">
		<!-- 탑 영역  -->
		<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>

		<div id="main">
			<!-- 반응형 메뉴바 -->
			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>
			<!-- 메뉴 끝 -->
 
			<!-- content -->
			<div class="page-content" style="margin-top: 7%; margin-bottom: 15%;">
				<div class="col-lg-4 login-form">
					<div class="d-flex justify-content-center">
						<img src="resources/assets/compiled/png/team_logo.png"
	                                style="width:150 height: 3em; margin-bottom: 40px" alt="Logo">			
					</div>
					<form method="post" action="<c:url value="loginDo" />">
						<div class="form-group position-relative has-icon-left mb-4">
							<input value="${cookie.rememberId.value}" type="text"
								class="form-control form-control-xl" placeholder="아이디"
								name="memId" id="memId">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="password" class="form-control form-control-xl"
								placeholder="비밀번호" name="memPw">
							<div class="form-control-icon">
								<i class="bi bi-shield-lock"></i>
							</div>
						</div>
						<div class="form-check form-check-lg d-flex align-items-end">
							<input ${cookie.rememberId.value==null ? "" : "checked"}
								class="form-check-input me-2" type="checkbox" name="remember"
								id="rememberId"> <label
								class="form-check-label text-gray-600" for="rememberId">
								아이디 기억하기 </label>
						</div>
						<div>
							<button class="btn btn-primary btn-block btn-lg shadow-lg mt-3">로그인</button>
						</div>
					</form>
				</div>
				<div class="text-center mt-5 text-lg fs-4">
					<span class="login-inner"><a class="font-bold"
						href="<c:url value='/registView'/>">회원가입</a></span>
					<div class="vr"></div>
					<span id="addIdEntry" class ="login-inner"><a class="font-bold" onclick="">아이디찾기</a></span>
                        <div class="vr"></div>
                        <span id="addPwEntry" class ="login-inner"><a class="font-bold" onclick="">비밀번호찾기</a></span>
					<div class="row">
						<div class="text-center">
							<img id="google-login" src="resources/img/web_light_sq_na@3x.png"
								style="width: 50px; margin-top: 15px; cursor: pointer;">
						</div>
					</div>
					<!-- 아이디 찾기 모달 -->
                    <div id="findIdModal" class="modal">
                    	<div class="modal-dialog modal-dialog-centered">
                    		<div class="modal-content">
                    			<span class="close">&times;</span>
                    			<h3>아이디 찾기</h3>
                    			<p class="mb-5">회원정보에 등록한 이름과 이메일을 입력해주세요.</p>
                    			<form id="idFindingForm" action="<c:url value='findIdDo' />">
                    				<div class="form-group position-relative has-icon-left mb-4">
                    					<input type="text" class="form-control form-control-xl" id="memNm" name="memNm" placeholder="이름" />
                    					<div class="form-control-icon">
                    						<i class="bi bi-person"></i>
                    					</div>
                    				</div>
                    				<div class="form-group position-relative has-icon-left mb-4">
                    					<input type="email" class="form-control form-control-xl" id="memEmail" name="memEmail" placeholder="이메일" required />
                    					<div class="form-control-icon">
                    						<i class="bi bi-envelope"></i>
                    					</div>
                    				</div>
                    				<button type="submit" id="idSubmitBtn" class="btn btn-block btn-xl btn-outline-primary font-bold mt-3" style="margin-bottom: 20px;">아이디 찾기</button>
                    			</form>
                    		</div>
                    	</div>
                    </div>
                    <!-- 아이디 찾기 모달 끝 -->
                    
                    <!-- 비밀번호 찾기 모달 -->
                    <div id="findPwModal" class="modal">
                    	<div class="modal-dialog modal-dialog-centered">
                    		<div class="modal-content">
                    			<span class="close">&times;</span>
                    			<h3>비밀번호 찾기</h3>
                    			<p class="mb-5">비밀번호를 찾고자 하는 아이디를 입력해주세요.</p>
                    			<form id="pwFindingForm" action="<c:url value='idMailCheck' />">
                    				<div class="form-group position-relative has-icon-left mb-4">
                    					<input type="text" class="form-control form-control-xl" id="memId" name="memId" placeholder="아이디" />
                    					<div class="form-control-icon">
                    						<i class="bi bi-person"></i>
                    					</div>
                    				</div>
                    				<div class="form-group position-relative has-icon-left mb-4">
                    					<input type="email" class="form-control form-control-xl" id="memEmail" name="memEmail" placeholder="이메일" required />
                    					<div class="form-control-icon">
                    						<i class="bi bi-envelope"></i>
                    					</div>
                    				</div>
                    				<button type="submit" id="pwSubmitBtn" class="btn btn-block btn-xl btn-outline-primary font-bold mt-3" style="margin-bottom: 20px;">임시 비밀번호 설정</button>
                    			</form>
                    		</div>
                    	</div>
                    </div>
                    <!-- 비밀번호 찾기 모달 끝 -->
				</div>
			</div>

			<!-- footer 영역 -->
			<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
		</div>
	</div>
	<script>
		$("#google-login").click(function() {
			$.ajax({
				url : '<c:url value="/api/v1/oauth2/google" />',
				type : "POST",
				success : function(res) {
					window.location.href = res;
				},
				error : function(e) {
					console.log(e)
				}
			});
		});
		
		// 모달 요소
		var idModal = document.getElementById("findIdModal");
		var pwModal = document.getElementById("findPwModal");
		var addIdEntry = document.getElementById("addIdEntry");
		var addPwEntry = document.getElementById("addPwEntry");
		var close = document.getElementsByClassName("close")[0];
		
		// 클릭시 모달 열림
		addIdEntry.onclick = function() {
			idModal.style.display = "block";
		}
		addPwEntry.onclick = function() {
			pwModal.style.display = "block";
		}
		
		// 클릭시 모달 닫음
		close.onclick = function() {
			idModal.style.display = "none";
			pwModal.style.display = "none";
		}
		
		// 모달 외부 클릭시 모달 닫음
		window.onclick = function(event) {
			if (event.target == idModal) {
				idModal.style.display = "none";
			} else if (event.target == pwModal) {
				pwModal.style.display = "none";
			}
		}
		
	</script>
</body>
</html>