<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/PasswordUpdate/PasswordUpdate.css">
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
    <title>WeSpace</title>
</head>
<body>
<jsp:include page="Header.jsp" flush="true" />
    <div id="basic-modal-content2">
        <h2>修改密碼</h2>
        <p>密碼長度需6位以上，至少包含1個英文字母</p>
        <form action="/resetResult2" method="post">
        	<c:if test="${not empty passwordError}">
					<div class= "alert-error">
						${passwordError}
					</div>
			</c:if> 
            <br>
            <input type="hidden" name="token" value="${param.token}">
            <input type="password" required="required" name="password" id="password" value="${member.password}" class="sign-in-password" placeholder="新密碼">
            <input type="password" required="required" name="passwordCheck" id="passwordCheck" class="sign-in-password" placeholder="再次輸入密碼">
            <input type="submit" class="sign-in-submit" value="確認修改">
        </form>
    </div>
</body>
</html>