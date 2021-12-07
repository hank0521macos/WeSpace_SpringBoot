<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WeSpace</title>
<link rel="stylesheet" href="css/SearchResult/SearchResultPage.css">
<script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
</head>
<body>

	<c:if test="${loginData == null || loginData.status == 0}">
		<jsp:include page="Header.jsp" flush="true" />
	</c:if>

	<c:if test="${loginData != null && loginData.status == 1}">
		<jsp:include page="HeaderLogin.jsp" flush="true" />
	</c:if>

	<div class="main">
		<!-- --------------------左側區塊-------------------- -->
		<div class="sidebar">
			<p>目的</p>
          	<select>
                <option disabled selected>活動性質</option>
	            <c:forEach var="facilitiesType" items="${facilitiesTypeAll}">
	            	<option value="${facilitiesType.facilitiesTypeId}">${facilitiesType.name}</option>
	            </c:forEach>    
            </select>
			<p>活動人數</p>
            <select>
                <option disabled selected>活動人數</option>
                <option>1-10</option>
                <option>11-20</option>
                <option>21-40</option>
                <option>41-60</option>
                <option>61-80</option>
                <option>81-100</option>
                <option>101-200</option>
                <option>201-300</option>
                <option>301-400</option>
                <option>401-500</option>
                <option>500+</option>
            </select>
			<p>縣市</p>
			<select>
                <option disabled selected>地點</option>
                <option value="基隆市">基隆市</option>
                <option value="臺北市">臺北市</option>
                <option value="新北市">新北市</option>
                <option value="宜蘭縣">宜蘭縣</option>
                <option value="新竹市">新竹市</option>
                <option value="新竹縣">新竹縣</option>
                <option value="桃園市">桃園市</option>
                <option value="苗栗縣">苗栗縣</option>
                <option value="臺中市">臺中市</option>
                <option value="彰化縣">彰化縣</option>
                <option value="南投縣">南投縣</option>
                <option value="嘉義市">嘉義市</option>
                <option value="嘉義縣">嘉義縣</option>
                <option value="雲林縣">雲林縣</option>
                <option value="臺南市">臺南市</option>
                <option value="高雄市">高雄市</option>
                <option value="屏東縣">屏東縣</option>
                <option value="臺東縣">臺東縣</option>
                <option value="花蓮縣">花蓮縣</option>
                <option value="金門縣">金門縣</option>
                <option value="連江縣">連江縣</option>
                <option value="澎湖縣">澎湖縣</option>
            </select>
			<p>每小時/預算上限</p>
			<select>
				<option disabled selected>請選擇</option>
				<option>200 NT$</option>
				<option>300 NTS</option>
				<option>400 NTS</option>
				<option>500 NTS</option>
				<option>700 NTS</option>
				<option>1000 NTS</option>
				<option>1500 NTS</option>
				<option>2000 NTS</option>
				<option>3000 NTS</option>
				<option>4000 NTS</option>
				<option>5000 NTS</option>
				<option>7000 NTS</option>
			</select>
			<p>每小時/最低預算</p>
			<select>
				<option disabled selected>請選擇</option>
				<option>200 NT$</option>
				<option>300 NTS</option>
				<option>400 NTS</option>
				<option>500 NTS</option>
				<option>700 NTS</option>
				<option>1000 NTS</option>
				<option>1500 NTS</option>
				<option>2000 NTS</option>
				<option>3000 NTS</option>
				<option>4000 NTS</option>
				<option>5000 NTS</option>
				<option>7000 NTS</option>
			</select>
			<p>場地名稱搜尋</p>
			<input type="text" class="name_search">
			<p>平日或假日？</p>
			<input type="checkbox" class="checkbox"><span>平日</span> 
			<input type="checkbox" class="checkbox"><span>假日</span>
			<p>租用時段？</p>
			<input type="checkbox" class="checkbox"><span>上午</span> 
			<input type="checkbox" class="checkbox"><span>下午</span> 
			<input type="checkbox" class="checkbox"><span>晚上</span> 
			<input type="submit" class="search-submit" value="搜尋">
		</div>
		
		<!-- --------------------右側區塊-------------------- -->
		<div style="margin-top:100px;">
		<c:forEach var="facilitiesByMainSearch" items="${facilitiesByMainSearch}">
			<div class="search_result">
				<a href="">
				<c:if test="${empty facilitiesByMainSearch.facilitiesImages}">
					<div class="search_result_item" style="background-image: url(img/default.png); background-position:center;"></div>
				</c:if>
				<c:if test="${not empty facilitiesByMainSearch.facilitiesImages}">
					<div class="search_result_item" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesByMainSearch.facilitiesImages.toArray()[0].name});"></div>
				</c:if>
				</a>
				<table>
					<tr>
						<td class="facilities_name"><a href="#">${facilitiesByMainSearch.name}</a></td>
					</tr>
					<tr>
						<td class="facilities_info"><i class="fas fa-house-user"></i>
							<span>${facilitiesByMainSearch.facilitiesOwner.name}│${facilitiesByMainSearch.city}</span></td>
					</tr>
					<tr>
						<td class="facilities_info"><i class="fas fa-map-marker-alt"></i>
							<span>${facilitiesByMainSearch.city} ${facilitiesByMainSearch.town}</span> 
							<i class="fas fa-user"></i> 
							<span>${facilitiesByMainSearch.guests}人</span>
						</td>
					</tr>
					<tr>
						<td class="facilities_info"><i class="fas fa-tags"></i> 
							<span>
							<c:forEach var="facilitiesTypeByMainSearch" items="${facilitiesByMainSearch.facilitiesType}">
									<a href="#">${facilitiesTypeByMainSearch.name}</a>/ 
							</c:forEach>
							</span>
						</td>
					</tr>
				</table>
				<a href="#">
					<div class="facilities_expense_per_hour">
						<p>每小時$${facilitiesByMainSearch.minBudget}起</p>
					</div>
				</a>
			</div>
		</c:forEach>
		</div>
	</div>

	<script src="vendors/jquery/jquery-3.6.0.min.js"></script>
</body>
</html>