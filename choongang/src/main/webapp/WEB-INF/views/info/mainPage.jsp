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
<link href='../resources/css/reset.css' rel='stylesheet' />
<link href='../resources/css/info.css' rel='stylesheet' />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<!-- fullcalender -->
<link href='../resources/css/mainCalendar.css' rel='stylesheet' />
<link href='../resources/css/main.min.css' rel='stylesheet' />
<script src='../resources/js/main.js'></script>
<script src='../resources/js/main.min.js'></script>
<script src='../resources/js/locales-all.js'></script>
<script src='../resources/js/locales-all.min.js'></script>
<link rel="stylesheet" href="../resources/css/jquery-ui.min.css" >
<link rel="stylesheet" href="../resources/css/jquery-ui.css">
<script src="../resources/js/jquery-ui.min.js"></script>
</head>
<body>
	

<jsp:include page="../common/nav.jsp"></jsp:include>

<div id="container">
<div id="box">
	
	<div id="gnb">
		<div class="iconBox">
		<img src="../resources/img/user.png" class="profile">
		<div class="icon">
		<p class="iconText" >닉네임</p>
		</div>
	</div>
	</div>
	
	<div id="first">
	<div id="doughnut">
	<div id="bar">
		<div class="titleB">
    	<h3 class="title">Server State</h3>
    	<a href=""><p class="more">More</p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
    	</div>
		<div class="barBox">
		<div class="barBar">
		<canvas id="barChart" width="600" height="400" style="width:100%"></canvas>
		
		<ul class="barUl">
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox">작업중</h3></li>
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox">작업예정</h3></li>
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox">작업완료</h3></li>
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox">작업없음</h3></li>
		</ul>
		</div>
		<div class="barBar2">
		<ul class="barUl2">
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">아주 아주 아주아주 긴 서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">아주 아주 긴 서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">아주 아주 긴 서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">아주 아주 긴 서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">아주 아주 아주아주 긴 서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">서버명입니다</h3></li>
		</ul>
		<ul class="barUl3">
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">아주 아주 아주아주 긴 서버명입니다</h3></li>
			<li class="barList2"><div class="colorBox2"><p class="colorBoxRed"></p></div><h3 class="titleBox">서버명입니다</h3></li>
		</ul>
		</div>
		
	</div>
	</div>
	
	</div>
	<div id="scheduleBox">
	<div class="titleB">
		<h3 class="title" style="margin-bottom: 50px;">Schedule</h3>
		<a href=""><p class="more">More</p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
		</div>
		<div id="calendar"></div>
		
	</div>
</div>


	<div id="box2">
	<div id="doughnutBox">
		<div class="titleB">
    	<h3 class="title">Server List</h3>
    	<a href=""><p class="more">More</p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
    	</div>
		<div class="doughnutBox2">
		<canvas id="doughnut-chart" width="300" height="300" style="width:100%"></canvas>
		<ul class="doughnutUl">
			<li class="doughnutList"><p class="colorBox"></p><h3 class="titleBox">Window</h3></li>
			<li class="doughnutList"><p class="colorBox"></p><h3 class="titleBox">Linux</h3></li>
			<li class="doughnutList"><p class="colorBox"></p><h3 class="titleBox">AIX</h3></li>
		</ul>
	</div>
	</div>

	<div id="noticeBox">
	<div class="titleB">
    	<h3 class="title" style="margin-bottom: 30px;">Notice</h3>
    	<a href=""><p class="more">More</p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
    	</div>
		<div class="noticeBox2">
		<ul class="noticeUl">
			<li class="noticeList"><h3 class="titleList">제목입니다.</h3><p class="date">2022.03.30</p></li>
			<li class="noticeList"><h3 class="titleList">제목입니다.</h3><p class="date">2022.03.30</p></li>
			<li class="noticeList"><h3 class="titleList">제목입니다.</h3><p class="date">2022.03.30</p></li>
			<li class="noticeList"><h3 class="titleList">제목입니다.</h3><p class="date">2022.03.30</p></li>
		</ul>
	</div>
	</div>
	
	
	
</div>

</div>
</div>




<script>
// 서버 차트 작성
var context = document.getElementById('barChart');
$.ajax({
	url : '/choongang/info/getServerInfo',
	method : 'POST',
	dataType : 'json'
}).done(function(json){
	const stateLabels = ['작업중', '작업예정', '작업완료', '작업없음'];
	const osLabels = ['AIX', 'Windows', 'Linux'];
	
	var os = [0, 0, 0];
	
	for(var server of json.serverInfo){
		var sv = server['serverVo'].os;
		
		if(sv == 'AIX'){
			os[0]++;
		} else if(sv == 'Windows'){
			os[1]++;
		} else if(sv == 'Linux'){
			os[2]++;
		}
	}
	
	// 서버 상태 Bar Chart 작성
	var myChart = new Chart(context, {
		type: 'bar',
		data: {
		labels: stateLabels,
		datasets: [{
			backgroundColor: ["#e04651", "#f8c631","#3d5fac","#c9c9c9"], 
			pointBackgroundColor: 'white',
			borderWidth: 0,
			data: [
				json.stateCount[1],
				json.stateCount[0],
				json.stateCount[2],
				json.stateCount[3]
			]
	    }]},
	    options: {
			responsive: false,
			legend: {
				display:false
			},
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true,
						stepSize : 20,
						fontColor : "#222",
						fontSize : 20,
	                       fontFamily : 'Montserrat'
					},
					gridLines:{
						color: '#e8e8e8',
						lineWidth:1,
	                       drawBorder: false,
	                       margin:10
					}
				}],
				xAxes: [{
					ticks:{
						beginAtZero: true,
						stepSize : 30,
						fontColor : "#222",
						fontSize : 20,
						fontFamily :'Noto Sans KR'
					},
					gridLines:{
						display:false
					}
				}]
			}
		}
	});
	
	// 서버 OS 종류별 작성
	new Chart(document.getElementById("doughnut-chart"), {
	    type: 'doughnut',
	    data: {
	      labels: osLabels,
	      datasets: [
	        {
	          label: "Population (millions)",
	          backgroundColor: ["#e54e6d", "#3d5fac","#f8c631"], 
	          data: os,
			  borderWidth: 0
	        }
	      ]
	    },
	    options: {
			responsive: false,
			legend: {
				display:false
			}
	    }
	});
	
	console.log(json.weekScheduleInfo.length);
	
	var events = json.weekScheduleInfo.map(function(item){
		return{
			title : item.title,
			start : item.start_date + "T" + item.start_time,
			end : item.end_date + "T" + item.end_date,
			id : item.sc_no
		}
	});
	
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'listMonth',
		locale: 'ko',
		events : events
	});
	
	calendar.render();
})

/* var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
	  initialView: 'listWeek',
	  locale: 'ko',
	  events: [
						{
							    title: '언제부터시작인가',
							    start: '2022-03-28T14:30:00',
							    extendedProps: {
							      status: 'done'
								}
							},
							{
							  title: '테스트입니다1111111',
							  start: '2022-03-30T14:30:00',
							  extendedProps: {
							    status: 'done'
								}
							},
							{
							  title: '테스트입니다222222',
							  start: '2022-03-30T07:00:00',
							  backgroundColor: 'green',
							  borderColor: 'green'
							},
							{
							  title: '테스트입니다333333',
							  start: '2022-03-31T14:30:00',
							  extendedProps: {
							    status: 'done'
							  }
							},{
							  title: '테스트입니다4444444',
							  start: '2022-03-31T18:30:00',
							  extendedProps: {
							    status: 'done'
							  }
							},{
							   title: '테스트입니다555555',
							   start: '2022-03-31T14:30:00',
							   extendedProps: {
							     status: 'done'
							   }
							},{
							    title: '테스트입니다6666666',
							    start: '2022-03-31T22:30:00',
							    extendedProps: {
							      status: 'done'
							}
							},{
							     title: '테스트입니다7777777',
							     start: '2022-04-01T14:30:00',
							     extendedProps: {
							       status: 'done'
							}
							   },{
							    title: '테스트입니다88888888',
							    start: '2022-04-02T14:30:00',
								extendedProps: {
								status: 'done'
									}
								},{
									title: '테스트입니다999999',
									start: '2022-04-02T14:30:00',
									extendedProps: {
										status: 'done'
									}
								}]
							}); 
calendar.render(); */

 </script>
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<!-- MDB -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.11.0/mdb.min.js"></script>
</html>