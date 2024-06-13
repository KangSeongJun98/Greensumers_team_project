<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
				    <h3 style="margin: 0;">탄소 배출량 통계</h3>
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
											<h4 class="mb-0 ms-3">${sessionScope.login.memNm}님의 탄소발자국 </h4>
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
										<h4>사용자 평균과 비교</h4>
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
																	<td>${cfList[0].elctrCf}kg</td>
																	<td>${cfList[0].gasCf}kg</td>
																	<td>${cfList[0].waterCf}kg</td>
																	<td>${cfList[0].carCf}kg</td>
																</tr>
															</tbody>
														</table>
													</header>
													<p id= "doughnut-result" style="margin-top: 30px">총 이산화탄소 배출량은 ${lastEmissions}kg으로, 이는 다른 가정의 평균 배출량인
														${totalDataLastEmissions}kg 대비 약 ${carbonRate}% 입니다.</p>
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
		// 차트 생성
		const ctx = document.getElementById('myChart').getContext('2d');

		// 데이터 초기화
		let gas_cf = [];
		let elctr_cf = [];
		let water_cf = [];
		let car_cf = [];
		
		
		var avg_total =(${AvgList[0].gasCf} + ${AvgList[0].elctrCf} + ${AvgList[0].waterCf} + ${AvgList[0].carCf}).toFixed(1)
			
		if ("${cfList[0].yearMonth}" == "${AvgList[0].yearMonth}") {
		    elctr_cf = ["${AvgList[0].elctrCf}", "${cfList[0].elctrCf}"];
		    gas_cf = ["${AvgList[0].gasCf}", "${cfList[0].gasCf}"];
		    water_cf = ["${AvgList[0].waterCf}", "${cfList[0].waterCf}"];
		    car_cf = ["${AvgList[0].carCf}", "${cfList[0].carCf}"];
		} else {
		    elctr_cf = ["${AvgList[0].elctrCf}", "0"];
		    gas_cf = ["${AvgList[0].gasCf}", "0"];
		    water_cf = ["${AvgList[0].waterCf}", "0"];
		    car_cf = ["${AvgList[0].carCf}", "0"];
		}

		const myChart = new Chart(ctx, {
	        type: 'bar',  // 막대 그래프 설정
	        data: {
	            labels: ['사용자 평균', '내 배출량'],
	            datasets: [
	                {
	                    label: '전기',
	                    data: elctr_cf,
	                    backgroundColor: 'rgba(0, 26, 193, 0.4)'
	                },
	                {
	                    label: '가스',
	                    data: gas_cf,
	                    backgroundColor: 'rgba(76, 0, 211, 0.3)'
	                },
	                {
	                    label: '수도',
	                    data: water_cf,
	                    backgroundColor: 'rgba(16, 237, 255, 0.3)'
	                },
	                {
	                    label: '교통',
	                    data: car_cf,
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
				indexAxis : 'y'
			}
	    });
	    
		let labels = []
		let datas = []
		let date = new Date("${cfList[0].yearMonth}" + '-01')
		date.setMonth(date.getMonth() - 1);

		// 결과를 원하는 형식으로 출력
		let year = date.getFullYear();
		let month = String(date.getMonth() + 1).padStart(2, '0');  // 월을 2자리로 포맷팅
		let result = year+"-"+month;
	
		if(result == "${cfList[1].yearMonth}"){
			var cfData = (${cfList[1].gasCf}+${cfList[1].elctrCf}+${cfList[1].waterCf}+${cfList[1].carCf}).toFixed(1)
			$("#previous-month-emissions").text(cfData+"kg");
		}else{
			$("#previous-month-emissions").text("0kg")
		}
		
		<c:forEach var="cf" items="${cfList}" begin="0" end="9" varStatus="i">    
			var cfData = (${cf.gasCf}+${cf.elctrCf}+${cf.waterCf}+${cf.carCf}).toFixed(1)
			if(${i.index}==0){
				$(".date").text("(${cf.yearMonth}월 기준)")
				$("#This-month-emissions").text(cfData+"kg")
				
				var difference = cfData - avg_total;

				var percentageDifference = (difference / avg_total) * 100
				if (percentageDifference > 0) {
				    $("#doughnut-result").html("${cf.memId}님의 총 이산화탄소 배출량은 " +  cfData +" kg으로, <br>이는 다른 가정의 평균 배출량인 " + avg_total + "kg 대비 약 <span class='percentage-color-red'>" +percentageDifference.toFixed(1)+"%</span> 더 많습니다.")
				}else if (percentageDifference < 0) {
				    $("#doughnut-result").html("${cf.memId}님의 총 이산화탄소 배출량은 " +  cfData +" kg으로, <br>이는 다른 가정의 평균 배출량인 " + avg_total + "kg 대비 약 <span class='percentage-color-blue'>" + Math.abs(percentageDifference).toFixed(1)+"%</span> 더 적습니다.")
				} else {
				    console.log(`박진기님의 이산화탄소 배출량은 평균 배출량과 같습니다.`);
				    $("#doughnut-result").html("${cf.memId}님의 총 이산화탄소 배출량은 " +  cfData +" kg으로, <br>이는 다른 가정의 평균 배출량인 " + avg_total + "kg과 같습니다.")
				    
				} 
				
			}
			datas.unshift(cfData)
			labels.unshift("${cf.yearMonth}")
		</c:forEach>
		const lineCtx = document.getElementById('lineChart').getContext('2d');
		const lineChart = new Chart(lineCtx, {
			
			type : 'line',
			data : {
				labels : labels,
				datasets : [ {
					label : '탄소배출량',
					data : datas,
					fill : false,
					tension : 0.2
				} ]
			},
			options : {
				scales : {
					y : {
						beginAtZero : true
					}
				}
			}
		});	

		
		var twoChart_labels = []
		var twoChart_elctrs = []
		var twoChart_gas = []
		var twoChart_watets = []
		var twoChart_cars = []	
		
		<c:forEach var="cf" items="${cfList}" varStatus="i">
			if("${i.index}"!=0 && "${cfList[0].yearMonth}".split("-")[1] == "${cf.yearMonth}".split("-")[1]){
				twoChart_labels = ["${cf.yearMonth}", "${cfList[0].yearMonth}"]
				twoChart_elctrs = ["${cf.elctrCf}", "${cfList[0].elctrCf}"]
				twoChart_gas = ["${cf.gasCf}", "${cfList[0].gasCf}"]
				twoChart_watets = ["${cf.waterCf}", "${cfList[0].waterCf}"]
				twoChart_cars = ["${cf.carCf}", "${cfList[0].carCf}"]
			}
		</c:forEach>
		if(twoChart_labels.length == 0 ){
			twoChart_labels = ["", "${cfList[0].yearMonth}"]
			twoChart_elctrs = ["0", "${cfList[0].elctrCf}"]
			twoChart_gas = ["0", "${cfList[0].gasCf}"]
			twoChart_watets = ["0", "${cfList[0].waterCf}"]
			twoChart_cars = ["0", "${cfList[0].carCf}"]
		}
		
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
		                    callback: function(value, index, values) {
		                        // 로그 스케일에서 주요 라벨만 표시
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

		var doughnut_datas = ["${cfList[0].elctrCf}", "${cfList[0].gasCf}", "${cfList[0].waterCf}", "${cfList[0].carCf}"];

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
		                display: true,  // 레전드 표시
		                position: 'bottom'  // 레전드를 하단에 위치
		            },
		            tooltip: {
		                enabled: true, // 툴팁 활성화
		                mode: 'index',
		                intersect: false
		            }
		        },
		        cutout: '60%',  // 도넛의 가운데 부분을 70%로 설정
		        responsive: true,  // 차트 반응형으로 설정
		        maintainAspectRatio: false,  // 비율 유지하지 않음
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
		
		var cfData = (${cfList[0].gasCf} + ${cfList[0].elctrCf} + ${cfList[0].waterCf} + ${cfList[0].carCf}).toFixed(1);
		var doughnut_text = "<p>총 이산화탄소 배출량은 " + cfData + " kg으로, 이는 다른 가정의 평균 배출량인 " + avg_total + " kg 대비 약 " + percentageDifference.toFixed(1) + "% 입니다.</p>";
		$("#doughnut-result").html(doughnut_text);
		
	</script>
</html>