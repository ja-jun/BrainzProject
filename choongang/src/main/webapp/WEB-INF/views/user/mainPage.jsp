<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><spring:message code="nav.user"/></title>
<script src="https://kit.fontawesome.com/1fa86d52d5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link href='../resources/css/user.css' rel='stylesheet' />
<link href='../resources/css/reset.css' rel='stylesheet' />
<link href="../resources/css/jquery-ui.css" rel="stylesheet"/>
<link href="../resources/css/jquery-ui.min.css" rel="stylesheet"/>

<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/ui.jqgrid2.css" />
<script src="../resources/js/grid.locale-<spring:message code='lang'/>.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script src="../resources/js/jQuery.jqGrid.setColWidth.js"></script>
<script src="../resources/js/jquery-ui.min.js"></script>

<script> 
const id = '<spring:message code="user.id"/>';
const name = '<spring:message code="user.name"/>';
const auth = '<spring:message code="user.authority"/>';
const registrant = '<spring:message code="user.registrant"/>';
const dsc = '<spring:message code="user.dsc"/>';
const lastLogin = '<spring:message code="user.lastLogin"/>';
const loadText = '<spring:message code="user.loadtext"/>';
const modifyTitle = '<spring:message code="user.modal.modifyTitle"/>';
const Ph1 = '<spring:message code="user.modifyPw.Ph1"/>';
const Ph2 = '<spring:message code="user.modifyPw.Ph2"/>';
const modifyBtn = '<spring:message code="user.modal.modifyBtn"/>';
const wrongAccess = '<spring:message code="user.modify.wrongAccess"/>';
const No = '<spring:message code="user.lastLogin.null"/>';
const checkName_Msg = '<spring:message code="user.checkName_Msg"/>';
const checkPhone_Msg1 = '<spring:message code="user.checkPhone_Msg1"/>';
const checkPhone_Msg2 = '<spring:message code="user.checkPhone_Msg2"/>';
const checkEmail_Msg1 = '<spring:message code="user.checkEmail_Msg1"/>';
const checkEmail_Msg2 = '<spring:message code="user.checkEmail_Msg2"/>';
const mod_success = '<spring:message code="user.modify.success"/>';
const checkId_Msg1 = '<spring:message code="user.checkId_Msg1"/>';
const checkId_Msg2 = '<spring:message code="user.checkId_Msg2"/>';
const checkPw_Msg1 = '<spring:message code="user.checkPw_Msg1"/>';
const checkPw_Msg2 = '<spring:message code="user.checkPw_Msg2"/>';
const checkPw_Msg3 = '<spring:message code="user.checkPw_Msg3"/>';
const reg_success = '<spring:message code="user.register.success"/>';
const checkId_alert = '<spring:message code="user.checkId_alert"/>';
const checkId_Msg3 = '<spring:message code="user.checkId_Msg3"/>';
const checkId_Msg4 = '<spring:message code="user.checkId_Msg4"/>';
const checkPw_Msg4 = '<spring:message code="user.checkPw_Msg4"/>';
const del_confirm = '<spring:message code="user.delete.confirm"/>';
const del_success = '<spring:message code="user.delete.success"/>';
const cancel = '<spring:message code="user.delete.cancel"/>';
const registerBtn = '<spring:message code="user.modal.registerBtn"/>';
const registerTitle = '<spring:message code="user.modal.registerTitle"/>';
const alert1 = '<spring:message code="user.delete.alert1"/>';
const alert2 = '<spring:message code="user.delete.alert2"/>';

//그리드 형식            
function createAndInitGrid(){
    $("#list").jqGrid({
    	colModel: [   
   			{name: 'user_id', label: id, align:'left', width:'30%'},
            {name: 'name', label: name, align:'left', width:'30%'},
            {name: 'parent_name', label: registrant, align:'center', width:'30%'},
            {name: 'dsc', label: dsc, align:'left', width:'50%'},
            {name: 'last_login', label: lastLogin, align:'center', formatter:dateFormatter, width:'40%'},
            {name: 'user_no', label: '사용자번호', hidden:true}
            ],
        pager: '#pager',
        rowNum: 10,
        rowList: [10,30,50],
        viewrecords: true,
        multiselect: true,
        multiselectWidth: 100,
        //등록시 인코드
		autoencode : 'true',
        //Data 연동 부분
        url : "/choongang/user/getUserList",
        datatype : "JSON", //받을 때 파싱 설정
        postData : {}, //....
        mtype : "POST",
        loadtext : loadText,
        height: 'auto',
		autowidth:true,
		loadComplete : function(data){
			$("#nullData").remove();
			if(data.rows.length == 0){
				$(".ui-jqgrid-bdiv").append("<div id='nullData'><img src='../resources/img/external.png' class='dataI'><p class='dataP'>검색결과가 없습니다</p></div>");
			}
		},
		beforeSelectRow: function(rowid, e){
			i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
			cm = $(this).jqGrid('getGridParam','colModel');
			return (cm[i].name === 'cb');
		},
		
		
		// 수정 띄우기
		ondblClickRow: function(rowId) {
            var rowData = $("#list").getRowData(rowId);
            var user_no = rowData.user_no;
            
            $.ajax({
	    	     url: "./getUser",
	    	     type: "post",
	    	     data: {user_no : user_no},
	    	  	 success: function(data){
					var user = data.user;		    	  		 
	    	  		 
		            var title = document.querySelector('.title');
		            title.innerText = modifyTitle;
	    	  		
		            var user_no = document.createElement('input');
		            user_no.setAttribute('type','hidden');
		            user_no.setAttribute('name','user_no');
		            user_no.setAttribute('id','user_no');
		            user_no.setAttribute('value', user.user_no);
		            $('#regUserInfo').append(user_no); 
		            
		            $('#user_id').val(user.user_id);
		            $('#user_id').attr("disabled", "disabled");
   					$('.id_check_button').hide();
		            $('#check_sucess_icon').hide();
		            $('#user_pw').val();
		            $('#user_pw').attr("placeholder", Ph1);
		            $('#user_pw2').val();
		            $('#user_pw2').attr("placeholder", Ph2);
		            $('#name').val(user.name);
	    	  		$('#authority').val(user.authority);
	    	  		$('#phone').val(user.phone);
	    	  		$('#email').val(user.email);
	    	  		$('#dsc').val(user.dsc);
	    	  		
	    	  		
	    	  		
	    	  		var btn = document.getElementById('inputBtn');
		            btn.setAttribute("value", modifyBtn);
		            btn.setAttribute("onclick","updateUser()"); 
	    	  		
	    	  		modalOn();
	    	  		
				},
		        error: function() {
		        	alert(wrongAccess);
		        }
			});	     
            $("#user_no").remove();          	
        }
 });	
};

// 최종 로그인 시간 형 변환
var dateFormatter = function(cellvalue, options, rowObject) {
	var new_format_value='';
		 
	var date = new Date(cellvalue); //현재 시간
		  	 
	if(cellvalue == null) {
		new_format_value = No;
	} else {	
		new_format_value = date.getFullYear() + "."
		+ (date.getMonth() + 1).toString().padStart(2,'0') + "."
		+ date.getDate().toString().padStart(2,'0') + "  ("
		+ (date.getHours()).toString().padStart(2,'0') + ":"
		+ date.getMinutes().toString().padStart(2,'0') + ")";  
	} 
	
	return new_format_value;
}

// 수정 유효성 체크
function updCheck(target){
	var result = 1;
	
	if(target.getAll('name') == ''){
		$('#checkName_Msg').html( checkName_Msg );
        $('#checkName_Msg').attr("style", "color: red");
		result = 0;
	}
	
	if(target.getAll('phone') == ''){
		$('#checkPhone_Msg').html( checkPhone_Msg1 );
        $('#checkPhone_Msg').attr("style", "color: red");
		result = 0;
	} else {
		var checkPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
        
		if (!checkPhone.test(target.getAll('phone'))) {
        	$('#checkPhone_Msg').html( checkPhone_Msg2 );
            $('#checkPhone_Msg').attr("style", "color: red");
    		result = 0;	
		}
	}		
	
	if(target.getAll('email') == ''){
		$('#checkEmail_Msg').html( checkEmail_Msg1 );
        $('#checkEmail_Msg').attr("style", "color: red");
		result = 0;
	} else {
		var checkEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
        if (!checkEmail.test(target.getAll('email'))) {
        	$('#checkEmail_Msg').html( checkEmail_Msg2 );
            $('#checkEmail_Msg').attr("style", "color: red");
    		result = 0;	
		} 
	}
	
	return result;
}
// 수정 사용자 넘기기
function updateUser(){	
	var formData = new FormData(document.getElementById('regUserInfo'));
	
	if(updCheck(formData) == 0){
		return;
	} else {
		 $.ajax({
		    url: "/choongang/user/updateUser",
		    type: "post",
		    processData: false,
		    contentType: false,
		    data: formData
		}).done(function(){
			$("#list").trigger('reloadGrid');
			modalOff();
			alert( mod_success );
		});	
	}
}
//검색시 사용자 가져와서 집어넣기
function search(){
	var searchWord = document.getElementById("searchWord").value;	
	$("#list").jqGrid("clearGridData", true);		
	$("#list")
	.setGridParam({
		url : "./getUserList",
		mtype : "post",
		postData : {searchWord : searchWord},
		dataType : "json",
	})
	.trigger("reloadGrid");			
}
// 사용자 등록 유효성 체크
function regCheck(target){
	
	var result = 1;
	
	if(target.getAll('user_id') == ''){
		$('#checkId_Msg').html( checkId_Msg1 );
        $('#checkId_Msg').attr("style", "color: red");
        result = 0;
	} else {
		if(confirmedId == false) {
			$('#checkId_Msg').html( checkId_Msg2 );
	        $('#checkId_Msg').attr("style", "color: red");
	        result = 0;
		} 
	} 
	
	if(target.getAll('user_pw') == ''){
		$('#checkPw_Msg').html( checkPw_Msg1 );
        $('#checkPw_Msg').attr("style", "color: red");
		result = 0;
	} 
	
	if($('#user_pw2').val() == ''){
		$('#checkPw_Msg2').html( checkPw_Msg2 );
        $('#checkPw_Msg2').attr("style", "color: red");
		result = 0;
	} 
	
	if(target.getAll('user_pw') != $('#user_pw2').val()){
		$('#checkPw_Msg2').html( checkPw_Msg3 );
        $('#checkPw_Msg2').attr("style", "color: red");
		result = 0;
	} 
	
	if(target.getAll('name') == ''){
		$('#checkName_Msg').html( checkName_Msg );
        $('#checkName_Msg').attr("style", "color: red");
		result = 0;
	} 
	
	if(target.getAll('phone') == ''){
		$('#checkPhone_Msg').html( checkPhone_Msg1 );
        $('#checkPhone_Msg').attr("style", "color: red");
		result = 0;
	} else {
		
		var checkPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
        
		if (!checkPhone.test(target.getAll('phone'))) {
        	$('#checkPhone_Msg').html( checkPhone_Msg2 );
            $('#checkPhone_Msg').attr("style", "color: red");
    		result = 0;	
		}
	}		
	
	
	if(target.getAll('email') == ''){
		$('#checkEmail_Msg').html( checkEmail_Msg1 );
        $('#checkEmail_Msg').attr("style", "color: red");
		result = 0;
	} else {
		var checkEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
        if (!checkEmail.test(target.getAll('email'))) {
        	$('#checkEmail_Msg').html( checkEmail_Msg2 );
            $('#checkEmail_Msg').attr("style", "color: red");
    		result = 0;	
		} 
	}
	
	return result;
}
//사용자 등록
function registerUser(){
	var formData = new FormData(document.getElementById('regUserInfo'));
	
	//input태그의 name과 vo변수명이 같을때 자동으로 들어간다
	if(regCheck(formData) == 0){
		return;
	} else {
		
		 $.ajax({
		     url: "/choongang/user/registerUser",
		     type: "post",
		     processData: false,
		     contentType: false,
		     data: formData
		 }).done(function(){
				$("#list").trigger('reloadGrid');
				modalOff();
				alert( reg_success );
		 });	 
		
	}
}


var confirmedId = false;

//id 중복확인
function id_check() {
	$('.input_id').change(function () {
		$('#check_sucess_icon').hide();
		$('.id_check_button').show();
		$('.input_id').attr("check_result", "fail");
	})
	if ($('.input_id').val() == '') {
		$('#checkId_Msg').html( checkId_alert );
		return;
	}
	
	let id = $('.input_id').val();
	$.ajax({
		url: "/choongang/user/isExistId",
		data: {'id': id},
		datatype: 'json',
		success: function (data) {
			if (data.result == false) {
				$('#checkId_Msg').html( checkId_Msg3 );
				$('#checkId_Msg').attr("style", "color: red");
				confirmedId = true;
				return;
			} else {
				$('#checkId_Msg').html( checkId_Msg4 );
				$('#checkId_Msg').attr("style", "color: #0b5fda");
				$('.input_id').attr("check_result", "success");
				$('#check_sucess_icon').show();
				$('.id_check_button').hide();
				confirmedId = true;
				return;
			}
		}
	});
}
 
//비밀번호 확인 메세지
$(function(){
	$('#user_id').keyup(function(){
	     $('#checkId_Msg ').html('');
	   });
	
	$('#user_pw').keyup(function(){
	     $('#checkPw_Msg ').html('');
	   });
	
	$('#user_pw2').keyup(function(){
	     $('#checkPw_Msg2 ').html('');
	   });
	 	
	$('#name').keyup(function(){
      $('#checkName_Msg ').html('');
    });
	
	$('#phone').keyup(function(){
      $('#checkPhone_Msg ').html('');
    });
	
	$('#email').keyup(function(){
      $('#checkEmail_Msg ').html('');
    });
    $('#user_pw2').keyup(function(){
        if($('#user_pw').val() != $('#user_pw2').val()){
          $('#checkPw_Msg2').html( checkPw_Msg3 );
          $('#checkPw_Msg2').attr("style", "color: red");
        } else{
          $('#checkPw_Msg2').html( checkPw_Msg4 );
          $('#checkPw_Msg2').attr("style", "color: blue");
        }
    });
    
    $('#user_pw').keyup(function(){
        if($('#user_pw2').val() != $('#user_pw').val()){
          $('#checkPw_Msg2').html( checkPw_Msg3 );
          $('#checkPw_Msg2').attr("style", "color: red");
        } else{
          $('#checkPw_Msg2').html( checkPw_Msg4 );
          $('#checkPw_Msg2').attr("style", "color: blue");
        }
    });
});

//권한 넘기기
function deleteChangeUser(){
	var userNos = [];
	var rowids = $("#list").getGridParam("selarrrow");
	var currentPage = $("#list").getGridParam("page");  
	for (let i = 0; i < rowids.length; i++) {
        const rowid = rowids[i];
        var rowData = $("#list").getRowData(rowid);
        var user_no = rowData.user_no
        if(user_no == ${userInfo.user_no}){
        	alert( alert1 );
        	return;
        }
		userNos.push(rowData.user_no);
    }
	
	if(userNos.length == 0){
		alert( alert2 );
		return;
	}
	
	$('#deleteModalBack').show();
	
	$('#selectUser').empty();
	
	$.ajax({
		url: "./getSelectUserList",
		type: "POST",
		contentType: 'application/json',
		data: JSON.stringify(userNos),
		success: function(data){
			var selectUserList = data.selectUserList;
			
			var selectUser = $('#selectUser');
			selectUser.append($('<option value="' + ${userInfo.user_no} + '">본인</option>'));
			
			selectUserList.forEach(function(item, index){
				var user = $('<option value="' + item.user_no + '">' + item.name + '</option>');
				selectUser.append(user);
			});
		}
	});
}

//삭제
function deleteUser(){ 
	$('#deleteModalBack').hide();
	var userNos = [];
	var rowids = $("#list").getGridParam("selarrrow");
	var currentPage = $("#list").getGridParam("page");  
	for (let i = 0; i < rowids.length; i++) {
        const rowid = rowids[i];
        var rowData = $("#list").getRowData(rowid);
		userNos.push(rowData.user_no);
    }
	
	var changeManager = $('#selectUser').val();
	console.log(changeManager);
	
	// $("#list").jqGrid("clearGridData", true);		
	if(confirm( del_confirm ) == true ){
		var text = "";
 		$.ajax({
			url: "./deleteUser",
			type: "post",
			traditional: true,
			data: {param: userNos, changeManager: changeManager}
	 	}).done(function(){
	 		$('#list').jqGrid('setGridParam', {page:currentPage}).trigger('reloadGrid');
	 	}); alert( del_cancel);
	}else{
		$("#list").trigger('reloadGrid');
		alert( cancel );
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
	$('#deleteModalBack').hide();
    modal.style.display = "none";
	document.getElementById("regUserInfo").reset();  //입력했던 값 지우기
	document.getElementById("checkId_Msg").innerText="";
	document.getElementById("checkPw_Msg").innerText="";
	document.getElementById("checkPw_Msg2").innerText="";
	document.getElementById("checkName_Msg").innerText="";
	document.getElementById("checkPhone_Msg").innerText="";
	document.getElementById("checkEmail_Msg").innerText="";
	
	var btn = document.getElementById('inputBtn');
    btn.setAttribute("value", registerBtn );
    btn.setAttribute("onclick","registerUser()");
    
    
    $('#user_id').attr("disabled",false);
    $('#check_sucess_icon').hide();
    $('.id_check_button').show();
    $('#id_check_button').attr("disabled",false);
    $('#user_pw').removeAttr('placeholder');
    $('#user_pw2').removeAttr('placeholder');
    var title = document.querySelector('.title');
    title.innerText= registerTitle;
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
	
	$("#userPage").addClass("on");
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
		
		<div id="userBox">
		<div id="top">
			<div class="btnBox">
         	<button class="writeBtn" id="insertBtn" onclick="modalOn()"><spring:message code="user.view.registerBtn"/></button>
         	<button class="writeBtn" id="deleteBtn" onclick="deleteChangeUser()"><spring:message code="user.view.deleteBtn"/></button>
         	</div>
         		<div id="search">
         			<div class="searchBox">
						<input id="searchWord" type="text" class="searchForm" placeholder="<spring:message code="user.view.searchPh"/>">
						<button class="searchBtn" onclick="search()"><spring:message code="user.view.search"/></button>
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
			<form id="regUserInfo">
			<div class="top">
				<h3 class="title"><spring:message code="user.modal.registerTitle"/></h3>
				<i class="bi bi-x" onclick="modalOff()"></i>
			</div>
			<div class="bottom">
			<div class="userInput">
				<strong class="text"><spring:message code="user.modal.registerId"/><span class="star">*</span></strong>
				<input type="text" id="user_id" name="user_id" class="input_id" onblur="id_check()" check_result="fail" required />
				<div id="checkId_Msg" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text"><spring:message code="user.modal.registerPw1"/><span class="star">*</span></strong>
				<input type="password" id="user_pw" name="user_pw" class="textBox"><br>
				<div id="checkPw_Msg" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text"><spring:message code="user.modal.registerPw2"/><span class="star">*</span></strong>
				<input type="password" id="user_pw2" class="textBox"><br>
				<div id="checkPw_Msg2" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text"><spring:message code="user.modal.registerName"/><span class="star">*</span></strong>
				<input type="text" id="name" name="name" class="textBox"><br>
				<div id="checkName_Msg" class="confirmAlertBox"></div>
			</div>
			<!-- <div class="userInput">
				<strong class="text"><spring:message code="user.modal.auth"/><span class="star">*</span></strong>
				<select form="regUserInfo" id="authority" name="authority" class="selectBox" >
					<option value="ROLE_ADMIN">관리자</option>
					<option value="ROLE_USER">사용자</option>
				</select>
			</div> -->
			<div class="userInput">
				<strong class="text"><spring:message code="user.modal.phone"/><span class="star">*</span></strong>
				<input type="text" id="phone" name="phone" class="textBox" ><br>
				<div id="checkPhone_Msg" class="confirmAlertBox"></div>
			</div>
			
			<div class="userInput">
				<strong class="text"><spring:message code="user.modal.email"/><span class="star">*</span></strong>
				<input type="text" id="email" name="email" class="textBox"><br>
				<div id="checkEmail_Msg" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text"><spring:message code="user.modal.desc"/></strong>
				<input type="text" id="dsc" name="dsc" class="textBox">
			</div>
			<ul class="btnList">
				<li class="btnLi"><input type="button" id="inputBtn" value="<spring:message code='user.view.registerBtn'/>" class="writeBtn2" onclick="registerUser()" ></li>
				<li class="btnLi"><input type="button" value="<spring:message code='noti.close'/>" class="writeBtn2" onclick="modalOff()" ></li>
			</ul>
			</div>
			</form>

		<!-- Form 태그 종료 -->
		</div>
	</div>
</div>

<div id="deleteModalBack">
	<div class="deleteModal">
		<div class="deleteBox">
			
			<div class="top">
				<h3 class="topTitle"><spring:message code="user.modal.deletetitle"/></h3>
				<i class="bi bi-x" onclick="modalOff()"></i>
			</div>
			<img src="../resources/img/trash2.png" class="trash">
			<p class="text"><spring:message code="user.modal.deletecheck"/></p>
			<select id="selectUser" name="changeManager" class="selectUserBox" >
            </select>
			<ul class="btnList">
				<li class="btnLi"><input type="button" value='<spring:message code="user.modal.cancle"/>' class="writeBtn2" onclick="modalOff()"></li>
				<li class="btnLi"><input type="button" value='<spring:message code="user.view.deleteBtn"/>' class="writeBtn2" onclick="deleteUser()"></li>
			</ul>
		</div>
	</div>
</div>
   
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>