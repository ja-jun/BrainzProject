<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 날짜를 문자로 -->   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./mainPage" method="get">
			<input name="searchWord"type="text" placeholder="서버명/IP">
			<input type="submit" value="검색" class="btn btn-primary">
	</form>
	
	<a href="./insertServerPage">등록</a>  <a href="./deleteServerProcess?server_no=${선택한 모든 server_no 리스트로 보내야하나?}">삭제</a>
	
	
	<br><br>
	
	
	<table border="1">
	
		<tr>
			<td><input type="checkbox" name="check" value="지금리스트에 나와있는 모든 server_no 선택 "></td>
			<td>서버명</td>
			<td>IP</td>
			<td>OS 분류</td>
			<td>상태</td>
			<td>설명</td>
			<td>등록일</td>
		</tr>
		<c:forEach items="${serverVoList}" var="server">
			<tr>
				<td><input type="checkbox" name="check" value="${server.server_no}"></td>
				<td>${server.name}</td>
				<td>${server.ip}</td>
				<td>${server.os}</td>
				<td><!--상태 부분--></td>
				<td>${server.dsc}</td>
				<td>${server.write_date}</td>
			</tr>
		</c:forEach>

	</table>



</body>
</html>