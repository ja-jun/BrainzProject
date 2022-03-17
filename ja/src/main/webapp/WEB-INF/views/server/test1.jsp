<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">

<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/jquery-ui.min.css" />

<script src="../resources/js/grid.locale-kr.js" type="text/javascript"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>

<script>
var datas = [
		{bbsNum : 1 , bbsTitle : "안녕" , bbsWriter : "한조" , bbsDate : "1111" , bbsHit : "2222"}];
	//jqgrid 띄우기...
	var searchResultColNames = ['게시글관리번호', '번호', '제목', '작성자', '날짜', '조회수']; 
	var searchResultColModel = [{name:'bbsMgtNo', index:'bbsMgtNo', align:'center', hidden:true}, 
		{name:'bbsNum', index:'bbsNum', align:'left', width:'12%'}, 
		{name:'bbsTitle', index:'bbsTitle', align:'center', width:'50%'}, 
		{name:'bbsWriter', index:'bbsWriter', align:'center', width:'14%'}, 
		{name:'bbsDate', index:'bbsDate', align:'center', width:'12%'}, 
		{name:'bbsHit', index:'bbsHit', align:'center', width:'12%'}]; 
	$(function() { 
		$("#qwer").jqGrid({
			datatype : "local",
			data : datas,					
			height: 261, 
			width: 1019, 
			colNames: searchResultColNames, 
			colModel: searchResultColModel, 
			rowNum : 10, 
			pager: "pager"}
		); 
	});

	</script>
</head>
<body>
	<div>
		<table id="qwer"></table>
		<div id="pager"></div>
	</div>

</body>
</html>