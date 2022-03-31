<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var test = getCookie("clientlanguage");
	console.log("쿠기 clientlanguage에 저장된 값 : " + test);
</script>
</head>
<body>
	<h1>i18n Test</h1>
	
	<h4><spring:message code="language"></spring:message></h4>
	<h4>${welcome}</h4>
	<h4>${message.user.title }</h4>
</body>
</html>