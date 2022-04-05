<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
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
		            {name: 'nc_no', label : '번호', align:'center', width:15},
		            {name:'nc_title', label:'제목', align:'left', width:200},
		            {name: 'file_no', label : '파일', align:'center', width:15, formatter: imageFormatter},
		            {name: 'nc_writeDate', label : '등록일시', align:'center', width:50},              
		            {name: 'name', label : '등록자', align:'center', width:30},
		            {name: 'nc_readCount', label : '조회수', align:'center', width:15}
              	   ],
		              pager: '#pager',
		              rowNum: 10,
		              rowList: [10,30,50],
		              viewrecords: true,
		              multiselect: true,
		              //등록시 인코드
		  			  autoencode : 'true',
		              //Data 연동 부분
		              url : "/choongang/notification/getNotificationList",
		              datatype : "JSON", //받을 때 파싱 설정
		              postData : {}, //....
		              mtype : "POST",
		              loadtext : "로딩중...",
		  	          height: 'auto',
		  			  autowidth:true,  			 
		  			
		  			  onCellSelect: function(rowid, iCol, e){
		  	            var rowData = $("#list").getRowData(rowid);
		  	            var nc_no = rowData.nc_no;
		  	            
		  	            if(iCol == 2){
			  	            location.href="readPage?nc_no=" + nc_no;
		  	            } else {
		  	            	return;
		  	            }
		  	          
		  	         },  	  		    
       });		
  }

/*** Formatter 스크립트 함수 ***/
function imageFormatter(cellValue)
{
    // rowObject  : JqGrid의 행 정보를 담고 있다.
	// console.log(rowObject);
//	$('#afile3-list').append("<a href='/choongang/notification/download?file_no=" + item.file_no + "' download>" + item.fileName + "</a>");
	
	if(cellValue == null){
		   return '';
		} else {
		   return '<a href="/choongang/notification/download?file_no=' + cellValue + '"><img src="../resources/img/file1.png" /></a>';
		}
	
   // return '<img src="../resources/img/file1.png" />';
}


//검색시 서버 가져와서 집어넣기
function search(){
	var searchWord = document.getElementById("searchWord").value;	

	$("#list").jqGrid("clearGridData", true);		
	$("#list")
	.setGridParam({
		url : "/choongang/notification/getNotificationList",
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
	     url: "/choongang/notification/insertNotification",
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
	    url: "/choongang/notification/updateNotification",
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

function updateModal() {
	
	var rowIds = $('#list').getGridParam('selarrrow');
	
	if(rowIds.length > 1){
		alert("1개의 글만 수정 가능합니다.");
		return;
	} else if(rowIds.length == 0){
		alert("수정하실 글을 선택해주세요.")
	} else {
		var nc_no = $('#list').getRowData(rowIds[0]).nc_no;
	}
	
	console.log(nc_no);
	
	$.ajax({
		url: "/choongang/notification/getNotification",
		type: 'POST',
		data: "nc_no=" + nc_no,
		success: function(data){
			var notification = data.notification;
			
			var title = document.querySelector('.title');
	            title.innerText="공지사항 수정";
  	  		
            var nc_no = document.createElement('input');
          	nc_no.setAttribute('type','hidden');
      	  	nc_no.setAttribute('name','nc_no');
      		nc_no.setAttribute('id','nc_no');
    		nc_no.setAttribute('value',notification.nc_no);
            $('#regNotificationInfo').append(nc_no); 
	            
  	  		$('input[name=nc_title]').val(notification.nc_title);
  	  		$('textarea[name=nc_content]').val(notification.nc_content);
  	  		
  	  		var btn = document.getElementById('inputBtn');
	            btn.setAttribute("value","수정");
	            btn.setAttribute("onclick","updateNotification()");
  	  		
	        var btn2 = document.getElementById('deleteBtn3');
            btn2.setAttribute("style","display:block");			              			            			        
	        
            // 업로드 된 파일 리스트 만들기
            $.each(data.fileVo, function(index, item){
            	$('#afile3-list').append("<a href='/choongang/notification/download?file_no=" + item.file_no + "' download>" + item.fileName + "</a>");
            });
                        
  	  		modalOn();
		}
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
			     url: "/choongang/notification/deleteNotification",
			     type: "post",
			     contentType:'application/json',
			     data: JSON.stringify(notificationNos)
			 }).done(function(){
					$("#list").trigger('reloadGrid');
					modalOff();
					alert("삭제되었습니다.");
			 });
		 }else{
				   alert("취소합니다.");
		 }
}

function deleteModal() {
		
	var notificationNos = [];
	
	var nc_no = $("#nc_no").val();
    notificationNos.push(nc_no);

	if(confirm("정말 삭제하시겠습니까?") == true ){
     	 var text = "";
		
		 $.ajax({
		     url: "/choongang/notification/deleteNotification",
		     type: "post",
		     contentType:'application/json',
		     data: JSON.stringify(notificationNos)
		 }).done(function(){
				$("#list").trigger('reloadGrid');
				modalOff();
				alert("삭제되었습니다.");
		 });
	 	}else{
			   alert("취소합니다.");
	 	}	
}

function registerNotification(){
		var btn = document.getElementById('inputBtn');
        btn.setAttribute("value","등록");
		btn.setAttribute("onclick","insertNotification()");
	  		
        var btn2 = document.getElementById('deleteBtn3');
        btn2.setAttribute("style","display:none");	
		
		modalOn();
}




// 파일업로드
/*
$(document).ready(function(){
    
    //use jQuery MultiFile Plugin 
    $('#multiform input[name=file]').MultiFile({
        max: 5, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
        //accept: "", //허용할 확장자(지정하지 않으면 모든 확장자 허용)
        maxfile: 1024, //각 파일 최대 업로드 크기
        maxsize: 3024,  //전체 파일 최대 업로드 크기
        STRING: { //Multi-lingual support : 메시지 수정 가능
            remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
            duplicate : "$file 은 이미 선택된 파일입니다.", 
            denied : "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
            selected:'$file 을 선택했습니다.', 
            toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)", 
            toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
            toobig: "$file 은 크기가 매우 큽니다. (max $size)"
        },
        list:"#afile3-list" //파일목록을 출력할 요소 지정가능
    });
});
*/



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
	$('#nc_no').remove();
	$('#deleteBtn2').remove();
	$('#afile3-list a').remove();
	$('#afile3-list br').remove();
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
 	// 엔터 누르면 검색
	$("#searchWord").keyup(function(e){if(e.keyCode == 13)  search(); });
	
	$("#noticePage").addClass("on");
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
		
		<div id="noticeBox">
		<div id="top">
			<div class="btnBox">
         	<button class="writeBtn" id="insertBtn" onclick="registerNotification()">등록</button>
         	<button class="writeBtn" id="updateBtn" onclick="updateModal()">수정</button>		
         	<button class="writeBtn" id="deleteBtn" onclick="deleteNotification()">삭제</button>
         	</div>
         		<div id="search">
         			<div class="searchBox">
						<input id="searchWord" type="text" class="searchForm" placeholder="제목/내용">
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
					<form id="regNotificationInfo">
					<div class="top">
						<h3 class="title">공지사항 등록</h3>
						<i class="bi bi-x" onclick="modalOff()"></i>
					</div>
					<div class="noticeInput">
						<strong class="text">제목<span class="star">*</span></strong>
						<input type="text" id="nc_title" name="nc_title" class="textBox" >
					</div>
					<div class="noticeInput" style="display: flex;">
						<strong class="text">내용<span class="star">*</span></strong>
						<textarea id="nc_content" name="nc_content" class="textBox" style="height: 150px;"></textarea>
					</div>
								
						<div class="noticeInput">
							<strong class="text">파일<span class="star">*</span></strong>
							<input type="file" name="file" />
							<div id="afile3-list" style="border:2px solid #c9c9c9;min-height:50px"></div> 
							
						</div>
					
					<div id="result"></div>		
																
						
					<div class="btnBox">					
						<input type="button" id="inputBtn" value="등록" class="btnBoxbtn" onclick="insertNotification()">
						<input type="button" id="deleteBtn3" value="삭제" class="btnBoxbtn" onclick="deleteModal()" style="display:none">						
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