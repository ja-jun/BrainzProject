<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		$(function(){
			$("#testDatepicker").datepicker({
				dateFormat: "yyyy-mm-dd"
			});
		});
		
		function test(){
			var picker = document.getElementById('testDatepicker');
			
			var xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = JSON.parse(xhr.responseText);
					
					if(data.result == 'success'){
						alert('입력에 성공했습니다.');
					} else {
						alert('입력에 실패했습니다.');
					}
				}
			}
			
			xhr.open('get','../schedule/insertDate?date=' + picker.value, true);
			xhr.send();
		}
	</script>
</head>
<body>
	<input type="text" id="testDatepicker">
	<button type="submit" onclick="test()">전송</button>
</body>
</html>