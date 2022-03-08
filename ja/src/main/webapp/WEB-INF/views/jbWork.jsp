<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Amita&family=Jua&family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
  <style>
    .btn{
      text-decoration: none;
      font-size:3rem;
      color:white;
      margin:100px auto 50px;
      width:35%;
      text-align: center;
      display:block;
      border-radius: 10px;
      transition:all 0.1s;
      font-family: 'Jua', sans-serif;
    }
    .btn:active{
      transform: translateY(3px);
    }
    .btn.blue{
      background-color: #3083e3;
      border-bottom:5px solid #2c6cb5;
    }
    .btn.blue:active{
      border-bottom:2px solid #165195;
   
  </style>
</head>
<body>
  <a class="btn blue" href="./jbRegisterUser">사용자 등록</a>
  <a class="btn blue" href="#server">서버 등록</a>
  <a class="btn blue" href="#work">작업 등록</a>
  <a class="btn blue" href="./security_logout">로그아웃</a>
</body>
</html>