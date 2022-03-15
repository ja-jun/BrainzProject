<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>Insert title here</title>
<style>
	.text_center{
		text-align: center;
	}
</style>
</head>
<body>
	<div style="width: 1200px; margin:0 auto">
		<div class="container-fluid">
			<div class="row">
				<div class="col">
				</div>
			</div>
			<div class="row">
				<div class="col"></div>
				<div class="col-4">
					<form action="./registerUserProcess" method="post">
					<div class="row" style="padding-top: 40px;">
						<div class="col text-center fs-2 fw-bold">사용자 등록</div>
					</div>	
					<div class="row mt-3">
						<div class="col">
							아이디<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="user_id" class="form-control" placeholder="아이디를 입력"><br>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							비밀번호<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="password" name="user_pw" class="form-control" placeholder="비밀번호 입력"><br>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							이름<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="name" class="form-control" placeholder="이름 입력"><br>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							권한<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<select class="form-select" name="authority">
								  <option value="ROLE_ADMIN">관리자</option>
								  <option value="ROLE_USER">사용자</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							연락처<font color="red"><sup>&#149;</sup></font>
						</div>	
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="phone" class="form-control" placeholder="연락처 입력"><br>
							</div>
						</div>
					</div>	
					<div class="row">
						<div class="col">
							이메일<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="email" class="form-control" placeholder="이메일 입력">
							</div>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							설명 
						</div>
						<div class="row mt-1">
							<div class="col">
							    <textarea name="dsc" rows="3" class="form-control"></textarea>
							</div>
						</div>
					</div>
					<div class="row my-5">
						<div class="col d-grid">
							<input type="submit" value="등록" class="btn btn-primary btn-lg">
						</div>
					</div>
					</form>
				</div>
				<div class="col"></div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>	
</body>
</html>