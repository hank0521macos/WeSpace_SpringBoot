<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeSpace|場地管理</title>
<link rel="stylesheet" href="css/MemberBackEnd/mySpace.css">
<script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
<script src="js/facilitiesMySpace/mySpace.js"></script>
</head>

<body>
<c:if test="${loginData == null || loginData.status == 0}">
	<jsp:include page="Header.jsp" flush="true" />
</c:if>

<c:if test="${loginData != null && loginData.status == 1}">
	<jsp:include page="HeaderLogin.jsp" flush="true" />
</c:if> 
	<div class="content-wrapper">
		<div class="title">
			<p>場地管理</p>
		</div>
		<div class="nav-bar">
			<ul>
				<li><a href="#">預訂單</a></li>
				<li><a href="#">聯絡單</a></li>
				<li style="border-bottom: 3px solid black;"><a href="#">我的空間</a></li>
			</ul>
		</div>
		<div class="createSpaceArea">
			<div class="insertSpace">
				<i class="fas fa-plus-circle"></i>
				<a href="${pageContext.request.contextPath}/spacePage" class="insertSpace">新增空間</a>
			</div>
			
			<c:forEach items="${facilities}" var="facilities">
			<div class="unverifySpace">
				<div class="spaceItem">
				<c:if test="${empty facilities.facilitiesImages}">
					<div class="spaceImage" style="background-image: url(img/default.png);"></div>
				</c:if>
				<c:if test="${not empty facilities.facilitiesImages}">
					<div class="spaceImage" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilities.facilitiesImages.toArray()[0].name});"></div>
				</c:if>
					<div class="spaceUI">
						<div class="spaceInfo">
							<c:if test="${facilities.name == '' or facilities.name == null}">
								<h3>未命名</h3>
							</c:if>
								<h3>${facilities.name}</h3>
							<c:if test="${facilities.facilitiesOwner == null}">
								<p>尚未指派管理者</p>
							</c:if>
								<p>${facilities.facilitiesOwner.name}</p>
						</div>
						<div class="spaceButton">
						
							<form action="/previewSpace" method="get" style="display:inline;">	
						  		<input type="hidden" name="id" value="${facilities.id}">
								<input type="submit" value="預覽">
							</form>
							<form action="/listOneSpace" method="get" style="display:inline;">	
						  		<input type="hidden" name="id" value="${facilities.id}">
								<input type="submit" value="編輯">
							</form>
						  	<form action="/deleteSpace" method="get" style="display:inline;" onClick='return confirmSubmit()'>	
						  		<input type="hidden" name="id" value="${facilities.id}">
								<input type="submit" value="刪除">
							</form>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
			
		</div>
	</div>
<script>
function confirmSubmit() {
	var agree = confirm("你確定要刪除此空間嗎？");
	if (agree)
		return true;
	else
		return false;
}
</script>
</body>
</html>