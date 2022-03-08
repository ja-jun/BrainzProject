<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/jquery-ui.min.css" />
<script src="../resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<script src="../resources/js/minified/jquery.jqGrid.min.js"  type="text/javascript"></script>


<script>
function getServerList(){
	   var xhr = new XMLHttpRequest();
	   
	   xhr.onreadystatechange = function(){
	      if(xhr.readyState == 4 && xhr.status == 200){
	         var data = JSON.parse(xhr.responseText);
	         
	         
	         var aaa = data.serverList;

	         var jsonArr = [];
	         for (var i = 0; i < aaa.length; i++) {
	             jsonArr.push({
	                '서버명': aaa[i].name,
	                'IP':aaa[i].ip,
	                'OS분류':aaa[i].os,
	                '설명':aaa[i].dsc
	             });
	         }
	         
	            $("#list").jqGrid({
	               datatype: "local",
	               data: jsonArr,
	               rowNum: 10,
	               height: 500,
	               autowidth:true,
	               pager: '#pager',
					rowList: [10,30,50],
	                colModel: [   
	                     {name: '서버명', label : '서버명', align:'left'},
	                     {name:'IP', label:'IP', align:'left'},
	                     {name: 'OS분류', label : 'OS분류', align:'left'},
	                     {name: '설명', label : '설명', align:'left'}
	                     ],
	                     
	                multiselect: true
	            });
	        
	            
	            
	      }
	      
	   };
	   
	   xhr.open("get" , "./getServerList" , true);
	   xhr.send();   
	   
	}
	     
	     
	     
	window.addEventListener("DOMContentLoaded" , function(){
	   $(window).resize(function() {

	      $("#list").setGridWidth($(this).width() * .100);

	   });
	   
	   
	   
	   getServerList();
	});   

	
	
function getInputValue(){
	var value = $('#searchWord').val();
	
	
}	
</script>

<title>Insert title here</title>
</head>
<body>
	
	<table id="list"></table>
    <div id="pager"></div>
    <br>
	<input type="text" id="searchWord" placeholder="서버명/IP">
 	<input type="button" onclick="getInputValue();" value="search">
 
 
 
 
 
 
 
 
 
</body>
</html>