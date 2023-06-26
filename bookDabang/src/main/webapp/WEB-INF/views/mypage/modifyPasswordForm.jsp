<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
	ul.modifyPasswordForm li{margin-top : 10px}
	ul.modifyPasswordForm li input{width: 370px;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//비밀번호 수정 유효성 체크
		$('#password_form').submit(function(){
			//공백 체크
			let items = document.querySelectorAll('input[type="text"],input[type="password"]');
			for(let i=0;i<items.length;i++){
				if(items[i].value.trim()==''){
					let label = document.querySelector('label[for="'+items[i].id+'"]');
					alert(label.textContent + ' 항목 필수 입력');
					items[i].value = '';
					items[i].focus();
					return false;
				}
			}//end of for
			
			//새 비밀번호 = 새 비밀번호 확인 일치 여부 체크
			if($('#passwd').val()!=$('#cpasswd').val()){
				alert('새 비밀번호와 새 비밀번호 확인이 불일치합니다.');
				$('#passwd').val('').focus();
				$('#cpasswd').val('');
				return false;
			}
			
		});//end of submit
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<hr size="1" noshade="noshade" width="100%">
	<div class="content-main" style="margin-top: 55px;">
		<p class="align-center">
			<img src="${pageContext.request.contextPath}/images/lock.png" 
			width="100" height="100" class="align-center lock" >
		</p>
		<div style="font-size:17px;">
			<p class="align-center">비밀번호 확인</p>
			<hr size="1" noshade="noshade" width="700px;">
			<p class="align-center">개인정보 변경을 위해 비밀번호를 입력해주세요.</p>
		</div>
		<form id="password_form" action="modifyPassword.do" method="post" style="border:none">
			<ul class="modifyPasswordForm">
				<li>
					<label for="id">아이디</label>
					<input type="text" name="id" id="id" maxlength="12" autocomplete="off" placeholder="현재 아이디를 입력해주세요.">
				</li>
				<li>
					<label for="origin_passwd">현재 비밀번호</label>
					<input type="password" name="origin_passwd" id="origin_passwd" maxlength="12" placeholder="현재 비밀번호를 입력해주세요."><br>
				</li>
				<li>
					<label for="passwd">새 비밀번호</label>
					<input type="password" name="passwd" id="passwd" maxlength="12" placeholder="영문,숫자,특수문자 포함 8~16자로 입력해주세요."><br>
				</li>				
				<li>
					<label for="cpasswd">새 비밀번호 확인</label>
					<input type="password" name="cpasswd" id="cpasswd" maxlength="12" placeholder="비밀번호 확인을 위해 비밀번호를 다시 한번 입력해주세요."><br>
				</li>				
			</ul>
		<div class="align-center">
			<input type="submit" value="비밀번호 변경">
			<input type="button" value="MY페이지" 
					   onclick="location.href='myPage.do'">
		</div>
		</form>
	</div>
</div>
</body>
</html>