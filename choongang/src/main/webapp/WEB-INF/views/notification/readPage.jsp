<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href='../resources/css/readPage.css' rel='stylesheet' />
<script>
window.addEventListener("DOMContentLoaded", function(){
	var today = document.querySelector('.dateText');
	
	var mydate = new Date(today);
	var a = mydate.toDateString();
	today = a;
	console.log(today);
	
});   
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
		
		<div id="noticeBox">
			<div class="titleBar">
				<h3 class="titleText">${data.nc_title }</h3>
				<strong class="dateText">${data.nc_writeDate }</strong>
			</div>
			
			<div class="contentBox">
				<p class="contentText">${data.nc_content }</p>
			</div>
			
			<div class="footer">
			
			<c:choose>
            		<c:when test="${empty data3.nc_no }">
            		<div class="next" style="display:none">
					</div>
            		</c:when>
            		<c:otherwise>
            		<div class="next">
					<a href="./readPage?nc_no=${data3.nc_no }" style="display: flex;">
					<img src="https://img.icons8.com/ios-filled/50/000000/collapse-arrow.png" style="width:15px">
					<span class="nextTitle">다음</span>
					<p class="nextText">${data3.nc_title }</p>
					</a>
					</div>
            		</c:otherwise>
           </c:choose>
			
			<div class="prev">
				<a href="./readPage?nc_no=${data2.nc_no }" style="display: flex;">
				<img src="https://img.icons8.com/ios-filled/50/000000/expand-arrow--v1.png" style="width:15px">
				<span class="prevTitle">이전</span>
				<p class="prevText">${data2.nc_title }</p>
				</a>
			</div>
			<div class="btnBox">
				<a href="./mainPage"><button class="btnList">목록보기</button></a>
			</div>
			</div>
      	</div>
      	
	</div>
	</div>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>