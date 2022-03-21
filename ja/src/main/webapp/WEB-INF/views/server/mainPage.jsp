<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 날짜를 문자로 -->   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">

<link rel="stylesheet" typ e="text/css" media="screen" href="../resources/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/jquery-ui.min.css" />

<script src="../resources/js/grid.locale-kr.js" type="text/javascript"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>



<script>
	function search(){
		
		var searchWordInput = document.getElementsByName("searchWord");
		var searchWordValue = searchWordInput[0].value;
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
		         
		         
		         $('#list').jqGrid('clearGridData');
		         $('#list').jqGrid('setGridParam', {data: jsonArr}).trigger('reloadGrid');
		         /*
		            $("#list").jqGrid({
		               datatype: "local",
		               data: jsonArr,
		               rowNum: 10,
		               rowList: [10,30,50],
		               height: 500,
		               autowidth:true,
		               pager: '#pager',
		                colModel: [   
		                     {name: '서버명', label : '서버명', align:'left'},
		                     {name:'IP', label:'IP', align:'left'},
		                     {name: 'OS분류', label : 'OS분류', align:'left'},
		                     {name: '설명', label : '설명', align:'left'}
		                     ],
		                     
		                multiselect: true
		            });
				*/
				
//				searchWordValue.value = "";
			}			
		};
		
		xhr.open("get" , "./getServerList?searchWord=" + searchWordValue, true);
		xhr.send();			
	}
	
	function createAndInitGrid(){
        $("#list").jqGrid({
            datatype: "local",
            data: [],
            rowNum: 10,
            rowList: [10,30,50],
            height: 500,
            autowidth:true,
            pager: '#pager',
             colModel: [   
                  {name: '서버명', label : '서버명', align:'left'},
                  {name:'IP', label:'IP', align:'left'},
                  {name: 'OS분류', label : 'OS분류', align:'left'},
                  {name: '설명', label : '설명', align:'left'}
                  ],
                  
             multiselect: true
         });		
	}
	
	function getListTest(){
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText); 
				
		         renderGridByDatas(data.serverList);
				}
		};
		
		xhr.open("get" , "./getServerList" , true);   
		xhr.send(); 		
	}
	
	
	function searchTest(){
		var searchWordInput = document.getElementsByName("searchWord");
		var searchWordValue = searchWordInput[0].value;
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);
				
		         renderGridByDatas(data.serverList);
			}			
		};
		
		xhr.open("get" , "./getServerList?searchWord=" + searchWordValue, true);
		xhr.send();			
	}
	
	
	
	function renderGridByDatas(datas){
      
        var jsonArr = [];
        for (var i = 0; i < datas.length; i++) {
            jsonArr.push({
               '서버명': datas[i].name,
               'IP':datas[i].ip,
               'OS분류':datas[i].os,
               '설명':datas[i].dsc
            });
        }
        
		         $('#list').jqGrid('clearGridData');
		         $('#list').jqGrid('setGridParam', {data: jsonArr}).trigger('reloadGrid');
		};
		
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
			               rowList: [10,30,50],
			               height: 500,
			               autowidth:true,
			               pager: '#pager',
			                colModel: [   
			                     {name: '서버명', label : '서버명', align:'left'},
			                     {name:'IP', label:'IP', align:'left'},
			                     {name: 'OS분류', label : 'OS분류', align:'left'},
			                     {name: '설명', label : '설명', align:'left'}
			                     ],
			                     
			                multiselect: true
			            });
			            
			            /*
						var dateBox = document.createElement("div");
						dateBox.setAttribute("class","col-2 bg-success");
						
						//숫자를 날짜로 변환하는 API 써서 변환
						//숫자를 날짜로
						var commentWriteDate = new Date(commentData.COMMENT_WRITEDATE);  
						//날짜를 문자로 
						dateBox.innerText = commentWriteDate.getFullYear() + "."
											+ (commentWriteDate.getMonth() + 1) + "."
											+ commentWriteDate.getDate(); 
						*/
 				}
			};
			
			xhr.open("get" , "./getServerList" , true);   
			xhr.send(); 
		}
	
	
	function insertServer(){
		
		
		
	}
	
	function deleteServer(){
		
		
	}
		
	window.addEventListener("DOMContentLoaded", function(){
//		getSessionInfo(); //로그인 정보 담음
/* 	   $(window).resize(function() {
	      $("#list").setGridWidth($(this).width() * .100);
	   });    */
 	//getServerList();
		createAndInitGrid();
		getListTest();
	});
	
	
	
</script>

</head>
<body>

	<div class="row mt-3">
		<div class="col-4">
			<input name="searchWord" type="text" class="form-control" placeholder="서버명/IP">
		</div>
		<div class="col d-grid">
			<button class="searchBtn" onclick="searchTest()">검색</button>
		</div>
	</div>

	<br>
	 <div id="box">
	   	<button class="writeBtn" id="writeBtn" onclick="insertServer()">등록</button>
		<button class="deleteBtn" id="deleteBtn" onclick="deleteServer()">삭제</button>
		<a href="./getExcelServerList"><button  class="writeBtn" id="excelBtn">내보내기</button></a>
		
	</div>
	
	<br>
	
	<table id="list"></table>
	<div id="pager"></div>
	
	
	
</body>
</html>