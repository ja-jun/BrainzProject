<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./insertServerProcess" method="post" >
		<h1>서버 등록</h1>
	
		서버명     <input type="text" name="name"><br>
		IP	*		    <input type="text" name="ip"><br>
		OS분류 *    <select name="os" class="form-select">
								<option value="aix">AIX</option>
								<option value="Windows">Windows</option>
								<option value="Linux">Linux</option>							
							</select><br>
		위치    <input type="text" name="loc"><br>
		MAC *   <input type="text" name="mac"><br>
		관리 번호    <input type="text" name="control_num"><br>
		설명    <input type="text" name="dsc"><br>
		<input type="submit" value="등록" >
	</form>

</body>
</html>>