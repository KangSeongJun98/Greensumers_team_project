<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>

<script>
	function sendMail() {
		memEmail = $("#memEmail").val()
		$.ajax({
			url : "<c:url value='sendVerifMailDo' />",
			type : 'post',
			data : {
				memEmail : memEmail
			// 여기에 이메일 값을 넣으세요.
			},
			success : function(res) { // controllor에서 list를 return 받았음
				console.log(res)
				alert("성공적으로 메일을 전송하였습니다.");
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

	function checkVerification() {
		var hiddenDiv = document.getElementById("hiddenDiv");
		let email = $("#memEmail").val();
		let code = $("#verifCode").val();
		if (code == '') {
			alert("코드를 입력하세요");
			return false;
		}

		$.ajax({
			url : "<c:url value='/verify'/>",
			type : 'post',
			data : {
				email : email,
				code : code
			},
			success : function(res) {
				console.log(res);
				if (res === 'Y') {
					alert("인증 되었습니다.");
					if (hiddenDiv.style.display === "none") {
						hiddenDiv.style.display = "";
					}
				} else {
					alert("번호를 확인해 주세요");
					$("#verifCode").val('');
					$("#verifCode").focus();
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

	function removeMember() {
		let answer = prompt("'탈퇴하겠습니다.'를 정확히 입력해주세요.")
		
		if(answer == "탈퇴하겠습니다."){
			console.log(answer)
			$.ajax({
				url : "<c:url value='/deleteDo'/>",
				type : 'post',
				contentType : 'application/json', // Content-Type을 명시하여 JSON 형식으로 데이터를 보냄
				data : {
					memId : "${sessionScope.login.memId}"
				},
				success : function(res) {
					location.href= '<c:url value="/logoutDo" />';
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			console.log(answer)
			alert("정확히 입력해주세요.");
		}
	}
</script>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var road_addr = ''; // 주소 변수
				var jibun_addr = '';
				var bun_ge = '';
				var bun = '';
				var ge = '';
				var address_id = ''; //address 테이블에 사용되는 pk값

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					road_addr = data.roadAddress;
					jibun_addr = data.jibunAddress;
					bun_ge = data.jibunAddressEnglish.split(',')[0]
					bun = bun_ge.split('-')[0].padStart(3, '0');
					if (bun_ge.split('-')[1] === undefined) {
						ge = '000'
					} else {
						ge = bun_ge.split('-')[1].padStart(3, '0');
					}

				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					road_addr = data.roadAddress;
					jibun_addr = data.jibunAddress;
					console.log(data)
					bun_ge = data.jibunAddressEnglish.split(',')[0]
					bun = bun_ge.split('-')[0].padStart(3, '0');
					if (bun_ge.split('-')[1] === undefined) {
						ge = '000'
					} else {
						ge = bun_ge.split('-')[1].padStart(3, '0');
					}
				}
				address_id = data.bcode + bun + ge

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById("memKornRoadNm").value = road_addr;
				document.getElementById("memLotnoAddr").value = jibun_addr;
				document.getElementById("memAddrId").value = address_id;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("memDtlAddr").focus();
			}
		}).open();
	}
</script>
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
			<div class="page-heading">
				<h3>내 정보</h3>
			</div>
			<div class="page-content">
				<section class="row">
					<div class="col-12 col-lg-6">
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-header">
										<h4>${sessionScope.login.memNm}님</h4>
									</div>
									<div class="card-body">
										<div class="row" style="margin-bottom: 8px">
											<div class="col-4">
												<div class="d-flex align-items-center">
													<svg class="bi text-primary" width="32" height="32"
														fill="blue" style="width: 10px">
														<use
															xlink:href="assets/static/images/bootstrap-icons.svg#circle-fill" />
                                                    </svg>
													<h5 class="mb-0 ms-3">아이디</h5>
												</div>
											</div>
											<div class="col-8">
												<h5 class="mb-0 text-end">${sessionScope.login.memId}</h5>
											</div>
										</div>
										<div class="row">
											<div class="col-4">
												<div class="d-flex align-items-center">
													<svg class="bi text-primary" width="32" height="32"
														fill="blue" style="width: 10px">
														<use
															xlink:href="assets/static/images/bootstrap-icons.svg#circle-fill" />
                                                    </svg>
													<h5 class="mb-0 ms-3">이메일</h5>
												</div>
											</div>
											<div class="col-8">
												<h5 class="mb-0 text-end">${sessionScope.login.memEmail}</h5>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-header">
										<h4>비밀번호 변경</h4>
									</div>
									<div class="card-body">
										<form method="post" class="form form-vertical" data-parsley-validate
											action="<c:url value='/updatePwDo' />">
											<div class="form-body">
												<div id="EmailVerification">
													<div class="col-12">
														<div class="form-group">
															<label for="memEmail" class="form-label"><i
																class="bi bi-envelope"></i> 이메일</label>
															<div class="input-group mb-3">
																<input disabled value="${sessionScope.login.memEmail}"
																	type="email" class="form-control" id="memEmail"
																	name="memEmail" placeholder="이메일">
																<button type="button"
																	class="btn btn-outline-primary col-lg-2 col-xs-4"
																	onclick="sendMail()">
																	<i class="bi bi-send"></i>
																</button>
															</div>
															<div class="input-group mb-3">
																<input type="text" class="form-control" id="verifCode"
																	name="verifCode" placeholder="인증코드"
																	data-parsley-required="true">
																<button type="button"
																	class="btn btn-outline-primary col-lg-2 col-xs-4"
																	onclick="checkVerification()">
																	<i class="bi bi-check2"></i>
																</button>
															</div>
														</div>
													</div>
												</div>
												<div name="changePassword" id="hiddenDiv"
													style="display: none;">
													<div class="col-12">
														<div class="form-group">
															<label for="memPw" class="form-label"><i
																class="bi bi-lock"></i> 비밀번호</label> <input type="password"
																class="form-control" id="memPw" name="memPw"
																placeholder="영어와 숫자를 포함한 4~12글자"
																data-parsley-required="true">
														</div>
													</div>
													<div class="col-12">
														<div class="form-group">
															<label for="pwCheck" class="form-label"><i
																class="bi bi-clipboard-check"></i> 비밀번호 확인</label> <input
																type="password" class="form-control" id="pwCheck"
																name="pwCheck" placeholder="비밀번호 확인"
																data-parsley-required="true">
														</div>
													</div>
												</div>
												<div class="col-12 d-flex justify-content-end">
													<button type="submit" class="btn btn-primary me-1 mb-1">비밀번호
														변경</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-12 col-lg-6">
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-header">
										<h4>개인 정보 수정</h4>
									</div>
									<div class="card-body">
										<form method="post" class="form form-vertical" data-parsley-validate
											action="<c:url value='updateDo' />">
											<div class="form-body">
												<div class="col-12">
													<div class="form-group">
														<label for="memNm" class="form-label"><i
															class="bi bi-person-vcard"></i> 이름</label> <input
															value="${sessionScope.login.memNm }" type="text"
															class="form-control" id="memNm" name="memNm"
															placeholder="이름" data-parsley-required="true">
													</div>
												</div>
												<div class="col-12">
													<div class="form-group">
														<label for="memAls" class="form-label"><i
															class="bi bi-vector-pen"></i> 닉네임</label>
															<input value="${sessionScope.login.memAls}" type="text"
																class="form-control" id="memAls" name="memAls"
																placeholder="닉네임" data-parsley-required="true">
													</div>
												</div>
												<div class="col-12">
													<div class="form-group">
														<label for="memKornRoadNm" class="form-label"><i
															class="bi bi-house-check"></i> 주소</label>
														<div class="input-group mb-3">
															<input value="${sessionScope.login.memKornRoadNm}"
																type="text" class="form-control was-validated"
																id="memKornRoadNm" name="memKornRoadNm"
																placeholder="카카오 주소찾기" data-parsley-required="true">
															<button class="btn btn-outline-primary col-lg-2 col-xs-4"
																onclick="execDaumPostcode()">
																<i class="bi bi-search"></i>
															</button>
														</div>
														<div class="input-group mb-3" style="display: none;">
															<input value="${sessionScope.login.memAddrId}"
																type="text" class="form-control" id="memAddrId"
																name="memAddrId" placeholder="주소아이디">
														</div>
														<div class="input-group mb-3" style="display: none;">
															<input value="${sessionScope.login.memLotnoAddr}"
																type="text" class="form-control" id="memLotnoAddr"
																name="memLotnoAddr" placeholder="지번 주소">
														</div>
														<div class="input-group mb-3">
															<input value="${sessionScope.login.memDtlAddr}"
																type="text" class="form-control" id="memDtlAddr"
																name="memDtlAddr" placeholder="세부 주소">
														</div>
													</div>
												</div>
												<div class="col-12">
													<div class="form-group">
														<label for="memTel" class="form-label"><i
															class="bi bi-phone"></i> 전화번호</label> <input
															value="${sessionScope.login.memTel}" type="text"
															class="form-control" id="memTel" name="memTel"
															placeholder="숫자만 입력해주세요" data-parsley-required="true">
													</div>
												</div>
												<div class="col-12">
													<div class="form-group">
														<label for="memPw" class="form-label"><i
															class="bi bi-lock"></i> 비밀번호</label> <input type="password"
															class="form-control" id="memPw" name="memPw"
															placeholder="기존 비밀번호를 입력해주세요"
															data-parsley-required="true">
													</div>
												</div>
												<div class="col-12 d-flex justify-content-end" style="margin-top: 35px;">
													<button type="submit" class="btn btn-primary me-1 mb-1">회원
														정보 수정</button>
													<button type="button" class="btn btn-warning me-1 mb-1" onclick="removeMember()">회원
														탈퇴</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>

		<!-- footer 영역 -->
		<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	</div>
	<script src="resources/assets/compiled/js/app.js"></script>
</body>
</html>