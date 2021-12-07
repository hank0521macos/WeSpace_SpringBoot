<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
    <link rel="stylesheet" href="css/Header/Header.css">
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
</head>
<body>
    
        <div class="header">    
        		<a href="${pageContext.request.contextPath}/"><img id="logo" src="img/logo.png"></a>  
                <div class="logo">挑場地｜替你挑選好場地</div>
                <div class="navbar">
                    <a href="${pageContext.request.contextPath}/">找場地</a>
                    <a href="">客服中心</a>
                    <a href="${pageContext.request.contextPath}/regist">註冊</a>
                    <a href="${pageContext.request.contextPath}/login">登入</a>
                </div>
        </div>
 
</body>
</html>