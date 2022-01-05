<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WeSpace</title>
    <link rel="stylesheet" href="css/OrdersResult/OrdersResult.css">
</head>
<body>
	<c:if test="${loginData == null || loginData.status == 0}">
		<jsp:include page="Header.jsp" flush="true" />
	</c:if>
	
	<c:if test="${loginData != null && loginData.status == 1}">
		<jsp:include page="HeaderLogin.jsp" flush="true" />
	</c:if> 
	<div class="wrapper">
	    <div class="main">
	        <div class="message">
	            <img src="img/logo.png" class="logo">
	            <h2>等待場地審核</h2>
	            <h4>您的預約已送出</h4>
	            <p>場地正在審核您的申請，通常需要幾分鐘到幾個小時的時間</p>
	            <p>預約資訊與審核結果會發送至</p>
	            <p>${orders.contactEmail}</p>
	            <br>
	            <p>您也可以隨時<span><a href="${pageContext.request.contextPath}/myOrders">查詢訂單狀況</a></span></p>
	        </div>
	        <div class="ordersInfo">
	            <table class="ordersInfoTB">
	                <tr>
	                    <td class="TBTitle">訂單編號</td>
	                    <td>${orders.id}</td>
	                </tr>
	                <tr>
	                    <td class="TBTitle">電話</td>
	                    <td>${orders.contactMobilePhone}</td>
	                </tr>
	                <tr>
	                    <td class="TBTitle">Email</td>
	                    <td>${orders.contactEmail}</td>
	                </tr>
	            </table>
	        </div>
	        <a href="/" class="backToHome"><div class="button">返回場地資訊</div></a>
	    </div>
    </div>
</body>
</html>