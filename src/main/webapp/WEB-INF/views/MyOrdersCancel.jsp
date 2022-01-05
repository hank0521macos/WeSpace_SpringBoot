<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeSpace | 我的預訂</title>
<link rel="stylesheet" href="css/MyOrders/MyOrders.css">
<script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
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
			<p>我的預訂</p>
		</div>
		<div class="nav-bar">
			<ul>
                <li><a href="${pageContext.request.contextPath}/myOrders">處理中</a></li>
				<li><a href="#">已預訂</a></li>
				<li style="border-bottom: 3px solid black;"><a href="${pageContext.request.contextPath}/myOrdersCancel">退訂</a></li>
				<li><a href="#">已結束</a></li>
			</ul>
		</div>
		
		
		<div class="myOrdersArea" id="myOrdersArea">
			<c:if test="${empty orders}">
				<div class="noOrders">你沒有任何進行中的預訂。<br>
					 趕緊來尋找場地，規劃下一段美好時光吧。<br>
					 <br>
					 找不到你的預訂？<span>聯絡我們</span>
				</div>
			</c:if>
		<c:forEach var="orders" items="${orders}">
		<c:if test="${orders.status == 0}">
            <div class="myOrdersList">
            	<c:forEach var="facilitiesImage" items="${orders.facilities.facilitiesImages}" begin="0" end="0">
                	<a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${orders.facilities.id}"><div class="spaceImg" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});"></div></a>
               	</c:forEach>
                <div class="spaceInfo">
                    <table class="tableA">
                        <tr>
                            <td><i class="far fa-clock"></i></td>
                            <td>
                            	<fmt:formatDate value='${orders.date}' pattern='yyyy-MM-dd'/>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>${orders.startTime}:00~${orders.endTime}:00</td>
                        </tr>
                        <tr>
                            <td><i class="far fa-compass"></i></td>
                            <td>${orders.facilities.name}</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>${orders.facilities.city}${orders.facilities.town}${orders.facilities.address}</td>
                        </tr>
                    </table>
                    <table class="tableB">
                        <tr>
                            <td class="tableB_title">訂單編號</td>
                            <td>${orders.id}</td>
                        </tr>
                        <tr>
                            <td class="tableB_title">下訂時間</td>
                            <td>
                            	<fmt:formatDate value='${orders.createTime}' pattern='yyyy-MM-dd HH:mm:ss'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="tableB_title">訂單金額</td>
                            <td>$${orders.expense}</td>
                        </tr>
                        <tr>
                            <td class="tableB_title">狀態</td>
                            <td>使用者取消</td>
                        </tr>
                        <tr>
                            <td class="tableB_title">聯絡人</td>
                            <td>${orders.contactName}</td>
                        </tr>
                        <tr>
                            <td class="tableB_title">信箱</td>
                            <td>${orders.contactEmail}</td>
                        </tr>
                    </table>
                    <form action="/reCancelOrders" method="get" onsubmit="return confirmSubmit(this);">
                    	<input name="ordersId" type="hidden" value="${orders.id}">
	                	<input type="submit" class="deleteOrders" value="再次預訂此場地">
	                </form>
                </div>
            </div>
        </c:if>
       	</c:forEach>
		</div>
	</div>
		<script>
    //確認刪除提交
    function confirmSubmit(form) {
    	var agree = confirm("確定要重啟這份訂單？");
    	if (agree)
    		return true;
    	else
    		return false;
    };
	</script>
</body>
</html>