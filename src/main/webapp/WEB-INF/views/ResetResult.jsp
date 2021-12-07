<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/ResetResult/ResetResult.css">
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
    <title>WeSpace</title>
</head>
<body>
<jsp:include page="Header.jsp" flush="true" />
    <div id="basic-modal-content2">
        <h2>忘記密碼</h2>
        <p>已寄送密碼重置信至您設定的聯絡信箱。</p>
        <form action="/resendForgotPassword" method="post">
	        <h6>如未收到重置信，請於信箱搜尋 WeSpace 或 
	        	<input type="submit" class="reSendMail" value="重新寄送">
	       	</h6>
	       	<c:if test="${not empty errorVerifyMail}">
				<div class= "alert-error">
					${errorVerifyMail}
				</div>
			</c:if> 
		</form>
        <input type="submit" class="home" value="回首頁" 
        	onclick="location.href='${pageContext.request.contextPath}/'">
    </div>
</body>
</html>