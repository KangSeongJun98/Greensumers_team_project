<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="resources/assets/compiled/css/app.css">
<link rel="stylesheet" href="resources/assets/compiled/css/my.css">
<link rel="stylesheet" href="resources/assets/compiled/css/auth.css">
<script src="resources/assets/extensions/jquery/jquery.min.js"></script>
<script src="resources/assets/extensions/parsleyjs/parsley.min.js"></script>
<script src="resources/assets/static/js/pages/parsley.js"></script>

<!-- alert css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<c:if test="${not empty msg}">
		<script>alert("${msg}");</script>
	</c:if>
<script>

	//email코드 전송
	function changeStyleDisplay() {
		var hiddenDiv = document.getElementById("hiddenDiv");
		if (hiddenDiv.style.display === "none") {
			hiddenDiv.style.display = "";
		}
		memEmail = $("#memEmail").val()
		$.ajax({
			url : "<c:url value='sendVerifMailDo' />",
			type : 'post',
			data : {
				memEmail : memEmail
			// 여기에 이메일 값을 넣으세요.
			},
			success : function(res) { // controllor에서 list를 return 받았음
				if(res == "Success"){
					email_check = true
				}
	
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

</script>

</head>
<body>
	<div id="app">

		<!-- content -->
		<div id="auth">
			<div class="row h-100">
				<div class="col-12 col-md-2 col-lg-3"></div>
				<div class="col-12 col-md-8 col-lg-6">
					<div id="auth-left"
						style="padding-top: 20px; padding-bottom: 20px;">
						<img src="resources/assets/compiled/png/logo2.png"
							style="width: 170px; height: 100px;" alt="Logo">
						<h1 class="auth-title">아이디 찾기</h1>
						<p class="auth-subtitle mb-5">회원정보에 등록한 이름과 이메일을 입력해주세요.</p>

						<form action="<c:url value='findIdDo' />">
							<div class="form-group position-relative has-icon-left mb-4">
								<input type="text" class="form-control form-control-xl"
									id="memNm" name="memNm" placeholder="이름">
								<div class="form-control-icon">
									<i class="bi bi-person"></i>
								</div>
							</div>
							<div class="form-group position-relative has-icon-left mb-4">
								<input type="email" class="form-control form-control-xl"
									id="memEmail" name="memEmail" placeholder="이메일" required>
								<div class="form-control-icon">
									<i class="bi bi-envelope"></i>
								</div>
							</div>
							<button type="submit"
								class="btn btn-primary btn-block btn-lg shadow-lg mt-5">아이디 찾기</button>
						</form>
						<div class="text-center mt-5 text-lg fs-4">
							<p class='text-gray-600'>
								아이디가 기억났다면? <a onclick="window.close()" class="font-bold">로그인</a>.
							</p>
						</div>
					</div>
				</div>
				<div class="col-12 col-md-2 col-lg-3"></div>
			</div>

		</div>

	</div>
</body>
</html>