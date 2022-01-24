<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "spring" uri="http://www.springframework.org/tags"%>

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
		<h2><spring:message code="signUp.welcome"/></h2>
		<p>
			<spring:message code="signUp.title"/> <a href="${pageContext.request.contextPath}/login">登入</a>
		</p>
		<hr>
		<form action="/save-member" method="post">
			<div class="sign-up-email"><spring:message code="signUp.email"/>
				<c:if test="${not empty duplicatedError}">
					<span class= "alert-error">
						${duplicatedError}
					</span>
				</c:if> 
			</div>
			<input type="email" required="required" name="account" id="sign-up-email" class="sign-up-email" value="${member.account}" placeholder="example@email.com">
			<input type="hidden" name="email" id="sign-up-email2">
			<div class="sign-up-firstname"><spring:message code="signUp.lastName"/>/<spring:message code="signUp.firstName"/></div>
			<input type="text" required="required" name="firstname" class="sign-up-firstname" value="${member.firstname}">
			<input type="text" required="required" name="lastname" class="sign-up-lastname" value="${member.lastname}">
			<div class="sign-up-mobile-phone"><spring:message code="signUp.phone"/></div>
			<input type="text" required="required" name="mobilePhone" class="sign-up-mobile-phone" value="${member.mobilePhone}" onkeyup="value=value.replace( /[^\d]/g,'')">
			<div class="sign-up-password"><spring:message code="signUp.password"/>&nbsp;&nbsp;<font style="font-size:10px;color:gray;">(<spring:message code="signUp.password.hint"/>)</font>
				<c:if test="${not empty passwordError}">
					<span class= "alert-error">
						${passwordError}
					</span>
				</c:if> 
			</div>
			<input type="password" required="required" name="password" class="sign-up-password" value="${member.password}"> 
			<input type="submit" class="sign-up-submit" value="<spring:message code="signUp.signUp"/>" onclick="emailValueEqualsAccount()">
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