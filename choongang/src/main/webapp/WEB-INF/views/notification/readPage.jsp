<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><spring:message code="nav.notification"/></title>
<script src="https://kit.fontawesome.com/1fa86d52d5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href='../resources/css/readPage.css' rel='stylesheet' />
<script>

window.addEventListener("DOMContentLoaded", function(){
	$(function(){
		var date = document.querySelector('.dateText').innerText;
    	var date2 = new Date(+new Date(date) + 3240 * 10000).toISOString().replace("T", " ").replace(/\..*/, '');
    	console.log(date2);
    	document.querySelector('.dateText').innerText = date2;
	});
	
	$("#noticePage").addClass("on");
	
	$.ajax({
		url: "/choongang/notification/getNotification",
		type: 'POST',
		data: "nc_no=" + ${data.nc_no },
		success: function(data){
            // 업로드 된 파일 리스트 만들기
            $.each(data.fileVo, function(index, item){
            	$('#afile3-list').append("<a href='/choongang/notification/download?file_no=" + item.file_no + "' download>" + item.fileName + "</a>");
            });
                  
		}
	});
	
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
				<p class="iconText" style="font-size: 18px">${userInfo.name }</p>
				</div>
				<a href="/choongang/security_logout"><i class="fa-solid fa-right-from-bracket" style=" margin-left: 16px; font-size: 22px; padding-top: 2px;"></i></a>
			</div>
		</div>
		
		<div id="noticeBox">
			<div class="titleBar">
				<h3 class="titleText">${data.nc_title }</h3>
				<strong class="dateText">${data.nc_writeDate }</strong>
			</div>
			
			<c:if test="${!empty file}">
				<div id="afile3-list"></div>
			</c:if>
			
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
					<span class="nextTitle"><spring:message code="noti.page"/></span>
					<p class="nextText">${data3.nc_title }</p>
					</a>
					</div>
            		</c:otherwise>
           </c:choose>
           
           
           <c:choose>
            		<c:when test="${empty data2.nc_no }">
            		<div class="prev" style="display:none">
					</div>
            		</c:when>
            		<c:otherwise>
            		<div class="prev">
					<a href="./readPage?nc_no=${data2.nc_no }" style="display: flex;">
					<img src="https://img.icons8.com/ios-filled/50/000000/expand-arrow--v1.png" style="width:15px">
					<span class="prevTitle"><spring:message code="noti.page2"/></span>
					<p class="prevText">${data2.nc_title }</p>
					</a>
					</div>
            		</c:otherwise>
           </c:choose>
			
			
			<div class="btnBox">
				<a href="./mainPage"><button class="btnList"><spring:message code="noti.page3"/></button></a>
			</div>
			</div>
      	</div>
      	
	</div>
	</div>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>