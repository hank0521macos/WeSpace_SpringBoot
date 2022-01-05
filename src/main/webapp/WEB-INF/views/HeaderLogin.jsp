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
                	<a href="javascript:;" style="letter-spacing:2px; cursor:unset;">您好，${loginData.firstname} ${loginData.lastname}</a>
                    <a href="${pageContext.request.contextPath}/">找場地</a>               
                    <a href="${pageContext.request.contextPath}/myOrders">我的預訂</a>
                    <a href="${pageContext.request.contextPath}/mySpace">我的場地</a>
                    <a href="">客服中心</a>
                    <a href="javascript:;" id="toggle-button" onclick="show22()"><i class="far fa-user-circle"></i></a>
                   
                </div>
                <div id="toggle-menu" style="display:none;">
                	<a href="">個人資料</a>
                    <a href="">正體中文</a>
                    <a href="">聊一聊</a>
                    <form action="/logout-member" method="get">
                    	<input type="submit" class="sign-up" value="登出">
                    </form>                   
                </div>
        </div>
        
        
 <script src="vendors/jquery/jquery-3.6.0.min.js"></script>       
 <script>
	//使用者menu顯示
	 var isShow = false;
	  function show22() {
	      if(!isShow) {
	          isShow = true;
	         document.getElementById('toggle-menu').style.display='';
	     }
	     else {
	         isShow = false;
	         document.getElementById('toggle-menu').style.display='none';
	     }
	  }
 </script>
</body>
</html>