<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/demo/resources/sample.css">
<title>Insert title here</title>
</head>
<body>
	<h1>LOGIN</h1>
	<form action="login_check" method="post">
		<c:if test="${param.ng!=null}">
			<p> error : <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/> </p>
		</c:if>
		USER : <input type="text" name="user_id"><br>
		PASSWORD : <input type="password" name="user_pw"><br>
		<input type="submit" value="Login">
	</form>
</body>
</html>