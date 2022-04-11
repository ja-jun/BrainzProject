<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
			<div class="logoBox" style="display: inline-flex;padding-left: 24px;">
				<a href="../info/mainPage" style="display: flex;align-items: center;">
                <img src="../resources/img/logo_test2.png" style="display: flex;width: 70px">
				<h3 class="headerName">Bcentral</h3>
            </a>
			</div>
				<ul id="ulList">
					<li class="pageList" id="userPage">
						<a href="../user/mainPage">
						<div class="navBox">
						<img src="../resources/img/user.png">
						<span class="navTitle"><spring:message code="nav.user"/></span>
						</div>
						</a>
					</li>
						
					<li class="pageList" id="serverPage">
						<a href="../server/mainPage">
						<div class="navBox">
						<img src="../resources/img/server.png">
						<span class="navTitle"><spring:message code="nav.server"/></span>
						</div>
						</a>
					</li>
					
					<li class="pageList" id="calenderPage">
						<a href="../schedule/mainPage">
						<div class="navBox">
						<img src="../resources/img/calendarV1.png">
						<span class="navTitle"><spring:message code="nav.schedule"/></span>
						</div>
						</a>
					</li>
					
					<li class="pageList" id="noticePage">
						<a href="../notification/mainPage">
						<div class="navBox">
						<img src="../resources/img/notice.png">
						<span class="navTitle"><spring:message code="nav.notification"/></span>
						</div>
						</a>
					</li>
				</ul>
				
				<ul class="language2">
					<li class="languageBox2"><a href="./mainPage?lang=ko"><span class="languageText">Ko</span></a></li>
					<li class="languageBox2"><a href="./mainPage?lang=en"><span class="languageText">En</span></a></li>
					<li class="languageBox2"><a href="./mainPage?lang=ch"><span class="languageText">Cn</span></a></li>
				</ul>
				
			</div>
	    </div>	

<script>
function getCookie(key){
    var result = null;
    var cookie = document.cookie.split(';');
    cookie.some(function(item){
        item = item.replace(' ', '');
        var dic = item.split('=');

        if(key === dic[0]){
            result = dic[1];
            return true;
        }
    });
    return result;
};
var selectLang = document.getElementsByClassName('languageBox2');

var lang = getCookie('clientlanguage');

if(lang == 'en'){
	selectLang[1].setAttribute("class", "languageBox2 onn");	
} else if(lang == 'ch'){
	selectLang[2].setAttribute("class", "languageBox2 onn");
} else {
	selectLang[0].setAttribute("class", "languageBox2 onn");
}
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>