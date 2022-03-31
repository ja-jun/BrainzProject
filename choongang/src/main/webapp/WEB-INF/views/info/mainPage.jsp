<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
<!-- MDB -->
<!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.11.0/mdb.min.css" rel="stylesheet" /> -->
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<!-- custom -->
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href='../resources/css/nav.css' rel='stylesheet' />
<link href='../resources/css/reset.css' rel='stylesheet' />
<!-- JqGrid -->
<link rel="stylesheet" type="text/css" href="../resources/css/jquery-ui.min.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/ui.jqgrid2.css"/>
<script type="text/javascript" src="../resources/js/grid.locale-kr.js"></script>
<script type="text/javascript" src="../resources/js/jquery.jqGrid.js"></script>
<script type="text/javascript" src="../resources/js/jQuery.jqGrid.setColWidth.js"></script>
<script type="text/javascript" src="../resources/js/jquery-ui.min.js"></script>
<script>
/* 서버 현황 START */
function getServerInfo(){
	$.ajax({
		url: "/choongang/info/getServerInfo",
		method: "POST",
		dataType: "json"
	}).done(function(json){
		/* Render Chart Start */
		const stateLabels = ['작업중', '작업완료', '작업예정', '작업없음'];
		const osLabels = ['AIX', 'Windows', 'Linux'];
		
		var os = [0, 0, 0];
		
		for(var server of json.serverInfo){
			var sv = server['serverVo'].os;
			console.log(sv);
			if(sv == 'AIX'){
				os[0]++;
			} else if(sv == 'Windows'){
				os[1]++;
			} else if(sv == 'Linux'){
				os[2]++;
			}
		}
		
		const stateData = {
			labels : stateLabels,
			datasets : [{
				label : '서버 상태',
				backgroundColor : [
				      'rgb(255, 99, 132)',
				      'rgb(54, 162, 235)',
				      'rgb(255, 205, 86)',
				      'rgb(164, 164, 164)'
				    ],
				data : [json.stateCount[1], 
						json.stateCount[2], 
						json.stateCount[0],
						json.stateCount[3]]
			}]
		};
		
		const osData = {
			labels : osLabels,
			datasets : [{
				label : '서버 종류',
				backgroundColor : [
					'rgb(255, 159, 64)',
					'rgb(75, 192, 192)',
					'rgb(153, 102, 255)'
				],
				data : os
			}]
		};
		

		const stateConfig = {
			type : 'doughnut',
			data : stateData,
			options : {
				responsive: 'false'
			}
		};
		
		const osConfig = {
			type : 'bar',
			data : osData,
			options : {
				responsive : 'false',
				scales : {
					y : {
						beginAtZero : true
					}
				}
			}
		};
		
		// chart.js 를 render 하는 함수
		// canvas에 id를 붙이는걸로는 불러올 수 없고
		// aria-label 또는 role을 이용해야 불러올 수 있다.
		const stateChart = new Chart(document.getElementById('stateChart'), stateConfig);
		const osChart = new Chart(document.getElementById('osChart'), osConfig);
		/* Render Chart End */
		
		/* Server Listing */
		for(var server of json.serverInfo){
			var svVo = document.createElement('li');
			svVo.setAttribute("class","list-group-item");
			svVo.innerText = server['serverVo'].name;
			
			var state = server['state'];
			if(state == 0){
				$('ul[name=state-pre]').append(svVo);
			} else if(state == 1){
				$('ul[name=state-working]').append(svVo);
			} else if(state == 2){
				$('ul[name=state-aft]').append(svVo);
			} else {
				$('ul[name=state-no]').append(svVo);
			}
		}
		
	})
};
/* 서버 현황 END */

/* 작업 현황 START */
function getScheduleInfo(){
	$('#scheduleGrid').jqGrid({
		colModel : [
			{name : 'title', label : '작업명', align : 'left'},
			{name : 'start_time', label : '시작시간', align : 'center'},
			{name : 'end_time', label : '종료시간', align : 'center'},
			{name : 'state', label : '상태', align : 'center'},
		],
		url : '/choongang/info/getScheduleInfo',
		datatype : 'JSON',
		loadtext : '로딩중',
		height : 'auto',
		rowNum : 50
	});
}
/* 작업 현황 END */

window.addEventListener('DOMContentLoaded', function(){
	var today = new Date();
	
	getServerInfo();
	getScheduleInfo();
	
	$('span[name=today]').text(today.toLocaleString() + '\t 기준 서버 현황');
});
</script>
</head>
<body>
	<div id="container">
		<jsp:include page="../common/nav.jsp"></jsp:include>
	</div>
	<div class="row" style="padding-left: 260px; margin-top: 80px; width: 2500px;">
		<div class="col pt-3 ps-4">
			<div class="row">
				<!-- 서버 현황 시작 -->
				<div class="col-4">
					<div class="row bg-dark border border-secondary border-4" style="height: 70px">
						<div class="col">
							<span style="text-color: e69600; font-size: 30px; color: #e69600; font-weight: 700;">
								서버 현황 
							</span>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-6 p-3 border border-3 border-secondary border-end-0">
							<canvas id="stateChart" height="330px">
								<p>Hello Fallback World</p>
							</canvas>
						</div>
						<div class="col-6 pt-2 border border-3 border-secondary">
							<canvas id="osChart" height="330px">
								<p>Hello Fallback World</p>
							</canvas>
						</div>
					</div>
					<div class="row">
						<div class="col p-3 pt-2 border border-3 border-secondary border-top-0">
							<div class="row">
								<div class="col">
									<span name="today"></span>
								</div>
							</div>
							<div class="row">
								<!-- 작업중 리스트 -->
								<div class="col">
									<div class="row">
										<div class="col">
											<i class="bi bi-server" style="color: rgb(255, 99, 132)"></i>작업중
										</div>
									</div>
									<div class="row">
										<div class="col">
											<ul class="list-group list-group-flush" name="state-working">
											</ul>
										</div>
									</div>
								</div>
								<!-- 작업예정 리스트 -->
								<div class="col">
									<div class="row">
										<div class="col">
											<i class="bi bi-server" style="color: rgb(255, 205, 86)"></i>작업예정
										</div>
									</div>
									<div class="row">
										<div class="col">
											<ul class="list-group list-group-flush" name="state-pre">
											</ul>
										</div>
									</div>
								</div>
								<!-- 작업완료 리스트 -->
								<div class="col">
									<div class="row">
										<div class="col">
											<i class="bi bi-server" style="color: rgb(54, 162, 235)"></i>작업완료
										</div>
									</div>
									<div class="row">
										<div class="col">
											<ul class="list-group list-group-flush" name="state-aft">
											</ul>
										</div>
									</div>
								</div>
								<!-- 작업예정 리스트 -->
								<div class="col">
									<div class="row">
										<div class="col">
											<i class="bi bi-server" style="color: rgb(164, 164, 164)"></i>작업없음
										</div>
									</div>
									<div class="row">
										<div class="col">
											<ul class="list-group list-group-flush" name="state-no">
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 서버 현황 종료 -->
				<div class="col-3 ms-3">
					<div class="row bg-dark border border-secondary border-4" style="height: 70px">
						<div class="col pe-0">
							<span style="text-color: e69600; font-size: 30px; color: #e69600; font-weight: 700;">
								작업 현황 
							</span>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col border border-3 border-secondary">
							<table id="scheduleGrid"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<!-- MDB -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.11.0/mdb.min.js"></script>
</html>