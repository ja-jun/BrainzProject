<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link href='../resources/css/notification.css' rel='stylesheet'/>
<link href='../resources/css/reset.css' rel='stylesheet'/>
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

function createAndInitGrid(){
    $("#list").jqGrid({
         colModel: [   
	            {name: 'nc_no', label : '번호', align:'left'},
	            {name:'nc_title', label:'제목', align:'left'},
	            {name: 'nc_content', label : '내용', align:'center'},
	            {name: 'nc_file', label : '파일', align:'center'},
	            {name: 'nc_writeDate', label : '등록일시', align:'center'},              
	            {name: 'name', label : '등록자', align:'left'},
	            {name: 'nc_readCount', label : '조회수', align:'center'},
	         /*    {name:'server_no',label:'서버번호', hidden:true} */
              ],
              pager: '#pager',
              rowNum: 10,
              rowList: [10,30,50],
              viewrecords: true,
              multiselect: true,
              //등록시 인코드
  			autoencode : 'true',
              //Data 연동 부분
              url : "./getNotificationList",
              datatype : "JSON", //받을 때 파싱 설정
              postData : {}, //....
              mtype : "POST",
              loadtext : "로딩중...",
  	        height: 'auto',
  			autowidth:true,
  			/* beforeSelectRow: function(rowid, e){
  				i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
  				cm = $(this).jqGrid('getGridParam','colModel');
  				return (cm[i].name === 'cb');
  			}, */
  			
  			// 클릭후 상세보기 띄우기
  			onCellSelect: function(rowId) {
  				
  				
  	            var rowData = $("#list").getRowData(rowId);
  	            var nc_no = rowData.nc_no;
  	            
  	            $.ajax({
  		    	     url: "./getNotification",
  		    	     type: "post",
  		    	     data: {nc_no : nc_no},
  		    	  	 success: function(data){
  						var notification = data.notification;		    	  		 
  		    	  		 
  			            var title = document.querySelector('.title');
  			            title.innerText="공지사항 보기";
  		    	  		
  			            var nc_no = document.createElement('input');
  			          	nc_no.setAttribute('type','hidden');
  			      	  	nc_no.setAttribute('name','nc_no');
  			      		nc_no.setAttribute('id','nc_no');
  			    		nc_no.setAttribute('value',notification.nc_no);
  			            $('#regNotificationInfo').append(nc_no); 
  			            
  		    	  		$('input[name=nc_title]').val(notification.nc_title);
  		    	  		$('select[name=nc_content]').val(notification.nc_content);
  		    	  		
  		    	  		var btn = document.getElementById('inputBtn');
  			            btn.setAttribute("value","수정");
  			            btn.setAttribute("onclick","updateNotification()");
  		    	  		
  			            /* 삭제 버튼 */
						/* document.getElementById('btn');*/  			            var btn2 = document.createElement('input');
  			            btn2.setAttribute('type','button');
  			            btn2.setAttribute('class','btnBoxbtn');
  			            btn2.setAttribute('value','삭제');
  			            btn2.setAttribute('id','btn');
  			            btn2.setAttribute('onclick','deleteNotification()');	            
  			            $('.btnBox').append(btn2); 
  			            
  		    	  		modalOn();
  		    	  		
  					},
  			        error: function() {
  			        	alert("잘못된 접근입니다.");
  			        }
  				});	     
  	                     	
  	        }
    
       });		
  }



//검색시 서버 가져와서 집어넣기
function search(){
	var searchWord = document.getElementById("searchWord").value;	

	$("#list").jqGrid("clearGridData", true);		
	$("#list")
	.setGridParam({
		url : "./getNotificationList",
		mtype : "post",
		postData : {searchWord : searchWord},
		dataType : "json",
	})
	.trigger("reloadGrid");		
}

// insert
function insertNotification(){
	
	var formData = new FormData(document.getElementById('regNotificationInfo'));
	//input태그의 name과 vo변수명이 같을때 자동으로 들어간다
	 $.ajax({
	     url: "./insertNotification",
	     type: "post",
	     processData: false,
	     contentType: false,
	     data: formData
	 }).done(function(){
			$("#list").trigger('reloadGrid');
			modalOff();
			alert("등록되었습니다.");
	 });	 
}



// update
function updateNotification(){	
	var formData = new FormData(document.getElementById('regNotificationInfo'));
	 $.ajax({
	    url: "./updateNotification",
	    type: "post",
	    processData: false,
	    contentType: false,
	    data: formData
	}).done(function(){
		$("#list").trigger('reloadGrid');
		modalOff();
		alert("수정되었습니다.");
	});	
}


// delete
function deleteNotification(){ 
	var notificationNos = [];
	var rowids = $("#list").getGridParam("selarrrow");

	for (let i = 0; i < rowids.length; i++) {
       const rowid = rowids[i];
       var rowData = $("#list").getRowData(rowid);
       notificationNos.push(rowData.nc_no);
    }		
	
		$("#list").jqGrid("clearGridData", true);		

         if(confirm("정말 삭제하시겠습니까?") == true ){
       	  var text = "";
			 $.ajax({
			     url: "./deleteNotification",
			     type: "post",
			     contentType:'application/json',
			     data: JSON.stringify(notificationNos)
			 }).done(function(){
					$("#list").trigger('reloadGrid');
					alert("삭제되었습니다.");
			 });
		 }else{
				   alert("취소합니다.");
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
	document.getElementById("regNotificationInfo").reset();  //입력했던 값 지우기
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

	/* 	
	//모달창 외 부분 클릭하면 모달창 닫힘 : 불편함... 없애는게 나을거 같음
	modal.addEventListener("click", e => {
	    const evTarget = e.target;
		if(evTarget.classList.contains("modal-overlay")) { modalOff(); }
	})
 */
	
});

</script>

</head>
<body>
	<jsp:include page="../nav/nav.jsp"></jsp:include>
	
	<div class="container">
		<div class="row mt-3">
			<div class="col-4">
				<input id="searchWord" type="text" class="form-control" placeholder="제목/내용">
			</div>
			<div class="col">
				<button class="writeBtn" onclick="search()">검색</button>
			</div>
		</div>
	
		<div id="box">
			<button class="writeBtn" id="insertBtn" onclick="modalOn()">등록</button>
			<button class="writeBtn" id="updateBtn" onclick="modalOn()">수정</button>			
			<button class="writeBtn" id="deleteBtn" onclick="deleteNotification()">삭제</button>
						
			<h2>공지사항</h2>
			<table id="list"></table>
			<div id="pager"></div>
		</div>	
	</div>

		<!--등록 모달창 시작 -->
		<div id="modal" class="modal-overlay" style="display:none">
			<div class="modal-window">
				<div class="modalBox">
				
					<!-- Form 태그 시작 -->
					<form id="regNotificationInfo">
					<div class="top">
						<h3 class="title">공지사항 등록</h3>
						<i class="bi bi-x" onclick="modalOff()"></i>
					</div>
					<div class="titleBox">
						<strong class="text">제목<span class="star">*</span></strong>
						<input type="text" id="nc_title" name="nc_title" class="textBox" >
					</div>
					<div class="titleBox">
						<strong class="text">내용<span class="star">*</span></strong>
						<textarea id="nc_content" name="nc_content" class="textBox"></textarea>
					</div>
					<div class="titleBox">
						<strong class="text">파일<span class="star">*</span></strong>
						<input type="file" id="file_no" name="file_no">						
					</div>
					<div class="btnBox">
						<input type="button" id="inputBtn" value="등록" class="btnBoxbtn" onclick="insertNotification()">
						<input type="button" name="" value="닫기" class="btnBoxbtn" onclick="modalOff()" >					
					</div>
					</form>
					
				<!-- Form 태그 종료 -->
				</div>
			</div>
		</div>
	
		<!--상세보기 모달창 시작 -->
		<div id="modal2" class="modal-overlay" style="display:none">
			<div class="modal-window">
				<div class="modalBox">	
				
					<div class="top">
						<h3 class="title">공지사항 보기</h3>
						<i class="bi bi-x" onclick="modalOff2()"></i>
					</div>
					<div class="titleBox">
						<strong class="text">제목</strong>
						<strong type="text" id="nc_title" name="nc_title" class="textBox"></strong>
						
					</div>
					<div class="titleBox">
						<strong class="text">내용</strong>
						<strong id="nc_content" name="nc_content" class="textBox"></strong>
						
					</div>						
					<div class="titleBox">
						<strong class="text" >파일</strong>		
						<strong type="file" id="file_no" name="file_no"></strong>
									
					</div>
					<div class="titleBox">
						<strong class="text">등록일시</strong>
						<strong id="nc_writeDate" name="nc_writeDate" class="textBox"></strong>
						
					</div>
					<div class="titleBox">
						<strong class="text">등록자</strong>
						<strong id="name" name="name" class="textBox"></strong>
						
					</div>
					<div class="titleBox">
						<strong class="text">조회수</strong>
						<strong id="nc_readCount" name="nc_readCount" class="textBox"></strong>
					</div>
					<div class="btnBox">
						<input type="button" id="inputBtn" value="등록" class="btnBoxbtn" onclick="insertNotification()">
						<input type="button" id="inputBtn" value="수정" class="btnBoxbtn" onclick="updateNotification()">						
						<input type="button" name="" value="닫기" class="btnBoxbtn" onclick="modalOff2()" >					
					</div>
					</form>
					
				<!-- Form 태그 종료 -->
				</div>
			</div>
		</div>
	
	
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>