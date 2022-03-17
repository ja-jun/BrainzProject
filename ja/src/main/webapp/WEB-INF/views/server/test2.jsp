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

<link href='../resources/css/calendar.css' rel='stylesheet' />
<link href='../resources/css/reset.css' rel='stylesheet' />

<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/ui.jqgrid2.css" />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script>

function search(){
	
	var searchWordInput = document.getElementsByName("searchWord");
	var searchWordValue = searchWordInput.value;

	
	
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
	         var aaa = data.serverList;
	         var jsonArr = [];
	         for (var i = 0; i < aaa.length; i++) {
	             jsonArr.push({
	                '서버명': aaa[i].name,
	                'IP':aaa[i].ip,
	                'OS분류':aaa[i].os,
	                '설명':aaa[i].dsc
	             });
	         }
	         
	            $("#list").jqGrid({
	               datatype: "local",
	               data: jsonArr,
	               rowNum: 10,
	               rowList: [10,30,50],
	               height: 500,
	               autowidth:true,
	               pager: '#pager',
	                colModel: [   
	                     {name: '서버명', label : '서버명', align:'left'},
	                     {name:'IP', label:'IP', align:'left'},
	                     {name: 'OS분류', label : 'OS분류', align:'left'},
	                     {name: '설명', label : '설명', align:'left'}
	                     ],
	                     
	                multiselect: true
	            });

		
		
		}			
	};
	
	xhr.open("get" , "./getServerList?searchWord=" + searchWordValue, true);
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
		                '서버명': aaa[i].name,
		                'IP':aaa[i].ip,
		                'OS분류':aaa[i].os,
		                '설명':aaa[i].dsc
		             });
		         }
		         
		            $("#list").jqGrid({
		               datatype: "local",
		               data: jsonArr,
		               rowNum: 10,
		               rowList: [10,30,50],
		               height: 300,
		               autowidth:true,
		               pager: '#pager',
		                colModel: [   
		                     {name: '서버명', label : '서버명', align:'left'},
		                     {name:'IP', label:'IP', align:'left'},
		                     {name: 'OS분류', label : 'OS분류', align:'left'},
		                     {name: '설명', label : '설명', align:'left'}
		                     ],
		                     
		                multiselect: true
		            });
		            
		            /*
					var dateBox = document.createElement("div");
					dateBox.setAttribute("class","col-2 bg-success");
					
					//숫자를 날짜로 변환하는 API 써서 변환
					//숫자를 날짜로
					var commentWriteDate = new Date(commentData.COMMENT_WRITEDATE);  
					//날짜를 문자로 
					dateBox.innerText = commentWriteDate.getFullYear() + "."
										+ (commentWriteDate.getMonth() + 1) + "."
										+ commentWriteDate.getDate(); 
					*/
				}
		};
		
		xhr.open("get" , "./getServerList" , true);   
		xhr.send(); 
	}


function insertServer(){
	
	
	
}

function deleteServer(){
	
	
}
	
window.addEventListener("DOMContentLoaded", function(){
//	getSessionInfo(); //로그인 정보 담음
 	   $(window).resize(function() {
      $("#list").setGridWidth($(this).width() * .100);
   });    
	getServerList();

});



</script>

</head>
<body>
	<div id="container">
		<div class="header">
			<!-- 활성화 된 페이지 이름 넣기 -->
			<h3 class="headerName">서버 관리</h3>
		</div>
		
		<div id="content">
			<div class="navBar">
				<ul>
					<!-- 네비바 페이지 이름 변경/a태그 안에 각자 만든 페이지 경로 넣기 -->
					<!-- 활성화 된 페이지는 li class에 있는 on을 활성화 된 페이지에 복붙 -->
					<li class="pageList"><a href=""><i class="bi bi-person"></i>사용자 관리</a></li>
					<li class="pageList on"><a href="./css"><i class="bi bi-shield-check"></i>서버 관리</a></li>
					<li class="pageList"><a href=""><i class="bi bi-calendar-check"></i>작업 관리</a></li>
				</ul>
			</div>
					
		
	<div class="container">
		<div class="row mt-3">
			<div class="col-4">
				<input name="searchWord" type="text" class="form-control" placeholder="서버명/IP">
			</div>
			<div class="col ">
				<button class="writeBtn" onclick="search()">검색</button>
			</div>
		</div>
	
		<br>
		<button class="writeBtn" id="writeBtn" onclick="insertServer()">등록</button>
		<button class="writeBtn" id="deleteBtn" onclick="deleteServer()">삭제</button>
		
		<table id="list"></table>
		<div id="pager"></div>
	</div>	
		
		
		
		
		
		
		
		
		
		
		
		<!-- 모달창 시작 -->
		<div id="modal" class="modal-overlay" style="display:none">
			<div class="window">
				<div class="modalBox">
					<!-- Form 태그 시작 -->
					<form id="regScheduleInfo">
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
							<input type="radio" name="repeat_11" value="0" class="arr" checked> 반복설정
							<input type="radio" name="repeat_11" value="1" class="timearr"> 하루설정
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
		                   		<button type="button" value="sun" name="sun" class="btnDay">SUN</button>
		                   		<button type="button" value="mon" name="mon" class="btnDay">MON</button>
		                   		<button type="button" value="the" name="the" class="btnDay">TUE</button>
		                   		<button type="button" value="wed" name="wed" class="btnDay">WED</button>
		                   		<button type="button" value="thu" name="thu" class="btnDay">THU</button>
		                   		<button type="button" value="fri" name="fri" class="btnDay">FRI</button>
		                   		<button type="button" value="sat" name="sat" class="btnDay">SAT</button>
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
						<input type="button" name="" value="등록" class="btnBoxbtn" onclick="regBtn()">
						<input type="button" name="" value="닫기" class="btnBoxbtn" onclick="delBtn()">
					</div>
					</form>
					<!-- Form 태그 종료 -->
				</div>
			</div>
		</div>
	</div>
	
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>