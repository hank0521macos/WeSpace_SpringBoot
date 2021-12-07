<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/Regist/Regist.css">
    <title>WeSpace|註冊</title>
</head>
<body>
<jsp:include page="Header.jsp" flush="true" />
    <div id="basic-modal-content">
		<h2>歡迎加入！</h2>
		<p>
			已經有WeSpace帳號？ <a href="${pageContext.request.contextPath}/login">登入</a>
		</p>
		<hr>
		<form action="/save-member" method="post">
			<div class="sign-up-email">電子郵件信箱
				<c:if test="${not empty duplicatedError}">
					<span class= "alert-error">
						${duplicatedError}
					</span>
				</c:if> 
			</div>
			<input type="email" required="required" name="account" id="sign-up-email" class="sign-up-email" value="${member.account}" placeholder="example@email.com">
			<input type="hidden" name="email" id="sign-up-email2">
			<div class="sign-up-firstname">姓氏</div>
			<input type="text" required="required" name="firstname" class="sign-up-firstname" value="${member.firstname}">
			<div class="sign-up-lastname">名</div>
			<input type="text" required="required" name="lastname" class="sign-up-lastname" value="${member.lastname}">
			<div class="sign-up-mobile-phone">聯絡電話</div>
			<input type="text" required="required" name="mobilePhone" class="sign-up-mobile-phone" value="${member.mobilePhone}">
			<div class="sign-up-password">密碼
				<c:if test="${not empty passwordError}">
					<span class= "alert-error">
						${passwordError}
					</span>
				</c:if> 
			</div>
			<input type="password" required="required" name="password" class="sign-up-password" value="${member.password}"> 
			<input type="submit" class="sign-up-submit" value="註冊" onclick="emailValueEqualsAccount()">
		</form>
	</div>

	<script src="vendors/jquery/jquery-3.6.0.min.js"></script>
	<script>
		//提交表單時email欄位值等同於account的欄位值
		function emailValueEqualsAccount() {
		 	var email = document.getElementById('sign-up-email').value;
		 	document.getElementById('sign-up-email2').value = email;
		}
	</script>
</body>
</html>