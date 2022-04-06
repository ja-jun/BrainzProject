<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서버관리</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link href='../resources/css/server.css' rel='stylesheet' />
<link href='../resources/css/reset.css' rel='stylesheet' />
<link href="../resources/css/jquery-ui.css" rel="stylesheet"/>
<link href="../resources/css/jquery-ui.min.css" rel="stylesheet"/>
<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/ui.jqgrid2.css" />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script src="../resources/js/jQuery.jqGrid.setColWidth.js"></script>
<script src="../resources/js/jquery-ui.min.js"></script>

<script>
//mac 중복확인용
var isConfirmedMac = false; 

//ip 정규식
var regExp = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/;

function createAndInitGrid(){
    $("#list").jqGrid({
	        colModel: [   
	            {name: 'name', label : '서버명', align:'left'},
	            {name: 'ip', label:'IP', align:'left'},
	            {name: 'os', label : 'OS분류', align:'center'},
	            {name: 'status', label : '상태', align:'center', formatter : function(cellvalue){
		           	 switch(cellvalue){
		        	 case "0":
						return "오늘 작업 예정";
		        	 case "1":
						return "현재 작업 중";
		        	 case "2":
						return "오늘 작업 완료";
		        	 case "3":
						return "오늘 작업 없음";
	            }}},              
	            {name: 'loc', label : '위치', align:'left'},
	            {name: 'mac', label : 'MAC', align:'center'},
	            {name: 'control_num', label : '관리번호', align:'left'},
	            {name: 'dsc', label : '설명', align:'left'},     
	            {name: 'write_date', label : '등록일', align:'center' },
	            {name: 'server_no',label:'서버 번호', hidden:true}
	            ],
            pager: '#pager',
            rowNum: 10,
            rowList: [10,30,50],
            viewrecords: true,
            multiselect: true,
			autoencode: true,
            //Data 연동 부분
            url : "./getServerList",
            datatype : "JSON", //받을 때 파싱 설정
            postData : {},
            mtype : "POST",
            loadtext : "로딩중...",
	        height: 'auto',
			autowidth:true,
			beforeSelectRow: function(rowid, e){
				i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
				cm = $(this).jqGrid('getGridParam','colModel');
				return (cm[i].name === 'cb');
			},
			/*
			loadComplete : function(){
				alert(1111);	
			},
			*/
			gridComplete : function(){
				//alert(3333);	
			},
			// 수정 모달 창 띄우기
 	        ondblClickRow: function (rowId) { 
 	        	
	            var rowData = $("#list").getRowData(rowId);
	            var server_no = rowData.server_no;
		       	
	            $.ajax({
		    	     url: "./getServer",
		    	     type: "post",
		    	     data: {server_no : server_no},
		    	  	 success: function(data){
						var server = data.server;		    	  		 
		    	  		 
			            var title = document.querySelector('.title');
			            title.innerText="서버 수정";
		    	  		
			            var server_no = document.createElement('input');
			            server_no.setAttribute('type','hidden');
			            server_no.setAttribute('name','server_no');
			            server_no.setAttribute('id','server_no');
			            server_no.setAttribute('value',server.server_no);
			            $('#regServerInfo').append(server_no); 
			            
		    	  		$('input[name=name]').val(server.name);
		    	  		$('input[name=ip]').val(server.ip);
		    	  		$('select[name=os]').val(server.os);
		    	  		$('input[name=loc]').val(server.loc);
		    	  		$('input[name=mac]').val(server.mac);
		    	  		$('input[name=control_num]').val(server.control_num);
		    	  		$('input[name=dsc]').val(server.dsc);
		    	  		$('input[name=write_date]').val(server.write_date);		
		    	  		
		    	  		var btn = document.getElementById('inputBtn');
			            btn.setAttribute("value","수정");
			            btn.setAttribute("onclick","updateServer()");
		    	  		
		    	  		modalOn();
					},
			        error: function() {
			        	alert("잘못된 접근입니다.");
			        }
				});            
	            $("#server_no").remove();
	           
	        }
     });		
    
      
}


//검색시 서버 가져와서 집어넣기
function search(){
	var searchWord = document.getElementById("searchWord").value;	

	$("#list").jqGrid("clearGridData", true);		
	$("#list")
	.setGridParam({
		url : "./getServerList",
		mtype : "post",
		postData : {searchWord : searchWord},
		dataType : "json",
	})
	.trigger("reloadGrid");
	
	// 내보내기 기능을 위한 검색어 전송
	var exportAnchor = document.getElementById("exportAnchor");
	var qIndex = exportAnchor.href.lastIndexOf("?");
	
	if(qIndex >= 0){
		exportAnchor.href = exportAnchor.href.substring(0, qIndex) + "?searchWord=" + searchWord;
	} else {
		exportAnhcor.href += "?searchWord=" + searchWord;
	}
}


function insertServer(){
	
	validationTest();
	console.log("인서트 시작");
	
	var formData = new FormData(document.getElementById('regServerInfo'));
	//input태그의 name과 vo변수명이 같을때 자동으로 들어간다
	 $.ajax({
	     url: "./insertServer",
	     type: "post",
	     processData: false,
	     contentType: false,
	     data: formData
	 }).done(function(data){
		 	var result= data.result;
		 	if(result != "0"){
				validationError(result);
		 	} else{
				alert("등록되었습니다.");			 		
		 	}
			$("#list").trigger('reloadGrid');
			modalOff();
	 });	 
}


 //삭제
function deleteServer(){ 
	var serverNos = [];
	var rowids = $("#list").getGridParam("selarrrow");

	for (let i = 0; i < rowids.length; i++) {
        const rowid = rowids[i];
        var rowData = $("#list").getRowData(rowid);
		serverNos.push(rowData.server_no);
    }		
	
		$("#list").jqGrid("clearGridData", true);		

          if(confirm("정말 삭제하시겠습니까?") == true ){
        	  var text = "";
			 $.ajax({
			     url: "./deleteServer",
			     type: "post",
			     contentType:'application/json',
			     data: JSON.stringify(serverNos)
			 }).done(function(){
					$("#list").trigger('reloadGrid').bind("jqGridAfterLoadComplete" , function(){
						//alert("삭제되었습니다.");	
						var toastLiveExample = document.getElementById('liveToast');
						var toast = new bootstrap.Toast(toastLiveExample);
						toast.show();
						
					});
											
			 });
			}else{
				   alert("취소합니다.");
					$("#list").trigger('reloadGrid');
			}
 }
 
//수정 서버 넘기기
function updateServer(){			
 	if($("#name").val() == ""){
		 document.getElementById("nameAlertBox").innerText = "서버명을 입력해주세요.";
		 document.getElementById("nameAlertBox").style.color = "red";
		 $('#name').focus();
		return;
	} else{
		 document.getElementById("nameAlertBox").innerText = "";
	}

	if(!regExp.test($("#ip").val())){
		 document.getElementById("ipAlertBox").innerText = "IPv4 또는 IPv6 형식으로 입력해주세요.";
		 document.getElementById("ipAlertBox").style.color = "red";
		$('#ip').focus();
		return;
	} else{
		 document.getElementById("ipAlertBox").innerText = "";
	}
	
	var mac = document.getElementById("mac");
	var macValue = mac.value;

	var server_no = $('#server_no').val();	
	 $.ajax({
	     url: "./validationMac",
	     type: "post",
	     processData: false,
	     contentType: false,
	     data: {server_no : server_no, mac : macValue}
	 }).done(function(data){
			var macAlertBox = document.getElementById("macAlertBox");
			if(data.formMac == false){
				isConfirmedMac = false; 
				macAlertBox.innerText = "유효하지 않은 MAC 입니다.";
				macAlertBox.setAttribute("style","color:red");
				return;
			} else if(data.isExistMac == true){
				isConfirmedMac = false; 
				macAlertBox.innerText = "이미 존재하는 MAC 입니다.";
				macAlertBox.setAttribute("style","color:red");
				return;
			} else{
				isConfirmedMac = true; 
				macAlertBox.innerText = "";
			}
	 });	 

	 console.log("eeeeeeee");


	var formData = new FormData(document.getElementById('regServerInfo'));
	 $.ajax({
	    url: "./updateServer",
	    type: "post",
	    processData: false,
	    contentType: false,
	    data: formData
	}).done(function(data){
		var result= data.result;
	 	if(result != "0"){
			validationError(result);
	 	} else{
			alert("수정되었습니다.");	 		
	 	}
		$("#list").trigger('reloadGrid');
		modalOff();
	});	
}



/* //MAC 중복확인 - server_no가 수정전 server_no랑 같으면 mac이 같아도 되게 만들어야함.....
function confirmMac(){
	
	var mac = document.getElementById("mac");
    var macValue = mac.value;
	
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){ 
			var data = JSON.parse(xhr.responseText); 
		
			var macAlertBox = document.getElementById("macAlertBox");
			if(data.formMac == false){
				isConfirmedMac = false; 
				macAlertBox.innerText = "유효하지 않은 MAC 입니다.";
				macAlertBox.setAttribute("style","color:red");
			} else if(data.isExistMac == true){
				isConfirmedMac = false; 
				macAlertBox.innerText = "이미 존재하는 MAC 입니다.";
				macAlertBox.setAttribute("style","color:red");
			} else{
				isConfirmedMac = true; 
				macAlertBox.innerText = "";
			}
		}
	};
	
	xhr.open("post" , "./validationMac", true);  
    xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //Post
	xhr.send("mac=" + macValue); 
} */
 
	
function validationTest(){
 	if($("#name").val() == ""){
		 document.getElementById("nameAlertBox").innerText = "서버명을 입력해주세요.";
		 document.getElementById("nameAlertBox").style.color = "red";
		 $('#name').focus();
		return;
	} else{
		 document.getElementById("nameAlertBox").innerText = "";
	}

	var regExp = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/;
	
	if(!regExp.test($("#ip").val())){
		 document.getElementById("ipAlertBox").innerText = "IPv4 또는 IPv6 형식으로 입력해주세요.";
		 document.getElementById("ipAlertBox").style.color = "red";
		$('#ip').focus();
		return;
	} else{
		 document.getElementById("ipAlertBox").innerText = "";
	}

	var mac = document.getElementById("mac");
    var macValue = mac.value;
	
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){ 
			var data = JSON.parse(xhr.responseText); 
		
			var macAlertBox = document.getElementById("macAlertBox");
			if(data.formMac == false){
				isConfirmedMac = false; 
				macAlertBox.innerText = "유효하지 않은 MAC 입니다.";
				macAlertBox.setAttribute("style","color:red");
			} else if(data.isExistMac == true){
				isConfirmedMac = false; 
				macAlertBox.innerText = "이미 존재하는 MAC 입니다.";
				macAlertBox.setAttribute("style","color:red");
			} else{
				isConfirmedMac = true; 
				macAlertBox.innerText = "";
			}
		}
	};
	
	xhr.open("post" , "./validationMac", true);  
    xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //Post
	xhr.send("mac=" + macValue); 
	
	
	if(isConfirmedMac == false){
		$('#mac').focus();
		return;
	}


}
 
 
 
 
 

 
 //서버에서 유효성 검사 결과를 alert로 보여주기
 function validationError(result){
	 switch(result){
	 case "1":
		 alert("로그인이 필요합니다.");
	 	break;
	 case "2":
		 alert("서버명이 없습니다.");
		 break;
	 case "3":
		 alert("유효한 IP가 아닙니다.");
		 break;
	 case "4":
		 alert("유효한 MAC 주소가 아닙니다.");
		 break;
	 case "5":
		 alert("중복된 MAC 입니다.");
		 break;
	 }
 }
 
 
 
 
 
 

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
	document.getElementById("macAlertBox").innerText=""; 	//MAC 중복 메세지 지우기
	document.getElementById("ipAlertBox").innerText=""; 	
	document.getElementById("nameAlertBox").innerText=""; 	
    var title = document.querySelector('.title');
    title.innerText="서버 등록";

	var btn = document.getElementById('inputBtn');
    btn.setAttribute("value","등록");
    btn.setAttribute("onclick","insertServer()");	
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
	
	const modal = document.getElementById("modal");
	
	$("#serverPage").addClass("on");
});
</script>
</head>

<body>
	<jsp:include page="../common/nav.jsp"></jsp:include>
   
   <div id="container">
      <div id="box">
      
      
      <div id="gnb">
         <div class="iconBox">
         <img src="../resources/img/user.png" class="profile">
            <div class="icon">
            <p class="iconText" >닉네임</p>
            </div>
         </div>
      </div>
      
      <div id="serverBox">
      <div id="top">
         <div class="btnBox">
            <button class="writeBtn" id="insertBtn" onclick="modalOn()">등록</button>
            <button class="writeBtn" id="deleteBtn" onclick="deleteServer()">삭제</button>
            <a href="./getExcelServerList" id="exportAnchor"><button class="writeBtn" id="excelBtn">내보내기</button></a>
            </div>
               <div id="search">
                  <div class="searchBox">
                  <input id="searchWord" type="text" class="searchForm" placeholder="서버명/IP">
                  <button class="searchBtn" onclick="search()">검색</button>
               </div>
            </div>   
      </div>
         
         <div id="jqgridBox">
            <table id="list" style="width:100%"></table>
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
               <div class="serverInput">
                  <strong class="text">서버명<span class="star">*</span></strong>
                  <input type="text" id="name" name="name" class="textBox" >
                  <div id="nameAlertBox" class="confirmAlertBox"></div> 
               </div>
               <div class="serverInput">
                  <strong class="text">IP<span class="star">*</span></strong>
                  <input type="text" id="ip" name="ip" class="textBox">
                  <div id="ipAlertBox" class="confirmAlertBox"></div>                   
               </div>
               <div class="serverInput">
                  <strong class="text">OS분류<span class="star">*</span></strong>
                  <select form="regServerInfo" id="os" name="os" class="selectBox" >
                        <option value="AIX">AIX</option>
                        <option value="Windows">Windows</option>
                        <option value="Linux">Linux</option>                     
                        <option value="Linux">Linux</option>                     
                        <option value="Linux">Linux</option>                     
                     </select>
               </div>
               <div class="serverInput">
                  <strong class="text">위치</strong>
                  <input type="text" id="loc" name="loc" class="textBox">
               </div>
               <div class="serverInput">
                  <strong class="text">MAC<span class="star">*</span></strong>
                  <input type="text" id="mac"  name="mac" class="textBox" >
                  <div id="macAlertBox" class="confirmAlertBox"></div> 
               </div>
               
               <div class="serverInput">
                  <strong class="text">관리번호</strong>
                  <input type="text" id="control_num" name="control_num" class="textBox">
               </div>
               <div class="serverInput">
                  <strong class="text">설명</strong>
                  <input type="text" id="dsc" name="dsc" class="textBox">
               </div>
               <div class="btnBox">
                  <input type="button" id="inputBtn" value="등록" class="writeBtn2" onclick="insertServer()">
                  <input type="button" name="" value="닫기" class="writeBtn2" onclick="modalOff()" >
               </div>
               </form>

            <!-- Form 태그 종료 -->
            </div>
         </div>
      </div>

<script>

</script>

<div class="position-fixed top-0 start-50 p-3" style="z-index: 11">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-body fw-bold fs-1 text-danger">
      삭제되었습니다.
    </div>
  </div>
</div>



</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>