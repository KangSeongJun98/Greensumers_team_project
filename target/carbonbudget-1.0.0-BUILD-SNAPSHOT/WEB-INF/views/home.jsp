<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page
	import="com.greensumers.carbonbudget.commons.utils.CarbonCalculator"%>
<%@ page
	import="com.greensumers.carbonbudget.comparison.vo.ComparisonVO"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Statistics</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
#myChart {
	min-width: 50%; /* 원하는 최소 너비로 변경하세요 */
	min-height: 80%;
}

#lineChart {
	min-width: 60%;
	min-height: 80%;
}

#twoChart {
	min-width: 60%;
	max-width: 90%;
	min-height: 80%;
}

#doughnutChart {
	min-width: 80%;
	min-height: 40%;
}
.percentage-color-red{
	color: #E0115F;
}
.percentage-color-blue{
	color: #6495ED;
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
			<div class="page-heading" >
				<div style="display: flex; align-items: center;">
				    <img src="resources/img/carbon1.png" style="height: 50px; width: 50px;">
				    <h3 style="margin: 0;">사용자 전체 통계</h3>
			    </div>
			    <h6 style="margin-left: 5%" class="date"></h6>
			</div>

			<div class="page-content">
				<section class="row">
					<div class="col-md-12 col-lg-4">
						<div class="row">
							<div class="col-12">
								<div class="card"
									style="height: 175px; display: flex; flex-direction: column;">
									<div class="card-header" style="">
										<div class="d-flex align-items-center">
											<h4 class="mb-0 ms-3">${avgList[0].countId}명의 탄소발자국 </h4>
										</div>
									</div>
									<div class="card-body">
										<div class="row" style="margin-bottom: 12px">
											<div class="col-8">
												<h5 class="mb-0 text-end">${useYm}</h5>
											</div>
										</div>
										<div class="row" style="margin-bottom: 12px">
											<div class="col-7">
												<div class="d-flex align-items-center">
													<h6 class="mb-0 ms-3">
														금월 배출량:
													</h6>
												</div>
											</div>
											<div class="col-5">
												<h6 class="mb-0 text-end" id="This-month-emissions">0</h6>
											</div>
										</div>
										<div class="row" style="margin-bottom: 12px">
											<div class="col-7">
												<div class="d-flex align-items-center">
													<h6 class="mb-0 ms-3">
														전월 배출량:
													</h6>
												</div>
											</div>
											<div class="col-5">
												<h6 class="mb-0 text-end" id="previous-month-emissions"></h6>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="card"
									style="height: 280px; display: flex; flex-direction: column;">
									<div class="card-header" style="padding-bottom: 10px">
										<h4>평균 배출량</h4>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-12"
												style="height: 180px; text-align: center;">
												<canvas id="myChart" style="display: inline;"></canvas>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="card"
									style="height: 310px; display: flex; flex-direction: column;">
									<div class="card-header">
										<h4>월별 배출량</h4>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-12"
												style="height: 215px; text-align: center;">
												<canvas id="lineChart" style="display: inline;"></canvas>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-8">
						<div class="row">
							<div class="row">
							<div class="col-12">
								<div class="card" style="height: 490px; display: flex; flex-direction: column;">
									<div class="card-header">
										<h4>작년대비 배출량</h4>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-12" style="height: 400px; text-align: center;">
												<canvas id="twoChart" style="display: inline;"></canvas>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="card"
									style="height: 310px; display: flex; flex-direction: column;">
									<div class="card-header">
										<h4>세부사항</h4>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-3"
												style="height: 218px; text-align: center; display: flex; justify-content: center; align-items: center;">
												<canvas id="doughnutChart" style="display: inline;"></canvas>
											</div>
											<div class="col-9">
												<section>
													<header>
														<table class="table">
															<thead>
																<tr>
																	<th>전기</th>
																	<th>가스</th>
																	<th>수도</th>
																	<th>교통</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>${avgList[0].elctrCf}kg</td>
																	<td>${avgList[0].gasCf}kg</td>
																	<td>${avgList[0].waterCf}kgkg</td>
																	<td>${avgList[0].carCf}kg</td>
																</tr>
															</tbody>
														</table>
													</header>
													<p id= "doughnut-result" style="margin-top: 30px"></p>
												</section>
											</div>
										</div>
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
</body>
<!-- 에너지 사용량 차트 -->
	<script>
	const ctx = document.getElementById('myChart').getContext('2d');
	
	var avg_total =(${avgList[0].gasCf} + ${avgList[0].elctrCf} + ${avgList[0].waterCf} + ${avgList[0].carCf}).toFixed(1)
	console.log(avg_total)
	
	 $(".date").text("(${avgList[0].yearMonth}월 기준)");
	
    const myChart = new Chart(ctx, {
	        type: 'bar',  // 막대 그래프 설정
	        data: {
	            labels: [''],
	            datasets: [
	                {
	                    label: '전기',
	                    data: ["${avgList[0].elctrCf}"],
	                    backgroundColor: 'rgba(0, 26, 193, 0.4)'
	                },
	                {
	                    label: '가스',
	                    data: ["${avgList[0].gasCf}"],
	                    backgroundColor: 'rgba(76, 0, 211, 0.3)'
	                },
	                {
	                    label: '수도',
	                    data: ["${avgList[0].waterCf}"],
	                    backgroundColor: 'rgba(16, 237, 255, 0.3)'
	                },
	                {
	                    label: '교통',
	                    data: ["${avgList[0].carCf}"],
	                    backgroundColor: 'rgba(93, 177, 236, 0.5)'
	                }
	            ]
	        },
	        options : {
				scales : {
					x : {
						stacked : true
					},
					y : {
						stacked : true
					}
				},
				indexAxis : 'y',
				borderWidth: 1,
		        maxBarThickness: 40
				
			}
	    });

    let labels = [];
    let datas = [];
    let date = new Date("${avgList[0].yearMonth}-01");
    date.setMonth(date.getMonth() - 1);

 // 결과를 원하는 형식으로 출력
    let year = date.getFullYear();
    let month = String(date.getMonth() + 1).padStart(2, '0');  // 월을 2자리로 포맷팅
    let result = year + "-" + month;
    
    if(result == "${avgList[1].yearMonth}"){
		var avgData = (${avgList[1].gasCf}+${avgList[1].elctrCf}+${avgList[1].waterCf}+${avgList[1].carCf}).toFixed(1)
		$("#previous-month-emissions").text(avgData+"kg");
	}else{
		$("#previous-month-emissions").text("0kg")
	}
    
    
    <c:forEach var="avg" items="${avgList}" begin="0" end="9" varStatus="i">
        var avgData = (${avg.gasCf} + ${avg.elctrCf} + ${avg.waterCf} + ${avg.carCf}).toFixed(1); 
        datas.unshift(avgData);
        labels.unshift("${avg.yearMonth}"); 
    </c:forEach>
    var this_month_emissions = (${avgList[0].gasCf} + ${avgList[0].elctrCf} + ${avgList[0].waterCf} + ${avgList[0].carCf}).toFixed(1);
    $("#This-month-emissions").text(this_month_emissions + "kg");
    $("#doughnut-result").text("가정당 평균 배출량은 "+this_month_emissions + "kg입니다. 그래프를 통해 각 항목별 탄소배출량을 비교하여, 어떤 부분에서 더 많은 배출이발생하고 있는지 확인해 보시기 바랍니다.");
    
    console.log(datas)

    const lineCtx = document.getElementById('lineChart').getContext('2d');
    const lineChart = new Chart(lineCtx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '탄소배출량',
                data: datas,
                fill: false,
                tension: 0.2
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    var twoChart_labels = [];
    var twoChart_elctrs = [];
    var twoChart_gas = [];
    var twoChart_watets = [];
    var twoChart_cars = [];

    <c:forEach var="avg" items="${avgList}" varStatus="i">
        if ("${i.index}" != 0 && "${avgList[0].yearMonth}".split("-")[1] == "${avg.yearMonth}".split("-")[1]) {
            twoChart_labels = ["${avg.yearMonth}", "${avgList[0].yearMonth}"];
            twoChart_elctrs = ["${avg.elctrCf}", "${avgList[0].elctrCf}"];
            twoChart_gas = ["${avg.gasCf}", "${avgList[0].gasCf}"];
            twoChart_watets = ["${avg.waterCf}", "${avgList[0].waterCf}"];
            twoChart_cars = ["${avg.carCf}", "${avgList[0].carCf}"];
        }
    </c:forEach>

    const twoctx = document.getElementById('twoChart').getContext('2d');
    const twoChart = new Chart(twoctx, {
        type: 'bar',
        data: {
            labels: twoChart_labels,
            datasets: [{
                label: '전기',
                data: twoChart_elctrs,
                backgroundColor: 'rgba(0, 26, 193, 0.4)'
            }, {
                label: '가스',
                data: twoChart_gas,
                backgroundColor: 'rgba(76, 0, 211, 0.3)'
            }, {
                label: '수도',
                data: twoChart_watets,
                backgroundColor: 'rgba(16, 237, 255, 0.3)'
            }, {
                label: '교통',
                data: twoChart_cars,
                backgroundColor: 'rgba(93, 177, 236, 0.5)'
            }]
        },
        options: {
            indexAxis: 'x',
            scales: {
                y: {
                    type: 'logarithmic',
                    beginAtZero: false,
                    ticks: {
                        callback: function(value) {
                            const remain = value / (Math.pow(10, Math.floor(Chart.helpers.log10(value))));
                            if (remain === 1 || remain === 2 || remain === 5) {
                                return value;
                            }
                            return null;
                        }
                    }
                }
            }
        }
    });

    var doughnut_datas = ["${avgList[0].elctrCf}", "${avgList[0].gasCf}", "${avgList[0].waterCf}", "${avgList[0].carCf}"];
    const doughnutCanvas = document.getElementById('doughnutChart').getContext('2d');

    const doughnutChart = new Chart(doughnutCanvas, {
        type: 'doughnut',
        data: {
            labels: ['전기', '가스', '수도', '교통'],
            datasets: [{
                label: '탄소배출량 세부 항목',
                data: doughnut_datas,
                backgroundColor: [
                    'rgba(0, 26, 193, 0.4)',
                    'rgba(76, 0, 211, 0.3)',
                    'rgba(16, 237, 255, 0.3)',
                    'rgba(93, 177, 236, 0.5)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    position: 'bottom'
                },
                tooltip: {
                    enabled: true,
                    mode: 'index',
                    intersect: false
                }
            },
            cutout: '60%',
            responsive: true,
            maintainAspectRatio: false,
            title: {
                display: true,
                text: '탄소배출량 세부 항목',
                fontSize: 16,
                fontColor: '#333'
            },
            animation: {
                animateScale: true,
                animateRotate: true
            }
        }
    });

</script>

</html>