<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href='../resources/css/nav.css' rel='stylesheet' />
<link href='../resources/css/reset.css' rel='stylesheet' />
<script>
</script>
</head>

<body>

	
	<div id="content">
			<div class="navBar">
                <h3 class="headerName">Bcentral</h3>
				<ul id="ulList">
					<li class="pageList" id="userPage">
						<a href="../user/mainPage">
						<div class="navBox">
						<img src="../resources/img/person.png" class="imgNav">
						<span class="navTitle">사용자관리</span>
						</div>
						</a>
					</li>
						
					<li class="pageList" id="serverPage">
						<a href="../server/mainPage">
						<div class="navBox">
						<img src="../resources/img/servers.png" class="imgNav">
						<span class="navTitle">서버관리</span>
						</div>
						</a>
					</li>
					
					<li class="pageList" id="calenderPage">
						<a href="../schedule/mainPage">
						<div class="navBox">
						<img src="../resources/img/calendar2.png" class="imgNav">
						<span class="navTitle">작업관리</span>
						</div>
						</a>
					</li>
					
					<li class="pageList" id="noticePage">
						<a href="../notification/mainPage">
						<div class="navBox">
						<img src="../resources/img/notice.png" class="imgNav">
						<span class="navTitle">공지사항</span>
						</div>
						</a>
					</li>
				</ul>
				
				<ul class="language2">
					<li class="languageBox2 onn"><span class="languageText">Ko</span></li>
					<li class="languageBox2"><span class="languageText">En</span></li>
					<li class="languageBox2"><span class="languageText">Cn</span></li>
				</ul>
				
			</div>
	    </div>	

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>