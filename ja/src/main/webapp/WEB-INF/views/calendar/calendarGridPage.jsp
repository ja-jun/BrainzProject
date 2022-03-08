<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href='../resources/css/reset.css' rel='stylesheet' />
<!-- jqGrid -->
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resources/css/ui.jqgrid.css" />
<link href='../resources/css/calendar2.css' rel='stylesheet' />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
</head>
<script>

	
function getCalendarList(){
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			
			
			var aaa = data.calendarList;
			console.log(aaa);
			
			
			
				for(x of aaa){
				var dataArray = [	
					{  
				        "작업명" : x.title,
				        "시작날짜" : x.start_date,
				        "마감날짜" : x.end_date,
				        "시작시간" : x.start_hour,
				        "마감시간" : x.end_hour
				        }
					];
			  }
				console.log(x.title);
			
				
				$("#list").jqGrid({
					datatype: "local",
					data: dataArray,
					rowNum: 10,
					width:1000,
					height: 500,
					 colModel: [
				          {name: '작업명', label : '작업명', align:'left'},
				          {name: '시작날짜', label : '시작날짜', align:'left'},
				          {name: '마감날짜', label : '마감날짜', align:'left'},
				          {name: '시작시간', label : '시작시간', align:'left'},
				          {name: '마감시간', label : '시작시간', align:'left'}
				        ],
				    pager: '#pager',
				    multiselect: true
				});
			
			
				
					
					/* for(var i=0;i<=aaa.length;i++){
						jQuery("#list").jqGrid('addRowData',i+1,aaa[i])
					}; */
		}
		
	};
	
	xhr.open("get" , "./getCalendarList" , true);
	xhr.send();	
	
}
	
	
	
window.addEventListener("DOMContentLoaded" , function(){
	getCalendarList();
});	

</script>
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
		<table id="list"></table>
		<div id="pager"></div> 
</div>
</div>
		
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>