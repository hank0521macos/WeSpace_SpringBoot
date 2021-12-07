<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/Login/Login.css">
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
    <title>WeSpace|登入</title>
</head>
<body>
<jsp:include page="Header.jsp" flush="true" />
    <div id="basic-modal-content2">
        <h2>歡迎回來！</h2>
        <p>還沒有WeSpace帳號？ <a href="${pageContext.request.contextPath}/regist">立即註冊</a></p>
        <hr>
        <form action="/login-member" method="post">
        	<c:if test="${not empty error}">
					<div class= "alert-error">
						${error}
					</div>
			</c:if> 
			<c:if test="${not empty errorVerifyMail}">
					<div class= "alert-error">
						${errorVerifyMail}
					</div>
			</c:if> 
            <input type="email" required="required" name="account" id="account" value="${member.account}" class="sign-in-email" placeholder="example@email.com">
            <br>	            
            <input type="password" required="required" name="password" id="password" value="${member.password}" class="sign-in-password" placeholder="密碼">
            <div class="remember_forget_button">
                <input type="checkbox" name="remember" id="remember" value="true">
                <p>記住我</p>
                <a href="${pageContext.request.contextPath}/forgot">忘記密碼？</a>
            </div>
            <input type="submit" class="sign-in-submit" value="登入">
        </form>
        <form action="/reVerifyMailLogin" method="get">
	        <c:if test="${loginData != null && loginData.status == 0}">
	        	<input type="submit" class="reSendMail" value="補發驗證信">
	       </c:if>
	    </form>
        <hr>
        <div class="advertise">
            <i class="fas fa-hand-holding-usd"></i>
            <p>出租你的空間，賺取報酬！</p>
            <a href="#">成為場地主→</a>
        </div>
    </div>
    
    <script>
    	var cookies = document.cookie.split(';');
    	function getCK(mkey){
    		for(var i=0;i<cookies.length;i++){
    			var kv = cookies[i].split('=');
    			if(kv[0].trim()==mkey){
    				return kv[1].trim();
    			}
    		}
    		return '';
    	}
    	
    	window.onload=function(){
    		var account = getCK('account');
    		var password = getCK('password');
    		var remember = getCK('remember');
    		
    		if(remember=='true'){
    			var accountInput = document.getElementById("account");
    			accountInput.value = account;
    			var passwordInput = document.getElementById("password");
    			passwordInput.value = password;
    			var rememberInput = document.getElementById("remember");
    			rememberInput.checked = "checked";
    		}
    			
    	}
    
    </script>
    
</body>
</html>