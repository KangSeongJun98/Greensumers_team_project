<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			<div class="page-content col-lg-8 login-form">
				<!-- 검색창 -->
				<div class="row" style="margin-bottom: 2%;">
					<div class="input-group" style="width: 500%; margin-left: 16%;">
						<div class="col-sm-1">
							<select id="id_searchType" name="searchType"
								class="form-control input-sm">
								<option value="T">제목</option>
								<option value="W">작성자</option>
							</select>
						</div>
						<div class="col-sm-6">
							<!-- 검색바 -->
							<input class="form-control shadow-none search" name="searchWord"
								type="search" placeholder="검색어" aria-label="search" />
						</div>
								
						<div>
								
						</div>
						<div class="col-sm-1 text-right">
							<button type="submit" class="btn btn-primary form-control">
								<i class="bi bi-search"></i>
							</button>
						</div>
					</div>
				</div>

				<!-- 게시판 시작 -->
				<section id="content-types">
					<div class="row">
						 <c:forEach var="board" items="${boardList}">
            				<div class="col-xl-4 col-md-6 col-sm-12">
				                <div class="card">
				                    <div class="card-content">
				                        <div class="embed-responsive embed-responsive-4by3">
				                            <img src="resources/assets/compiled/png/team_logo.png"
				                                 class="card-img-top embed-responsive-item" alt="singleminded">
				                        </div>
				                        <div class="card-body">
				                            <h5 class="card-title"><a href="<c:url value="/boardDetailView?boardNo=${board.boardNo } "/>">${board.boardTitle}</h5>
				                            <p class="card-text">${board.boardContent}</p>
				                        </div>
				                    </div>
				                    <ul class="list-group list-group-flush">
				                        <li class="list-group-item">작성자: ${board.memNm}</li>
				                        <li class="list-group-item">작성일: ${board.boardDate}</li>
				                       
				                    </ul>
				                    <div class="d-flex justify-content-end">
				                        <button class="btn btn-light-primary" style="margin-right: 10px;">수정</button>
				                        <button class="btn btn-light-primary">전체보기</button>
				                    </div>
				                </div>
				            </div>
				        </c:forEach>

						
				</section>
				<!-- 페이징 처리 -->
				<div class="row">
					<nav aria-label="Page navigation example">
						<ul class="pagination pagination-primary  justify-content-center">
							<li class="page-item"><a class="page-link" href="#"> <span
									aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
							</a></li>
							<li class="page-item active"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item"><a class="page-link" href="#"> <span
									aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
							</a></li>
						</ul>
					</nav>
				</div>
			</div>

			<!-- footer 영역 -->
			<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
		</div>
	</div>
	
</body>
</html>