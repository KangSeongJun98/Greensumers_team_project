<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="resources/assets/compiled/css/app.css">
<link rel="stylesheet" href="resources/assets/compiled/css/my.css">

<!-- 테스트 -->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<script src="resources/assets/extensions/jquery/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 테스트 끝 -->

<script src="resources/assets/extensions/parsleyjs/parsley.min.js"></script>
<script src="resources/assets/static/js/pages/parsley.js"></script>

<!-- alert css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
$(document).ready(function(){
    // 현재 페이지 URL
    var currentPageUrl = window.location.pathname;

    $(".sidebar-item a").each(function(){
        // 각 아이템의 링크 URL
        var itemUrl = $(this).attr("href");
       
        if (currentPageUrl === itemUrl) {
        	$(".sidebar-item").removeClass("active");
            $(this).closest('.sidebar-item').addClass('active');
        }
    });

    // 사이드바 아이템을 클릭했을 때의 동작을 설정
    $(".sidebar-item").click(function(){
        // 모든 사이드바 아이템에서 'active' 클래스 제거
        $(".sidebar-item").removeClass("active");
        
        // 클릭한 아이템에 'active' 클래스를 추가
        $(this).addClass('active');
    });

    // msg가 존재할 경우 swal을 사용하여 스타일이 적용된 경고창 표시
    <c:if test="${not empty msg}">
        swal({
            title : "${msg}",
            icon  : "success",
            closeOnClickOutside : false
        });
    </c:if>
});
</script>

<div id="sidebar">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header position-relative" style="padding-bottom: 0px; padding-top: 16px;">
                    <div class="logo">
                        <a href="<c:url value="/" />">
                            <img src="resources/assets/compiled/png/logo2.png"
                                style="width: 70%; height: 3em; margin-left: 15%;" alt="Logo" srcset=""></a>
                    </div>
                </div>
                <!-- 메뉴목록 -->
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">재정관리</li>

                        <li class="sidebar-item">
                            <a href="<c:url value="/abView" />" class='sidebar-link'>
                                <i class="bi bi-wallet-fill"
                                ></i>
                                <span>가계부</span>
                            </a>
                        </li>

                        <li class="sidebar-item">
                            <a href="<c:url value='/calendarView' />" class='sidebar-link'>
                                <i class="bi bi-calendar-check-fill"></i>
                                <span>캘린더</span>
                            </a>
                        </li>

                        <li class="sidebar-title">실천일지</li>

                        <li class="sidebar-item">
                            <a href="<c:url value="/freeList" />" class='sidebar-link'>
                                <i class="bi bi-journal-album"></i>
                                <span>전체보기</span>
                            </a>


                        </li>

                        <li class="sidebar-item">
                            <a href="<c:url value="/freeForm" />" class='sidebar-link'>
                                <i class="bi bi-pen-fill"></i>
                                <span>작성하기</span>
                            </a>
                        </li>

                        <li class="sidebar-title">탄소중립</li>
                        <li class="sidebar-item ">
                            <a href="<c:url value="/cfComparisonView"/>" class='sidebar-link'>
                                <i class="bi bi-tree-fill"></i>
                                <span>내 탄소발자국</span>
                            </a>
                        </li>
                        <li class="sidebar-item ">
                            <a href="<c:url value="/" />" class='sidebar-link'> 
                                <i class="bi bi-bar-chart-line-fill"></i>
                                <span>전체 탄소발자국</span>
                            </a>
                        </li>


                        <li class="sidebar-title">사용자</li>
                        <!-- 로그인 안돼있으면  -->
                        <c:if test="${sessionScope.login == null}">
                        <li class="sidebar-item">
                            <a href="<c:url value="/loginView" />" class='sidebar-link'>
                                <i class="bi bi-person-circle"></i>
                                <span>로그인</span>
                            </a>
                        </li>

                        <li class="sidebar-item">
                            <a href="<c:url value="/registView" />" class='sidebar-link'>
                                <i class="bi bi-box-arrow-left"></i>
                                <span>회원가입</span>
                            </a>
                        </li>
                        </c:if>
                        
                        <!-- 로그인 했으면  -->
                        <c:if test="${sessionScope.login != null}">
                        <li class="sidebar-item">
                            <a href="<c:url value="/myPageView" />" class='sidebar-link'>
                                <i class="bi bi-person-circle"></i>
                                <span>마이페이지</span>
                            </a>
                        </li>

                        <li class="sidebar-item">
                            <a href="<c:url value="/logoutDo" />" class='sidebar-link'>
                                <i class="bi bi-box-arrow-left"></i>
                                <span>로그아웃</span>
                            </a>
                        </li>
                        </c:if>       
                        
                    </ul>
                </div>
            </div>
        </div>