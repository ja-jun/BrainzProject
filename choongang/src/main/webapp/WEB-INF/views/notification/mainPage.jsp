<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><spring:message code="nav.notification"/></title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/1fa86d52d5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link href='../resources/css/notification.css' rel='stylesheet'/>
<link href='../resources/css/reset.css' rel='stylesheet'/>
<link href="../resources/css/jquery-ui.css" rel="stylesheet"/>
<link href="../resources/css/jquery-ui.min.css" rel="stylesheet"/>

<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/noticeGrid.css" />
<script src='../resources/js/grid.locale-<spring:message code="lang"/>.js'></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script src="../resources/js/jQuery.jqGrid.setColWidth.js"></script>
<script src="../resources/js/jquery-ui.min.js"></script>
<script>
const number = '<spring:message code="noti.number"/>';
const title = '<spring:message code="noti.title"/>';
const file = '<spring:message code="noti.file"/>';
const write_date = '<spring:message code="noti.writedate"/>';
const writer = '<spring:message code="noti.writer"/>';
const readCount = '<spring:message code="noti.readCount"/>';
const loading = '<spring:message code="noti.loading"/>';
const registerd = '<spring:message code="noti.registered"/>';
const modified = '<spring:message code="noti.modified"/>';
const modified1 = '<spring:message code="noti.modified1"/>';
const modified2 = '<spring:message code="noti.modified2"/>';
const title_modification = '<spring:message code="noti.title.modification"/>';
const modify_btn = '<spring:message code="noti.modification"/>';
const remove1 = '<spring:message code="noti.remove1"/>';
const remove2 = '<spring:message code="noti.remove2"/>';
const cancel = '<spring:message code="noti.cancel"/>';
const reg = '<spring:message code="noti.registration"/>';
const reg2 = '<spring:message code="noti.registration2"/>';
const fileselect = '<spring:message code="noti.fileselect"/>';
const fileselect2 = '<spring:message code="noti.fileselect2"/>';

function createAndInitGrid(){
    $("#list").jqGrid({
         colModel: [   
		            {name: 'nc_no', label : number, align:'center', width:'15%'},
		            {name:'nc_title', label: title, align:'left', width:'70%'},
		            {name: 'file_no', label : file, align:'center', width:'10%', formatter: imageFormatter},
		            {name: 'nc_writeDate', label : write_date, align:'center', width:'30%'},              
		            {name: 'name', label : writer, align:'center', width:'30%'},
		            {name: 'nc_readCount', label : readCount, align:'center', width:'20%'}
              	   ],
		              pager: '#pager',
		              rowNum: 10,
		              rowList: [10,30,50],
		              viewrecords: true,
		              multiselect: true,
		              multiselectWidth: 70,
		              //등록시 인코드
		  			  autoencode : 'true',
		              //Data 연동 부분
		              url : "/choongang/notification/getNotificationList",
		              datatype : "JSON", //받을 때 파싱 설정
		              postData : {}, //....
		              mtype : "POST",
		              loadtext : loading,
		  	          height: 'auto',
		  			  autowidth:true,  			 
		  			  loadComplete : function(data){
						$("#nullData").remove();
						if(data.rows.length == 0){
							$(".ui-jqgrid-bdiv").append("<div id='nullData'><img src='../resources/img/external.png' class='dataI'><p class='dataP'>검색결과가 없습니다</p></div>");
						}
					   },
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
	if(cellValue == null){
		   return '';
		} else {
		   return '<a href="/choongang/notification/download?file_no=' + cellValue + '"><img src="../resources/img/download.png" /></a>';
		}
	
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
	 }).done(function(data){
		 if(data.result == 0){
			 alert(fileselect2);
		 }
			$("#list").trigger('reloadGrid');
			modalOff();
			alert( registerd );
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
		alert( modified );
	});	
}

// 수정 모달창
function updateModal() {
	
	var rowIds = $('#list').getGridParam('selarrrow');
	
	if(rowIds.length > 1){
		alert( modified1 );
		return;
	} else if(rowIds.length == 0){
		alert( modified2 )
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
	            title.innerText = title_modification;
  	  		
            var nc_no = document.createElement('input');
          	nc_no.setAttribute('type','hidden');
      	  	nc_no.setAttribute('name','nc_no');
      		nc_no.setAttribute('id','nc_no');
    		nc_no.setAttribute('value',notification.nc_no);
            $('#regNotificationInfo').append(nc_no); 
	            
  	  		$('input[name=nc_title]').val(notification.nc_title);
  	  		$('textarea[name=nc_content]').val(notification.nc_content);
  	  		
  	  		var btn = document.getElementById('inputBtn');
	            btn.setAttribute("value",modify_btn);
	            btn.setAttribute("onclick","updateNotification()");
  	  		
	        var btn2 = document.getElementById('deleteBtn3');
            btn2.setAttribute("style","display:block");		
            
            $.each(data.fileVo, function(index, item){
				$('#fileBox').empty();
            	
            	var strong = $('<strong class="text"> <spring:message code="noti.file"/> </strong>');
            	
            	var div = $('<div class="upload-name"></div>');
            	var a = $("<a href='/choongang/notification/download?file_no=" + item.file_no + "' download>" + item.fileName + "</a>");
            	// var img = $("<img src='../resources/img/delete.png'>");
            	div.append(a);
            	// div.append(img);
            	
            	var button = $('<button class="filename" style="background:#e88790" onclick="createFileBtn()"><spring:message code="noti.remove"/></button>');
            	
            	$('#fileBox').append(strong);
            	$('#fileBox').append(div);
            	$('#fileBox').append(button);
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

         if(confirm( remove1 ) == true ){
       	  var text = "";
			 $.ajax({
			     url: "/choongang/notification/deleteNotification",
			     type: "post",
			     contentType:'application/json',
			     data: JSON.stringify(notificationNos)
			 }).done(function(){
					$("#list").trigger('reloadGrid');
					modalOff();
					alert( remove2 );
			 });
		 }else{
				   alert( cancel );
		 }
}

// 삭제 모달
function deleteModal() {
		
	var notificationNos = [];
	
	var nc_no = $("#nc_no").val();
    notificationNos.push(nc_no);

	if(confirm( remove1 ) == true ){
     	 var text = "";
		
		 $.ajax({
		     url: "/choongang/notification/deleteNotification",
		     type: "post",
		     contentType:'application/json',
		     data: JSON.stringify(notificationNos)
		 }).done(function(){
				$("#list").trigger('reloadGrid');
				modalOff();
				alert( remove2 );
		 });
	 	}else{
			   alert( cancel );
	 	}	
}

// 등록 모달
function registerNotification(){
		var title = document.querySelector('.title');
		title.innerText=reg;
		
		var btn = document.getElementById('inputBtn');
        btn.setAttribute("value",reg2);
		btn.setAttribute("onclick","insertNotification()");
	  		
        var btn2 = document.getElementById('deleteBtn3');
        btn2.setAttribute("style","display:none");
        
        $('#fileBox').empty();
        createFileBtn();
		
		modalOn();
}

//파일 창 생성 및 삭제
function createFileBtn(){
	$('#fileBox').empty();
	
	var strong = $('<strong class="text"> <spring:message code="noti.file"/> </strong>');
	var input = $('<input class="upload-name" value="<spring:message code="noti.fileselect"/>">');
	var label = $('<label for="ex_filename" class="filename"><spring:message code="noti.fileselect"/></label>');
	var input_label = 
		$('<input type="file" name="file" id="ex_filename" onchange="insertSelectedFileName()" accept=".bmp, .gif, .jpeg, .jpg, .png, .psd, .pic, .raw, .tiff, .avi, .flv, .mkv, .mov, .mp3, .mp4, .wav, .wma, .doc,  .docx, .xls, .xlsx, .ppt, .pptx,  .html,  .hwp, .pdf, .txt"/>');
	
	$('#fileBox').append(strong);
	$('#fileBox').append(input);
	$('#fileBox').append(label);
	$('#fileBox').append(input_label);
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
	$('#nc_no').remove();
	$('#deleteBtn2').remove();
	$('#afile3-list a').remove();
	$('#afile3-list br').remove();
}

function insertSelectedFileName(){
	var fileName = $("#ex_filename").val();
		 
	 var fileExtension = '.bmp, .gif, .jpeg, .jpg, .png, .psd, .pic, .raw, .tiff, .avi, .flv, .mkv, .mov, .mp3, .mp4, .wav, .wma, .doc,  .docx, .xls, .xlsx, .ppt, .pptx,  .html,  .hwp, .pdf, .txt';
	 
	 if(fileExtension.lastIndexOf(fileName.substring(fileName.lastIndexOf('.'))) != -1){
		  $(".upload-name").val(fileName);			 
	 } else {
		 alert( fileselect2 );
		 createFileBtn();
	 }				
}

//모달창 열렸을 때 ESC누르면 닫힘
window.addEventListener("keyup", e => {
    if(isModalOn() && e.key === "Escape") { modalOff(); }
})

window.addEventListener("DOMContentLoaded", function(){
	createAndInitGrid();
	const modal = document.getElementById("modal");

 	// 엔터 누르면 검색
	$("#searchWord").keyup(function(e){if(e.keyCode == 13)  search(); });
	
	$("#noticePage").addClass("on");
	
	$("#ex_filename").on('change',function(){
		
		 var fileName = $("#ex_filename").val();
		
		 /* var fileLength = fileName.lastIndexOf('.');
		 
		 var fileExtension = '.bmp, .gif, .jpeg, .jpg, .png, .psd, .pic, .raw, .tiff, .avi, .flv, .mkv, .mov, .mp3, .mp4, .wav, .wma, .doc,  .docx, .xls, .xlsx, .ppt, .pptx,  .html,  .hwp, .pdf, .txt';
		 
		 if(fielExtension.lastIndexOf(fileName.subString(fileName.lastIndexOf('.'))) != -1){
			  $(".upload-name").val(fileName);			 
		 } else {
			 alert( fileselect2 );
			 createFileBtn();
		 } */
		 $(".upload-name").val(fileName);
	});
	
});

</script>

</head>
<body>
		<jsp:include page="../common/nav.jsp"></jsp:include>
	
	<div id="container">
		<div id="box">
		
		
		<div id="gnb">
			<div class="iconBox">
			<img src="../resources/img/profile.png" class="profile">
				<div class="icon">
				<p class="iconText" style="font-size: 18px">${userInfo.name }</p>
				</div>
				<a href="/choongang/security_logout"><i class="fa-solid fa-right-from-bracket" style=" margin-left: 16px; font-size: 22px; padding-top: 2px;"></i></a>
			</div>
		</div>
		
		<div id="noticeBox">
		<div id="top">
			<div class="btnBox">
         	<button class="writeBtn" id="insertBtn" onclick="registerNotification()"><spring:message code="noti.registration2"/></button>
         	<button class="writeBtn" id="updateBtn" onclick="updateModal()"><spring:message code="noti.modification"/></button>		
         	<button class="writeBtn" id="deleteBtn" onclick="deleteNotification()"><spring:message code="noti.remove"/></button>
         	</div>
         		<div id="search">
         			<div class="searchBox">
						<input id="searchWord" type="text" class="searchForm" placeholder='<spring:message code="noti.search"/>'>
						<button class="searchBtn" onclick="search()"><spring:message code="noti.search2"/></button>
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
						<h3 class="title"><spring:message code="noti.registration"/></h3>
						<i class="bi bi-x" onclick="modalOff()"></i>
					</div>
					<div class="noticeInput">
						<strong class="text"><spring:message code="noti.title"/><span class="star">*</span></strong>
						<input type="text" id="nc_title" name="nc_title" class="textBox" >
					</div>
					<div class="noticeInput" style="display: flex;">
						<strong class="text"><spring:message code="noti.content"/><span class="star">*</span></strong>
						<textarea id="nc_content" name="nc_content" class="textBox" style="height: 240px;"></textarea>
					</div>
								
						<div id="fileBox" class="noticeInput">
							<strong class="text"><spring:message code="noti.file"/></strong>
							<input class="upload-name" value='<spring:message code="noti.fileselect"/>'>
							<label for="ex_filename" class="filename"><spring:message code="noti.fileselect"/></label>
							<input type="file" name="file" id="ex_filename" accept=".bmp, .gif, .jpeg, .jpg, .png, .psd, .pic, .raw, .tiff, .avi, .flv, .mkv, .mov, .mp3, .mp4, .wav, .wma, .doc,  .docx, .xls, .xlsx, .ppt, .pptx,  .html,  .hwp, .pdf, .txt"/>
						</div>
					
					<div id="result"></div>		
																
						
					<div class="btnBox2">					
						<input type="button" id="inputBtn" value='<spring:message code="noti.registration2"/>' class="writeBtn2" onclick="insertNotification()">
						<input type="button" id="deleteBtn3" value='<spring:message code="noti.remove"/>' class="writeBtn2" onclick="deleteModal()" style="display:none">						
						<input type="button" name="" value='<spring:message code="noti.close"/>' class="writeBtn2" onclick="modalOff()" >					
					</div>
					</form>					
					<!-- Form 태그 종료 -->
					
				</div>
			</div>
		</div>
			
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>