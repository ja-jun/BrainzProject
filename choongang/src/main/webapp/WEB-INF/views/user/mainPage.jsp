<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script src="../resources/js/jQuery.jqGrid.setColWidth.js"></script>
<script src="../resources/js/jquery-ui.min.js"></script>

<script> 
            
//그리드 형식            
function createAndInitGrid(){
    $("#list").jqGrid({
    	colModel: [   
   			{name: 'user_id', label : '아이디', align:'left'},
            {name: 'name', label:'이름', align:'left'},
            {name: 'authority', label : '권한', align:'center'},
            {name: 'dsc', label : '설명', align:'left'},
            {name: 'last_login', label : '최종 로그인 시간', align:'center', formatter:dateFormatter},
            {name: 'user_no', label : '사용자번호', hidden:true}
            ],
        pager: '#pager',
        rowNum: 10,
        rowList: [10,30,50],
        viewrecords: true,
        multiselect: true,
        //등록시 인코드
		autoencode : 'true',
        //Data 연동 부분
        url : "/choongang/user/getUserList",
        datatype : "JSON", //받을 때 파싱 설정
        postData : {}, //....
        mtype : "POST",
        loadtext : "로딩중...",
        width:1573,
        height: 'auto',
		autowidth:true,
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
		            title.innerText="사용자 수정";
	    	  		
		            var user_no = document.createElement('input');
		            user_no.setAttribute('type','hidden');
		            user_no.setAttribute('name','user_no');
		            user_no.setAttribute('id','user_no');
		            user_no.setAttribute('value',user.user_no);
		            $('#regUserInfo').append(user_no); 
		            
		            $('#user_id').val(user.user_id);
		            $('#user_id').attr("disabled", "disabled");
		            $('#id_check_button').attr("disabled", "disabled");
		            $('#user_pw').val();
		            $('#user_pw').attr("placeholder", "비밀번호 미입력시 기존 비밀번호로 등록됩니다.");
		            $('#user_pw2').val();
		            $('#user_pw2').attr("placeholder", "비밀번호 미입력시 기존 비밀번호로 등록됩니다.");
		            $('#name').val(user.name);
	    	  		$('#authority').val(user.authority);
	    	  		$('#phone').val(user.phone);
	    	  		$('#email').val(user.email);
	    	  		$('#dsc').val(user.dsc);
	    	  		
	    	  		
	    	  		var btn = document.getElementById('inputBtn');
		            btn.setAttribute("value","수정");
		            btn.setAttribute("onclick","updateUser()"); 
	    	  		
	    	  		modalOn();
	    	  		
				},
		        error: function() {
		        	alert("잘못된 접근입니다.");
		        }
			});	     
                     	
        }

 });	
};

var dateFormatter = function(cellvalue, options, rowObject) {
	var new_format_value='';
		 
	var date = new Date(cellvalue);
		  	 
	if(date== "Thu Jan 01 1970 09:00:00 GMT+0900 (한국 표준시)") {
		new_format_value= "접속기록 없음"	
	} else {	
		new_format_value = date.getFullYear() + "."
		+ (date.getMonth() + 1).toString().padStart(2,'0') + "."
		+ date.getDate().toString().padStart(2,'0') + "  ("
		+ (date.getHours() + 9).toString().padStart(2,'0') + ":"
		+ date.getMinutes().toString().padStart(2,'0') + ")";  
	} 
	
	return new_format_value;
}

// 수정 유효성 체크
function updCheck(target){
	var result = 1;
	
	if(target.getAll('name') == ''){
		$('#checkName_Msg').html('이름을 입력해주세요.');
        $('#checkName_Msg').attr('color', '#ff0000');
		result = 0;
	}
	
	if(target.getAll('phone') == ''){
		$('#checkPhone_Msg').html('연락처를 입력해주세요.');
        $('#checkPhone_Msg').attr('color', '#ff0000');
		result = 0;
	} else {
		var checkPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
        
		if (!checkPhone.test(target.getAll('phone'))) {
        	$('#checkPhone_Msg').html('전화번호 형식이 올바르지 않습니다.');
            $('#checkPhone_Msg').attr('color', '#ff0000');
    		result = 0;	
		}
	}		
	
	if(target.getAll('email') == ''){
		$('#checkEmail_Msg').html('이메일을 입력해주세요.');
        $('#checkEmail_Msg').attr('color', '#ff0000');
		result = 0;
	} else {
		var checkEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
        if (!checkEmail.test(target.getAll('email'))) {
        	$('#checkEmail_Msg').html('이메일 형식이 올바르지 않습니다.');
            $('#checkEmail_Msg').attr('color', '#ff0000');
    		result = 0;	
		} 
	}
	
	return result;
}

// 수정 서버 넘기기
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
			alert("수정되었습니다.");
		});	
	}
}

//검색시 서버 가져와서 집어넣기
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
		$('#checkId_Msg').html('아이디를 입력해주세요.');
        $('#checkId_Msg').attr('color', '#ff0000');
        result = 0;
	} 
	
	if(target.getAll('user_pw') == ''){
		$('#checkPw_Msg').html('비밀번호를 입력해주세요.');
        $('#checkPw_Msg').attr('color', '#ff0000');
		result = 0;
	} 
	
	if($('#user_pw2').val() == ''){
		$('#checkPw_Msg2').html('비밀번호 확인을 입력해주세요.');
        $('#checkPw_Msg2').attr('color', '#ff0000');
		result = 0;
	} 
	
	if(target.getAll('name') == ''){
		$('#checkName_Msg').html('이름을 입력해주세요.');
        $('#checkName_Msg').attr('color', '#ff0000');
		result = 0;
	} 
	
	
	if(target.getAll('phone') == ''){
		$('#checkPhone_Msg').html('연락처를 입력해주세요.');
        $('#checkPhone_Msg').attr('color', '#ff0000');
		result = 0;
	} else {
		
		var checkPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
        
		if (!checkPhone.test(target.getAll('phone'))) {
        	$('#checkPhone_Msg').html('전화번호 형식이 올바르지 않습니다.');
            $('#checkPhone_Msg').attr('color', '#ff0000');
    		result = 0;	
		}
	}		
	
	
	if(target.getAll('email') == ''){
		$('#checkEmail_Msg').html('이메일을 입력해주세요.');
        $('#checkEmail_Msg').attr('color', '#ff0000');
		result = 0;
	} else {

		var checkEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
        if (!checkEmail.test(target.getAll('email'))) {
        	$('#checkEmail_Msg').html('이메일 형식이 올바르지 않습니다.');
            $('#checkEmail_Msg').attr('color', '#ff0000');
    		result = 0;	
		} 
	}
	
	return result;
}

//사용자 등록
function registerUser(){
	var formData = new FormData(document.getElementById('regUserInfo'));
	console.log(formData.getAll('user_pw'));
	console.log(formData.getAll('dsc'));
	
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
				alert("등록되었습니다.");
		 });	 
		
	}
}

//id 중복확인
function id_check() {
	$('.input_id').change(function () {
		$('#check_sucess_icon').hide();
		$('.id_check_button').show();
		$('.input_id').attr("check_result", "fail");
	})
	if ($('.input_id').val() == '') {
		alert('아이디를 입력해주세요.')
		return;
	}
	
	let id = $('.input_id').val();
	$.ajax({
		url: "/choongang/user/isExistId",
		data: {'id': id},
		datatype: 'json',
		success: function (data) {
			if (data.result == false) {
				$('#checkId_Msg').html('이미 존재하는 아이디 입니다.');
				$('#checkId_Msg').attr('color', '#ff0000');
				return;
			} else {
				$('#checkId_Msg').html('사용가능한 아이디 입니다.');
				$('#checkId_Msg').attr('color', '#0000FF');
				$('.input_id').attr("check_result", "success");
				$('#check_sucess_icon').show();
				$('.id_check_button').hide();
				return;
			}
		}
	});
}

 //그리드에 값 집어넣기          
function renderGridByDatas(datas){
	var jsonArr = [];
    for (var i = 0; i < datas.length; i++) {
	    //숫자를 날짜로
	    var userInsertDate = new Date(datas[i].write_date);  
	    //날짜를 문자로 
	    write_date = userInsertDate.getFullYear() + "."
	                 + (userInsertDate.getMonth() + 1) + "."
	                 + userInsertDate.getDate() + " "
	                 + "(" + userInsertDate.getHours() + ":"
	                 + userInsertDate.getMinutes() + ")"; 
	     
	    jsonArr.push({
	    	'user_id': datas[i].user_id,
	        'name':datas[i].name,
	        'authority':datas[i].authority,
	        'dsc':datas[i].dsc,
	        'write_date': datas[i].write_date,
	        'user_no':datas[i].user_no
		});
	};
	$('#list').jqGrid('clearGridData');
	$('#list').jqGrid('setGridParam', {data: jsonArr}).trigger('reloadGrid');
};

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
          $('#checkPw_Msg2').html('비밀번호가 일치하지 않습니다.');
          $('#checkPw_Msg2').attr('color', '#ff0000');
        } else{
          $('#checkPw_Msg2').html('비밀번호 일치합니다.');
          $('#checkPw_Msg2').attr('color', '#0000FF');
        }
    });
    
    $('#user_pw').keyup(function(){
        if($('#user_pw').val() != $('#user_pw2').val()){
          $('#checkPw_Msg2').html('비밀번호가 일치하지 않습니다.');
          $('#checkPw_Msg2').attr('color', '#ff0000');
        } else{
          $('#checkPw_Msg2').html('비밀번호 일치합니다.');
          $('#checkPw_Msg2').attr('color', '#0000FF');
        }
    });
});

//삭제
function deleteUser(){ 
	var userNos = [];
	var rowids = $("#list").getGridParam("selarrrow");

	for (let i = 0; i < rowids.length; i++) {
        const rowid = rowids[i];
        var rowData = $("#list").getRowData(rowid);
		userNos.push(rowData.user_no);
    }		
	
	$("#list").jqGrid("clearGridData", true);		

	if(confirm("정말 삭제하시겠습니까?") == true ){
    	var text = "";
 		$.ajax({
			url: "./deleteUser",
			type: "post",
			contentType:'application/json',
			data: JSON.stringify(userNos)
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
	document.getElementById("regUserInfo").reset();  //입력했던 값 지우기
	document.getElementById("checkId_Msg").innerText="";
	document.getElementById("checkPw_Msg").innerText="";
	document.getElementById("checkPw_Msg2").innerText="";
	document.getElementById("checkName_Msg").innerText="";
	document.getElementById("checkPhone_Msg").innerText="";
	document.getElementById("checkEmail_Msg").innerText="";
	
	var btn = document.getElementById('inputBtn');
    btn.setAttribute("value","등록");
    btn.setAttribute("onclick","registerUser()");
    
    $('#user_id').attr("disabled",false);
    $('#id_check_button').attr("disabled", "false");
    $('#user_pw').removeAttr('placeholder');
    $('#user_pw2').removeAttr('placeholder');
    var title = document.querySelector('.title');
    title.innerText="사용자 등록";
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
			<img src="../resources/img/user.png" class="profile">
				<div class="icon">
				<p class="iconText" >닉네임</p>
				</div>
			</div>
		</div>
		
		<div id="userBox">
		<div id="top">
			<div class="btnBox">
         	<button class="writeBtn" id="insertBtn" onclick="modalOn()">등록</button>
         	<button class="writeBtn" id="deleteBtn" onclick="deleteUser()">삭제</button>
         	</div>
         		<div id="search">
         			<div class="searchBox">
						<input id="searchWord" type="text" class="searchForm" placeholder="아이디/이름">
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
				<h3 class="title">사용자 등록</h3>
				<i class="bi bi-x" onclick="modalOff()"></i>
			</div>
			<div class="userInput">
				<strong class="text">아이디<span class="star">*</span></strong>
				<input type="text" id="user_id" name="user_id" class="input_id" check_result="fail" required />
				<button type="button" id="id_check_button" class="id_check_button" onclick="id_check()">중복검사</button>
				<i class="fa-solid fa-check" id="check_sucess_icon" style="display: none;font-size: 20px;padding-left: 10px"></i><br>
				<div id="checkId_Msg" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text">비밀번호<span class="star">*</span></strong>
				<input type="password" id="user_pw" name="user_pw" class="textBox"><br>
				<div id="checkPw_Msg" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text">비밀번호 확인<span class="star">*</span></strong>
				<input type="password" id="user_pw2" class="textBox"><br>
				<div id="checkPw_Msg2" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text">이름<span class="star">*</span></strong>
				<input type="text" id="name" name="name" class="textBox"><br>
				<div id="checkName_Msg" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text">권한<span class="star">*</span></strong>
				<select form="regUserInfo" id="authority" name="authority" class="selectBox" >
					<option value="ROLE_ADMIN">관리자</option>
					<option value="ROLE_USER">사용자</option>
				</select>
			</div>
			<div class="userInput">
				<strong class="text">연락처<span class="star">*</span></strong>
				<input type="text" id="phone" name="phone" class="textBox" ><br>
				<div id="checkPhone_Msg" class="confirmAlertBox"></div>
			</div>
			
			<div class="userInput">
				<strong class="text">이메일<span class="star">*</span></strong>
				<input type="text" id="email" name="email" class="textBox"><br>
				<div id="checkEmail_Msg" class="confirmAlertBox"></div>
			</div>
			<div class="userInput">
				<strong class="text">설명</strong>
				<input type="text" id="dsc" name="dsc" class="textBox">
			</div>
			<div class="btnBox">
				<input type="button" id="inputBtn" value="등록" class="writeBtn2" onclick="registerUser()" >
				<input type="button" value="닫기" class="writeBtn2" onclick="modalOff()" >
			</div>
			</form>

		<!-- Form 태그 종료 -->
		</div>
	</div>
</div>
   
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>