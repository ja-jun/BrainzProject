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
        datatype: "local",
        data: [],
        rowNum: 10,
        rowList: [10,30,50],
        height: 600,
        width:1573,
        pager: '#pager',
         colModel: [   
            {name: 'user_id', label : '아이디', align:'left'},
             {name: 'name', label:'이름', align:'left'},
             {name: 'authority', label : '권한', align:'center'},
             {name: 'dsc', label : '설명', align:'left'},
             {name: 'write_date간', label : '최종 로그인 시간', align:'center'},
             {name: 'user_no', label : '사용자번호', hidden:true}
              ],
              
         multiselect: true,
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
                        + userInsertDate.getDate(); 
           
            jsonArr.push({
               'user_id':datas[i].user_id,
                'name':datas[i].name,
                'authority':datas[i].authority,
                'dsc':datas[i].dsc,
                'write_date':datas[i].write_date,
                'user_no':datas[i].user_no
            });
        }
               $('#list').jqGrid('clearGridData');
               $('#list').jqGrid('setGridParam', {data: jsonArr}).trigger('reloadGrid');
      };

 

//사용자 리스트 가져와서 집어넣기
function getList(){
   var xhr = new XMLHttpRequest();
   
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         var data = JSON.parse(xhr.responseText); 
         
            renderGridByDatas(data.userList);
         }
   };
   xhr.open("get" , "./getUserList" , true);   
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

            renderGridByDatas(data.userList);
      }         
   };
   
   xhr.open("get" , "./getUserList?searchWord=" + searchWordValue, true);
   xhr.send();         
}


//입력값 db에 등록하기
function registerUser(){
   var user_id = $("#user_id").val();
   var user_pw = $("#user_pw").val();
   var user_pw2 = $("#user_pw2").val();
   var name = $("#name").val();
   var authority = $("#authority").val();
   var phone = $("#phone").val();
   var email= $("#email").val();
   var dsc = $("#dsc").val();
      
   if(user_id=="") {
      alert("아이디를 입력하지 않았습니다.")
        return false;
    }
   
   if(user_pw=="") {
      alert("비밀번호를 입력하지 않았습니다.")
        return false;
    }
   
   if(user_pw2=="") {
      alert("비밀번호 확인을 입력하지 않았습니다.")
        return false;
    }
   
   if(name=="") {
      alert("이름을 입력하지 않았습니다.")
        return false;
    }
      
   if(phone=="") {
      alert("전화번호를 입력하지 않았습니다.")
        return false;
    }
   
   if(email=="") {
      alert("이메일을 입력하지 않았습니다.")
        return false;
    }
      
   
   var xhr = new XMLHttpRequest();
   
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){ 
         var data = JSON.parse(xhr.responseText); 

         modalOff();
         

         getList();
      }
   };
   
   xhr.open("post" , "./registerUser" , true);  
    xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //Post
   xhr.send("user_id=" +  user_id + "&user_pw=" + user_pw + "&name=" + name + "&authority=" + authority 
         + "&phone=" + phone + "&email=" + email + "&dsc=" + dsc ); 

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
     url: "./isExistId",
     data: {'id': id},
     datatype: 'json',
     success: function (data) {
       if (data.result == false) {
         $('#checkId').html('이미 존재하는 아이디 입니다.');
         $('#checkId').attr('color', '#ff0000');
         return;
       } else {
         $('#checkId').html('사용가능한 아이디 입니다.');
         $('#checkId').attr('color', '#0000FF');
         $('.input_id').attr("check_result", "success");
         $('#check_sucess_icon').show();
         $('.id_check_button').hide();
         return;
       }
     }
   });
 }


// 비밀번호 확인 메세지
$(function(){
    $('#user_pw').keyup(function(){
      $('#confrimMsg ').html('');
    });

    $('#user_pw2').keyup(function(){

        if($('#user_pw').val() != $('#user_pw2').val()){
          $('#confrimMsg').html('비밀번호가 일치하지 않습니다.');
          $('#confrimMsg').attr('color', '#ff0000');
        } else{
          $('#confrimMsg').html('비밀번호 일치합니다.');
          $('#confrimMsg').attr('color', '#0000FF');
        }

    });
});




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
 //배열로 넘길수 있는지?! 삭제시 select 풀기
function deleteUser(){ 
   var userNos = [];
   var rowids = $("#list").getGridParam("selarrrow");
   
   for (let i = 0; i < rowids.length; i++) {
        const rowid = rowids[i];
      console.log(rowid);
        var rowData = $("#list").getRowData(rowid);
      userNos.push(rowData.사용자번호);
      console.log(rowData);
    }
   var xhr = new XMLHttpRequest();
      
      xhr.onreadystatechange = function(){
         if(xhr.readyState == 4 && xhr.status == 200){
            var data = JSON.parse(xhr.responseText);
            
            alert("삭제되었습니다.");
            getList();
            
         }
      };
      
      xhr.open("post" , "./deleteUser" , true); //get.?
        xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xhr.send("userNos="+ userNos);   
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
   document.getElementById("regUserInfo").reset();  //입력했던 값 지우기
   document.getElementById("confirmAlertBox").innerText="";    //id 중복 메세지 지우기
}

//모달창 열렸을 때 ESC누르면 닫힘
window.addEventListener("keyup", e => {
    if(isModalOn() && e.key === "Escape") { modalOff(); }
})


window.addEventListener("DOMContentLoaded", function(){
	
	$("#userPage").addClass("on");
	
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
      <jsp:include page="../nav/nav.jsp"></jsp:include>
<!--       <div class="row mt-3">
         <div class="col-4">
            <input name="searchWord" type="text" class="form-control" placeholder="아이디/이름">
         </div>
         <div class="col ">
            <button class="writeBtn" onclick="search()">검색</button>
         </div>
      </div> -->
   
      <div id="box">
         <button class="writeBtn" id="insertBtn" onclick="modalOn()">등록</button>
         <button class="writeBtn" id="deleteBtn" onclick="deleteUser()">삭제</button>
         <div id="jqgridBox">
         <table id="list"></table>
         <div id="pager"></div>
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
         <div class="titleBox">
            <strong class="text">아이디<span class="star">*</span></strong>
            <input type="text" id="user_id" class="input_id" check_result="fail" required />
            <button type="button" class="id_check_button" onclick="id_check()">중복검사</button>
            <i class="fa-solid fa-check" id="check_sucess_icon" style="display: none;font-size: 20px;padding-left: 10px"></i><br>
            <font id="checkId" size="2"></font>
         </div>
         <div class="titleBox">
            <strong class="text">비밀번호<span class="star">*</span></strong>
            <input type="password" id="user_pw" class="textBox">
         </div>
         <div class="titleBox">
            <strong class="text">비밀번호 확인<span class="star">*</span></strong>
            <input type="password" id="user_pw2" class="textBox"><br>
            <font id="confrimMsg" size="2"></font>
         </div>
         <div class="titleBox">
            <strong class="text">이름<span class="star">*</span></strong>
            <input type="text" id="name" class="textBox">
         </div>
         <div class="titleBox">
            <strong class="text">권한<span class="star">*</span></strong>
            <select form="regUserInfo" id="authority" class="selectBox" >
               <option value="ROLE_ADMIN">관리자</option>
               <option value="ROLE_USER">사용자</option>
            </select>
         </div>
         <div class="titleBox">
            <strong class="text">연락처<span class="star">*</span></strong>
            <input type="text" id="phone" class="textBox" >
            <div id="confirmAlertBox"></div>
         </div>
         
         <div class="titleBox">
            <strong class="text">이메일<span class="star">*</span></strong>
            <input type="text" id="email" class="textBox">
         </div>
         <div class="titleBox">
            <strong class="text">설명</strong>
            <input type="text" id="dsc" class="textBox">
         </div>
         <div class="btnBox">
            <input type="button" name="" value="등록" class="btnBoxbtn" onclick="registerUser()" >
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