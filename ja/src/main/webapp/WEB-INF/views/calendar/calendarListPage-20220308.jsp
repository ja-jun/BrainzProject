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
<!-- Datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/jquery-ui.css">
<script src="../resources/js/jquery-ui.min.js"></script>
<!-- timepicker -->
<link rel="stylesheet" href="../resources/css/tui-time-picker.css" />
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/ui.jqgrid.css" />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script>


function writeBtn() {
	const modal = document.getElementById("modal");
	modal.setAttribute("style","display: flex");
}

function delBtn() {
	const modal = document.getElementById("modal");
	modal.setAttribute("style","display: none");
}


function getCalendarList(){
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);
				var calendarEl = document.getElementById('calendar');
				var list = data.scheduleList;
				console.log(list);
 				var events = list.map(function(item) {
    				return {
    					title : item.title,
						start : item.event_date + "T" + item.start_time,
						end : item.event_date + "T" + item.end_time
					}
    			}); 
 				
 				console.log(events);
				var calendar = new FullCalendar.Calendar(calendarEl, {
					 headerToolbar: {
				            left: 'prev',
				            center: 'title',
				            right: 'next'
				        },
					editable : true,
					events : events,
					locale: 'ko',
				});
				
				
				calendar.render();
				
				var next = document.getElementsByClassName('fc-next-button fc-button fc-button-primary');
				next[0].onclick = function(){
					var date = calendar.getDate();
					convertDate(date);
					calendar.removeAllEvents();
					//alert("The current date of the calendar is " + date.toISOString());
				}
			}
		};
		xhr.open("get" , "../schedule/getList" , true);
		xhr.send();	
}
	
function getNewCalendarList(){
	
}
// 받은 날짜값을 date 형태로 형변환 해준다.
function convertDate(date){
	var date = new Date(date);
	alert(date.yyyymmdd());
}

Date.prototype.yyyymmdd = function(){
	var yyyy = this.getFullYear().toString();
	var mm = (this.getMonth() + 1).toString();
	var dd = this.getDate().toString();
	return yyyy + "-" + (mm[1]?mm:"0" + mm[0]) + "-" + (dd[1]?dd:"0" + dd[0]);
}


function getServerList(){
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			var serverModal = document.getElementById('serverModal');
			serverModal.innerHTML = "";
			
			
			var table = document.createElement("table");
			table.setAttribute("class","serverList");
			var thead = document.createElement("thead");
			var tr = document.createElement("tr");
			tr.setAttribute("class","serverHeader");
			var th = document.createElement("th");
			th.setAttribute("class","serverHeaderText");
			var th2 = document.createElement("input");
			th2.setAttribute("type","checkbox");
			var th3 = document.createElement("th");
			th3.setAttribute("class","serverHeaderText");
			th3.innerText="서버명";
			var th4 = document.createElement("th");
			th4.setAttribute("class","serverHeaderText");
			th4.innerText="IP";
			var th5 = document.createElement("th");
			th5.setAttribute("class","serverHeaderText");
			th5.innerText="OS분류";
			
			table.appendChild(thead);
			thead.appendChild(tr);
			tr.appendChild(th);
			th.appendChild(th2);
			tr.appendChild(th3);
			tr.appendChild(th4);
			tr.appendChild(th5);
			
			
			
			
			var tbody = document.createElement("tbody");
			
			for(x of data.serverList){
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
			th9.innerText=x.serverName;
			tr6.appendChild(th9);
			var th10 = document.createElement("th");
			th10.setAttribute("class","serverContentText");
			th10.innerText=x.ip;
			tr6.appendChild(th10);
			var th11 = document.createElement("th");
			th11.setAttribute("class","serverContentText");
			th11.innerText=x.os;
			tr6.appendChild(th11);
			}
			
			
			
			table.appendChild(tbody);
			
			
			serverModal.appendChild(table);
			
		}
	};
	xhr.open("get" , "./getServerList" , true);
	xhr.send();	
}
  
window.addEventListener("DOMContentLoaded" , function(){

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
    	
	
	
	
	<div id="modal" class="modal-overlay">
		<div class="modalBox">
		
			<div class="top">
				<h3 class="title">작업 등록</h3>
				<i class="bi bi-x" onclick="delBtn()"></i>
			</div>
				<div class="titleBox">
					<strong class="text">작업명<span class="star">*</span></strong>
					<input type="text" name="" class="textBox">
				</div>
				<div class="dateBox">
					<strong class="text">기간설정</strong>
					<div class="radioBox">
					<input type="radio" name="radio" value="0" class="arr" checked> 반복설정
					<input type="radio" name="radio" value="1" class="timearr"> 하루설정
					<br>

                        <div id="radioBoxRepeat">
                            <!-- <div class="imgBox"><img src="../Desktop/aa/calendar.png"></div> -->
                            <input type="text" class="datepicker" name="" value="">
                            <div class="noneBox2">
                            <span class="ing">~</span>
                            <input type="text" class="datepicker" name="" value="">
							</div>
                        </div>
                        
                        
                        <div id="radioBoxCheck">
                            <input type="checkbox" name="" value="" class="limitless"> 무기한
                        </div>
                        

					</div>
				</div>


					

				<div class="timeBox">
					<strong class="text">반복설정</strong>
					<div class="radioBox">
					<input type="radio" name="radio1" value="0" checked> 매일
					<input type="radio" name="radio1" value="1" class="day"> 매월 <input type="text" name="" class="dayBox">째주
					<input type="radio" name="radio1" value="2" class="day"> 매월 <input type="text" name="" class="dayBox">일
					<br>
                    <div id="dayBox">
					<input type="checkbox" name="" value="" class="checkboxAll"><span class="checkAll">전체</span> 
                    <button name="" value="SUN" class="btnDay">SUN</button>
                    <button name="" value="MON" class="btnDay">MON</button>
                    <button name="" value="TUE" class="btnDay">TUE</button>
                    <button name="" value="WED" class="btnDay">WED</button>
                    <button name="" value="THU" class="btnDay">THU</button>
                    <button name="" value="FRI" class="btnDay">FRI</button>
                    <button name="" value="SAT" class="btnDay">SAT</button>
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
					<table class="serverList">
						<thead>
						<tr class="serverHeader">
						<th class="serverHeaderText"><input type="checkbox" name="" value=""></th>
						<th class="serverHeaderText">서버명</th>
						<th class="serverHeaderText">IP</th>
						<th class="serverHeaderText">OS분류</th>
						</tr>
						</thead>
						<tbody>
						<tr class="serverContent">
						<td class="serverContentText"><input type="checkbox" name="" value=""></td>
						<td class="serverContentText">서버명</td>
						<td class="serverContentText">IP</td>
						<td class="serverContentText">OS분류</td>
						</tr>
						</tbody>
					</table>
				
				<div class="btnBox">
					<input type="submit" name="" value="등록" class="btnBoxbtn">
					<input type="button" name="" value="닫기" class="btnBoxbtn" onclick="delBtn()">
				</div>
				
		</div>
		
		<div id="serverModal"></div>
	</div>
	</div>
	
	</div>
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>