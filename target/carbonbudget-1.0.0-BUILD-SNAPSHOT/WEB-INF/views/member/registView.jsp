<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

let login_check = false;
let als_check = false;
let email_check = false;
let email_duplication = true;
let code_check = false;

// 약관동의 중복체크
form_check = () => {
    if (!login_check) {
        alert("아이디를 확인해주세요");
        //$("#memId").focus();
        return false;
    } else if (email_duplication) {
        alert("이메일을 확인해주세요");
        $("#memEmail").focus();
        return false;
    } else if(!code_check){
    	alert("전송된 코드를 확인해주세요");
    	return false;
    }
    return true;
}

	//email코드 전송
	function changeStyleDisplay() {
		if (email_duplication == true){
			alert("이메일을 다시 입력해주세요")
			return
		}
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
					alert("코드가 전송됐습니다.")
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	//이메일 인증
	function checkVerification() {
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
					code_check = true;
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

	// id체크
	function checkId() {
	    $("#id-check-feedback").html("사용가능한 아이디입니다.").hide();
	    $("#id-check-invalid-feedback").html("아이디는 영문 대소문자, 한글, 숫자로 4에서 15자 사이이어야 합니다.").hide();
	    let memId = $("#memId");
	    let pattern = /^[a-zA-Z가-힣0-9]{4,15}$/; // 패턴 정의

	    if (!pattern.test(memId.val())) {
	        // 입력된 아이디가 패턴에 맞지 않으면 처리하지 않음
	        $("#id-check-invalid-feedback").show();
	        return;
	    }

	    $.ajax({
	        url: "<c:url value='loginCheck'/>",
	        type: 'post',
	        contentType: 'application/json',
	        data: JSON.stringify({
	            memId: memId.val()
	        }),
	        success: function(res) {
	            console.log(res);
	            if (res === "notnull") {
	                $("#id-check-invalid-feedback").html("중복된 아이디입니다.").show();
	                memId.attr('data-id', "");
	                memId.removeClass("is-valid");
	                memId.addClass("is-invalid");
	                document.getElementById('memId').setCustomValidity("Invalid");
	                login_check = false;
	            } else {
	                $("#id-check-feedback").html("사용가능한 아이디입니다.").show();
	                memId.attr('data-id', memId.val());
	                memId.removeClass("is-invalid");
	                memId.addClass("is-valid");
	                document.getElementById('memId').setCustomValidity("");
	                login_check = true;
	            }
	        },
	        error: function(e) {
	            console.log(e);
	            alert("아이디 확인 중 오류가 발생했습니다. 다시 시도해 주세요.");
	        }
	    });
	}

	//이메일 중복 체크
	function emailChk() {
		$("#email-check-feedback").html("사용가능한 이메일입니다.").hide();
		$("#email-check-invalid-feedback").html("중복된 이메일입니다.").hide();
		let memEmail = $("#memEmail");
		$.ajax({
			url : "<c:url value='alsCheck'/>",
			type : 'post',
			contentType : 'application/json', // Content-Type을 명시하여 JSON 형식으로 데이터를 보냄
			data : JSON.stringify({
				memEmail : memEmail.val()
			}),
			success : function(res) {
				console.log(res);
				if (res === "notnull") {
					$("#email-check-invalid-feedback").html("중복된 이메일입니다.").show();
					memEmail.attr('data-id', "");
					memEmail.removeClass("is-valid");
					memEmail.addClass("is-invalid");
	                document.getElementById('memEmail').setCustomValidity("Invalid");
	                email_duplication = true;

				} else {
					$("#email-check-feedback").html("사용가능한 이메일입니다.").show();
					memEmail.attr('data-id', memEmail.val());
					memEmail.removeClass("is-invalid");
					memEmail.addClass("is-valid");
		            document.getElementById('memEmail').setCustomValidity("");
		            email_duplication = false;
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

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
				<section id="multiple-column-form">
					<div class="row match-height">
						<div class="col-md-6 col-sm-12" id="sign-up-form">
							<div class="card">
								<div class="card-header">
									<h2 class="card-title">회원가입</h2>
								</div>
								<div class="card-content">
									<div class="card-body">
										<form class="form needs-validation" novalidate
											action="<c:url value='registDo' />"
											onsubmit="return form_check()">
											<div class="form-body">
												<div class="row">

													<!-- 버튼이 포함된 input -->
													<div class="col-12">
														<div class="form-group">
															<label for="memId" class="form-label"><i
																class="bi bi-person"></i> 아이디</label>
															<div class="input-group mb-3">
																<input type="text" class="form-control" id="memId"
																	data-id="" onkeyup="checkId()"
																	pattern="[a-zA-Z가-힣0-9]{4,15}" name="memId"
																	placeholder="4~12글자" required>

																<div id="id-check-invalid-feedback"
																	class="invalid-feedback">아이디를 확인해주세요.</div>
																<div id="id-check-feedback" class="valid-feedback"
																	style="display: none;">사용가능한 아이디입니다.</div>
															</div>
														</div>
													</div>

													<div class="col-12">
														<div class="form-group">
															<label for="memNm" class="form-label"><i
																class="bi bi-person-vcard"></i> 이름</label> <input type="text"
																class="form-control" id="memNm" name="memNm" required
																placeholder="이름">
															<div class="invalid-feedback">이름은 필수입니다.</div>
														</div>
													</div>

													<div class="col-12">
														<div class="form-group">
															<label for="memAls" class="form-label"><i
																class="bi bi-vector-pen"></i> 닉네임</label>
															<div class="input-group mb-3">
																<input type="text" class="form-control" id="memAls"
																	data-id='' name="memAls" placeholder="닉네임" required>
															<div class="invalid-feedback">닉네임을 확인해주세요.</div>
																
															</div>
														</div>
													</div>

													<div class="col-12">
														<div class="form-group">
															<label for="memEmail" class="form-label"><i
																class="bi bi-envelope"></i> 이메일</label>
															<div class="input-group mb-3">
																<input type="email" class="form-control" id="memEmail"
																	name="memEmail" placeholder="이메일" required
																	onkeyup="emailChk()">
																<button type="button"
																	class="btn btn-outline-primary col-lg-2 col-xs-4"
																	onclick="changeStyleDisplay()">
																	<i class="bi bi-send"></i>
																</button>
																<div id="email-check-feedback" class="valid-feedback"
																	style="display: none">사용가능한 이메일입니다.</div>
																<div id="email-check-invalid-feedback"
																	class="invalid-feedback">이메일은 필수입니다.</div>
															</div>
															<div class="input-group mb-3" id="hiddenDiv"
																style="display: none;">
																<input type="text" class="form-control" id="verifCode"
																	name="verifCode" placeholder="인증코드" required>
																<button type="button"
																	class="btn btn-outline-primary col-lg-2 col-xs-4"
																	onclick="checkVerification()">
																	<i class="bi bi-check2"></i>
																</button>
																<div class="invalid-feedback">인증코드를 확인해주세요.</div>
															</div>
														</div>
													</div>

													<div class="col-12">
														<div class="form-group">
															<label for="memKornRoadNm" class="form-label"><i
																class="bi bi-house-check"></i> 주소</label>
															<div class="input-group mb-3">
																<input type="text" class="form-control"
																	id="memKornRoadNm" name="memKornRoadNm" required
																	readonly placeholder="카카오 주소찾기">
																<button type="button"
																	class="btn btn-outline-primary col-lg-2 col-xs-4"
																	onclick="execDaumPostcode()">
																	<i class="bi bi-search"></i>
																</button>
																<div class="invalid-feedback">주소는 필수입니다.</div>
															</div>
															<div class="input-group mb-3" style="display: none;">
																<input type="hidden" class="form-control" id="memAddrId"
																	name="memAddrId" placeholder="주소아이디">
															</div>
															<div class="input-group mb-3" style="display: none;">
																<input type="text" class="form-control"
																	id="memLotnoAddr" name="memLotnoAddr"
																	placeholder="지번 주소">
															</div>
															<div class="input-group mb-3">
																<input type="text" class="form-control " id="memDtlAddr"
																	name="memDtlAddr" placeholder="세부 주소">
															</div>
														</div>
													</div>

													<div class="col-12">
														<div class="form-group">
															<label for="memTel" class="form-label"><i
																class="bi bi-phone"></i> 전화번호</label> <input type="text"
																oninput="autoHyphen2(this)" maxlength="13"
																pattern="010-[0-9]{4}-[0-9]{4}" class="form-control"
																id="memTel" name="memTel" placeholder="숫자만 입력해주세요"
																required>
															<div class="invalid-feedback">연락처는 필수입니다.</div>
														</div>
													</div>

													<!-- 단독 input -->
													<div class="col-12">
														<div class="form-group">
															<label for="memPw" class="form-label"><i
																class="bi bi-lock"></i> 비밀번호</label> <input type="password"
																class="form-control" id="memPw" name="memPw"
																placeholder="영어와 숫자를 포함한 4~12글자"
																pattern="[a-zA-Z0-9]{4,15}" data-parsley-required="true"
																required>
															<div id="pw-check-invalid-feedback"
																class="invalid-feedback">비밀번호는 필수입니다.</div>
														</div>
													</div>

													<div class="col-12">
														<div class="form-group">
															<label for="pwCheck" class="form-label"><i
																class="bi bi-clipboard-check"></i> 비밀번호 확인</label> <input
																type="password" class="form-control" id="pwCheck"
																name="pwCheck" placeholder="비밀번호 확인"
																pattern="[a-zA-Z0-9]{4,15}" data-parsley-required="true"
																required>
															<div class="invalid-feedback">비밀번호를 확인해주세요.</div>
														</div>
													</div>

													<div class="row agree">
														<div class="row agree_detail">
															<strong>개인정보 수집 이용에 동의</strong>
															<ul style="list-style-type: none;">
																<li>① 수집 항목: 아이디, 비밀번호, 이름, 전화번호</li>
																<li>② 수집 이용목적 : 회원제 서비스 이용에 따른 본인 식별 절차에 이용</li>
																<li>③ 보유 및 이용기간 : 제휴 시 서비스 이용 종료 까지</li>
																<li>④ 동의 거부시 서비스 이용 신청 불가</li>
															</ul>
															<div class="form-group form-check">
																<input type="checkbox" class="form-check-input"
																	id="ck_agree" required> <label
																	class="form-check-label" for="ck_agree">위의
																	'개인정보 수집 이용'에 동의 합니다.</label>
																<div class="invalid-feedback">동의 후 회원가입 가능합니다.</div>
															</div>
														</div>
													</div>

													<div class="col-12 d-flex justify-content-end">
														<button type="submit" class="btn btn-primary me-1 mb-1">회원가입</button>
														<button type="button" onclick="location.reload(true);"
															class="btn btn-light-secondary me-1 mb-1">전체 삭제</button>
													</div>
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

			<!-- footer 영역 -->
			<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
		</div>
	</div>
	<!-- 유효성검사 -->
	<script>
		// Example starter JavaScript for disabling form submissions if there are invalid fields
		(function() {
			'use strict'

			// Fetch all the forms we want to apply custom Bootstrap validation styles to
			var forms = document.querySelectorAll('.needs-validation')

			// Loop over them and prevent submission
			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
                    //추가
                    // id val
                    const validation_memId = document.getElementById('memId');
                    const id_dataIdValue = validation_memId.getAttribute('data-id');
                    const id_inputValue = validation_memId.value;
                    
                    const validation_memAls = document.getElementById('memEmail');
                    const als_dataIdValue = validation_memAls.getAttribute('data-id');
                    const als_inputValue = validation_memAls.value;
                    
                    if (id_inputValue !== id_dataIdValue) {
                    	validation_memId.setCustomValidity("Invalid");
                    } else {
                    	validation_memId.setCustomValidity("");
                    }
                    if (als_dataIdValue !== als_inputValue) {
                    	validation_memAls.setCustomValidity("Invalid");
                    } else {
                    	validation_memAls.setCustomValidity("");
                    }

                    //추가
					if (!form.checkValidity()) {
						event.preventDefault()
						event.stopPropagation()
					}

					form.classList.add('was-validated')
				}, false)
			})
		})()

		// 연락처 하이픈
	const autoHyphen2 = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '')
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		}
	</script>
</body>
</html>