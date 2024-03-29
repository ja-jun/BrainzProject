<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../resources/css/login.css">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/1fa86d52d5.js" crossorigin="anonymous"></script>
<title>LOGIN</title>
</head>
<body>

	<!-- 동영상 배경화면 -->
	<video autoplay muted>
   		<source src="../resources/video/bg.mp4" type="video/mp4"/>  <!-- bg1, bg2, bg3 중에 선택 -->
	</video>

	<!-- 상단 -->
	<header>
		<div class="content stagger-wrapper">
	        <p class="stagger-item">We’ve got you covered</p>
			<h1 class="stagger-item">Bcentral EMS</h1>
		</div>
	</header>

	<!-- 메인 -->
	<section>
		<form action="login_check" method="post">
			  <div class="input-group">
			      <input type="text" name="user_id" id="user_id" autocomplete="off"  required />
			      <label for="user_id"><i class="fa-solid fa-user"></i> Username</label>
			      <input style="display:none" aria-hidden="true"> 
			      <input type="password" style="display:none" aria-hidden="true">
		      </div>
		      <div class="input-group">
			      <input type="password" name="user_pw" id="user_pw" autocomplete="off"  required />
			      <label for="user_pw"><i class="fa-solid fa-lock"></i> Password</label>
		      </div>
		      <div class="btn-area"><button id="btn" type="submit">로그인</button></div>
			  <div class="Message">
			    <c:if test="${LoginFailMessage!=null}">
					<p><c:out value="${LoginFailMessage}"/></p>
				</c:if>
			  </div>
			</form>
	</section>
	
	<!-- 하단 -->
	<footer>
		<p>Copyright &copy 2022 Bcentral, All rights reserved.</p>
	</footer>
	<!-- 아이디, 비밀번호 미입력시 경고 -->
	<script>
        let id = $('#user_id');
        let pw = $('#user_pw');
        let btn = $('#btn');

        $(btn).on('click', function() {
            if($(id).val() == "") {
                $(id).next('label').addClass('warning');
                setTimeout(function() {
                    $('label').removeClass('warning');
                },1500);
            }
            else if($(pw).val() == "") {
                $(pw).next('label').addClass('warning');
                setTimeout(function() {
                    $('label').removeClass('warning');
                },1500);
            }
        });
        
        /* 비밀번호 오류 메세지 삭제 */
        setTimeout(function(){
            $('.Message').empty();
         }, 7000);
    </script>
</body>
</html>