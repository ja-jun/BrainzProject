<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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


<link rel="stylesheet" href="../resources/css/jquery.datetimepicker.css" />
<script src="../resources/js/jquery.datetimepicker.js"></script>
<script>
var test = '<spring:message code="calendar.repeat.all"/>';

/* 팝업닫기 버튼 클릭시 */
function delBtn() {
	const modal = document.getElementById("modal");
	modal.setAttribute("style","display:none");
	document.getElementById("regScheduleInfo").reset();
}


/* 등록 클릭시 */
function writeBtn() {
	var modal = document.getElementById("modal");
	modal.setAttribute("style","display:flex");
	 var btn1 = document.getElementById('btnBoxbtn1');
     btn1.innerHTML="";
     btn1.setAttribute("value","등록");
     btn1.setAttribute("class","btnBoxbtn");
     btn1.setAttribute("id","btnBoxbtn1");
     btn1.setAttribute("onclick","regBtn()");
     
     var btn2 = document.getElementById('btnBoxbtn2');
     btn2.innerHTML="";
     btn2.setAttribute("value","닫기");
     btn2.setAttribute("class","btnBoxbtn");
     btn2.setAttribute("id","btnBoxbtn2");
     btn2.setAttribute("onclick","delBtn()");
}


/* 삭제 버튼 클릭시 */
function molBtn() {
	const deleteRadio = document.getElementById("deleteRadio");
	deleteRadio.setAttribute("style","display:block");
	deleteRadio.innerHTML="";
	
	var div = document.createElement("div");
	div.setAttribute("class","radioBox");
	
	var ul = document.createElement("ul");
	
	var radioBoxList = document.createElement("li");
	radioBoxList.setAttribute("class","radioBoxList");
	
	var input = document.createElement("input");
	input.setAttribute("type","radio");
	input.setAttribute("name","delete_radio");
	input.setAttribute("value","0");
	input.setAttribute("checked","checked");
	var span = document.createElement("span");
	span.setAttribute("class","sapnRadio");
	span.innerText="이 일정";
	
	var radioBoxList2 = document.createElement("li");
	radioBoxList2.setAttribute("class","radioBoxList");
	
	var input2 = document.createElement("input");
	input2.setAttribute("type","radio");
	input2.setAttribute("name","delete_radio");
	input2.setAttribute("value","1");
	var span2 = document.createElement("span");
	span2.setAttribute("class","sapnRadio");
	span2.innerText="이 일정 및 향후 일정";
	
	var radioBoxList3 = document.createElement("li");
	radioBoxList3.setAttribute("class","radioBoxList");
	
	var input3 = document.createElement("input");
	input3.setAttribute("type","radio");
	input3.setAttribute("name","delete_radio");
	input3.setAttribute("value","2");
	var span3 = document.createElement("span");
	span3.setAttribute("class","sapnRadio");
	span3.innerText="모든 일정";
	
	var btnBox2 = document.createElement("div");
	btnBox2.setAttribute("class","btnBox2");
	var button = document.createElement("input");
	button.setAttribute("type","button");
	button.setAttribute("value","삭제");
	button.setAttribute("class","btnBoxbtn2");
	button.setAttribute("onclick","");
	var button2 = document.createElement("input");
	button2.setAttribute("type","button");
	button2.setAttribute("value","취소");
	button2.setAttribute("class","btnBoxbtn3");
	button2.setAttribute("onclick","delBox()");
	
	deleteRadio.appendChild(div);
	div.appendChild(ul);
	div.appendChild(btnBox2);
	btnBox2.appendChild(button);
	btnBox2.appendChild(button2);
	ul.appendChild(radioBoxList);
	ul.appendChild(radioBoxList2);
	ul.appendChild(radioBoxList3);
	radioBoxList.appendChild(input);
	radioBoxList.appendChild(span);
	radioBoxList2.appendChild(input2);
	radioBoxList2.appendChild(span2);
	radioBoxList3.appendChild(input3);
	radioBoxList3.appendChild(span3);
}

/* 삭제 취소 버튼 클릭시 */
function delBox() {
	const deleteRadio = document.getElementById("deleteRadio");
	deleteRadio.setAttribute("style","display:none");
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
						end : item.event_date + "T" + item.end_time,
						id : item.sc_no
					}
    			}); 
 				
				var calendar = new FullCalendar.Calendar(calendarEl, {
					 headerToolbar: {
				            left: 'prev',
				            center: 'title',
				            right: 'next'
				        },
					events : events,
					locale: 'en',
					contentHeight: 'auto',
					eventClick: function(info){
						/* 특정 event를 클릭했을 때 등록 창이 나오도록 변경 */
						$.ajax({
					        url: 'http://localhost:8080/ja/schedule/getScheduleInfo',
					        data: "sc_no=" + info.event.id,
					        type: 'POST',
					        success: function(data) {
					            writeBtn();
					            var sc_info = data.scheduleInfo;
					            $('.textBox').val(sc_info.title);
					            $('input[name=start_date]').val(sc_info.start_date);
					            if(sc_info.end_date == ''){
					            	$('.timearr').addClass('active');
					            } else if(sc_info.end_date == '9999-12-31'){
					            	$('.limitless').attr('checked','checked');
					            	const noneBox = document.querySelector('.noneBox2');
					                noneBox.setAttribute("style","display: none");
					            } else {
					            	$('.noneBox2 .datepicker').val(sc_info.end_date);
					            }
					            
					            var repeat_cat = $('input[name=repeat_cat]').get(sc_info.repeat_cat - 1);
					            $(repeat_cat).attr('checked','checked');
					            if($(repeat_cat).val() == 2){
					            	$('input[name=repeat_week]').val(sc_info.repeat_week);
					            } else if($(repeat_cat).val() == 3){
					            	$('input[name=repeat_day]').val(sc_info.repeat_day);
					            }
					            
					            var days = [sc_info.sun, sc_info.mon, sc_info.the, sc_info.wed, sc_info.thu, sc_info.fri, sc_info.sat];
					            for(var i = 0; i < 7; i++){
					            	if(days[i] == 'y'){
					            		var day = $('.btnDay').get(i);
					            		$(day).addClass('active');
					            		$(day).attr('checked', 'checked');
					            	}
					            }
					            
					            $('input[name=start_time]').val(sc_info.start_time);
					            $('input[name=end_time]').val(sc_info.end_time);
					            $('#sc_no').val(sc_info.sc_no);
					            
					            if($('button.active').length == 7){
					            	$('.checkboxAll').attr('checked','checked');
					            }
					            
					            var btn1 = document.getElementById('btnBoxbtn1');
					            btn1.innerHTML="";
					            btn1.setAttribute("value","수정");
					            btn1.setAttribute("class","btnBoxbtn");
					            btn1.setAttribute("id","btnBoxbtn1");
					            btn1.setAttribute("onclick","modBtn()");
					            
					            var btn2 = document.getElementById('btnBoxbtn2');
					            btn2.innerHTML="";
					            btn2.setAttribute("value","삭제");
					            btn2.setAttribute("class","btnBoxbtn");
					            btn2.setAttribute("id","btnBoxbtn2");
					            btn2.setAttribute("onclick","molBtn()");
					            
					            var input_date = document.createElement('input');
					            var cur_date = info.event.start;
					            input_date.setAttribute("name","cur_date");
					            input_date.setAttribute("type","hidden");
					            input_date.setAttribute("value", cur_date.)
					            console.log(info.event.start);
					        },
					        error: function() {
					        	alert("잘못된 접근입니다.");
					        }
					    });
					}
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
									end : item.event_date + "T" + item.end_time,
									id : item.sc_no
								}
							});
							
							calendar.addEventSource(newEvents);
						}
					}
					
					reXhr.open("post", "http://localhost:8080/ja/schedule/getList", true);
					reXhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					reXhr.send("year=" + date.getFullYear() + "&month=" + (date.getMonth() + 1));
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
									end : item.event_date + "T" + item.end_time,
									id : item.sc_no
								}
							});
							
							calendar.addEventSource(newEvents);
						}
					}
					
					reXhr.open("post", "http://localhost:8080/ja/schedule/getList", true);
					reXhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					reXhr.send("year=" + date.getFullYear() + "&month=" + (date.getMonth() + 1));
				};
			}
		};
		
		var today = new Date();
		
		xhr.open("post" , "http://localhost:8080/ja/schedule/getList", true);
		xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xhr.send("year=" + today.getFullYear() + "&month=" + (today.getMonth() + 1));
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
					rowList:[10,20,30],
					width:700,
					 colModel: [	
							{name: 'name', label : '<spring:message code="calendar.serverlist.serverName"/>', align:'left'},
					        {name: 'ip', label : 'IP', align:'left'},
					        {name: 'os', label : 'OS', align:'center'},
					        {name: 'server_no', hidden: true}
							],
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
						th12.setAttribute("name","server_no");
						th12.setAttribute("value",params[i].server_no);
						tr6.appendChild(th12);
 					}  
			    	
  					tbody.appendChild(tr6);
  					serverModal2.appendChild(theadList);
  					serverModal2.appendChild(tbody);
			    	
				});
		}
	};
	
	xhr.open("post" , "http://localhost:8080/ja/schedule/getServerList" , true);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhr.send();	
}

window.addEventListener("DOMContentLoaded" , function(){
	
	
	$(window).resize(function() {
		$("#list").setGridWidth($(this).width() * .100);
	});
	
	/* 요일선택 했을시  */ 
	$('.btnDay').click(function(){
  		if($(this).hasClass("active")){
  		   $(this).removeClass("active");
  		   $(this).children().remove();
  		}else{
  		   $(this).addClass("active");  
  		   var valueByClass = $(this).val();
   		   var input =document.createElement("input");
   		   input.setAttribute("type","hidden");
   		   input.setAttribute("name",valueByClass);
   		   input.setAttribute("value","y");
		   $(this).append(input);
  		}
  		var total = $('.btnDay').length;
		var checked = $('.btnDay.active').length;

		if(total != checked){
			$('.checkboxAll').prop("checked", false);
		}else{
			$('.checkboxAll').prop("checked", true); 
		}
	}); 

	
	/* 요일 전체 체크 시 */
    $('.checkboxAll').click(function(){
        const btnDay = document.querySelectorAll('.btnDay'); 

		var a = $('.checkboxAll').is(':checked');
        
        if(a == true){
        	$(btnDay).addClass("active");
        	$(btnDay).each(function() { 
        		var test = $(this).val();
        		var input =document.createElement("input");
        		   input.setAttribute("type","hidden");
        		   input.setAttribute("name",test);
        		   input.setAttribute("value","y");
     			$(this).append(input);
        		});
        	
   		}else{
   			$(btnDay).removeClass("active");
   			$(btnDay).children().remove();
   		}
	});
	
	
    
    
    
    /* 매월, 매일 */
    $("input[name='repeat_cat']").change(function() {
 		if($("input[name='repeat_cat']:checked").val() == "3") {
 			const dayBox = document.getElementById("dayBox"); 
 	        dayBox.setAttribute("style","display: none");
 		} else {
 			const dayBox = document.getElementById("dayBox"); 
 	        dayBox.setAttribute("style","display: block");
 		}
 	});
    
    
    /* 무기한 클릭시 */
     $('.limitless').click(function(){
        const noneBox = document.querySelector('.noneBox2');
        noneBox.setAttribute("style","display: none");  
        
        var a = $('.limitless').is(':checked');
        
        if(a == true){
        	noneBox.setAttribute("style","display: none");  
   		}else{
   			noneBox.setAttribute("style","display: block");  
   		}
	}); 
    

    $('#btn1').click(function(){
         const serverModal = document.getElementById("serverModal"); 
         serverModal.setAttribute("style","display: block"); 
 	}); 
    
    
    $('.btnBoxbtn3').click(function(){
        const serverModal = document.getElementById("serverModal"); 
        serverModal.setAttribute("style","display: none");
        
        var cbox = document.getElementsByClassName('cbox');
        for (var i = 0; i < cbox.length; i++) {
        	cbox[i].checked = false;
        }
	}); 
 	
 	$("input[name='repeat_11']").change(function() {
 		if($("input[name='repeat_11']:checked").val() == "0") {
			const timeBox = document.querySelector('.Boxxx');
			timeBox.setAttribute("style","display: block");
			const limitless = document.getElementById("radioBoxCheck");
			limitless.setAttribute("style","display: block");
			const noneBox2 = document.querySelector('.noneBox2');
			noneBox2.setAttribute("style","display: block");
 		} else if($("input[name='repeat_11']:checked").val() == "1") {
            const timeBox = document.querySelector('.Boxxx');
			timeBox.setAttribute("style","display: none");
			const radioBoxCheck = document.getElementById("radioBoxCheck");
			radioBoxCheck.setAttribute("style","display: none");
			const noneBox2 = document.querySelector('.noneBox2');
			noneBox2.setAttribute("style","display: none");
			const timepickerBox = document.getElementById("timepickerBox");
			timepickerBox.setAttribute("style","display: flex");
 		}
 	});
 	
 	
		$(function(){
			$('.datepicker').datepicker({
		    	dateFormat: 'yy.mm.dd'
				});
			})
		 
	    $(function(){
	    	$('#datetimepicker1').datetimepicker({
	    		datepicker:false,
	    		format:'H:i',
	    		step: 1
	    	});
	  	})
	  	
	  	$(function(){
	    	$('#datetimepicker2').datetimepicker({
	    		datepicker:false,
	    		format:'H:i',
	    		step: 1
	    	});
	  	})
		 
	/* page load후 바로 실행 되는 함수들 */  	
	getCalendarList();
	writeBtn();
	getServerList();
	delBtn();
});

function validationCheck(target){
	var result = 1;
	
	if(target.getAll('title') == ''){
		/* 	1. 제목이 있는지 여부 
			   제목에 혹시 어떠한 특수 문자가 들어갔는지 확인 해야함
		*/
		alert('제목을 입력해주세요.');
		result = 0;
	} else if(target.getAll('start_date') == ''){
		/* 	2. 시작 날짜가 제대로 입력 됐는지 확인
		 	   날짜 형식이 제대로 되었는지도 확인 해야함 
		 */
		alert('작업 시작 날짜를 입력해주세요.');
		result = 0;
	} else if(target.getAll('end_date') == '' && !$('.limitless').is(':checked') && target.getAll('repeat_11') == '0'){
		/*	3. 종료 날짜가 제대로 입력 됐는지 확인
			   날짜 형식이 제대로 되었는지도 확인 해야함
		*/
		alert('작업 종료 날짜를 입력해주세요.');
		result = 0;
	} else if(target.getAll('start_time') == '' || target.getAll('end_time') ==''){
		/*	4. 시작 시간과 끝나는 시작이 입력 됐는지 확인
			   위 날짜 처럼 추후 형식을 확인 했는지도 확인 해야함
		*/
		alert('작업 시간을 입력해주세요.');
		result = 0;
	} else if(target.getAll('repeat_cat') == '1'){
		/*	5. 매일 이라는 반복 유형 선택 시 특정 요일을 선택 했는지 확인 */
		if(target.has('sun') || target.has('mon') || target.has('the') || target.has('wed') || target.has('thu') || target.has('fri') || target.has('sat')){
			result = 1;
		} else {
			alert('작업을 원하는 요일을 선택해주세요.');
			result = 0;
		}
	} else if(target.getAll('repeat_cat') == '2'){
		/*	6. 매 달 특정 주차가 선택이 되었는지 확인 */
		if(target.getAll('repeat_week') < 1 || target.getAll('repeat_week') > 4){
			alert('매 달 1주차 부터 4주차 까지만 선택 가능합니다.');
			result = 0;
		} else if(target.getAll('repeat_week') == ''){
			alert('작업을 등록할 주차를 입력해주세요.');
			result = 0;
		} else {
			/* 7. 특정 주차가 선택되어 있다면 요일도 선택되어 있는지 확인 */
			if(target.has('sun') || target.has('mon') || target.has('the') || target.has('wed') || target.has('thu') || target.has('fri') || target.has('sat')){
				result = 1;
			} else {
				alert('작업을 원하는 요일을 선택해주세요.');
				result = 0;
			}
		}
	} else if(target.getAll('repeat_cat') == '3'){
		/*	8. 매 달 특정 요일이 선택되어 있는지 그리고 정확한 값인지 확인 */
		if(!target.has('repeat_day')){
			alert('작업을 원하는 매 월 특정 요일을 입력해주세요.');
			result = 0;
		} else if(target.getAll('repeat_day') < 1 || target.getAll('repeat_day') > 28){
			alert('특정 요일은 1일 부터 28일 까지만 선택 가능합니다.');
			result = 0;
		}
	}
	
	return result;
}

function regBtn(){
	
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	
	if(validationCheck(formData) == 0){
		return;
	} else {
		if($('.limitless').is(':checked')){
			formData.set('end_date','9999.12.31');
		}
	    $.ajax({
	        url: 'http://localhost:8080/ja/schedule/regSchedule',
	        data: formData,
	        processData: false,
	        contentType: false,
	        type: 'POST',
	        success: function ( data ) {
	            alert("등록에 성공했습니다.");
	            delBtn();
	            location.reload();
	        }
	    });
	}	
}

/* 수정 기능 */
function modBtn(){
	
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	
	if(validationCheck(formData) == 0){
		return;
	} else {
		if($('.limitless').is(':checked')){
			formData.set('end_date','9999.12.31');
		}
		$.ajax({
			url: 'http://localhost:8080/ja/schedule/modSchedule',
			data: formData,
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				alert("수정에 성공했습니다.");
				delBtn();
				location.reload();
			}
		});
	}
}
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
					<li class="pageList">
						<a href="../user/mainPage">
							<i class="bi bi-person"></i>
							<spring:message code="navbar.user"></spring:message>
						</a>
					</li>
					<li class="pageList">
						<a href="">
							<i class="bi bi-shield-check"></i>
							<spring:message code="navbar.server"></spring:message>
						</a>
					</li>
					<li class="pageList on">
						<a href="">
							<i class="bi bi-calendar-check"></i>
							<spring:message code="navbar.calendar"></spring:message>
						</a>
					</li>
				</ul>
			</div>
			
	    	<div id="box">
	    		<button class="writeBtn" onclick="writeBtn()">
	    			<spring:message code="calendar.register"></spring:message>
	    		</button>
	    	<div id="calendar"></div>
	    	</div>
	    </div>	
		
		<div id="modal" class="modal-overlay">
			<div class="window">
				<div class="modalBox">
					<!-- Form 태그 시작 -->
					<form id="regScheduleInfo" name="param">
					<div class="top">
						<h3 class="title">
							<spring:message code="calendar.register"></spring:message>
						</h3>
						<i class="bi bi-x" onclick="delBtn()"></i>
					</div>
					<div class="titleBox">
						<strong class="text">
							<spring:message code="calendar.title"></spring:message>
							<span class="star">*</span>
						</strong>
						<input type="text" name="title" class="textBox" autocomplete='off'>
						<input type="hidden" name="sc_no" id="sc_no">
					</div>
					<div class="dateBox">
						<strong class="text">
							<spring:message code="calendar.period"></spring:message>
						</strong>
						<div class="radioBox">
							<input type="radio" name="repeat_11" value="0" class="arr" autocomplete='off' checked> <spring:message code="calendar.repeat"></spring:message>
							<input type="radio" name="repeat_11" value="1" class="timearr" autocomplete='off'> <spring:message code="calendar.day"></spring:message>
							<br>
		            	    <div id="radioBoxRepeat">
		                	    
		                        <input type="text" class="datepicker start_date" name="start_date" autocomplete='off'>
		                        <div class="noneBox2">
		                        	<span class="ing">~</span>
		                           	<input type="text" class="datepicker end_date" name="end_date" autocomplete='off'>
								</div>
		                    <div class="imgBox"><img src="../resources/img/calendar.svg"></div>
		                    </div>   
		                    <div id="radioBoxCheck">

		                    	<input type="checkbox" class="limitless" autocomplete='off'> <spring:message code="calendar.unlimit"></spring:message>
		                    </div>
						</div>
					</div>
		
					<div class="timeBox">
						<strong class="text"><spring:message code="calendar.repeat.category"></spring:message>
						</strong>
						<div class="radioBox">
						<div class="Boxxx">
							<input type="radio" name="repeat_cat" value="1" autocomplete='off' checked> <spring:message code="calendar.repeat.everyday"></spring:message>
							<input type="radio" name="repeat_cat" value="2" autocomplete='off' class="day"> <spring:message code="calendar.repeat.month"></spring:message> 
								<input type="text" name="repeat_week" class="dayBox" autocomplete='off'> <spring:message code="calendar.repeat.week"></spring:message> 
							<input type="radio" name="repeat_cat" value="3" autocomplete='off' class="day"> <spring:message code="calendar.repeat.month"></spring:message> 
								<input type="text" name="repeat_day" class="dayBox" autocomplete='off'> <spring:message code="calendar.repeat.day"></spring:message> 
							<br>
		                   	<div id="dayBox">
								<input type="checkbox" name="checkboxAll" value="" class="checkboxAll" autocomplete='off'>
									<span class="checkAll">
										<spring:message code="calendar.repeat.all"></spring:message>
									</span> 
		                   		<button type="button" value="sun" name="sun" class="btnDay">SUN</button>
		                   		<button type="button" value="mon" name="mon" class="btnDay">MON</button>
		                   		<button type="button" value="the" name="the" class="btnDay">TUE</button>
		                   		<button type="button" value="wed" name="wed" class="btnDay">WED</button>
		                   		<button type="button" value="thu" name="thu" class="btnDay">THU</button>
		                   		<button type="button" value="fri" name="fri" class="btnDay">FRI</button>
		                   		<button type="button" value="sat" name="sat" class="btnDay">SAT</button>
		                   	</div>
		                   	</div>
		                   	
		                   	<div id="timepickerBox">

		                   	
		                   	<input id="datetimepicker1" type="text" name="start_time" autocomplete='off'>
		                   	<span class="ing">~</span>
		                   	<input id="datetimepicker2" type="text" name="end_time" autocomplete='off'>
		                   	<div class="imgBox"><img src="../resources/img/alarm.svg"></div>
		                   	</div>
						</div>
					</div>
		
					<div class="listBox">
						<strong class="text">작업대상<span class="star">*</span></strong>
						<div class="btnList">
							<input type="button" value="추가" class="btn1" id="btn1" autocomplete='off'>
							<input type="button" value="삭제" class="btn1" autocomplete='off'>
						</div>
					</div>
					<table class="serverList" id="serverListM">
						<thead id="theadList">
							<tr class="serverHeader">
								<th class="serverHeaderText"><input type="checkbox" autocomplete='off'></th>
								<th class="serverHeaderText">서버명</th>
								<th class="serverHeaderText">IP</th>
								<th class="serverHeaderText">OS분류</th>
							</tr>
						</thead>
					</table>
					
					<div class="btnBox">
						<input type="button" value="등록" class="btnBoxbtn" id="btnBoxbtn1" onclick="regBtn()" autocomplete='off'>
						<input type="button" value="닫기" class="btnBoxbtn" id="btnBoxbtn2" onclick="delBtn()" autocomplete='off'>
					</div>
					</form>
					<!-- Form 태그 종료 -->
				</div>
			</div>
			
			
		</div>
		
		<div id="serverModal">
		<div id="serverModalBox">
				<table id="list"></table>
				<div class="btnBox2">
					<input type="button" value="등록" class="btnBoxbtn2" autocomplete='off'>
					<input type="button" value="닫기" class="btnBoxbtn3" autocomplete='off'>
				</div>
				<div id="pager"></div> 
			</div>
			</div>
			
			
		<div id="deleteRadio"></div>
		
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>