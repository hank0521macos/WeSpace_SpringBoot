<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeSpace | 聯絡單管理</title>
<link rel="stylesheet" href="css/OrdersContact/ordersContact.css">
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
			<p>聯絡單管理</p>
		</div>
		<div class="nav-bar">
			<ul>
				<li><a href="/ordersDetail">預訂單</a></li>
				<li style="border-bottom: 3px solid black;"><a href="/ordersContact">聯絡單</a></li>
				<li><a href="/mySpace">我的空間</a></li>
			</ul>
		</div>
        <div class="searchCondition">
            <input id="date" type="date" class="searchConditionDate">&nbsp;至
            <input id="date" type="date" class="searchConditionDate">
            <input type="text" placeholder="搜尋訂單..." class="searchConditionName">
            <input type="submit" value="搜尋訂單"  class="searchConditionSubmit">
            <input type="submit" value="輸出Excel"  class="searchConditionExcel">
        </div>
        <div>
            <table class="ordersList">
                <thead>
                    <tr>
                        <th><button>場地名稱<i class="fas fa-sort"></i></button></th>
                        <th><button>姓名<i class="fas fa-sort"></i></button></th>
                        <th><button>預訂日期<i class="fas fa-sort"></i></button></th>
                        <th><button>電話<i class="fas fa-sort"></i></button></th>
                        <th><button>金額<i class="fas fa-sort"></i></button></th>
                        <th><button>實際金額<i class="fas fa-sort"></i></button></th>
                        <th><button>狀態<i class="fas fa-sort"></i></button></th>
                        <th>編輯</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>光合箱子光合箱子光合箱子光合箱子</td>
                        <td>吳孟育</td>
                        <td>2021/10/21</td>
                        <td>0975123973</td>
                        <td>$2213</td>
                        <td>$2200</td>
                        <td>已接訂</td>
                        <td>
                            <button><i class="far fa-edit"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
	</div>
</body>
</html>