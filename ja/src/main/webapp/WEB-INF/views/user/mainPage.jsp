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


</script>

</head>
<body>
	<div id="container">
		<div class="header">
			<!-- 활성화 된 페이지 이름 넣기 -->
			<div><h3 class="headerName">사용자 관리</h3></div>
			
		</div>
		
		<div id="content">
			<div class="navBar">
				<ul>
					<!-- 네비바 페이지 이름 변경/a태그 안에 각자 만든 페이지 경로 넣기 -->
					<!-- 활성화 된 페이지는 li class에 있는 on을 활성화 된 페이지에 복붙 -->
					<li class="pageList on"><a href="mainPage"><i class="bi bi-person"></i>사용자 관리</a></li>
					<li class="pageList"><a href=""><i class="bi bi-shield-check"></i>서버 관리</a></li>
					<li class="pageList"><a href="../calendar/calendarListPage"><i class="bi bi-calendar-check"></i>작업 관리</a></li>
				</ul>
			</div>
			
	    	<div id="box">
	    		<button class="writeBtn" id="writeBtn" onclick="location.href='./registerUser' ">등록</button>
	    		<button class="writeBtn" id="writeBtn" onclick="location.href='../security_logout' ">로그아웃</button>
	    	<div id="calendar"></div>
	    	</div>
	    </div>
	</div>
	
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>
	    
	    