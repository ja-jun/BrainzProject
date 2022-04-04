<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
		<p class="iconText" >${userInfo.name }</p>
		</div>
	</div>
	</div>
	
	<div id="first">
	<div id="doughnut">
	<div id="bar">
		<div class="titleB">
    	<h3 class="title"><spring:message code="info.serverstate"/></h3>
    	<a href="/choongang/server/mainPage"><p class="more"><spring:message code="info.more"/></p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
    	</div>
		<div class="barBox">
		<div class="barBar">
		<canvas id="barChart" width="400" height="300" style=""></canvas>
		
		<ul class="barUl">
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox"><spring:message code="info.schedule.working"/></h3></li>
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox"><spring:message code="info.schedule.preworking"/></h3></li>
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox"><spring:message code="info.schedule.aftworking"/></h3></li>
			<li class="barList"><p class="colorBox"></p><h3 class="titleBox"><spring:message code="info.schedule.noworking"/></h3></li>
		</ul>
		</div>
		<div class="barBar2">
		<ul class="barUl2">
		<!-- 작업 중 서버 목록 -->
		</ul>
		<ul class="barUl3">
		<!-- 작업 예정 서버 목록 -->
		</ul>
		</div>
		
	</div>
	</div>
	</div>



	<div id="scheduleBox">
	<div class="titleB">
		<h3 class="title" style="margin-bottom: 50px;"><spring:message code="info.schedule"/></h3>
		<a href="/choongang/schedule/mainPage"><p class="more"><spring:message code="info.more"/></p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
		</div>
		<div id="calendar"></div>
	</div>


	<div id="box2">
	<div id="doughnutBox">
		<div class="titleB">
    	<h3 class="title"><spring:message code="info.serverlist"/></h3>
    	<a href="/choongang/server/mainPage"><p class="more"><spring:message code="info.more"/></p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
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
    	<h3 class="title" style="margin-bottom: 30px;"><spring:message code="info.notification"/></h3>
    	<a href="/choongang/notification/mainPage"><p class="more"><spring:message code="info.more"/></p><i class="bi bi-arrow-right-short" style="margin-right:0"></i></a>
    	</div>
		<div class="noticeBox2">
		<ul class="noticeUl">
		</ul>
	</div>
	</div>
</div>

</div>
</div>
</div>




<script>
const language = '<spring:message code="language"/>';
const info_working = '<spring:message code="info.schedule.working"/>';
const info_preworking = '<spring:message code="info.schedule.preworking"/>';
const info_aftworking = '<spring:message code="info.schedule.aftworking"/>';
const info_noworking = '<spring:message code="info.schedule.noworking"/>';
const info_working_server = '<spring:message code="info.schedule.working.server"/>';
const info_preworking_server = '<spring:message code="info.schedule.preworking.server"/>';

// 서버 차트 작성
var context = document.getElementById('barChart');
$.ajax({
	url : '/choongang/info/getServerInfo',
	method : 'POST',
	dataType : 'json'
}).done(function(json){
	const stateLabels = [info_working, info_preworking, info_aftworking, info_noworking];
	const osLabels = ['AIX', 'Windows', 'Linux'];
	
	var os = [0, 0, 0];
	
	for(var server of json.serverInfo){
		if(server == null){
			continue;
		}
		var sv = server['serverVo'].os;
		
		if(sv == 'AIX'){
			os[0]++;
		} else if(sv == 'Windows'){
			os[1]++;
		} else if(sv == 'Linux'){
			os[2]++;
		}
		
		if(server['state'] == 1 && $('.barUl2 .barList2').length < 7){
			var list = document.createElement("li");
			list.setAttribute("class", "barList2");
			
			var div = document.createElement("div");
			div.setAttribute("class", "colorBox2");
			
			var para = document.createElement("p");
			para.setAttribute("class", "colorBoxRed");
			
			div.append(para);
			
			var h3 = document.createElement("h3");
			h3.setAttribute("class", "titleBox");
			h3.innerText = server['serverVo'].name;
			
			list.append(div);
			list.append(h3);
			
			$('.barUl2').append(list);
			
		} else if(server['state'] == 0 && $('.barUl3 .barList2').length < 7){
			var list = document.createElement("li");
			list.setAttribute("class", "barList2");
			
			var div = document.createElement("div");
			div.setAttribute("class", "colorBox2");
			
			var para = document.createElement("p");
			para.setAttribute("class", "colorBoxRed");
			
			div.append(para);
			
			var h3 = document.createElement("h3");
			h3.setAttribute("class", "titleBox");
			h3.innerText = server['serverVo'].name;
			
			list.append(div);
			list.append(h3);
			
			$('.barUl3').append(list);
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
						fontSize : 16,
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
						fontSize : 16,
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
		locale: language,
		events : events
	});
	
	calendar.render();
	
	if($('.barUl2 .barList2').length == 0){
		var list = document.createElement("li");
		list.setAttribute("class", "barList2");
		
		var h3 = document.createElement("h3");
		h3.setAttribute("class", "titleBox");
		h3.innerText = info_working_server;
		
		list.append(h3);
		
		$('.barUl2').append(list);
	}
	
	if($('.barUl3 .barList2').length == 0){
		var list = document.createElement("li");
		list.setAttribute("class", "barList2");
		
		var h3 = document.createElement("h3");
		h3.setAttribute("class", "titleBox");
		h3.innerText = info_preworking_server;
		
		list.append(h3);
		
		$('.barUl3').append(list);
	}
	
	for(var notiVo of json.notificationVo){
		var list = document.createElement("li");
		list.setAttribute("class", "noticeList");
		
		var h3 = document.createElement("h3");
		h3.setAttribute("class", "titleList");
		h3.innerText = notiVo.nc_title;
		
		var p = document.createElement("p");
		p.setAttribute("class", "date");		
		
		var writedate = new Date(notiVo.nc_writeDate);
		console.log(writedate);
		p.innerText = writedate.toLocaleDateString();
		
		list.append(h3);
		list.append(p);
		
		$('.noticeUl').append(list);
	}
})
 </script>
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<!-- MDB -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.11.0/mdb.min.js"></script>
</html>