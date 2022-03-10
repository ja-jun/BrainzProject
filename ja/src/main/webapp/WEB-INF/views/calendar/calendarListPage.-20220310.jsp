<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
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
<!-- Datepicker -->
<link rel="stylesheet" href="../resources/css/jquery-ui.min.css" >
<link rel="stylesheet" href="../resources/css/jquery-ui.css">
<script src="../resources/js/jquery-ui.min.js"></script>
<!-- timepicker -->
<link rel="stylesheet" href="../resources/css/tui-time-picker.css" />
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/ui.jqgrid2.css" />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script>


function writeBtn() {
	const modal = document.getElementById("modal");
	modal.setAttribute("style","display: flex");
	$("html, body").addClass("not_scroll");
}

function delBtn() {
	const modal = document.getElementById("modal");
	modal.setAttribute("style","display: none");
	
	const serverModal = document.getElementById("serverModal");
	serverModal.setAttribute("style","display: none");
}

function getCalendarList(){
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);
				var calendarEl = document.getElementById('calendar');
				var list = data.scheduleList;
				
 				var events = list.map(function(item) {
    				return {
						title : item.title,
						start : item.event_date + "T" + item.start_time,
						end : item.event_date + "T" + item.end_time
					}
    			}); 
 				
				var calendar = new FullCalendar.Calendar(calendarEl, {
					 headerToolbar: {
				            left: 'prev',
				            center: 'title',
				            right: 'next'
				        },
					events : events,
					locale: 'ko'
				});
				calendar.render();
				
				var prev = document.getElementsByClassName('fc-prev-button fc-button fc-button-primary');
				prev[0].onclick = function(){
					var date = calendar.getDate();
					// 등록된 모든 이벤트들을 삭제한다.
					calendar.removeAllEvents();
					
					// 새로운 이벤트들을 등록한다.
					var reXhr = new XMLHttpRequest();
					reXhr.onreadystatechange = function(){
						if(reXhr.readyState == 4 && reXhr.status == 200){
							var reData = JSON.parse(reXhr.responseText);
							
							var newEvents = reData.scheduleList.map(function(item){
								return {
									title : item.title,
									start : item.event_date + "T" + item.start_time,
									end : item.event_date + "T" + item.end_time
								}
							});
							
							calendar.addEventSource(newEvents);
						}
					}
					
					reXhr.open("get", "../schedule/getList?year=" + date.getFullYear() + "&month=" + (date.getMonth() + 1), true);
					reXhr.send();
				};
				
				var next = document.getElementsByClassName('fc-next-button fc-button fc-button-primary');
				next[0].onclick = function(){
					var date = calendar.getDate();
					// 등록된 모든 이벤트들을 삭제한다.
					calendar.removeAllEvents();
					
					// 새로운 이벤트들을 등록한다.
					var reXhr = new XMLHttpRequest();
					reXhr.onreadystatechange = function(){
						if(reXhr.readyState == 4 && reXhr.status == 200){
							var reData = JSON.parse(reXhr.responseText);
							
							var newEvents = reData.scheduleList.map(function(item){
								return {
									title : item.title,
									start : item.event_date + "T" + item.start_time,
									end : item.event_date + "T" + item.end_time
								}
							});
							
							calendar.addEventSource(newEvents);
						}
					}
					
					reXhr.open("get", "../schedule/getList?year=" + date.getFullYear() + "&month=" + (date.getMonth() + 1), true);
					reXhr.send();
				};
			}
		};
		
		var today = new Date();
		
		xhr.open("get" , "../schedule/getList?year=" + today.getFullYear() + "&month=" + (today.getMonth() + 1) , true);
		xhr.send();	
}

function getServerList(){
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			
			var aaa = data.serverList;
			var jsonArr = [];
			for (var i = 0; i < aaa.length; i++) {
			    jsonArr.push({
			    	'name': aaa[i].name,
			    	'ip': aaa[i].ip,
			    	'os': aaa[i].os,
			    	'server_no': aaa[i].server_no
			    });
			}
			
			
				$("#list").jqGrid({
					datatype: "local",
					data: jsonArr,
					rowNum: 10,
					autowidth:true,
					 colModel: [	
							{name: 'name', label : '서버명', align:'left'},
					        {name: 'ip', label : 'IP', align:'left'},
					        {name: 'os', label : 'OS분류', align:'center'},
					        {name: 'server_no', hidden: true}
							],
					rowList:[10,20,30],
				    pager: '#pager',
				    multiselect: true
				
				});
				
				
				
				
				$('.btnBoxbtn2').click(function(){
					var params = new Array(); 
					var a = $("#list").jqGrid('getGridParam', 'selarrrow');
					
					
					for (var i = 0; i < a.length; i++) { //row id수만큼 실행          
					    if($("input:checkbox[id='jqg_list_"+a[i]+"']").is(":checked")){ //checkbox checked 여부 판단
					    var rowdata = $("#list").getRowData(a[i]);
					    params.push(rowdata);
					    console.log(params);
					    
					    }
					
					}
					
					console.log(params);
			    	
			    	const serverModal = document.getElementById("serverModal"); 
			        serverModal.setAttribute("style","display: none");
			        
			        var theadList = document.getElementById("theadList");
			        
			    	var serverModal2 = document.getElementById("serverListM");
			    	serverModal2.innerHTML = "";
					
			    	var tbody = document.createElement("tbody");
			    	
			    
  					for(var i = 0; i < params.length; i++){
						var tr6 = document.createElement("tr");
						tr6.setAttribute("class","serverContent");
						tbody.appendChild(tr6);
						var th7 = document.createElement("th");
						th7.setAttribute("class","serverContentText");
						tr6.appendChild(th7);
						var th8 = document.createElement("input");
						th8.setAttribute("type","checkbox");
						th7.appendChild(th8);
						var th9 = document.createElement("th");
						th9.setAttribute("class","serverContentText");
						th9.innerText=params[i].name;
						tr6.appendChild(th9);
						var th10 = document.createElement("th");
						th10.setAttribute("class","serverContentText");
						th10.innerText=params[i].ip;
						tr6.appendChild(th10);
						var th11 = document.createElement("th");
						th11.setAttribute("class","serverContentText");
						th11.innerText=params[i].os;
						tr6.appendChild(th11);
						var th12 =document.createElement("input");
						th12.setAttribute("type","hidden");
						th12.setAttribute("name","serverList");
						th12.setAttribute("value",params[i].server_no);
						tr6.appendChild(th12);
 					}  
			    	
  					tbody.appendChild(tr6);
  					serverModal2.appendChild(theadList);
  					serverModal2.appendChild(tbody);
			    	
				});
		}
	};
	xhr.open("get" , "./getServerList" , true);
	xhr.send();	
}
  
window.addEventListener("DOMContentLoaded" , function(){
	
	$(window).resize(function() {

		$("#list").setGridWidth($(this).width() * .100);

	});


	$(function(){
	    $('.datepicker').datepicker({
            dateFormat: 'yy.mm.dd'
	    });
	  })
	  
	  
	 $(function(){ 
     var tpSelectbox = new tui.TimePicker('#timepicker-selectbox', {
                initialHour: 12,
                initialMinute: 00,
                inputType: 'selectbox',
                showMeridiem: false
            });
	 })


     $(function(){ 
     var tpSelectbox = new tui.TimePicker('#timepicker-selectbox2', {
                initialHour: 12,
                initialMinute: 00,
                inputType: 'selectbox',
                showMeridiem: false
            });
	 })
	 
	  
	  
	$('.btnDay').click(function(){
  		if($(this).hasClass("active")){
  		   $(this).removeClass("active");
  		}else{
  		   $(this).addClass("active");  
  		}
	});


    
    $('.checkboxAll').click(function(){
        const btnDay = document.querySelectorAll('.btnDay'); 

        if($(btnDay).hasClass("active")){
  		   $(btnDay).removeClass("active");
  		}else{
  		   $(btnDay).addClass("active");  
  		}
          
	});
    
    
    $("input[name='radio1']").change(function() {
 		if($("input[name='radio1']:checked").val() == "2") {
 			const dayBox = document.getElementById("dayBox"); 
 	        dayBox.setAttribute("style","display: none");
 		} else {
 			const dayBox = document.getElementById("dayBox"); 
 	        dayBox.setAttribute("style","display: block");
 		}
 	});
    
    
     $('.limitless').click(function(){
        const noneBox = document.querySelector('.noneBox2');
        
        if($(noneBox).hasClass("noneBox")){
   		   $(noneBox).removeClass("noneBox");
   		}else{
   		   $(noneBox).addClass("noneBox");  
   		}
          
	}); 
     
    
    $('#btn1').click(function(){
         const serverModal = document.getElementById("serverModal"); 
         serverModal.setAttribute("style","display: block");  
         $("html, body").removeClass("not_scroll");
 	}); 
    
    
    $('.btnBoxbtn3').click(function(){
        const serverModal = document.getElementById("serverModal"); 
        serverModal.setAttribute("style","display: none");
	}); 
 	
 	
 	$("input[name='radio']").change(function() {
 		if($("input[name='radio']:checked").val() == "0") {
			const timeBox = document.querySelector('.timeBox');
			timeBox.setAttribute("style","display: flex");
			const limitless = document.getElementById("radioBoxCheck");
			limitless.setAttribute("style","display: block");
 		} else if($("input[name='radio']:checked").val() == "1") {
            const timeBox = document.querySelector('.timeBox');
			timeBox.setAttribute("style","display: none");
			const limitless = document.getElementById("radioBoxCheck");
			limitless.setAttribute("style","display: none");
 		}
 	});

	
	getCalendarList();
	getServerList();

});

function regBtn(){
	$('#regScheduleInfo').click(function(){
		var formData = new FormData(this);
		
		$.ajax({
			url: './regSchedule',
			data: formData,
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			type: 'post',
			seccess: function(data){
				alert('success');
			},
			error: function(data){
				alert('fail');
			}
		});
	});
};
</script>

</head>
<body>
	<div id="container">
		<div class="header">
			<h3 class="headerName">작업 관리</h3>
		</div>
		
		<div id="content">
			<div class="navBar">
				<ul>
					<li class="pageList"><a href=""><i class="bi bi-person"></i>사용자 관리</a></li>
					<li class="pageList"><a href=""><i class="bi bi-shield-check"></i>서버 관리</a></li>
					<li class="pageList on"><a href=""><i class="bi bi-calendar-check"></i>작업 관리</a></li>
				</ul>
			</div>
			
	    	<div id="box">
	    		<button class="writeBtn" onclick="writeBtn()">등록</button>
	    	<div id="calendar"></div>
	    	</div>
	    </div>	
		
		<div id="modal" class="modal-overlay">
			<div class="window">
				<div class="modalBox">
					<!-- Form 태그 시작 -->
					<form id="regScheduleInfo" enctype="multipart/form-data" name="refInfo">
					<div class="top">
						<h3 class="title">작업 등록</h3>
						<i class="bi bi-x" onclick="delBtn()"></i>
					</div>
					<div class="titleBox">
						<strong class="text">작업명<span class="star">*</span></strong>
						<input type="text" name="title" class="textBox">
					</div>
					<div class="dateBox">
						<strong class="text">기간설정</strong>
						<div class="radioBox">
							<input type="radio" name="" value="0" class="arr" checked> 반복설정
							<input type="radio" name="repeat_cat" value="0" class="timearr"> 하루설정
							<br>
		            	    <div id="radioBoxRepeat">
		                	    <!-- <div class="imgBox"><img src="../Desktop/aa/calendar.png"></div> -->
		                        <input type="text" class="datepicker" name="start_date" value="">
		                        <div class="noneBox2">
		                        	<span class="ing">~</span>
		                           	<input type="text" class="datepicker" name="end_date" value="">
								</div>
		                    </div>   
		                    <div id="radioBoxCheck">
		                    	<input type="checkbox" name="end_date" value="9999-12-31" class="limitless"> 무기한
		                    </div>
						</div>
					</div>
		
					<div class="timeBox">
						<strong class="text">반복설정</strong>
						<div class="radioBox">
							<input type="radio" name="repeat_cat" value="1" checked> 매일
							<input type="radio" name="repeat_cat" value="2" class="day"> 매월 <input type="text" name="repeat_week" class="dayBox">째주
							<input type="radio" name="repeat_cat" value="3" class="day"> 매월 <input type="text" name="repeat_day" class="dayBox">일
							<br>
		                   	<div id="dayBox">
								<input type="checkbox" name="" value="" class="checkboxAll"><span class="checkAll">전체</span> 
		                   		<button type="button" value="y" name="sun" class="btnDay">SUN</button>
		                   		<button type="button" value="y" name="mon" class="btnDay">MON</button>
		                   		<button type="button" value="y" name="the" class="btnDay">TUE</button>
		                   		<button type="button" value="y" name="wed" class="btnDay">WED</button>
		                   		<button type="button" value="y" name="thu" class="btnDay">THU</button>
		                   		<button type="button" value="y" name="fri" class="btnDay">FRI</button>
		                   		<button type="button" value="y" name="sat" class="btnDay">SAT</button>
		                   	</div>
		                   	<div id="timepickerBox">
		                   		<div id="timepicker-selectbox"></div>
		                   		<span class="ing">~</span>
		                   		<div id="timepicker-selectbox2"></div>
		                   	</div>
						</div>
					</div>
		
					<div class="listBox">
						<strong class="text">작업대상<span class="star">*</span></strong>
						<div class="btnList">
							<input type="button" name="" value="추가" class="btn1" id="btn1">
							<input type="button" name="" value="삭제" class="btn1">
						</div>
					</div>
					<table class="serverList" id="serverListM">
						<thead id="theadList">
							<tr class="serverHeader">
								<th class="serverHeaderText"><input type="checkbox" name="" value=""></th>
								<th class="serverHeaderText">서버명</th>
								<th class="serverHeaderText">IP</th>
								<th class="serverHeaderText">OS분류</th>
							</tr>
						</thead>
					</table>
					
					<div class="btnBox">
						<input type="button" name="" value="등록" class="btnBoxbtn" onclick='regBtn()'>
						<input type="button" name="" value="닫기" class="btnBoxbtn" onclick="delBtn()">
					</div>
					</form>
					<!-- Form 태그 종료 -->
				</div>
			</div>
			
			
			<div id="serverModal">
				<table id="list"></table>
				<div class="btnBox2">
					<input type="button" name="" value="등록" class="btnBoxbtn2">
					<input type="button" name="" value="닫기" class="btnBoxbtn3">
				</div>
				<div id="pager"></div> 
			</div>
		</div>
	</div>
	
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>