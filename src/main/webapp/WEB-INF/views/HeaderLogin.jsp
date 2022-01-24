<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "spring" uri="http://www.springframework.org/tags"%>
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
                <div class="logo"><spring:message code="header.logo"/></div>
                <div class="navbar">
                	<a href="javascript:;" style="letter-spacing:2px; cursor:unset;"><spring:message code="header.hello"/>，${loginData.firstname} ${loginData.lastname}</a>
                    <a href="${pageContext.request.contextPath}/"><spring:message code="header.search"/></a>               
                    <a href="${pageContext.request.contextPath}/myOrders"><spring:message code="header.orders"/></a>
                    <a href="${pageContext.request.contextPath}/mySpace"><spring:message code="header.space"/></a>
                    <a href="javascript:;"><spring:message code="header.signout"/></a>
                    <a href="javascript:;" id="btn"><i class="fas fa-globe"></i></a>
                    <form action="/logout-member" method="get">
                    	<input type="submit" class="sign-up" value="登出">
                    </form>  
                </div>
                <div id="i18nSelect" class="i18nSelect">
				    <a href="${pageContext.request.contextPath}/?lang=zh_TW"><spring:message code="language.zh"/></a>
				    <a href="${pageContext.request.contextPath}/?lang=en_US"><spring:message code="language.en"/></a>
				    <a href="${pageContext.request.contextPath}/?lang=ja_JP"><spring:message code="language.ja"/></a>
		    	</div>
        </div>
        
        
 <script src="vendors/jquery/jquery-3.6.0.min.js"></script>       
 <script>
	$("#btn").click(function(){
		$("#i18nSelect").slideToggle("normal");
	})
</script>
</body>
</html>