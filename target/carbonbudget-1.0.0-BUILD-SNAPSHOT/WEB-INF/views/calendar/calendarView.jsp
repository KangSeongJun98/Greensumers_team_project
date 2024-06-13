<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="resources/assets/compiled/css/calendar.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/date-fns/2.21.3/date_fns.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script src="resources/js/icon.js"></script>

</head>
<body>
	<div id="app">
		<!-- 탑 영역 -->
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
			<div class="page-content" style="margin-bottom: 0PX;">
				<section class="row">
					<div class="card col-12 col-lg-9">
						<div class="card-body">
							<div class="row">
								<div id='calendar' class="login-form"></div>
							</div>
						</div>
					</div>

					<div class="col-12 col-lg-3">
						<div class="card">
							<div class="card-body py-4-5 px-4">
								<div class="d-flex align-items-center">
									<div class="avatar avatar-xl">
										<img src="resources/assets/compiled/jpg/1.jpg" alt="Face1">
									</div>
									<div class="ms-3 name">
										<h5 class="font-bold">${sessionScope.login.memAls }</h5>
										<h6 class="text-muted mb-0">${sessionScope.login.memId }</h6>
									</div>
								</div>
							</div>
						</div>
						<!-- 원형차트 -->
						<div class="card"
							style="height: 590px; display: flex; flex-direction: column;">
							<div class="card-header">
								<h4 id="this-month"></h4>
							</div>
							<div class="card-body chart-body">
								<canvas id="myChart" height="400px"></canvas>
							</div>
							<div style="margin-top: auto;">
							<c:if test="${empty totalPriceList}">
							<p class="chart-text" style="text-align: center;">
								총수입: <span class="price-container"><span class="price"
									id="income">0</span></span>원
							</p>
							<p class="chart-text" style="text-align: center;">
								총지출: <span class="price-container"><span class="price"
									id="expenses">0</span></span>원
							</p>
							</c:if> 
							
								<c:forEach items="${totalPriceList}" var="total">
									<c:if test="${total.lgCat eq '수입'}">
										<p class="chart-text" style="text-align: center;">
											총수입: <span class="price-container"><span class="price"
												id="income">${total.price}</span></span>원
										</p>
									</c:if>
									<c:if test="${total.lgCat eq '지출'}">
										<p class="chart-text" style="text-align: center;">
											총지출: <span class="price-container"><span class="price"
												id="expenses">${total.price}</span></span>원
										</p>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>

					<!-- 일별 세부 내역 모달  -->
					<div class="modal fade" id="details-modal" tabindex="-1"
						aria-labelledby="details-modalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="secondaryModalLabel">세부내역</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" style=" padding-bottom: 0px; margin-top: 10px;">
									<div class="input-group" id="table_container">
										<table id="modal-table" class="rwd-table">
										</table>
									</div>
								</div>
								<div class="modal-footer" style="padding-bottom: 5px; padding-top: 5px;">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
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
</body>
<script>
	$(document).ready(function(){		
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        locale: 'ko',
	        initialView: 'dayGridMonth',
	        height: 'auto',
	        contentHeight: 770,
	        selectable: true,
	        displayEventTime: false,
	        
	        // 이벤트 클릭시 상세보기 모달창 js
	        eventClick: function(info) {
	        	var eventDate = info.event.start;
	            var year = eventDate.getFullYear();
	            var month = ('0' + (eventDate.getMonth() + 1)).slice(-2); // Months are zero-based
	            var day = ('0' + eventDate.getDate()).slice(-2);
	            var date = year + '-' + month + '-' + day;
        		let tableHTML = ""
	            $("#secondaryModalLabel").text(date+" 세부내역")
	            
	            $.ajax({
	                url: '<c:url value="/getDayPrice" />',
	                type: "POST",
	                data: {
	                    eventDate: date
	                },
	                success: function(res) {
	                    for (i in res) {
	                        let lgCat = res[i]['lgCat'];
	                        let mdCat = res[i]['mdCat'];
	                        let smCat = res[i]['smCat'];
	                        let price = res[i]['price'];
	                        let remarks = res[i]['remarks'];
	                        let before = '';
	                        let after = '';
	                        let color = '';

	                        // lgCat이 수입인지 지출인지 확인하여 '+' 또는 '-' 및 색상 설정
	                        if (lgCat === '수입') {
	                            before = '+';
	                            color = 'rgba(75, 192, 192)';
	                        } else {
	                            before = '-';
	                            color = 'rgba(255, 99, 132)';
	                        }

	                        tableHTML += '<div class="container">' +
	                            '<div class="row" style="margin-left: 15px;">' +
	                            '<div class="col-auto" style="padding: 0px; margin-top: 5px;">' +
	                            generateIcon(mdCat) +
	                            '</div>' +
	                            '<div class="col">' +
	                            '<h4 class="m-0">' + mdCat + '</h4>' +
	                            '<p>' + smCat + '</p>' +
	                            '</div>' +
	                            '<div class="col" style ="padding-left: 0px;">' +
	                            '<h3 class="m-0 price" style=" width: 220px; color:' + color + ';">' + before + numberWithCommas(price) + '원</h3>' +
	                            '</div>' +
	                            '</div>' +
	                            '</div>';
	                    }
	                    $("#details-modal").modal('show');
	                    $("#modal-table").append(tableHTML);

	                },
	                error: function(e) {
	                    console.log(e);
	                }
	            });
	        },
	          
	        dayCellContent: function(info) {
	            var number = document.createElement("a");
	            number.classList.add("fc-daygrid-day-number");
	            number.innerHTML = info.dayNumberText.replace("일", '').replace("日", "");
	            if (info.view.type === "dayGridMonth") {
	                return {
	                    html: number.outerHTML
	                };
	            }
	            return {
	                domNodes: []
	            };
	        },
	        eventContent: function(arg) {
	            var eventTitle = document.createElement('div');
	            eventTitle.innerHTML = arg.event.title;
	            return {
	                domNodes: [eventTitle]
	            };
	        },
	        events: [
	            <c:forEach items="${priceList}" var="price">
	            {
	                title: "${price.lgCat} :${price.price}원",
	                start: '${price.finDy}',
	                className: '<c:out value="${price.lgCat eq '수입' ? 'income' : 'expenses'}"/>'
	            },
	            </c:forEach>
	        ]
	    });
	    calendar.render();
	    // 캘린더 랜더 후 차트 js 헤드 값 넣기
	    let date = $("#fc-dom-1").text();
        $("#this-month").text(date.split(" ")[1]+" 합계")
	
	    var labels = ['재정 상태'];
	    var datasets = [];
	
	    <c:forEach items="${totalPriceList}" var="total">
	    var dataset = {
	        label: '${total.lgCat}',
	        data: ['${total.price}'],
	
	        <c:if test="${total.lgCat == '수입'}">
	        backgroundColor: 'rgba(75, 192, 192, 0.2)', // 수입 막대 색상
	        borderColor: 'rgba(75, 192, 192, 1)', // 수입 막대 테두리 색상
	        </c:if>
	        <c:if test="${total.lgCat == '지출'}">
	        backgroundColor: 'rgba(255, 99, 132, 0.2)', // 지출 막대 색상
	        borderColor: 'rgba(255, 99, 132, 1)', // 지출 막대 테두리 색상
	        </c:if>
	
	        borderWidth: 1,
	        maxBarThickness: 60
	    };
	
	    datasets.push(dataset);
	    </c:forEach>
	
	 	// 차트 그리는 함수
	    let myChart;
	    function chart_fc(labels, datasets) {
	    	$(".chart-body").html("<canvas id='myChart' height='400px'></canvas>")
	        let myCt = document.getElementById('myChart');
	        if (myChart) {
	            myChart.destroy();
	        }
	        if(datasets.length !=0){
	        myChart = new Chart(myCt, {
	            type: 'bar',
	            data: {
	                labels: labels,
	                datasets: datasets
	            },
	            options: {
	                responsive: true,
	                maintainAspectRatio: false,
	                scales: {
	                    y: {
	                        grid: {
	                            display: false,
	                        }
	                    },
	                },
	                yAxis: {
	                    pointOnColumn: false,
	                    showLabel: false
	                }
	            }
	        });
	    	}else{
	    		if (myChart) {
		            myChart.destroy();
		        }
	    		var myPageUrl = '<c:url value="/abView" />';
	    		
	    		$(".chart-body").html('<div class="parentDiv col-12">' +
	    			    '<div style="position:absolute" class="col-12 login-form">' +
	    			    '<a href="' + myPageUrl + '"><img class="hoverImage col-12 login-form" src="resources/img/no_data2.png" style="min-width:10%; max-width: 400px; height: auto; max-height: 300px; display: block; margin-top:50px;"/></a></div>' +
	    			    '<img class="mainImage col-12 login-form" src="resources/img/no_data.png" style="min-width:10%; max-width: 500px; height: auto; max-height: 400px; display: block; margin-top:50px;"/>' +
	    			    '</div>');
	    	}     
	    }
	    chart_fc(labels, datasets);
	    
	    // 달력 월 변경시 ajax 요청
	    $(".fc-button").click(function() {
	        let date = $("#fc-dom-1").text();
	        $("#this-month").text(date.split(" ")[1]+" 합계")
	        datasets = [];
	        let incomeTotal = 0;
	        let expensesTotal = 0;
	
	        $.ajax({
	            url: '<c:url value="/changeDate" />',
	            type: "POST",
	            data: {
	                date: date
	            },
	            success: function(res) {
	                let datasets = [];
	                for (let i in res) {
	                    let backgroundColor, borderColor;
	                    if (res[i].lgCat == '수입') {
	                        backgroundColor = 'rgba(75, 192, 192, 0.2)'; // 수입 막대 색상
	                        borderColor = 'rgba(75, 192, 192, 1)'; // 수입 막대 테두리 색상
	                        incomeTotal = res[i].price;
	                    
	                    } else if (res[i].lgCat == '지출') {
	                        backgroundColor = 'rgba(255, 99, 132, 0.2)'; // 지출 막대 색상
	                        borderColor = 'rgba(255, 99, 132, 1)'; // 지출 막대 테두리 색상
	                        expensesTotal = res[i].price;
	                    }
	
	                    var dataset = {
	                        label: res[i].lgCat,
	                        data: [res[i].price],
	                        backgroundColor: backgroundColor,
	                        borderColor: borderColor,
	                        borderWidth: 1,
	                        maxBarThickness: 45
	                    };
	                    datasets.push(dataset);
	                }
	                // 텍스트에 있는 금액 변경
	                $('#income').text(incomeTotal);
	                $('#expenses').text(expensesTotal);
	                // 금액에 쉼표 추가
	                document.querySelectorAll('.price').forEach(function(element) {
	                    var currentValue = element.textContent;
	                    var formattedValue = currentValue.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	                    element.textContent = formattedValue;
	                });
		            chart_fc(labels, datasets);
	            },
	            error: function(e) {
	                console.log(e);
	            }
	        });
	    });
	    
	    // 금액 ,찍기
	    document.querySelectorAll('.price').forEach(function(element) {
	        var currentValue = element.textContent;
	        var formattedValue = currentValue.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	        element.textContent = formattedValue;
	    });
	    
	    // 금액찍기 함수
	    function numberWithCommas(x) {
	        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	    // 모달창 닫을 때 테이블 초기화
	    $('#details-modal').on('hidden.bs.modal', function (e) {
	        $("#modal-table").empty();
	    });
	});
</script>
</html>
