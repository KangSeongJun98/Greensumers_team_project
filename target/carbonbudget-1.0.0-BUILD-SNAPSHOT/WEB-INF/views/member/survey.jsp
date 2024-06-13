<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
	<div class="row">
		<img src="resources/assets/compiled/png/team_logo.png"
			style="width: 300px;">
	</div>
	
	<div class="row">
		<div class="card">
			<form action="<c:url value='ServeyDo' />" method="post">
				<div class="card-body">
					<div class="tab-content">
						<!-- 1 ~ 2 질문 -->
						<div class="row" id="row_1">
							<!-- 1번질문 -->
							<h5 class="form-label" style="margin-bottom: 5%">간단한 설문조사를
								진행해주세요 다른 사용자의 소비패턴과 비교해드립니다.</h5>
							<div class="col-sm-6">
								<label for="q1" class="form-label">1.가계부 사용 목적</label>
								<input type="hidden" name="result[0].qId" value="1">
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q1-1"
										name="result[0].aId" value="1"> <label for="q1-1"
										class="form-check-label">예산 관리</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q1-2"
										name="result[0].aId" value="2"> <label for="q1-2"
										class="form-check-label">지출 추적</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q1-3"
										name="result[0].aId" value="3"> <label for="q1-3"
										class="form-check-label">저축 목표 달성</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q1-4"
										name="result[0].aId" value="4"> <label for="q1-4"
										class="form-check-label">빚 관리</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q1-5"
										name="result[0].aId" value="5"> <label for="q1-5"
										class="form-check-label">기타</label>
								</div>
							</div>
							<!-- 2번질문 -->
							<div class="col-sm-6">
								<label for="q2" class="form-label">2.가계부 사용 빈도</label>
								<input type="hidden" name="result[1].qId" value="2">
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q2-1"
										name="result[1].aId" value="1"> <label for="q2-1"
										class="form-check-label">매일</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q2-2"
										name="result[1].aId" value="2"> <label for="q2-2"
										class="form-check-label">매주</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q2-3"
										name="result[1].aId" value="3"> <label for="q2-3"
										class="form-check-label">매월</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q2-4"
										name="result[1].aId" value="4"> <label for="q2-4"
										class="form-check-label">거의 사용하지 않음</label>
								</div>
							</div>
						</div>
						<hr>
						<!-- 3 ~ 4 질문 -->
						<div class="row" id="row_2">
							<!-- 3번째 질문 -->
							<div class="col-sm-6">
								<label for="q3" class="form-label">3.결혼 여부</label>
								<input type="hidden" name="result[2].qId" value="3">
								<div class="input-group mb-3">
									<div class="form-check">
										<input type="radio" class="form-check-input" id="q3-1"
											name="result[2].aId" value="1"> <label for="q3-1"
											class="form-check-label">예</label>
									</div>
									<div class="form-check">
										<input type="radio" class="form-check-input" id="q3-2"
											name="result[2].aId" value="2"> <label for="q3-2"
											class="form-check-label">아니오</label>
									</div>
								</div>
							</div>
							<!-- 4번째 질문 -->
							<div class="col-sm-6">
								<label for="q4" class="form-label">4.차량 보유 여부</label>
								<input type="hidden" name="result[3].qId" value="4">
								<div class="input-group mb-3">
									<div class="form-check">
										<input type="radio" class="form-check-input" id="q4-1"
											name="result[3].aId" value="1"> <label for="q4-1"
											class="form-check-label">예</label>
									</div>
									<div class="form-check">
										<input type="radio" class="form-check-input" id="q4-2"
											name="result[3].aId" value="2"> <label for="q4-2"
											class="form-check-label">아니오</label>
									</div>
								</div>
								<div class=car_input>
									<label for="autoComplete">차종: </label> <input id="autoComplete"
										type="text" name="carModel" class="q4-detail"
										placeholder="차종을 선택해주세요.">
									<input type="hidden" name="carId" class="carId" value=0>
								</div>
							</div>
						</div>
						<hr>
						<!-- 5 질문 -->
						<div class="row" id="row_3">
							<div class="col-sm-6">
								<label for="q5" class="form-label">5.연령</label>
								<input type="hidden" name="result[4].qId" value="5">
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q5-1"
										name="result[4].aId" value="1"> <label for="q5-1"
										class="form-check-label">20대</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q5-2"
										name="result[4].aId" value="2"> <label for="q5-2"
										class="form-check-label">30대</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q5-3"
										name="result[4].aId" value="3"> <label for="q5-3"
										class="form-check-label">40대</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q5-4"
										name="result[4].aId" value="4"> <label for="q5-4"
										class="form-check-label">50대</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q5-5"
										name="result[4].aId" value="5"> <label for="q5-5"
										class="form-check-label">60대 이상</label>
								</div>
							</div>

							<div class="col-sm-6">
								<label for="q6" class="form-label">6.연봉 수준을 선택해주세요</label>
								<input type="hidden" name="result[5].qId" value="6">
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q6-1"
										name="result[5].aId" value="1"> <label for="q6-1"
										class="form-check-label">3000만원 이하</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q6-2"
										name="result[5].aId" value="2"> <label for="q6-2"
										class="form-check-label">3000만원 ~5000만원</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q6-3"
										name="result[5].aId" value="3"> <label for="q6-3"
										class="form-check-label">5000만원~7000만원</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q6-4"
										name="result[5].aId" value="4"> <label for="q6-4"
										class="form-check-label">7000만원~9000만원</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q6-5"
										name="result[5].aId" value="5"> <label for="q6-5"
										class="form-check-label">9000만원 초과</label>
								</div>
							</div>
						</div>
						<hr>

						<!-- 7번째 질문 -->
						<div class="row" id="row_4">
							<div class="col-sm-6">
								<label for="q7" class="form-label">7.투자 여부</label>
								<input type="hidden" name="result[6].qId" value="7">
								<div class="input-group mb-3">
									<div class="form-check">
										<input type="radio" class="form-check-input" id="q7-1"
											name="result[6].aId" value="1"> <label for="q7-1"
											class="form-check-label">예</label>
									</div>
									<div class="form-check">
										<input type="radio" class="form-check-input" id="q7-2"
											name="result[6].aId" value="2"> <label for="q7-2"
											class="form-check-label">아니오</label>
									</div>
								</div>
							</div>
						</div>
						<hr>
						<!-- 8 질문 -->
						<div class="row" id="row_5">
							<input type="radio" name="result[7].aId" value="5" checked
								style="display: none;">
							<div class="col-sm-6">
								<label for="8" class="form-label">7-1.주요 투자 유형을 선택해주세요</label>
								<input type="hidden" name="result[7].qId" value="8">
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q8-1"
										name="result[7].aId" value="1"> <label for="q8-1"
										class="form-check-label">주식</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q8-2"
										name="result[7].aId" value="2"> <label for="q8-2"
										class="form-check-label">부동산</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q8-3"
										name="result[7].aId" value="3"> <label for="q8-3"
										class="form-check-label">가상화폐</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q8-4"
										name="result[7].aId" value="4"> <label for="q8-4"
										class="form-check-label">적금</label>
								</div>
							</div>

							<!-- 9 질문 -->
							<div class="col-sm-6">
								<label for="q9" class="form-label">7-2.투자관련 지출 금액</label> 
								<input type="hidden" name="result[8].qId" value="9">
								<input type="radio" name="result[8].aId" value="6" checked style="display: none;">
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q9-1"
										name="result[8].aId" value="1"> <label for="q9-1"
										class="form-check-label">10만원 미만</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q9-2"
										name="result[8].aId" value="2"> <label for="q9-2"
										class="form-check-label">10만원~30만원</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q9-3"
										name="result[8].aId" value="3"> <label for="q9-3"
										class="form-check-label">30만원~50만원</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q9-4"
										name="result[8].aId" value="4"> <label for="q9-4"
										class="form-check-label">50만원~100만원</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="q9-5"
										name="result[8].aId" value="5"> <label for="q9-5"
										class="form-check-label">100만원 초과</label>
								</div>
							</div>
							<hr>
						</div>
					</div>
					<button type="submit" class="btn btn-primary btn-lg w-100">제출</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		
		$("#survey_btn").click(function(){
			$('#survey-modal').modal("show"); // Bootstrap 모달 표시
			$("#row_5").hide();
			$(".car_input").hide();
		});
			
		$("#row_4 input").click(function() {
			// 질문 2번의 1번째 항목 선택시 
			if ($("#q7-2").is(":checked")) {
				// 3 ~ 4번 질문 안보이도록
				$("#row_5").hide("slow");
				$("input[name=q8]").prop("checked", false); // 선택해제 
				$("input[name=q9]").prop("checked", false);
			} else {
				// 보이도록
				$("#row_5").show("slow");
			}
		});

		$('#autoComplete').autocomplete({
			source : function(request, response) { // source: 입력시 보일 목록
				$.ajax({
					url : "<c:url value='getCarInfo' />", // 서버 URL
					type : "get", // GET 요청
					dataType : "json", // JSON 형식으로 데이터 수신
					data : {
						carModel : request.term
					}, // 요청 데이터
					success : function(data) { // 요청 성공 시
						response($.map(data, function(item) { // 데이터를 매핑하여 자동완성 형식으로 변환
							return {
								label : item.carModel, // 목록에 표시될 값
								value : item.carModel, // 선택 시 input 창에 표시될 값
								idx : item.carId
							// 항목의 인덱스 값
							};
						}));
					},
					error : function() { // 요청 실패 시
						alert("오류가 발생했습니다.");
					}
				});
			},
			focus : function(event, ui) {
				event.preventDefault(); // 기본 이벤트 동작 방지
			},

			minLength : 2, // 최소 입력 글자 수
			autoFocus : true, // 첫 번째 항목에 자동으로 초점이 맞춰짐
			delay : 10, // 자동완성 지연 시간 (ms)
			select : function(evt, ui) { // 항목 선택 시 실행
				console.log(ui.item.label); // 선택된 항목의 label 값
				console.log(ui.item.idx); // 선택된 항목의 idx 값
				$(".carId").val(ui.item.idx);
			}
		});
		

		$("#row_2 input").click(function() {
			if ($("#q4-1").is(":checked")) {
				$(".car_input").show("slow");
			} else {
				$(".car_input").hide("slow");
			}
		});

		$("#close-btn").click(function() {
			$('#survey-modal').modal('hide'); // Bootstrap 모달 숨김
		});
	});
</script>