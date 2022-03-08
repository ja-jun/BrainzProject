<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<!-- fullcalender -->
	<link href='../resources/css/main.css' rel='stylesheet' />
	<link href='../resources/css/main.min.css' rel='stylesheet' />
	<link href='../resources/css/calendar.css' rel='stylesheet' />
	<link href='../resources/css/reset.css' rel='stylesheet' />
	<script src='../resources/js/main.js'></script>
	<script src='../resources/js/main.min.js'></script>
	<script src='../resources/js/locales-all.js'></script>
	<script src='../resources/js/locales-all.min.js'></script>
	<script>
		function getList(){
			var xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = JSON.parse(xhr.responseText);
					
					var list = data.scheduleList;
					
					console.log(list);
					
					var event = list.map(function(item){
						return {
							title : item.event.title,
							start : item.event.event_date + "T" + item.event.start_time,
							end : item.event.event_date + "T" + item.event.end_time
						}
					})
					var calendarEl = document.getElementById('calendar');
					var calendar = new FullCalendar.Calendar(calendarEl, {
					  initialView: 'dayGridMonth',
					  events: event,
					  locale: 'ko'
					});
					calendar.render();
				}
			}
			
			xhr.open("get","./getList",true);
			xhr.send();
		}
		
		window.addEventListener("DOMContentLoaded", function(){
			getList();
		})
    </script>
</head>
<body>
	<div class="container-fluid" style="width: 1200px">
		<div class="row">
			<div class="col bg-light shadow mb-5" style="height: 80px">
			</div>
		</div>
		<div class="row">
			<div class="col mt-5">
				<div id='calendar'>
				</div>
			</div>
		</div>
	</div>
</body>
</html>