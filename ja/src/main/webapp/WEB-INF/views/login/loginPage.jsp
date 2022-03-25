<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/ja/resources/css/Login.css">
<link rel="stylesheet" type="text/css" href="/ja/resources/css/Login2.css">
<title>LOGIN</title>
</head>
<body>

<form action="login_check" method="post">
<section class="login">
    <h2>LOGIN</h2>
    <ul>
      <li><input type="text" name="user_id" placeholder="아이디"></li>
      <li><input type="password"  name="user_pw" placeholder="비밀번호"></li>
      <li><button type="submit">로그인</button></li>
      <li>
	    <c:if test="${LoginFailMessage!=null}">
			<p><c:out value="${LoginFailMessage}"/></p>
		</c:if>
	  <li>
    </ul>
</section>
</form>

</body>
</html>