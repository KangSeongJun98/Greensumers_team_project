<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
    <jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
    <section class="page-section" id="contact" style="margin-top: 200px;">
        <div class="container" >
            <div class="card mb-3">
			  <div class="card-body">
			    <h5 class="card-title">title : ${freeBoard.boTitle }</h5>
			    <p class="card-text">category : ${freeBoard.boCategoryNm }</p>
			    <p class="card-text"><small class="text-body-secondary">writer : ${freeBoard.boWriter }</small></p>
			     <div class="row g-0 justify-content-md-center">
			        <div class="col-auto">
				     	${freeBoard.boContent }
				     </div>
			     </div>
			  </div>
              <button onclick="goBack()" class="btn btn-primary">뒤로 가기</button>
			</div>
        </div>
    </section>
    
<%--     <jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include> --%>

    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
