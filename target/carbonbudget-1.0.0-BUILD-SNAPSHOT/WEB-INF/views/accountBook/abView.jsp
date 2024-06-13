<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>

<!-- Custom CSS -->
<link rel="stylesheet"
	href="resources/assets/compiled/css/surveyModal.css">
<link rel="stylesheet"
	href="resources/assets/compiled/css/datepicker.css">

	<!-- Font Awesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

	<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">

	<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery UI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

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

.write-modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 400px;
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

.icon-grid {
	display: grid; /* 그리드 레이아웃 사용*/
	grid-template-columns: repeat(4, 1fr); /* 4개의 열을 1fr크기로 */
	grid-auto-rows: minmax(120px, auto); /*자동으로 행의 크기를 조절 */
	grid-gap: 10px; /* 그리드 아이템 사이의 간격 */
	margin-top: 10px;
	justify-content: center; /* 가로 중앙 정렬 */
	align-items: center;
	justify-items: center;
	align-content: center;
	text-align: center;
}

.icon-grid-item {
	display: inline;
	margin: 0px;
	padding: 10px;
	cursor: pointer;
	border: 2px solid transparent; /* 기본 테두리 */
	transition: all 0.3s ease; /* 애니메이션 추가 */
	font-size: 3.5rem; /* 아이콘 크기  p태그 글자 */
}

.selected-icon {
	border: 2px solid #007bff; /* 선택된 테두리 색 */
	background-color: #e9f5ff; /* 선택된 배경색 */
}

/* 가로 선 스타일 */
.horizontal-line {
	border-bottom: 1px solid #000;
	margin: 10px 0;
	/* 여백 추가 */
}

.hidden {
	display: none;
}

.date-container {
	display: flex;
	justify-content: center;
	gap: 10px;
}

.arrow-left, .arrow-right {
	cursor: pointer;
	font-size: 2.5rem;
	color: #333;
}

#selectedMonth {
	font-size: 1.5rem;
}

.form-control.form-control-xl {
	padding: .55rem 1rem;
	font-size: 1.2rem
}

/*캘린더*/
.month-picker {
	position: relative;
	display: inline-block;
}

.month-display {
	display: flex;
	align-items: center;
	cursor: pointer;
}

#selectedMonth {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	width: 200px; /* 원하는 가로 크기로 설정 */
	display: contents; /* 요소를 인라인 블록으로 설정하여 크기 조정 가능 */
	white-space: nowrap;
}

#toggleCalendar {
	border: none;
	background: none;
	cursor: pointer;
	font-size: 16px;
}

.calendar {
	margin-top: 60px;
	display: none;
	position: absolute;
	top: 40px;
	left: -235px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	z-index: 10;
}

.calendar-header {
	display: flex;
	justify-content: space-between;
	padding: 10px;
	background-color: #f0f0f0;
	border-bottom: 1px solid #ccc;
	width: 350px;
	align-items: center;
}

.calendar-header button {
	border: none;
	background: none;
	cursor: pointer;
	font-size: 16px;
}

.calendar-body {
	padding: 10px;
}

.calendar-months {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	align-items: center;
	align-content: center;
	justify-content: center;
}

.calendar-months div {
	width: 18%; /* 4개씩 나오도록 설정 */
	display: flex; /* 플렉스 박스로 설정 */
	justify-content: center; /* 가운데 정렬 */
	align-items: center; /* 수직 가운데 정렬 */
	text-align: center;
	padding: 10px;
	cursor: pointer;
	border-radius: 4px;
	background-color: #f0f0f0;
}

.calendar-months div:hover {
	background-color: #e0e0e0;
}

.calendar-months .selected {
	background-color: #007bff;
	color: #fff;
}

/* 썸네일 이미지 css  */
.thumbnail-img {
	max-width: 300px;
	max-height: 330px;
	min-width: 300px;
	min-height: 330px;
	float: left;
}

/* ajax 로딩표시  */
#loading {
	height: 100%;
	left: 0px;
	position: fixed;
	_position: absolute;
	top: 0px;
	width: 100%;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.5;
	opacity: 0.5;
}

.loading {
	z-index: -1;
}

#loading_img {
	position: absolute;
	top: 50%;
	left: 50%;
	height: 100px;
	margin-top: -100px;
	margin-left: -100px;
	z-index: 0;
}

/* p태그 폰트  */
.p-font {
	text-align: center;
	font-size: 22px;
	font-weight: bold;
}

@media screen and (min-width: 1600px) {
	#message {
		margin: 0;
		max-height: 200px;
	}
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
			<div class="page-heading">
				<h3 id="year-display"></h3>
			</div>
			<div class="page-content">
				<section class="row">
					<div class="col-12 col-lg-9">
						<div class="row">
							<div class="col-6 col-lg-3 col-md-6">
								<div class="card">
									<div class="card-body px-4 py-4-5">
										<div class="row">
											<div class="col-12 d-flex justify-content-center">
												<form method="post" id="searchForm"
													action="<c:url value='/abView' />">
													<input type="hidden" id="monthPicker" name="yearMonth"
														value="${searchVO.yearMonth}">
													<div class="date-container d-flex align-items-center">
														<div class="arrow-left">
															<i style="color: #c9c0bd;" class="bi bi-caret-left"></i>
														</div>
														<h4 id="selectedMonth" class="text-muted font-semibold">${searchVO.yearMonth.split('-')[1]}</h4>
														<div class="arrow-right">
															<i style="color: #bb8181;" class="bi bi-caret-right"></i>
														</div>
													</div>
												</form>
												<div class="month-picker">
													<div class="calendar" id="calendar">
														<div class="calendar-header">
															<button type="button" id="prevYear">&#9664;</button>
															<span id="year"></span>
															<button type="button" id="nextYear">&#9654;</button>
														</div>
														<div class="calendar-body">
															<div class="calendar-months" id="calendarMonths"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="col-6 col-lg-3 col-md-6 ">
								<div class="card">
									<div class="card-body px-4 py-4-5">
										<div class="row align-items-center">
											<div
												class="col-md-4 col-lg-12 col-xl-12 col-xxl-5 d-flex justify-content-center justify-content-md-start">
												<div
													class="d-flex align-items-center justify-content-center justify-content-md-start"
													style="background-color: white;">
													<img src="resources/img/income.png" style="width: 50px;">
												</div>
											</div>
											<div
												class="col-md-8 col-lg-12 col-xl-12 col-xxl-7 d-flex flex-column align-items-center justify-content-center 
												justify-content-md-start h-50">
												<h6 class="text-muted font-semibold">수입</h6>
												<h6 class="font-extrabold mb-0" id="incomeValue"></h6>
											</div>
										</div>

									</div>
								</div>
							</div>
							<div class="col-6 col-lg-3 col-md-6">
								<div class="card">
									<div class="card-body px-4 py-4-5">
										<div class="row align-items-center">
											<div
												class="col-md-4 col-lg-12 col-xl-12 col-xxl-5 d-flex justify-content-center justify-content-md-start">
												<div
													class="d-flex align-items-center justify-content-center justify-content-md-start"
													style="background-color: white;">
													<img src="resources/img/expense.png" style="width: 50px;">
												</div>
											</div>
											<div
												class="col-md-8 col-lg-12 col-xl-12 col-xxl-7 d-flex flex-column align-items-center justify-content-center justify-content-md-start">
												<h6 class="text-muted font-semibold">지출</h6>
												<h6 class="font-extrabold mb-0" id="expenseValue"></h6>
											</div>
										</div>

									</div>
								</div>
							</div>
							<div class="col-6 col-lg-3 col-md-6">
								<div class="card">
									<div class="card-body px-4 py-4-5">
										<div class="row align-items-center text-center text-md-start">
											<div
												class="col-md-4 col-lg-12 col-xl-12 col-xxl-5 d-flex justify-content-center justify-content-md-start">
												<div
													class="d-flex align-items-center justify-content-center justify-content-md-start"
													style="background-color: white;">
													<img src="resources/img/balance.png" style="width: 50px;">
												</div>
											</div>
											<div
												class="col-md-8 col-lg-12 col-xl-12 col-xxl-7 d-flex flex-column align-items-center justify-content-center justify-content-md-start">
												<h6 class="text-muted font-semibold">잔액</h6>
												<h6 class="font-extrabold mb-0" id="balanceValue"></h6>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
						<!-- 월별 지출 차트 -->
						<!-- <div class="container" style="margin:0px;"> -->
						<div class="row">
							<div class="col-md-8 col-sm-12" style="margin-bottom: 40px;">
								<div class="card h-100">
									<div class="card-header" style="padding-bottom: 0px">
										<h4>최근 지출</h4>
									</div>
									<canvas id="myChart" style="display: inline;"></canvas>
								</div>
							</div>
							<div class="col-md-4 col-sm-12" style="margin-bottom: 40px;">
								<div class="card h-100">
									<div class="card-body">
										<!-- 유사도 비교  -->
										<!-- 설문조사 안했으면 설문조사 버튼 나오게 -->
										<c:if test="${sessionScope.login.surveyYn eq 'N'}">
											<div class="card-header"
												style="padding: 0px; margin-bottom: 10%">
												<h4>설문조사</h4>
											</div>
											<div class="card-content">
												<img id="survey_btn" class="mainImage col-12 login-form"
													src="resources/img/survey_img.png"
													style="min-width: 10%; max-width: 150px; height: auto; max-height: 200px; display: block; margin-top: 55px; cursor: pointer;" />
												<img class="mainImage col-12 login-form"
													src="resources/img/survey_font.png"
													style="min-width: 40%; max-width: 200px; height: auto; max-height: 400px; display: block; margin-top: 100px;" />
											</div>
										</c:if>
										<!-- 설문조사 했으면 비교 페이지 나오게  -->
										<c:if test="${sessionScope.login.surveyYn eq 'Y'}">
											<div class="card-content">
												<!-- 유사도 비교 차트  -->
												<div class="card-header"
													style="padding: 0px; margin-bottom: 0px">
													<h4>저축 비교</h4>
												</div>
												<canvas id="savingsRadarChart" width="350" height="400"
													style="display: inline;"></canvas>
											</div>
										</c:if>
										<!-- 유사도 비교 끝 -->
									</div>
								</div>
							</div>
						</div>
						<!-- </div> -->
						<!-- 월별 지출 차트 끝-->
					</div>
					<div class="col-12 col-lg-3">
						<div class="card">
							<div class="card-body py-4 px-4">
								<div class="d-flex align-items-center" style="margin-top: 5px;">
									<div class="avatar avatar-xl">
										<img src="resources/img/carbon3.png" alt="Face 1">
									</div>
									<div
										class="col-md-8 col-lg-12 col-xl-12 col-xxl-7 d-flex flex-column align-items-center justify-content-center justify-content-md-start">
										<h5 class="font-bold">${login.memId}<br>
										</h5>
										<h6 class="text-muted mb-0">${login.memNm}</h6>

									</div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 45px;">
							<div class="col-12 col-xl-12 col-sm-12">
								<div class="card">
									<div class="card-header">
										<h4>지출 카테고리</h4>
									</div>

									<c:choose>
										<c:when test="${empty Excategory}">
											<p id="message"
												style="text-align: center; font-size: 22.5px; font-weight: bold; margin-top: 42%; margin-bottom: 43%;">
												아직 지출 내역이 없습니다.<br>
											</p>
										</c:when>
										<c:otherwise>

											<div class="chart-container"
												style="width: 100%; display: flex; justify-content: center;">
												<canvas id="pieChart"
													style="max-width: 298px; max-height: 298px;"></canvas>
											</div>




										</c:otherwise>
									</c:choose>

									<div>
										<c:set var="count" value="0" />

										<!-- 빈 공간 추가 -->
										<c:if test="${fn:length(Excategory) < 2}">
											<p class="price"
												style="text-align: center; font-size: 20px; font-weight: bold; visibility: hidden;">
												빈 공간</p>
										</c:if>

										<!-- 카테고리 출력 -->
										<c:forEach items="${Excategory}" var="Exca">
											<c:if test="${count < 2}">
												<p class="price"
													style="text-align: center; font-size: 20px; font-weight: bold;"
													id="expriceValue">
													${Exca.excategory} :
													<fmt:formatNumber value="${Exca.exprice}" pattern="#,###" />
													원
												</p>
												<c:set var="count" value="${count + 1}" />
											</c:if>
										</c:forEach>


									</div>


								</div>


							</div>
						</div>
					</div>
				</section>
			</div>
			<!-- 작성 부분 -->
			<div class="row">
				<div class="col-12 col-xl-12">
					<div class="card">
						<div class="card-header">
							<h4 style="display: inline;">가계부 작성</h4>

						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-hover table-lg">
									<thead>
										<tr>
											<th>날짜</th>
											<th>대분류</th>
											<th>중분류</th>
											<th>소분류</th>
											<th>금액</th>
											<th>내용</th>
											<th>
												<button id="addEntryBtn"
													class='btn btn-block btn-xl btn-outline-primary font-bold mt-3'>
													<i class="bi bi-pencil-fill fa-lg" style="font-size: 20px;"></i>
												</button>
											</th>
										</tr>
									</thead>
									<tbody id="entryTableBody">
										<c:choose>
											<c:when test="${empty AbVO}">
												<tr>
													<td colspan="7" style="text-align: center;">
														<h5>가계부를 작성해 주세요.</h5>
													</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${AbVO}" var="ab">
													<tr>
														<td class="col-2">
															<div class="d-flex align-items-center">
																<p class="font-bold ms-3 mb-0">${ab.finDy}</p>
															</div>
														</td>
														<td><p class="font-bold ms-3 mb-0">${ab.lgCat}</p></td>
														<td><p class="font-bold ms-3 mb-0">${ab.mdCat}</p></td>
														<td><p class="font-bold ms-3 mb-0">${ab.smCat}</p></td>
														<td><p class="font-bold ms-3 mb-0">
																<span class="price"> <fmt:formatNumber
																		value="${ab.price}" pattern="#,###" /></span>
															</p></td>
														<td class="col-auto">
															<p class="mb-0">${ab.remarks}</p>
														</td>
														<td class="col-auto"><c:if
																test="${sessionScope.login.memId == searchVO.memId }">
																<form action="<c:url value='/abDelDo' />" method="post">
																	<input type="hidden" name="trxId" value="${ab.trxId}">
																	<button type="button" id="delete"
																		class='btn btn-block btn-xl btn-outline-primary font-bold mt-3'
																		onclick="fn_check(this)">
																		<i class="bi bi-trash-fill" style="font-size: 20px;"></i>
																	</button>
																</form>
															</c:if></td>
														<!-- 테이블 모양이 깨지지 않으려고 넣은 td -->
														<td class="col-auto"></td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>

								<c:if test="${not empty AbVO}">
									<button
										class='btn btn-block btn-xl btn-outline-primary font-bold mt-3'
										id="loadMoreBtn">더 보기</button>
								</c:if>


								<!-- 모달 -->
								<div id="myModal" class="modal">
									<div class="write-modal-content">
										<span class="close">&times;</span>
										<h3>가계부 작성</h3>
										<form id="budgetForm" action="<c:url value='/abWriteDo' />"
											method="post" accept-charset="UTF-8">
											<select id="transactionType" class="selectpicker">
												<option value="" disabled selected>선택하세요</option>
												<option value="수입">수입</option>
												<option value="지출">지출</option>
											</select> <input type="hidden" id="lgCat" name="lgCat"> <input
												type="number" id="amount" name="price"
												class="form-control form-control-xl" placeholder="금액"
												style="padding: .15rem 1rem; font-size: 1.2rem;">

											<!-- 날짜 선택 -->
											<label for="datepicker2" style="font-size: 20px;">날짜:</label>
											<input type="text" id="datepicker2" class="inp float-right"
												style="background-color: white;"> <input
												type="hidden" name="finDy" id="finDy">

											<div>
												<div class="horizontal-line"></div>
											</div>

											<input type="hidden" id="smCat" name="smCat" value="">
											<div id="subCategoryContainer" class="hidden">
												<label for="subCategory">상세 항목:</label> <select
													id="subCategory" name="subCategory">
													<!-- 상세 항목들이 여기에 동적으로 추가됩니다 -->
												</select>
											</div>

											<!-- 아이콘 히든 -->
											<input type="hidden" id="selectedIcon" name="mdCat" value="">

											<!-- 아이콘 그리드 -->
											<div class="icon-grid">
												<div class="icon-grid-item" data-value="급여" title="급여">
													<i class="fas fa-wallet"></i>
													<p style="font-size: 12px;">급여</p>
												</div>
												<div class="icon-grid-item" data-value="주거비" title="주거비">
													<i class="fas fa-home"></i>
													<p style="font-size: 12px;">주거비</p>
												</div>
												<div class="icon-grid-item" data-value="저축" title="저축">
													<i class="fas fa-piggy-bank"></i>
													<p style="font-size: 12px;">저축</p>
												</div>
												<div class="icon-grid-item" data-value="통신비" title="통신비">
													<i class="fas fa-mobile-alt"></i>
													<p style="font-size: 12px;">통신비</p>
												</div>
												<div class="icon-grid-item" data-value="교통비" title="교통비">
													<i class="fas fa-bus"></i>
													<p style="font-size: 12px;">교통비</p>
												</div>
												<div class="icon-grid-item" data-value="식비" title="식비">
													<i class="fas fa-utensils"></i>
													<p style="font-size: 12px;">식비</p>
												</div>
												<div class="icon-grid-item" data-value="보험" title="보험">
													<i class="fa-solid fa-hand-holding-medical"></i>
													<p style="font-size: 12px;">보험</p>
												</div>
												<div class="icon-grid-item" data-value="더보기" title="더보기"
													id="moreIcon">
													<i class="fas fa-plus"></i>
												</div>
											</div>

											<!-- 더보기로 추가될 아이콘들 (초기에는 숨김) -->
											<div id="additionalIcons" style="display: none;">
												<div class="icon-grid-item" data-value="반려동물" title="반려동물">
													<i class="fas fa-paw"></i><br>
													<p style="font-size: 12px;">반려동물</p>
												</div>
												<div class="icon-grid-item" data-value="생활용품" title="생활용품">
													<i class="fas fa-shopping-basket"></i>
													<p style="font-size: 12px;">생활용품</p>
												</div>
												<div class="icon-grid-item" data-value="의료비" title="의료비">
													<i class="fas fa-briefcase-medical"></i>
													<p style="font-size: 12px;">의료비</p>
												</div>
												<div class="icon-grid-item" data-value="교육비" title="교육비">
													<i class="fa-solid fa-school"></i>
													<p style="font-size: 12px;">교육비</p>
												</div>
												<div class="icon-grid-item" data-value="경조교제비" title="경조교제비">
													<i class="fa-solid fa-handshake"></i>
													<p style="font-size: 12px;">경조교제비</p>
												</div>
												<div class="icon-grid-item" data-value="문화생활" title="문화생활">
													<i class="fas fa-theater-masks"></i>
													<p style="font-size: 12px;">문화생활</p>
												</div>
												<div class="icon-grid-item" data-value="차량유지비" title="차량유지비">
													<i class="fas fa-car"></i>
													<p style="font-size: 12px;">차량유지비</p>
												</div>
												<div class="icon-grid-item" data-value="투자" title="투자">
													<i class="fa-solid fa-arrow-trend-up"></i>
													<p style="font-size: 12px;">투자</p>
												</div>
											</div>


											<div>
												<div class="horizontal-line"></div>
											</div>

											<h4>비고</h4>
											<textarea class="form-control" name="remarks"
												style="width: 100%; height: 5rem" placeholder="내용"></textarea>
											<!-- OCR 모달 버튼 -->
											<button id="easyOCR" type="button" style="display: none;"
												class="btn btn-block btn-xl btn-outline-primary font-bold mt-3"
												data-bs-toggle="modal" data-bs-target="#secondaryModal">
												이미지 인식</button>
											<button id="saveEntryBtn"
												class='btn btn-block btn-xl btn-outline-primary font-bold mt-3'>저장</button>
										</form>
									</div>
								</div>
							</div>
							<!-- 모달 끝 -->

							<!-- OCR 모달 -->
							<div class="modal fade" id="secondaryModal" tabindex="-1"
								aria-labelledby="secondaryModalLabel" aria-hidden="true">
								<form id="uploadForm" enctype="multipart/form-data">
									<div class="modal-dialog modal-lg col-12">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="secondaryModalLabel">지출일:</h5>
												<input type="text" id="datepicker" class="inp float-right"
													style="background-color: white;">
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<div class="input-group" style="margin-bottom: 5%">
													<input type="file" class="form-control" id="file-url"
														name="file-url" aria-describedby="inputGroupFileAddon04"
														aria-label="Upload" accept="image/*"
														onchange="setThumbnail(event);">
													<button class="btn btn-outline-secondary" type="button"
														id="inputGroupFileAddon04" onclick="ocr_fn()">텍스트추출</button>
												</div>
												<div class="input-group" id="image_container"
													style="overflow: auto; object-fit: cover;">
													<img src="resources/img/before.png" alt="없음"
														class="thumbnail-img col-5" id="before"> <img
														src="resources/img/arrow_mark.png" alt="arrow_mark"
														class="col-2" id=""
														style="background-color: transparent; height: 10%; margin-top: 5%">
													<img src="resources/img/after.png" alt="없음"
														class="thumbnail-img col-5" id="after">
												</div>
												<div class="input-group" id="table_container"></div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">닫기</button>
												<button type="button" class="btn btn-primary" id="ocr-save">저장</button>
											</div>
										</div>
									</div>
								</form>
							</div>
							<!-- OCR 모달 끝 -->

							<!-- 설문조사 모달  -->
							<div class="modal fade" id="survey-modal" tabindex="-1"
								aria-labelledby="details-modalLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-body"
											style="padding-bottom: 0px; margin-top: 10px;">
											<div class="input-group" id="table_container">
												<div id="survey-content" class="col-12">
													<jsp:include page="/WEB-INF/views/member/survey.jsp"></jsp:include>
												</div>
											</div>
										</div>
										<div class="modal-footer"
											style="padding-bottom: 5px; padding-top: 5px;">
											<button type="button" class="btn btn-secondary"
												id="close-btn" data-bs-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
							<!-- 설문조사 모달 끝 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	</div>
	</div>
	<script src="resources/assets/extensions/apexcharts/apexcharts.min.js"></script>
	<script src="resources/assets/static/js/pages/dashboard.js"></script>
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- jQuery UI -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

	<script src="resources/js/script2.js"></script>

</body>
<script>
	var Moex = [];
	var Moin = [];
	var Exca = [];
	var Month = [];
	// ajax 확인용 변수
	var isRequesting = false;
	// datePicker용 현재 날짜 전역변수
	var currentDate = $.datepicker.formatDate('yy-mm-dd', new Date());
	
	$(document).ready(function() {
		const usersData = [];
		// 유사한 값
		$.ajax({
		    type: 'POST',
		    url: 'http://192.168.0.21:5000/SimilarityDo',
		    data: { "memId": "${sessionScope.login.memId }" },
		    success: function(response) {
		        console.log('유사 id:', response);
		        var date = $("#monthPicker").val()
		        console.log("유사도 비교 ajax date: "+date)
		        
		        // 유사도 비교 성공시 ajax로 쿼리문 결과
			        $.ajax({
			    		url: '<c:url value="/savingCmpDo" />',
			            type: "POST",
			            contentType: 'application/json',
			            dataType: 'json',
			            data: JSON.stringify({
			                members: response,
			                finDy: date
			            }),
			            success: function(res) {
			            	for (let i in res){
			            		usersData.push(res[i]);
			            	}
			            	console.log(usersData)
			            	createRadarChart(usersData);
			            	

				    	},error: function(e){
				    		console.log(e)
				    	}
			    })   
		        console.error('유사 id 에러:', error);
		    }
		});
		
		$('#ocr-date').val(new Date().toISOString().substring(0, 10))
		var yearMonth = $("#monthPicker").val();
		$.ajax({
			url : 'http://localhost:8080/carbonbudget/api/abView',
			type : 'GET',
			data : {
				yearMonth : yearMonth,
				memId : "${sessionScope.login.memId}"
			},
			dataType : 'json',
			success : function(data) {
				Moex = [];
				$.each(data.moex, function(i, v) {
					Moex.push(v.monthEx);
					Month.push(v.month);
				});
				Moin = [];
				$.each(data.moin, function(i, v) {
					Moin.push(v.monthIn);
				});
				Exca = [];
				$.each(data.exca, function(i, v) {
					Exca.push({category: v.excategory, price: v.exprice, percentage: v.percentage});
				});
				
			},
			complete : function() {
				// Moex와 Moin 데이터 중 하나라도 0이 아닌 값이 있으면 차트를 그립니다.
				if (Moex.some(value => value !== 0) || Moin.some(value => value !== 0)) {
				console.log(Moex, Moin, Exca, Month);
					drawChart();
					drawPieChart();
				} else {
					// Moex와 Moin 데이터가 모두 0인 경우 차트를 그리지 않습니다.
					var ctx = document.getElementById('myChart').getContext('2d');
					ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
				}
			},

			error : function(xhr, status, error) {
				console.error(error);
			}
		});
	});

	// 차트를 그리는 함수
	function drawChart() {
		let ctx = document.getElementById('myChart').getContext('2d');
		let chart = new Chart(ctx, {
			type : 'bar',
			data : {
				labels : Month,
				datasets : [ {
					label : '수입',
					backgroundColor : 'rgba(75, 192, 192, 0.5)',
					borderColor : 'rgba(75, 192, 192, 0.5)',
					borderWidth : 1,
					data : Moin
				}, {
					label : '지출',
					backgroundColor : 'rgba(255, 99, 132, 0.5)',
					borderColor : 'rgba(255, 99, 132, 0.5)',
					borderWidth : 1,
					data : Moex
				} ]
			},
			options : {
				responsive: false,
				maintainAspectRatio : true,
				scales : {
					x : {
						beginAtZero : true,
						scaleLineColor : 'red',
						grid : {
							color : 'transparent',
						},
			
					},
					y : {
						beginAtZero : true,
						grid : {
							color : 'rgba(128, 128, 128, 0.1)'
						},
					}
				},
				
				maxBarThickness: 65, // 바의 두께 조정
				
			}
		});
		
		
	}
	
	function drawPieChart() {
	    var ctx = document.getElementById('pieChart').getContext('2d');
	    var categories = Exca.map(item => item.category);
	    var percentages = Exca.map(item => item.percentage);

	    var pieChart = new Chart(ctx, {
	        type: 'pie',
	        data: {
	            labels: categories,
	            datasets: [{
	                label: '지출 비율',
	                data: percentages,
	                backgroundColor: [
	                    'rgba(240, 229, 222)',
	                    'rgba(171, 208, 206)',
	                    'rgb(201, 192, 189)',
	                    'rgba(255, 252, 240)',
	                    'rgb(217, 212, 207)',
	                    'rgb(241, 187, 186)',
	                    'rgb(248, 236, 201)',
	                    'rgb(163, 161, 161)',
	                    'rgb(208, 158, 136)',
	                    'rgb(155, 133, 129)'
	                ],
	                borderColor: [
	                    'rgba(240, 229, 222)',
	                    'rgba(171, 208, 206)',
	                    'rgb(201, 192, 189)',
	                    'rgba(255, 252, 240)',
	                    'rgb(217, 212, 207)',
	                    'rgb(241, 187, 186)',
	                    'rgb(248, 236, 201)',
	                    'rgb(163, 161, 161)',
	                    'rgb(208, 158, 136)',
	                    'rgb(155, 133, 129)'
	                ],
	                borderWidth: 1
	            }]
	        },
	        options: {
	            indexAxis: 'y',
	            responsive: true,
	            scales: {},
	            tooltips: {
	                enabled: false
	            },
	            legend: {
	                display: false
	            },
	            plugins: {
	                datalabels: {
	                    formatter: function(value) {
	                        return value + '%';
	                    },
	                    color: '#737980',
	                    font: {
	                        weight: 'bold',
	                        size: 18
	                    },
	                    anchor: 'center',
	                    align: 'center' // 라벨을 가운데 정렬
	                }
	            }
	        },
	        plugins: [ChartDataLabels]
	    });
	}

	
	

	
	function fn_check(obj) {
	    if (confirm("정말 삭제하시겠습니까?")) {
	    	$(obj).parent().submit();

	        
	    } else {
	        // 취소 버튼 클릭 시 아무 동작도 하지 않음
	        return false;
	    }
	}

	//datepicker js
	$(document).ready(function() {
	    $("#datepicker").val(currentDate);
	    $("#datepicker").datepicker({
	        defaultDate: new Date(), // 2024년 6월로 기본 설정
	        dateFormat: 'yy-mm-dd', // 연도-월 형식으로 설정
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 한글 요일명 설정
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'], // 한글 월명 설정
	        showMonthAfterYear: true, 
	        currentText: '오늘', // 오늘 버튼 텍스트 설정
	        closeText: '닫기' // 닫기 버튼 텍스트 설정
	    });
	});
	
	//가계부 datepicker js
	$(document).ready(function() {
	    $("#datepicker2").val(currentDate);
	    $("#datepicker2").datepicker({
	        defaultDate: new Date(), // 2024년 6월로 기본 설정
	        dateFormat: 'yy-mm-dd', // 연도-월 형식으로 설정
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 한글 요일명 설정
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'], // 한글 월명 설정
	        showMonthAfterYear: true, 
	        prev: '이전',
	        next: '다음',
	        currentText: '오늘', // 오늘 버튼 텍스트 설정
	        closeText: '닫기' // 닫기 버튼 텍스트 설정
	        
	    });
	});

	//모달 창 관련 기능
	var modal = document.getElementById("myModal");
	var addEntryBtn = document.getElementById("addEntryBtn");
	var closeBtn = document.getElementsByClassName("close")[0];

	addEntryBtn.onclick = function() {
		modal.style.display = "block";
	}

	closeBtn.onclick = function() {
		modal.style.display = "none";
	}

	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}

	$(document).ready(function() {
	    // 초기 값 설정
	    $('#finDy').val(currentDate);
	    console.log('finDy:', currentDate);

	    // 아이콘을 클릭했을 때 실행되는 함수
	    $('.icon-grid-item').click(function() {
	        // 모든 아이콘에서 선택된 클래스 제거
	        $('.icon-grid-item').removeClass('selected-icon');
	        // 클릭한 아이콘에 선택된 클래스 추가
	        $(this).addClass('selected-icon');

	        // 클릭한 아이콘의 data-value 속성 값을 hidden 필드에 설정
	        var selectedValue = $(this).attr('data-value');
	        $('#selectedIcon').val(selectedValue);
	        console.log('mdCat:', selectedValue);

	        // 상세 항목 드롭다운 메뉴를 초기화
	        var subCategorySelect = $('#subCategory');
	        subCategorySelect.empty();

	        // 아이콘에 따라 상세 항목 추가
	        var subCategories = [];
	        switch (selectedValue) {
	            case '급여':
	                subCategories = ['월급', '상여금', '수당'];
	                break;
	            case '저축':
	                subCategories = ['적금', '주택청약', '예금', '부동산', '주식', '비상금'];
	                break;
	            case '통신비':
	                subCategories = ['휴대폰요금', 'IPTV', '인터넷'];
	                break;
	            case '교통비':
	                subCategories = ['지하철', '기차', '버스', '시외버스', '택시', '항공', '주차요금'];
	                break;
	            case '주거비':
	                subCategories = ['전기요금', '수도요금', '가스요금', '관리비', '대출'];
	                break;
	            case '여행':
	                subCategories = ['해외여행', '국내여행', '교통비'];
	                break;
	            case '보험':
	                subCategories = ['실비보험', '암보험', '치아보험'];
	                break;
	            case '차량유지비':
	                subCategories = ['자동차보험', '자동차세', '주유비', '자동차할부', '톨비/하이패스', '수리비'];
	                break;
	            case '생활용품':
	                subCategories = ['가구/가전', '주방/욕실', '오피스/문구'];
	                break;
	            case '의료비':
	                subCategories = ['정형외과', '치과', '약국', '성형외과', '내과'];
	                break;
	            case '문화생활':
	                subCategories = ['영화', 'OTT'];
	                break;
	            case '경조교제비':
	                subCategories = ['축의금', '조의금', '기부금', '모임회비', '선물'];
	                break;
	            case '교육비':
	                subCategories = ['학교', '학원', '도서', '강의', '기타 교육'];
	                break;
	            case '반려동물':
	                subCategories = ['사료/간식', '용품/장난감', '동물병원', '미용'];
	                break;
	            case '식비':
	                subCategories = ['시장/마트', '외식', '배달', '회식', '모임'];
	                break;
	            case '투자':
	                subCategories = ['부동산', '주식', '가상화폐'];
	                break;
	            default:
	                subCategories = [];
	        }

	        // 상세 항목 드롭다운 메뉴에 옵션 추가
	        if (subCategories.length > 0) {
	            subCategories.forEach(function(subCategory) {
	                subCategorySelect.append(new Option(subCategory, subCategory));
	            });
	            $('#subCategoryContainer').removeClass('hidden');
	        } else {
	            $('#subCategoryContainer').addClass('hidden');
	        }

	        // 상세 항목 맨 위의 값을 hidden 필드에 설정
	        var firstSubCategory = subCategorySelect.find('option').first().val();
	        $('#smCat').val(firstSubCategory);
	        console.log('smCat:', firstSubCategory);
	        
	     // 상세 항목 선택 시 smCat 필드 업데이트
	        $('#subCategory').change(function() {
	            var selectedSubCategory = $(this).val();
	            $('#smCat').val(selectedSubCategory);
	            console.log('smCat:', selectedSubCategory);
	        });

	    });

	    // 더보기 아이콘 클릭 시 추가 아이콘 표시
	    $("#moreIcon").click(function() {
	        $("#additionalIcons").children().each(function() {
	            $(this).appendTo(".icon-grid").show();
	        });
	        $(this).hide(); // 더보기 아이콘 숨기기
	    });

	    // 아이콘 클릭 시 히든 필드에 값 설정
	    $(".icon-grid").on("click", ".icon-grid-item", function() {
	        var iconValue = $(this).attr("data-value");
	        $("#selectedIcon").val(iconValue);
	    });

	    // 거래 유형 변경 시 특정 아이콘 숨기기/표시하기
	    $('#transactionType').change(function() {
	        var selectedType = $(this).val();
	    });

	    $(document).ready(function() {
	        $('#transactionType').change(function() {
	            var selectedType = $(this).val();
	            if (selectedType === "수입") {
	                $("#lgCat").val('수입').change(); // lgCat의 값을 수입으로 설정
	                console.log("lgCat : 수입");
	                $("#moreIcon").click();
	                $(".icon-grid-item").hide();
	                $(".icon-grid-item[data-value='급여']").show();
	                $(".icon-grid-item[data-value='투자']").show();
	                $(".icon-grid-item[data-value='경조교제비']").show();
	            } else if (selectedType === "지출") {
	                $("#lgCat").val('지출').change(); // lgCat의 값을 지출로 설정
	                console.log("lgCat set to: 지출");
	                $("#moreIcon").click();
	                $(".icon-grid-item").show();
	                $(".icon-grid-item[data-value='급여']").hide();
	                $(".icon-grid-item[data-value='투자']").hide();
	                $(".icon-grid-item[data-value='경조교제비']").hide();
	                $(".icon-grid-item[data-value='더보기']").hide();
	            } else {
	                $(".icon-grid-item").show();
	            }
	        });

	        $("#moreIcon").click(function() {
	            $("#additionalIcons").children().each(function() {
	                $(this).appendTo(".icon-grid").show();
	            });
	            $(this).hide();
	        });
	    });



	    // datepicker2 input 요소의 값이 변경될 때 실행되는 이벤트 핸들러
	    $('#datepicker2').change(function() {
	        // 선택한 날짜
	        var selectedDate = $(this).val();
	        // hidden 필드에 선택한 날짜를 설정
	        $('#finDy').val(selectedDate);
	        console.log('finDy:', selectedDate);
	    });

	    // price 입력란 값 변경 시
	    $('#amount').on('input', function() {
	        var priceValue = $(this).val();
	        console.log('price:', priceValue);
	    });

	    // remarks 입력란 값 변경 시
	    $('textarea[name="remarks"]').on('input', function() {
	        var remarksValue = $(this).val();
	        console.log('remarks:', remarksValue);
	    });

	    // 폼 제출 비동기 처리
	    $('#budgetForm').submit(function(event) {
	        event.preventDefault(); // 기본 제출 방지

	        // 필드 검사
	        var lgCatValue = $('#lgCat').val();
	        var mdCatValue = $('#selectedIcon').val();
	        var finDyValue = $('#finDy').val();
	        var priceValue = $('#amount').val();

	        if (!lgCatValue || !mdCatValue || !finDyValue || !priceValue) {
	            alert('모든 필드를 작성하세요!');
	            return;
	        }

	        // 폼 데이터를 객체로 수집
	        var formData = $(this).serialize();
	        console.log(formData); // 폼 데이터 확인

	        // 비동기 폼 제출
	        $.ajax({
	            type: 'POST',
	            url: $(this).attr('action'),
	            data: formData,
	            success: function(response) {
	                console.log('응답:', response);
	                // 성공적으로 저장된 후의 동작 (예: 모달 닫기, 메시지 표시 등)
	                $('#myModal').hide();
	                alert('저장되었습니다.');
	                location.reload(); // 페이지 새로고침
	            },
	            error: function(error) {
	                console.error('오류:', error);
	                // 오류 발생 시의 동작
	                alert('저장에 실패했습니다.');
	            }
	        });
	    });

	    // 폼 제출 시 입력된 값들을 콘솔에 출력 및 테이블에 추가
	    $('#budgetForm').submit(function(event) {
	        event.preventDefault(); // 기본 제출 방지
	        console.log('lgCat:', $('#lgCat').val());
	        console.log('mdCat:', $('#selectedIcon').val());
	        console.log('smCat:', $('#subCategory').val());
	        console.log('finDy:', $('#finDy').val());
	        console.log('price:', $('#amount').val());
	        console.log('remarks:', $('textarea[name="remarks"]').val());

	        // 새로운 항목을 테이블에 추가
	        var newRow = '<tr>' +
	            '<td class="col-2"><div class="d-flex align-items-center"><p class="font-bold ms-3 mb-0">' + $('#finDy').val() + '</p></div></td>' +
	            '<td><p class="font-bold ms-3 mb-0">' + $('#lgCat').val() + '</p></td>' +
	            '<td><p class="font-bold ms-3 mb-0">' + $('#selectedIcon').val() + '</p></td>' +
	            '<td><p class="font-bold ms-3 mb-0">' + $('#subCategory').val() + '</p></td>' +
	            '<td><p class="font-bold ms-3 mb-0"><span class="price">' + $('#amount').val() + '</span></p></td>' +
	            '<td class="col-auto"><p class="mb-0">' + $('textarea[name="remarks"]').val() + '</p></td>' +
	            '<td class="col-auto">' +
	                '<c:if test="${sessionScope.login.memId == searchVO.memId }">' +
	                    '<form action="<c:url value="/abDelDo" />" method="post">' +
	                        '<input type="hidden" name="trxId" value="${ab.trxId}">' +
	                        '<button type="button" id="delete" class="btn btn-block btn-xl btn-outline-primary font-bold mt-3" onclick="fn_check(this)">' +
	                            '<i class="bi bi-trash-fill" style="font-size: 20px;"></i>' +
	                        '</button>' +
	                    '</form>' +
	                '</c:if>' +
	            '</td>' +
	            '<td class="col-auto"></td>' +
	        '</tr>';
	        $('#entryTableBody').prepend(newRow);

	        // 입력 필드 초기화
	        $('#lgCat').val('');
	        $('#selectedIcon').val('');
	        $('#subCategory').val('');
	        $('#finDy').val('');
	        $('#amount').val('');
	        $('textarea[name="remarks"]').val('');
	    });
	});

	
	$(document).ready(function() {
	    // 이전 월로 이동하는 함수
	    $('.arrow-left').click(function() {
	        // 현재 월 가져오기
	        var currentMonth = $('#monthPicker').val();
	        // 현재 월을 Date 객체로 변환
	        var date = new Date(currentMonth);
	        // 한 달 전으로 설정
	        date.setMonth(date.getMonth() - 1);
	        // 새로운 날짜 문자열 생성
	        var newMonth = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0');
	        // input 요소에 새로운 날짜 설정
	        $('#monthPicker').val(newMonth);
	        // 폼 제출
	        $("#searchForm").submit();
	    });

	    // 다음 월로 이동하는 함수
	    $('.arrow-right').click(function() {
	        // 현재 월 가져오기
	        var currentMonth = $('#monthPicker').val();
	        // 현재 월을 Date 객체로 변환
	        var date = new Date(currentMonth);
	        // 한 달 후로 설정
	        date.setMonth(date.getMonth() + 1);
	        // 새로운 날짜 문자열 생성
	        var newMonth = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0');
	        // input 요소에 새로운 날짜 설정
	        $('#monthPicker').val(newMonth);
	        // 폼 제출
	        $("#searchForm").submit();
	    });
	});
	
	//가계부 내역 더보기 ========= 요청하는 값 확인하기
	$(document).ready(function() {
		var year = $('#monthPicker').val().substr(0, 4);
		var yearText = year + "년 " + "가게부";
		$('#year-display').text(yearText);
		console.log("연도:", year);

		
	    var curPage = 1;

	    $('#loadMoreBtn').click(function() {
	        curPage++;
	        $.ajax({
	            url: 'getPost',
	            type: 'GET',
	            data: { curPage: curPage, memId: "${sessionScope.login.memId}", yearMonth: $("#monthPicker").val() },
	            success: function(data) {
	                var newRows = '';
	                if (data.length === 0) {
	                    // 데이터가 없으면 마지막 페이지임을 알림
	                    alert("마지막 페이지입니다.");
	                } else {
	                    data.forEach(function(ab) {
	                        newRows += '<tr>' +
	                        '<td class="col-2"><div class="d-flex align-items-center"><p class="font-bold ms-3 mb-0">' + ab.finDy + '</p></div></td>' +
	                        '<td><p class="font-bold ms-3 mb-0">' + ab.lgCat + '</p></td>' +
	                        '<td><p class="font-bold ms-3 mb-0">' + ab.mdCat + '</p></td>' +
	                        '<td><p class="font-bold ms-3 mb-0">' + ab.smCat + '</p></td>' +
	                        '<td><p class="font-bold ms-3 mb-0"><span class="price">' + ab.price + '</span></p></td>' +
	                        '<td class="col-auto"><p class="mb-0">' + ab.remarks + '</p></td>' +
	                        '<td class="col-auto">' +
	                            '<form id="delForm" action="<c:url value='/abDelDo' />" method="post">' +
	                                '<input type="hidden" name="trxId" value="' + ab.trxId + '">' +
	                                '<button type="button" id="delete" class="btn btn-block btn-xl btn-outline-primary font-bold mt-3" onclick="fn_check(this)">' +
	                                    '<i class="bi bi-trash-fill" style="font-size: 20px;"></i>' +
	                                '</button>' +
	                            '</form>' +
	                        '</td>' +
	                        '<td class="col-auto"></td>' +
	                    '</tr>';
	                    });
	                    $('#entryTableBody').append(newRows);
	                    formatPrice(); // 새로 추가된 행의 가격 포맷팅
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error('Error:', error);
	            }
	        });
	    });
	});
	
	// 파일 업로드 미리보기
    function setThumbnail(event) {
    var reader = new FileReader();

    reader.onload = function(event) {
        // 새로운 이미지를 추가합니다.
        $("#before").attr("src", event.target.result);
    };
    reader.readAsDataURL(event.target.files[0]);
}

	
	
	// ajax 요청
    ocr_fn = () => {
    	$("#table_container").empty();
        var formData = new FormData($("#uploadForm")[0]);
        // 이미 ajax 요청중
        if (isRequesting) {
            alert("이미지 인식중입니다.");
            return;
        }

        isRequesting = true;
        
        // AJAX 요청 전에 로딩 표시를 보여주고 중복 요청을 막음
        var loading = $("#div_ajax_load_image");
        var width = 0;
        var height = 0;
        var left = 0;
        var top = 0;
        width = 50;
        height = 50;
        top = ($(window).height() - height) / 2 + $(window).scrollTop();
        left = ($(window).width() - width) / 2 + $(window).scrollLeft();

        if (loading.length != 0) {
            loading.css({ "top": top + "px", "left": left + "px" });
            loading.show();
        } else {
            $('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="resources/img/loading3.gif" style="width:70px; height:70px;"></div>');
        }

        $.ajax({
            url: 'http://192.168.0.21:5000/OCRDo',
            method: 'post',
            data: formData,
            contentType: false,
            processData: false,
            success: function (res) {
                result = JSON.parse(res);       
                var roi1_base64 = result["img"];
                $("#after").attr("src", "data:image/jpeg;base64," + roi1_base64);
                
             // OCR 결과값 테이블에 추가
                let tableHTML = "<table style='text-align:center;' class='table table-hover table-lg'><thead><tr><th>에너지</th><th>금액</th><th>사용량</th><th>삭제</th></tr></thead><tbody class='table-group-divider'>";
				result.final_info.forEach(info => {
				    tableHTML += "<tr><td>" + info.에너지 + "요금</td><td>" + info.금액 + "원</td><td>" + info.사용량 + "</td> <td><button type='button' class='btn-close table_del_btn' aria-label='Close'></button></td> </tr>";
				});
				tableHTML += "</tbody></table>";

                $("#table_container").append(tableHTML);
            },
            error: function (e) {
                alert("고지서 전체 이미지를 업로드해주세요")
            	console.log(e);
            },
            complete: function () {
                $("#div_ajax_load_image").hide();
                isRequesting = false;
            }
        });
    }
    
    // 모달창 닫을 때 내용 초기화
    $('#secondaryModal').on('hidden.bs.modal', function (e) {
        // 이미지의 src를 빈 문자열로 설정하여 초기화
        $("#before").attr("src", "resources/img/before.png");
        $("#after").attr("src", "resources/img/after.png");
        $("#file-url").val("");
        $("#table_container").empty();
        $("#datepicker").val(currentDate);
    });
    
    // OCR 결과창 삭제 버튼
    // .table_del_btn가 동적으로 추가된 요소여서 이렇게 사용
    $("#table_container").on("click", ".table_del_btn", function() {
	    $(this).closest("tr").remove();
	});
    
    
    // 테이블 내용을 json 데이터로
    $("#ocr-save").click(function(){
    	let ocrData = [];
    	// 테이블에서 각 행(tr)을 선택하여 정보 추출
    	$("#table_container tbody tr").each(function() {
    	    let cells = $(this).find('td');
    	    let rowObject = {
    	    	smCat: cells.eq(0).text().trim(),
    	    	price: cells.eq(1).text().replace('원','').replaceAll(',','').trim(),
    	    	remarks: cells.eq(2).text().trim(),
    	    	finDy: $("#datepicker").val()
    	    };
    	    ocrData.push(rowObject);
    	});
    	console.log(ocrData)
	    	// 저장버튼 ajax 요청
	    	$.ajax({
	    		url: '<c:url value="/OCRSave" />',
	            type: "POST",
	            contentType: 'application/json',
				dataType:'text',
				data: JSON.stringify(ocrData),
	            success: function(res) {
	            	console.log(res)
	            	if(res=='Y'){
	            		alert("저장이 완료됐습니다.")
	            		$('#secondaryModal').modal('hide');
	            		$('#myModal').hide();
	            		location.reload(); // Refresh the page on success
	            	}else{
	            		alert("저장이 실패했습니다.")
	            	}
	    	},error: function(e){
	    		console.log(e)
	    	}
	    })
    })
    
    $(document).ready(function() {
    // 주거비 아이콘 클릭 시 이미지 인식 버튼 표시
    $('.icon-grid-item[data-value="주거비"]').click(function() {
        $('#easyOCR').show(); // 이미지 인식 버튼 표시
    });

    // 다른 아이콘 클릭 시 이미지 인식 버튼 숨김
    $('.icon-grid-item').not('[data-value="주거비"]').click(function() {
        $('#easyOCR').hide(); // 이미지 인식 버튼 숨김
    });

    // 이미지 인식 버튼 클릭 시 동작
    $('#easyOCR').click(function() {
        // 이미지 인식 모달 표시
        $('#secondaryModal').modal('show');
    });
});
    
    
 // 숫자를 세 자리마다 콤마로 포맷팅하는 함수
    function formatNumber(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // DOMContentLoaded 이벤트 리스너를 사용하여 DOM이 완전히 로드된 후에 값을 설정합니다.
    document.addEventListener('DOMContentLoaded', function() {
        // 각 값을 포맷팅하여 표시합니다.
        document.getElementById("incomeValue").textContent = formatNumber`${(Income.income)} 원`;
        document.getElementById("expenseValue").textContent = formatNumber`${(Expense.expense)} 원`;
        document.getElementById("balanceValue").textContent = formatNumber`${(Balance.balance)} 원`;
    });

    // 가격 값을 포맷팅하는 함수 (기타 요소에서 사용할 경우)
    function formatPrice() {
        const prices = document.querySelectorAll('.price');
        prices.forEach(function(price) {
            price.textContent = formatNumber(price.textContent);
        });
    }

//레이더 차트 함수
function createRadarChart(usersData) {
    const ctx = document.getElementById('savingsRadarChart').getContext('2d');
    
    // 사용자마다 고정된 색상을 정의합니다.
    const colors = [
        {
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgb(255, 99, 132)',
            pointBackgroundColor: 'rgb(255, 99, 132)',
            pointBorderColor: '#fff',
            pointHoverBackgroundColor: '#fff',
            pointHoverBorderColor: 'rgb(255, 99, 132)'
        },
        {
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgb(54, 162, 235)',
            pointBackgroundColor: 'rgb(54, 162, 235)',
            pointBorderColor: '#fff',
            pointHoverBackgroundColor: '#fff',
            pointHoverBorderColor: 'rgb(54, 162, 235)'
        },
        {
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgb(75, 192, 192)',
            pointBackgroundColor: 'rgb(75, 192, 192)',
            pointBorderColor: '#fff',
            pointHoverBackgroundColor: '#fff',
            pointHoverBorderColor: 'rgb(75, 192, 192)'
        }
        // 다른 사용자의 색상을 필요한 만큼 추가할 수 있습니다.
    ];

    // 라벨 배열을 생성합니다. 필드명에 맞게 라벨을 설정합니다.
    const labels = ['저축', '주택 청약', '예금', '부동산', '주식', '비상금'];

    new Chart(ctx, {
        type: 'radar',
        data: {
            labels: labels, // 생성한 라벨 배열을 사용합니다.
            datasets: usersData.map((userData, index) => {
                return {
                    label: userData.memId,
                    data: [
                        userData.savings,
                        userData.housingSubscription,
                        userData.deposit,
                        userData.realEstate,
                        userData.stocks,
                        userData.emergencyFund
                    ],
                    fill: true,
                    ...colors[index] // 각 사용자에게 고정된 색상을 할당합니다.
                };
            })
        },
        options: {
            scales: {
                r: {
                    ticks: {
                        display: false
                    }
                }
            }
        }
    });
}


// HTML 요소 선택
    const leftArrow = document.querySelector('.arrow-left i');
    const rightArrow = document.querySelector('.arrow-right i');


 // 마우스 이벤트 핸들러 함수
    function handleMouseEnter(event) {
        event.target.classList.replace('bi-caret-left', 'bi-caret-left-fill');
        event.target.classList.replace('bi-caret-right', 'bi-caret-right-fill');
    }

    function handleMouseLeave(event) {
        event.target.classList.replace('bi-caret-left-fill', 'bi-caret-left');
        event.target.classList.replace('bi-caret-right-fill', 'bi-caret-right');
    }

    // 이벤트 리스너 등록
    leftArrow.addEventListener('mouseenter', handleMouseEnter);
    leftArrow.addEventListener('mouseleave', handleMouseLeave);
    rightArrow.addEventListener('mouseenter', handleMouseEnter);
    rightArrow.addEventListener('mouseleave', handleMouseLeave);


</script>

</html>