<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>css 포함 서버관리</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link href='../resources/css/server.css' rel='stylesheet' />
<link href='../resources/css/reset.css' rel='stylesheet' />
<link href="../resources/css/jquery-ui.css" rel="stylesheet"/>
<link href="../resources/css/jquery-ui.min.css" rel="stylesheet"/>
<link href="../resources/css/jquery-ui.structure.css" rel="stylesheet"/>
<link href="../resources/css/jquery-ui.theme.css" rel="stylesheet"/>

<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/ui.jqgrid2.css" />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script src="../resources/js/jQuery.jqGrid.setColWidth.js"></script>
<script src="../resources/js/jquery-ui.min.js"></script>



<script> 
            
//그리드 형식            
function createAndInitGrid(){
    $("#list").jqGrid({
        datatype: "local",
        data: [],
        rowNum: 10,
        rowList: [10,30,50],
        height: 'auto',
        autowidth:true,
        pager: '#pager',
         colModel: [   
              {name: '서버명', label : '서버명', align:'left'},
              {name:'IP', label:'IP', align:'left'},
              {name: 'OS분류', label : 'OS분류', align:'center'},
              {name: '상태', label : '상태', align:'center'},              
              {name: '위치', label : '위치', align:'left'},
              {name: 'MAC', label : 'MAC', align:'center'},
              {name: '관리번호', label : '관리번호', align:'left'},
              {name: '설명', label : '설명', align:'left'},     
              {name: '등록일', label : '등록일', align:'center', formatter : 'datetime', formatoptions: {srcformat: "U/1000", newformat: 'Y/m/d H:i:s'} },
              {name:'서버번호',label:'서버번호', hidden:true}
              ],
              
         multiselect: true
     });		
}
           
 //그리드에 값 집어넣기          
	function renderGridByDatas(datas){
	      
        var jsonArr = [];
        for (var i = 0; i < datas.length; i++) {	
            jsonArr.push({
               '서버명': datas[i].name,               
               'IP':datas[i].ip,
               'OS분류':datas[i].os,
               '상태':datas[i].loc,
               '위치':datas[i].loc,
               'MAC':datas[i].mac,
               '관리번호':datas[i].control_num,
               '설명':datas[i].dsc,
               '등록일':datas[i].write_date,
               '서버번호':datas[i].server_no
            });
        }
		         $('#list').jqGrid('clearGridData');
		         $('#list').jqGrid('setGridParam', {data: jsonArr}).trigger('reloadGrid');
	}
		
	 

//서버리스트 가져와서 집어넣기
function getList(){
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

//검색시 서버 가져와서 집어넣기
function search(){
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


//입력값 db에 등록하기
function insertServer(){
	var name = $("#name").val();
	var ip = $("#ip").val();
	var os = $("#os").val();
	var loc = $("#loc").val();
	var mac = $("#mac").val();
	var  control_num= $("#control_num").val();
	var dsc = $("#dsc").val();
	
	if(name ==""){
		//필수 입력 했는지 확인...
	}
	if(isConfirmed ==false ){
		
	}
	
	
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){ 
			var data = JSON.parse(xhr.responseText); 

			modalOff();
			getList();
		}
	};
	
	xhr.open("post" , "./insertServer" , true);  
    xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //Post
	xhr.send("name=" +  name + "&ip=" + ip + "&os=" + os + "&loc=" + loc 
			+ "&mac=" + mac + "&control_num=" + control_num + "&dsc=" + dsc ); 

}

var isConfirmed = false; //mac 중복확인용

//MAC 중복확인
function confirmMac(){
	
	var mac = document.getElementById("mac");
    var macValue = mac.value;
	
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){ 
			var data = JSON.parse(xhr.responseText); 
		
			var confirmAlertBox = document.getElementById("confirmAlertBox");
			if(data.result == true){
				isConfirmed = false; 
				confirmAlertBox.innerText = "이미 존재하는 MAC 입니다.";
				confirmAlertBox.setAttribute("style","color:red");
			} else{
				isConfirmed = true; 
				confirmAlertBox.innerText = "사용 가능한 MAC 입니다.";
				confirmAlertBox.setAttribute("style","color:green");
			}
			return false;
			
		}
	};
	
	xhr.open("post" , "./isExistMac", true);  
    xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //Post
	xhr.send("mac=" + macValue); 
}

//서버 선택 삭제
            
/*         if(confirm("정말 삭제하시겠습니까?") == true){
            $.ajax({
                url: "delete action ",
                data: params ,
                type: "POST",
                beforeSend:function(){
                  console.log("삭제중입니다.");
                }
            }).done(function(){
              console.log("삭제되었습니다.");
            });
        }else{
            return false;
        }
 */
 //삭제 -  삭제시 select 풀기 추가하기
function deleteServer(){ 
	var serverNos = [];
	var rowids = $("#list").getGridParam("selarrrow");
	
	for (let i = 0; i < rowids.length; i++) {
        const rowid = rowids[i];
        var rowData = $("#list").getRowData(rowid);
		serverNos.push(rowData.서버번호);
    }
	
	
	
	var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);
				
				alert("삭제되었습니다.");
				getList();
				
			}
		};
		
		xhr.open("post" , "./deleteServer" , true); //get.?
        xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xhr.send("serverNos="+ serverNos);	
}
 
	
 //유효한 ip인지 확인하는 함수
	

 
 
 
 
 
 
	
//모달창 함수	
function modalOn() {
    modal.style.display = "flex";
}
function isModalOn() {
    return modal.style.display === "flex";
}
function modalOff() {
    modal.style.display = "none";
	document.getElementById("regServerInfo").reset();  //입력했던 값 지우기
	document.getElementById("confirmAlertBox").innerText=""; 	//MAC 중복 메세지 지우기
}

//모달창 열렸을 때 ESC누르면 닫힘
window.addEventListener("keyup", e => {
    if(isModalOn() && e.key === "Escape") { modalOff(); }
})




window.addEventListener("DOMContentLoaded", function(){
	   $(window).resize(function() {
      $("#list").setGridWidth($(this).width() * .100);
   });    
		createAndInitGrid();
		getList();
	
	const modal = document.getElementById("modal")
	
	//모달창 외 부분 클릭하면 모달창 닫힘 : 불편함... 없애는게 나을거 같음
	modal.addEventListener("click", e => {
	    const evTarget = e.target;
   		if(evTarget.classList.contains("modal-overlay")) { modalOff(); }
	})
	
});



</script>
</head>

<body>



	<div id="container">
		<div class="header">
			<!-- 활성화 된 페이지 이름 넣기 -->
			<h3 class="headerName">서버 관리</h3>
		</div>
		
		<div id="content">
			<div class="navBar">
				<ul>
					<!-- 네비바 페이지 이름 변경/a태그 안에 각자 만든 페이지 경로 넣기 -->
					<!-- 활성화 된 페이지는 li class에 있는 on을 활성화 된 페이지에 복붙 -->
					<li class="pageList"><a href=""><i class="bi bi-person"></i>사용자 관리</a></li>
					<li class="pageList on"><a href="./css"><i class="bi bi-shield-check"></i>서버 관리</a></li>
					<li class="pageList"><a href=""><i class="bi bi-calendar-check"></i>작업 관리</a></li>
				</ul>
			</div>
					
		
	<div class="container">
		<div class="row mt-3">
			<div class="col-4">
				<input name="searchWord" type="text" class="form-control" placeholder="서버명/IP">
			</div>
			<div class="col ">
				<button class="writeBtn" onclick="search()">검색</button>
			</div>
		</div>
	
		<div id="box">
			<button class="writeBtn" id="insertBtn" onclick="modalOn()">등록</button>
			<button class="writeBtn" id="deleteBtn" onclick="deleteServer()">삭제</button>
			<a href="./getExcelServerList"><button  class="writeBtn" id="excelBtn">내보내기</button></a>
						
			<h2>서버 관리</h2>
			<table id="list"></table>
			<div id="pager"></div>
		</div>	
	</div>
</div>
	</div>


		<!--등록 모달창 시작 -->
		<div id="modal" class="modal-overlay" style="display:none">
			<div class="modal-window">
				<div class="modalBox">
				
					<!-- Form 태그 시작 -->
					<form id="regServerInfo">
					<div class="top">
						<h3 class="title">서버 등록</h3>
						<i class="bi bi-x" onclick="modalOff()"></i>
					</div>
					<div class="titleBox">
						<strong class="text">서버명<span class="star">*</span></strong>
						<input type="text" id="name" class="textBox" >
					</div>
					<div class="titleBox">
						<strong class="text">IP<span class="star">*</span></strong>
						<input type="text" id="ip" class="textBox">
					</div>
					<div class="titleBox">
						<strong class="text">OS분류<span class="star">*</span></strong>
						<select form="regServerInfo" id="os" class="selectBox" >
								<option value="AIX">AIX</option>
								<option value="Windows">Windows</option>
								<option value="Linux">Linux</option>							
								<option value="Linux">Linux</option>							
								<option value="Linux">Linux</option>							
							</select>
					</div>
					<div class="titleBox">
						<strong class="text">위치</strong>
						<input type="text" id="loc" class="textBox">
					</div>
					<div class="titleBox">
						<strong class="text">MAC<span class="star">*</span></strong>
						<input type="text" id="mac"  id="mac" class="textBox" onblur="confirmMac()">
						<div id="confirmAlertBox"></div> 
					</div>
					
					<div class="titleBox">
						<strong class="text">관리번호</strong>
						<input type="text" id="control_num" class="textBox">
					</div>
					<div class="titleBox">
						<strong class="text">설명</strong>
						<input type="text" id="dsc" class="textBox">
					</div>
					<div class="btnBox">
						<input type="button" name="" value="등록" class="btnBoxbtn" onclick="insertServer()">
						<input type="button" name="" value="닫기" class="btnBoxbtn" onclick="modalOff()" >
					</div>
					</form>

				<!-- Form 태그 종료 -->
				</div>
			</div>
		</div>

	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>