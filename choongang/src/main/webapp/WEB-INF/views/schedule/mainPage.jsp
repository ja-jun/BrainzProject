<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업관리</title>
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
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<script src="../resources/js/tippy-bundle.umd.min.js"></script>
<script>
const language = '<spring:message code="language"/>';
const lang_regSc = '<spring:message code="schedule.register"/>';
const lang_regBtn = '<spring:message code="schedule.registbtn"/>';
const lang_clsBtn = '<spring:message code="schedule.closebtn"/>';
const lang_del = '<spring:message code="schedule.delete"/>';
const lang_delWhl = '<spring:message code="schedule.deletewhole"/>';
const lang_delaft = '<spring:message code="schedule.deleteaft"/>';
const lang_cancle = '<spring:message code="schedule.canclebtn"/>';
const lang_moddel = '<spring:message code="schedule.modify"/>';
const lang_mod = '<spring:message code="schedule.modifybtn"/>';
const lang_svname = '<spring:message code="schedule.servername"/>';
const lang_val_title1 = '<spring:message code="schedule.validation.title1"/>';
const lang_val_title2 = '<spring:message code="schedule.validation.title2"/>';
const lang_val_title3 = '<spring:message code="schedule.validation.title3"/>';
const lang_val_title4 = '<spring:message code="schedule.validation.title4"/>';
const lang_val_server1 = '<spring:message code="schedule.validation.server1"/>';
const lang_val_server2 = '<spring:message code="schedule.validation.server2"/>';
const lang_val_server3 = '<spring:message code="schedule.validation.server3"/>';
const lang_val_date1 = '<spring:message code="schedule.validation.date1"/>';
const lang_val_time1 = '<spring:message code="schedule.validation.time1"/>';
const lang_val_login = '<spring:message code="validation.login"/>';
const lang_reg_success = '<spring:message code="schedule.register.success"/>';
const lang_reg_fail = '<spring:message code="schedule.register.fail"/>';
const lang_reg_fail1 = '<spring:message code="schedule.register.fail1"/>';
const lang_reg_fail2 = '<spring:message code="schedule.register.fail2"/>';
const lang_mod_success = '<spring:message code="schedule.modify.success"/>';
const lang_del_success = '<spring:message code="schedule.delete.success"/>';

/* 팝업닫기 버튼 클릭시 */
function delBtn() {
	$('body').css("overflow-y", "auto");
	const modal = document.getElementById("modal");
	modal.setAttribute("style","display:none");
	document.getElementById("regScheduleInfo").reset();
	$('input[name=pre_title]').remove();
}
/* 등록 클릭시 */
function writeBtn() {
	
	$('body').css("overflow", "hidden");
	var modal = document.getElementById("modal");
	modal.setAttribute("style","display:flex");
	
	var confirmAlertBox = document.getElementById("confirmAlertBox");
    confirmAlertBox.setAttribute("style","display:none");
    
    $('.confirmAlertBox').empty();
    $('#confirmAlertBox4').empty();
    
    const noneBox = document.querySelector('.noneBox2');
	noneBox.setAttribute("style","display: block");  
	
	$('.arr').prop('checked',true);
	const timepickerBox = document.getElementById("radioBoxRepeat");
	timepickerBox.setAttribute("style","display: flex");
	const radioBoxCheck = document.getElementById("radioBoxCheck");
	radioBoxCheck.setAttribute("style","display: block");
	const radioBoxRepeat2 = document.getElementById("radioBoxRepeat2");
	radioBoxRepeat2.setAttribute("style","display: none");
	var timeBox = document.querySelector('.timeBox');
	timeBox.setAttribute("style","display: flex");
	
    $('.checkboxAll').prop('checked',false);
    $('.limitless').prop('checked',false);
	
	var title = document.querySelector('.title');
    title.innerText = lang_regSc;
    
    $('.serverContent').remove();
    $('.btnDay').removeClass("active");
	$('.btnDay').children().remove();
    
	 var btn1 = document.getElementById('btnBoxbtn1');
     btn1.innerHTML="";
     btn1.setAttribute("value",lang_regBtn);
     btn1.setAttribute("class","btnBoxbtn");
     btn1.setAttribute("id","btnBoxbtn1");
     btn1.setAttribute("onclick","regBtn()");
     
     var btn2 = document.getElementById('btnBoxbtn2');
     btn2.innerHTML="";
     btn2.setAttribute("value",lang_clsBtn);
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
	span.innerText=lang_delWhl;
	
	var radioBoxList3 = document.createElement("li");
	radioBoxList3.setAttribute("class","radioBoxList");
	
	var input3 = document.createElement("input");
	input3.setAttribute("type","radio");
	input3.setAttribute("name","delete_radio");
	input3.setAttribute("value","2");
	var span3 = document.createElement("span");
	span3.setAttribute("class","sapnRadio");
	span3.innerText=lang_delaft;
	
	var btnBox2 = document.createElement("div");
	btnBox2.setAttribute("class","btnBox2");
	var button = document.createElement("input");
	button.setAttribute("type","button");
	button.setAttribute("value",lang_del);
	button.setAttribute("class","btnBoxbtn2");
	button.setAttribute("onclick","delSchedule()");
	var button2 = document.createElement("input");
	button2.setAttribute("type","button");
	button2.setAttribute("value",lang_cancle);
	button2.setAttribute("class","btnBoxbtn3");
	button2.setAttribute("onclick","delBox()");
	
	deleteRadio.appendChild(div);
	div.appendChild(ul);
	div.appendChild(btnBox2);
	btnBox2.appendChild(button);
	btnBox2.appendChild(button2);
	ul.appendChild(radioBoxList);
	ul.appendChild(radioBoxList3);
	radioBoxList.appendChild(input);
	radioBoxList.appendChild(span);
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
					start : item.start_date + "T" + item.start_time,
					end : item.end_date + "T" + item.end_time,
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
				locale: language,
				eventClick: function(info){
					/* 특정 event를 클릭했을 때 등록 창이 나오도록 변경 */
					$.ajax({
				        url: './getScheduleInfo',
				        data: "sc_no=" + info.event.id,
				        type: 'POST',
				        success: function(data) {
				            writeBtn();
				            
				            var sc_info = data.scheduleInfo;
				            var sc_server = data.serverList;
				            
				            $('.textBox').val(sc_info.title);
				            
				            var pre_title = document.createElement('input');
				            pre_title.setAttribute('type', 'hidden');
				            pre_title.setAttribute('name', 'pre_title');
				            pre_title.setAttribute('value', sc_info.title);
				            $('.textBox').append(pre_title);
				            
				            var sc_no_input = document.createElement('input');
				            sc_no_input.setAttribute('type','hidden');
				            sc_no_input.setAttribute('name','sc_no');
				            sc_no_input.setAttribute('value',sc_info.sc_no);
				            $('.textBox').append(sc_no_input);
				            
				            $('input[name=start_date]').val(sc_info.start_date);
				            $('input[name=end_date]').val(sc_info.end_date);
				            
				            if(sc_info.repeat_cat == 0){
				            	$('.arr').attr('checked',false);
				            	$('.timearr').attr('checked','checked');
				            	$('input[name=start_date_2]').val(sc_info.start_date);
					            $('input[name=end_date_2]').val(sc_info.end_date);
					            $('input[name=start_time_2]').val(sc_info.start_time);
					            $('input[name=end_time_2]').val(sc_info.end_time);
					            
					            const timeBox = document.querySelector('.timeBox');
					 			timeBox.setAttribute("style","display: none");
					 			const limitless = document.getElementById("radioBoxCheck");
								limitless.setAttribute("style","display: none");
								const timepickerBox = document.getElementById("radioBoxRepeat");
								timepickerBox.setAttribute("style","display: none");
								const radioBoxRepeat2 = document.getElementById("radioBoxRepeat2");
								radioBoxRepeat2.setAttribute("style","display: grid");
				            } else{
				            	$('input[name=start_date_1]').val(sc_info.start_date);
					            $('input[name=end_date_1]').val(sc_info.end_date);
					            $('input[name=start_time_1]').val(sc_info.start_time);
				            	if(sc_info.end_date == '9999-12-31'){
					            	$('.limitless').prop('checked',true);
					            	const noneBox = document.querySelector('.noneBox2');
					                noneBox.setAttribute("style","display: none");
				            	} else {				            		
					            	$('input[name=end_time_1]').val(sc_info.end_time);
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
					            		var input =document.createElement("input");
					            		input.setAttribute("type","hidden");
					            		input.setAttribute("name",$(day).val());
					            		input.setAttribute("value","y");
					         		    $(day).append(input);
					            	}
					            }
					            
					            if($('button.active').length == 7){
					            	$('.checkboxAll').prop('checked',true);
					            }
				            }				            
				            
				            
				            var confirmAlertBox = document.getElementById("confirmAlertBox");
				            confirmAlertBox.innerText="";
				            
				            var title = document.querySelector('.title');
				            title.innerText=lang_moddel;
				            
					    	var serverList = document.getElementById("serverListM");
					    	serverList.innerHTML = "";
					    	var thead = document.createElement("thead");
					    	thead.setAttribute("id","theadList");
					    	
				            var tr = document.createElement("tr");
							tr.setAttribute("class","serverHeader");
							thead.appendChild(tr);
							var th1 = document.createElement("th");
							th1.setAttribute("class","serverHeaderText");
							tr.appendChild(th1);
							var th2 = document.createElement("input");
							th2.setAttribute("type","checkbox");
							th2.setAttribute("name","allCheck");
							th2.setAttribute("id","allCheck");
							th1.appendChild(th2);
							var th3 = document.createElement("th");
							th3.setAttribute("class","serverHeaderText");
							th3.innerText=lang_svname;
							tr.appendChild(th3);
							var th4 = document.createElement("th");
							th4.setAttribute("class","serverHeaderText");
							th4.innerText="IP";
							tr.appendChild(th4);
							var th5 = document.createElement("th");
							th5.setAttribute("class","serverHeaderText");
							th5.innerText="OS";
							tr.appendChild(th5);
								
						    serverList.appendChild(thead);
				            
				            
				            
				            var tbody = document.createElement("tbody");
				            tbody.setAttribute("class","tbodyBox");
				            
				            for(x of sc_server){
				            	var tr6 = document.createElement("tr");
								tr6.setAttribute("class","serverContent");
								tbody.appendChild(tr6);
								var th7 = document.createElement("th");
								th7.setAttribute("class","serverContentText");
								tr6.appendChild(th7);
								var th8 = document.createElement("input");
								th8.setAttribute("type","checkbox");
								th8.setAttribute("name","rowCheck");
								th7.appendChild(th8);
								var th9 = document.createElement("th");
								th9.setAttribute("class","serverContentText");
								th9.innerText=x.name;
								tr6.appendChild(th9);
								var th10 = document.createElement("th");
								th10.setAttribute("class","serverContentText");
								th10.innerText=x.ip;
								tr6.appendChild(th10);
								var th11 = document.createElement("th");
								th11.setAttribute("class","serverContentText");
								th11.innerText=x.os;
								tr6.appendChild(th11);
								var th12 = document.createElement("input");
								th12.setAttribute("type","hidden");
								th12.setAttribute("name","server_no");
								th12.setAttribute("value",x.server_no);
								tr6.appendChild(th12);
								
						    	tbody.appendChild(tr6);
						    	serverList.appendChild(tbody);
				    		} 
				        
				            var btn1 = document.getElementById('btnBoxbtn1');
				            btn1.innerHTML="";
				            btn1.setAttribute("value",lang_mod);
				            btn1.setAttribute("class","btnBoxbtn");
				            btn1.setAttribute("id","btnBoxbtn1");
				            btn1.setAttribute("onclick","modBtn()");
				            
				            var btn2 = document.getElementById('btnBoxbtn2');
				            btn2.innerHTML="";
				            btn2.setAttribute("value",lang_del);
				            btn2.setAttribute("class","btnBoxbtn");
				            btn2.setAttribute("id","btnBoxbtn2");
				            btn2.setAttribute("onclick","molBtn()");
				            
				            var input_date = document.createElement('input');
				            var event_date = info.event.start;
				            var month = "";
				            var day = "";
				            
				            if((event_date.getMonth() + 1) >= 1 || (event_date.getMonth() + 1) < 10){
				            	month = "0" + (event_date.getMonth() + 1);	
				            }
				            
				            if(event_date.getDate() >= 1 || event_date.getDate() < 10){
				            	day = "0" + event_date.getDate();
				            }
				            cur_date = event_date.getFullYear() + "-" + month + "-" + day;
				            
				            input_date.setAttribute("name","cur_date");
				            input_date.setAttribute("type","hidden");
				            input_date.setAttribute("value", cur_date);
				            $('#regScheduleInfo').append(input_date);
				        },
				        error: function() {
				        	alert("잘못된 접근입니다.");
				        }
				    });
				},
				
				eventDidMount: function(info) {
		            tippy(info.el, {
		                content:  info.event.title
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
							if(new Date(item.event_date))
							return {
								title : item.title,
								start : item.start_date + "T" + item.start_time,
								end : item.end_date + "T" + item.end_time,
								id : item.sc_no
							}
						});
						
						calendar.addEventSource(newEvents);
						$(function(){
							$('.fc-scrollgrid-sync-table tbody tr:nth-child(n+4)').children('.fc-day-other').remove();
					  	})
					}
				}
				
				reXhr.open("post", "./getList", true);
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
								start : item.start_date + "T" + item.start_time,
								end : item.end_date + "T" + item.end_time,
								id : item.sc_no
							}
						});
						
						calendar.addEventSource(newEvents);
						$(function(){
							$('.fc-scrollgrid-sync-table tbody tr:nth-child(n+4)').children('.fc-day-other').remove();
					  	})
					}
				}
				
				reXhr.open("post", "./getList", true);
				reXhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				reXhr.send("year=" + date.getFullYear() + "&month=" + (date.getMonth() + 1));
			};
		}
	};
		
	var today = new Date();
	
	xhr.open("post" , "./getList", true);
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
				height:500,
				width:1000,
				colModel: [	
						{name: 'name', label : lang_svname, align:'left'},
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
		    	tbody.setAttribute("class","tbodyBox");
		    
 					for(var i = 0; i < params.length; i++){
					var tr6 = document.createElement("tr");
					tr6.setAttribute("class","serverContent");
					tbody.appendChild(tr6);
					var th7 = document.createElement("th");
					th7.setAttribute("class","serverContentText");
					tr6.appendChild(th7);
					var th8 = document.createElement("input");
					th8.setAttribute("type","checkbox");
					th8.setAttribute("name","rowCheck");
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
					var th12 = document.createElement("input");
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
	
	xhr.open("post" , "./getServerList" , true);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhr.send();	
}
window.addEventListener("DOMContentLoaded" , function(){
	
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
         $('.cbox').prop('checked',false);
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
			const limitless = document.getElementById("radioBoxCheck");
			limitless.setAttribute("style","display: block");
			const timeBox = document.querySelector('.timeBox');
 			timeBox.setAttribute("style","display: flex");
 			const timepickerBox = document.getElementById("radioBoxRepeat");
			timepickerBox.setAttribute("style","display: flex");
 			const radioBoxRepeat2 = document.getElementById("radioBoxRepeat2");
 			radioBoxRepeat2.setAttribute("style","display: none");
 		}  else if($("input[name='repeat_11']:checked").val() == "1") {
 			const timeBox = document.querySelector('.timeBox');
 			timeBox.setAttribute("style","display: none");
 			const limitless = document.getElementById("radioBoxCheck");
			limitless.setAttribute("style","display: none");
			const timepickerBox = document.getElementById("radioBoxRepeat");
			timepickerBox.setAttribute("style","display: none");
			const radioBoxRepeat2 = document.getElementById("radioBoxRepeat2");
			radioBoxRepeat2.setAttribute("style","display: grid");
 		} 
 	});
 	
 	
 	$(document).on("click", "#allCheck", function(){
 		var checked = $("#allCheck").is(':checked');
		if(checked == true){
			$("input[name='rowCheck']").prop('checked',true);
		} else {
			$("input[name='rowCheck']").prop('checked',false);
		}
 	});
 	
 	$("#calenderPage").addClass("on");
 	
 	$(document).ready(function(){
 		  $('.fc-scrollgrid-sync-table tbody tr:nth-child(n+4)').children('.fc-day-other').remove();
 		})
 	
	$(function(){
		$('.datepicker').datepicker({
	    	dateFormat: 'yy-mm-dd',
	    	minDate: 0
			});
		$('.datepicker').datepicker('setDate', 'today');
	});
	
    $(function(){
    	$('#datetimepicker1').datetimepicker({
    		datepicker:false,
    		lang:'ko',
    		format:'H:i',
    		step: 10
    	});
    	$("#datetimepicker1").val("00:00");
  	});
  	
  	$(function(){
    	$('#datetimepicker2').datetimepicker({
    		datepicker:false,
    		format:'H:i',
    		step: 10
    	});
    	$("#datetimepicker2").val("24:00");
  	});
  	
  	$(function(){
    	$('#datetimepicker3').datetimepicker({
    		datepicker:false,
    		format:'H:i',
    		step: 10
    	});
    	$("#datetimepicker3").val("00:00");
  	});
  	
   $(function(){
    	$('#datetimepicker4').datetimepicker({
    		datepicker:false,
    		format:'H:i',
    		step: 10
    	});
    	$("#datetimepicker4").val("24:00");
  	});
  	
	/* page load후 바로 실행 되는 함수들 */  	
	getCalendarList();
	writeBtn();
	getServerList();
	delBtn();
});
function confirmTitle(){
	
	var title = document.querySelector('input[name="title"]').value;
	
	var confirmAlertBox = document.getElementById("confirmAlertBox");
	confirmAlertBox.style.display = "block";
	
	if($('input[name=pre_title]').length && title == $('input[name=pre_title]').val()){
		confirmAlertBox.innerText = lang_val_title4;
		confirmAlertBox.style.color = "blue";
		return 1;
	} else {
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);
				
				if(data.result == true){
					confirmAlertBox.innerText = lang_val_title1;
					confirmAlertBox.style.color = "red";
					return 0;
				}else if(title == ""){
					confirmAlertBox.innerText = lang_val_title2;
					confirmAlertBox.style.color = "red";
					return 0;
				} else {
					confirmAlertBox.innerText = lang_val_title3;
					confirmAlertBox.style.color = "green";
					return 1;
				}
			}
		};
		
		title = encodeURIComponent(title);
		
		xhr.open("get" , "./isExistTitle?title=" + title , true); 
		xhr.send();
	}
	
};

function deleteServer(){
	
	if ($("input[name='rowCheck']:checked").length == 0) {
		alert(lang_val_server1);
	} else {
		var chk = confirm(lang_val_server2);
		if(chk == true){
			for(var i=$("input[name='rowCheck']:checked").length-1; i>-1; i--){
				﻿		$("input[name='rowCheck']:checked").eq(i).closest("tr").remove();
			}﻿ 
		}else{
			return;
		}
	}
}
function validationCheck(target){
	
	var result = confirmTitle();
	
	if(target.getAll('start_date') == '' && target.getAll('end_date') == '' && !$('.limitless').is(':checked') && target.getAll('repeat_11') == '0'){
		/* 	2. 시작 날짜가 제대로 입력 됐는지 확인
		 	   날짜 형식이 제대로 되었는지도 확인 해야함 
		 */
		var confirmAlertBox = document.getElementById("confirmAlertBox2");
			confirmAlertBox.style.display = "block";
			confirmAlertBox.innerText = lang_val_date1;
			confirmAlertBox.style.color = "red";
		result = 0;
	} else if(target.getAll('start_date') != '' || target.getAll('end_date') == '') {
		var confirmAlertBox = document.getElementById("confirmAlertBox2");
			confirmAlertBox.style.display = "none";
	};
	
	if(target.getAll('start_time') == '' || target.getAll('end_time') == ''){
		/*	4. 시작 시간과 끝나는 시작이 입력 됐는지 확인
			   위 날짜 처럼 추후 형식을 확인 했는지도 확인 해야함
		*/
		var confirmAlertBox = document.getElementById("confirmAlertBox3");
			confirmAlertBox.style.display = "block";
			confirmAlertBox.innerText = lang_val_time1;
			confirmAlertBox.style.color = "red";
		result = 0;
	} else if(target.getAll('start_time') != '' || target.getAll('end_time') =='') {
		var confirmAlertBox = document.getElementById("confirmAlertBox3");
			confirmAlertBox.style.display = "none";
	};
	
	
	if(!target.has('server_no')){
		var confirmAlertBox = document.getElementById("confirmAlertBox4");
			confirmAlertBox.style.display = "inline-flex";
			confirmAlertBox.innerText = lang_val_server3;
			confirmAlertBox.style.color = "red";
		result = 0
	}
	
	return result;	
}

function regBtn(){
	
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	
	if($('.timearr').is(':checked')){
		formData.set('repeat_cat', 0);
		formData.set('start_date', formData.getAll('start_date_2'));
		formData.set('end_date', formData.getAll('end_date_2'));
		formData.set('start_time', formData.getAll('start_time_2'));
		formData.set('end_time', formData.getAll('end_time_2'));
	} else {
		if($('.limitless').is(':checked')){
			formData.set('end_date', '9999-12-31');
		} else {
			formData.set('end_date', formData.getAll('end_date_1'));
		}
		
		formData.set('start_date', formData.getAll('start_date_1'));
		formData.set('start_time', formData.getAll('start_time_1'));
		formData.set('end_time', formData.getAll('end_time_1'));
	}
	
	userInfo3 = '<%=session.getAttribute("userInfo")%>';
	
	if(validationCheck(formData) == 0){
		return;
	} else if (userInfo3 == 'null'){
		var login = confirm(lang_val_login);
		if(login){
			document.location.href = "../login/loginPage";			
		} else {
			return;
		}
	} else {
	    $.ajax({
	        url: './regSchedule',
	        data: formData,
	        processData: false,
	        contentType: false,
	        type: 'POST',
	        success: function (data) {
	        	if(data.result == 0){
	        		alert(lang_reg_success);
		            delBtn();
		            location.reload();
	        	} else if(data.result == 1) {
	        		alert(lang_reg_fail1);
	        	} else if(data.result == 2){
	        		alert(lang_reg_fail2);
	        	}
	        },
	        error: function (data){
	        	alert(lang_reg_fail);
	        }
	    });
	}	
}
/* 수정 기능 */
function modBtn(){
	$('body').css("overflow-y", "auto");
	
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	
	if($('.timearr').is(':checked')){
		formData.set('repeat_cat', 0);
		formData.set('start_date', formData.getAll('start_date_2'));
		formData.set('end_date', formData.getAll('end_date_2'));
		formData.set('start_time', formData.getAll('start_time_2'));
		formData.set('end_time', formData.getAll('end_time_2'));
	} else {
		if($('.limitless').is(':checked')){
			formData.set('end_date', '9999-12-31');
		} else {
			formData.set('end_date', formData.getAll('end_date_1'));
		}
		
		formData.set('start_date', formData.getAll('start_date_1'));
		formData.set('start_time', formData.getAll('start_time_1'));
		formData.set('end_time', formData.getAll('end_time_1'));
	}
	
	if(validationCheck(formData) == 0){
		return;
	} else {
		$.ajax({
			url: './modSchedule',
			data: formData,
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				alert(lang_mod_success);
				delBtn();
				location.reload();
			}
		});
	}
}
/* 삭제 기능 */
function delSchedule(){
	$('body').css("overflow-y", "auto");
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	$.ajax({
		url: './delSchedule',
		data: formData,
		processData: false,
		contentType: false,
		type: 'POST',
		success: function(data){
			alert(lang_del_success);
			location.reload();
		}
	});
}
</script>

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
	    			
				<div id="scheduleBox">	
				<div id="top">
         				<button class="writeBtn" onclick="writeBtn()">
	    				<spring:message code="schedule.registbtn"/>
					</button>
				</div>
		
	    		<div id="calendar" style="padding:0px 30px 30px 30px"></div>
	    		</div>
	    	</div>
	    </div>
	  
		
		<!-- modal 창 -->
		<div id="modal" class="modal-overlay">
			<div class="window">
				<div class="modalBox">
				
					<!-- Form 태그 시작 -->
					<form id="regScheduleInfo" name="param">
					
					<div class="top">
						<h3 class="title">
							<spring:message code="schedule.register"/>
						</h3>
						<i class="bi bi-x" onclick="delBtn()"></i>
					</div>
					
					<div class="titleBox">
						<strong class="text">
							<spring:message code="schedule.title"/>
						<span class="star">*</span></strong>
					
					<div class="titleText">
						<input type="text" name="title" class="textBox" onblur="confirmTitle()" autocomplete='off'>
						<div id="confirmAlertBox" class="confirmAlertBox"></div>
					</div>
					</div>
					
					<div class="dateBox">
						<strong class="text"><spring:message code="schedule.period"/></strong>
						<div class="radioBox">
							<input type="radio" name="repeat_11" value="0" class="arr" autocomplete='off' checked> <spring:message code="schedule.repeat"/>
							<input type="radio" name="repeat_11" value="1" class="timearr" autocomplete='off'> <spring:message code="schedule.period"/>
							<br>
							
		            	    <div id="radioBoxRepeat">
		                        <input type="text" class="datepicker start_date" name="start_date_1" autocomplete='off'>
		                        <div class="noneBox2">
		                        	<span class="ing">~</span>
		                           	<input type="text" class="datepicker end_date" name="end_date_1" autocomplete='off'>
								</div>
		                    </div>
		                    
		                    <div id="radioBoxRepeat2">
		                    <div class="start">
		                        <input type="text" class="datepicker start_date" name="start_date_2" autocomplete='off'>
		                        <input id="datetimepicker3" class="datetimepicker" type="text" name="start_time_2" autocomplete='off'>
		                    </div>
		                    <div class="end">
		                        <input type="text" class="datepicker end_date" name="end_date_2" autocomplete='off'>
		                        <input id="datetimepicker4" class="datetimepicker" type="text" name="end_time_2" autocomplete='off'>
		                    </div>
		                    </div> 
		                    
		                    <div id="radioBoxCheck">
		                    	<input type="checkbox" class="limitless" autocomplete='off'> <spring:message code="schedule.indefinitely"/>
		                    </div>
		                <div id="confirmAlertBox2" class="confirmAlertBox"></div> 
						</div>
					</div>
					
		
					<div class="timeBox">
						<strong class="text">
							<spring:message code="schedule.repeat"/>
						</strong>
						<div class="radioBox">
						<div class="Boxxx">
							<input type="radio" name="repeat_cat" value="1" autocomplete='off' checked> <spring:message code="schedule.days"/>
							<input type="radio" name="repeat_cat" value="2" autocomplete='off' class="day"> <spring:message code="schedule.month"/> <input type="text" name="repeat_week" class="dayBox" autocomplete='off'><spring:message code="schedule.weeks"/> 
							<input type="radio" name="repeat_cat" value="3" autocomplete='off' class="day"> <spring:message code="schedule.month"/> <input type="text" name="repeat_day" class="dayBox" autocomplete='off'><spring:message code="schedule.dayofmonth"/> 
							<br>
		                   	<div id="dayBox">
								<input type="checkbox" name="checkboxAll" value="" class="checkboxAll" autocomplete='off'><span class="checkAll"><spring:message code="schedule.all"/> </span> 
		                   		<button type="button" value="sun" name="sun" class="btnDay"><spring:message code="schedule.sun"/></button>
		                   		<button type="button" value="mon" name="mon" class="btnDay"><spring:message code="schedule.mon"/></button>
		                   		<button type="button" value="the" name="the" class="btnDay"><spring:message code="schedule.the"/></button>
		                   		<button type="button" value="wed" name="wed" class="btnDay"><spring:message code="schedule.wed"/></button>
		                   		<button type="button" value="thu" name="thu" class="btnDay"><spring:message code="schedule.thu"/></button>
		                   		<button type="button" value="fri" name="fri" class="btnDay"><spring:message code="schedule.fri"/></button>
		                   		<button type="button" value="sat" name="sat" class="btnDay"><spring:message code="schedule.sat"/></button>
		                   	</div>
		                   	</div>
		                   	
		                   	<div id="timepickerBox">
		                   	<input id="datetimepicker1" class="datetimepicker" type="text" name="start_time_1" autocomplete='off'>
		                   	<span class="ing">~</span>
		                   	<input id="datetimepicker2" class="datetimepicker" type="text" name="end_time_1" autocomplete='off'>
		                   	</div>
		                   	<div id="confirmAlertBox3" class="confirmAlertBox"></div>
						</div>
					</div>
		
					<div class="listBox">
						<strong class="text">SERVER<span class="star">*</span><div id="confirmAlertBox4"></div> </strong>
						<div class="btnList">
							<input type="button" value="<spring:message code='schedule.add'/>" class="btn1" id="btn1" autocomplete='off'>
							<input type="button" value="<spring:message code='schedule.del'/>" class="btn1" onclick="deleteServer()" autocomplete='off'>
						</div>
					</div>
					
					<table class="serverList" id="serverListM">
						<thead id="theadList">
							<tr class="serverHeader">
								<th class="serverHeaderText"><input type="checkbox" id="allCheck" autocomplete='off' name="allCheck"></th>
								<th class="serverHeaderText"><spring:message code="schedule.servername"/> </th>
								<th class="serverHeaderText">IP</th>
								<th class="serverHeaderText">OS</th>
							</tr>
						</thead>
					</table>
					
					<div class="btnBox">
						<input type="button" value="<spring:message code='schedule.registbtn'/>" class="btnBoxbtn" id="btnBoxbtn1" onclick="regBtn()" autocomplete='off'>
						<input type="button" value="<spring:message code='schedule.closebtn'/>" class="btnBoxbtn" id="btnBoxbtn2" onclick="delBtn()" autocomplete='off'>
					</div>
					<div id="deleteRadio"></div>
					</form>
					<!-- Form 태그 종료 -->
				</div>
			</div>
		</div>
		
		<!-- server 등록 modal 창 -->
		<div id="serverModal">
		<div id="serverModalBox">
		<div class="box">SERVER LIST</div>
			<table id="list"></table>
			<div class="btnBox2">
				<input type="button" value="<spring:message code='schedule.add'/>" class="btnBoxbtn2" autocomplete='off'>
				<input type="button" value="<spring:message code='schedule.closebtn'/>" class="btnBoxbtn3" autocomplete='off'>
			</div>
			<div id="pager"></div> 
		</div>
		</div>
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>