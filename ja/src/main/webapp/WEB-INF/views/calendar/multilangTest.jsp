<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다국어 테스트</title>
</head>
<body>
	<h1><spring:message code="message.user.title"/></h1>
	<h1><spring:message code="message.user.id"/></h1>
	<h1><spring:message code="message.user.password"/></h1>
</body>
</html>