<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/ResetPassword/ResetPassword.css">
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
    <title>WeSpace</title>
</head>
<body>
<jsp:include page="Header.jsp" flush="true" />
    <div id="basic-modal-content2">
        <h2>忘記密碼</h2>
        <p>請輸入您的帳號，系統將寄送密碼重置信至您設定的連絡信箱。</p>
        <c:if test="${not empty error}">
				<div class= "alert-error">
					${error}
				</div>
		</c:if> 
        <form action="forgotPassword" method="post">
            <input type="email" required="required" name="account" id="account" value="${member.account}" class="forgot-email" placeholder="example@email.com">
            <br>	            
            <input type="submit" class="forgot-submit" value="送出">
        </form>
    </div>
</body>
</html>