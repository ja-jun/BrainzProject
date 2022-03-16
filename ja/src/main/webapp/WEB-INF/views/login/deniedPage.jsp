<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Denied-Page</title>
</head>
<body>
	<script type="text/javascript">
		alert("${msg}");
		window.location.href = "${nextPage}";
	</script>
</body>
</html>