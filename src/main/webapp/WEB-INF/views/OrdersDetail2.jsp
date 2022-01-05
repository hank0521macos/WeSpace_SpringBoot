<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeSpace | 預訂單管理</title>
<link rel="stylesheet" href="css/OrdersDetail/ordersDetail2.css">
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
			<p>預訂單管理</p>
		</div>
		<div class="nav-bar">
			<ul>
				<li style="border-bottom: 3px solid black;"><a href="/ordersDetail">預訂單</a></li>
				<li><a href="/ordersContact">聯絡單</a></li>
				<li><a href="/mySpace">我的空間</a></li>
			</ul>
		</div>
		<div class="ordersButton">
            <a href="/ordersDetail"><div class="ordersDetailButton"><i class="fas fa-arrow-left"></i>返回全部訂單</div></a>
		</div>
        <div class="priceCounting">
            <div class="priceBox">
                預訂總金額<br>
                $0
            </div>
            <i class="fas fa-minus"></i>
            <div class="priceBox">
                服務費金額<br>
                $0
            </div>
            <i class="fas fa-equals"></i>
            <div class="priceBoxTotal">
                收款金額<br>
                $0
            </div>
        </div>
        <div class="searchCondition">
            <input id="date" type="date" class="searchConditionDate">&nbsp;至
            <input id="date" type="date" class="searchConditionDate">
            <input type="text" placeholder="關鍵字" class="searchConditionName">
            <input type="submit" value="搜尋訂單"  class="searchConditionSubmit">
        </div>
        <div>
            <table class="ordersList">
                <thead>
                    <tr>
                        <th><button>訂單編號<i class="fas fa-sort"></i></button></th>
                        <th><button>姓名<i class="fas fa-sort"></i></button></th>
                        <th><button>預訂日期<i class="fas fa-sort"></i></button></th>
                        <th><button>產生日期<i class="fas fa-sort"></i></button></th>
                        <th><button>訂單金額<i class="fas fa-sort"></i></button></th>
                        <th><button>服務費(15%)<i class="fas fa-sort"></i></button></th>
                        <th>詳情</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>吳孟育</td>
                        <td>2021/10/21</td>
                        <td>2021/10/11</td>
                        <td>$2213</td>
                        <td>$300</td>
                        <td>
                            <button><i class="fas fa-info-circle"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>吳孟育</td>
                        <td>2021/10/21</td>
                        <td>2021/10/11</td>
                        <td>$2213</td>
                        <td>$300</td>
                        <td>
                            <button><i class="fas fa-info-circle"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
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