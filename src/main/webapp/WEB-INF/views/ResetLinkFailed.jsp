<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeSpace</title>
<style>
p {
	font-size: 40px;
	letter-spacing:10px;
	text-align: center;
	padding-top:250px;
}

a.homeIcon, a.homeIcon:visited{
	font-size: 20px;
	color:white;
	display:block;
	width:100px;
	text-decoration:none;
	text-align: center;
	background-color:#53A385;
	border-radius:999em;
	padding:15px 40px;
	margin:40px auto;
	letter-spacing:5px;
}
</style>
<script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
</head>
<body>
	<c:if test="${loginData == null || loginData.status == 0}">
		<jsp:include page="Header.jsp" flush="true" />
	</c:if>
	
	<c:if test="${loginData != null && loginData.status == 1}">
		<jsp:include page="HeaderLogin.jsp" flush="true" />
	</c:if> 
	
	<p>抱歉，此密碼更新連結已失效或超過時限</p>
	<a class="homeIcon" href="${pageContext.request.contextPath}/">返回首頁</a>
</body>
</html>