<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "spring" uri="http://www.springframework.org/tags"%>
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
		<form action="/subSearchResult" method="get" id="form1">
		<div class="sidebar">
			<p><spring:message code="searchResult.left.searchBox.purpose"/></p>
          	<select name="facilitiesTypeId">
                <option disabled selected><spring:message code="searchResult.left.searchBox.type"/></option>
	            <c:forEach var="facilitiesType" items="${facilitiesTypeAll}">
	            	<option value="${facilitiesType.facilitiesTypeId}">${facilitiesType.name}</option>
	            </c:forEach>    
            </select>
			<p><spring:message code="searchResult.left.searchBox.guests"/></p>
            <select name="facilitiesGuests">
                <option disabled selected><spring:message code="searchResult.left.searchBox.guests"/></option>
                <option value="1">1-10</option>
                <option value="11">11-20</option>
                <option value="21">21-40</option>
                <option value="41">41-60</option>
                <option value="61">61-80</option>
                <option value="81">81-100</option>
                <option value="101">101-200</option>
                <option value="201">201-300</option>
                <option value="301">301-400</option>
                <option value="401">401-500</option>
                <option value="501">500+</option>
            </select>
			<p><spring:message code="searchResult.left.searchBox.city"/></p>
			<select name="facilitiesCity">
                <option disabled selected><spring:message code="searchResult.left.searchBox.location"/></option>
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
			<p><spring:message code="searchResult.left.searchBox.maxBudget"/></p>
			<select name="facilitiesMaxBudget">
				<option disabled selected><spring:message code="searchResult.left.searchBox.select"/></option>
				<option value="200">200 NT$</option>
				<option value="300">300 NTS</option>
				<option value="400">400 NTS</option>
				<option value="500">500 NTS</option>
				<option value="700">700 NTS</option>
				<option value="1000">1000 NTS</option>
				<option value="1500">1500 NTS</option>
				<option value="2000">2000 NTS</option>
				<option value="3000">3000 NTS</option>
				<option value="4000">4000 NTS</option>
				<option value="5000">5000 NTS</option>
				<option value="7000">7000 NTS</option>
			</select>
			<p><spring:message code="searchResult.left.searchBox.minBudget"/></p>
			<select name="facilitiesMinBudget">
				<option disabled selected><spring:message code="searchResult.left.searchBox.select"/></option>
				<option value="200">200 NT$</option>
				<option value="300">300 NTS</option>
				<option value="400">400 NTS</option>
				<option value="500">500 NTS</option>
				<option value="700">700 NTS</option>
				<option value="1000">1000 NTS</option>
				<option value="1500">1500 NTS</option>
				<option value="2000">2000 NTS</option>
				<option value="3000">3000 NTS</option>
				<option value="4000">4000 NTS</option>
				<option value="5000">5000 NTS</option>
				<option value="7000">7000 NTS</option>
			</select>
			<p><spring:message code="searchResult.left.searchBox.searchName"/></p>
			<input type="text" class="name_search" name="facilitiesName">
			<p><spring:message code="searchResult.left.searchBox.weekdaysOrWeekends"/></p>
			<input type="radio" class="checkbox" name="facilitiesOpeningDay" value="1"><span><spring:message code="searchResult.left.searchBox.weekdays"/></span> 
			<input type="radio" class="checkbox" name="facilitiesOpeningDay" value="2"><span><spring:message code="searchResult.left.searchBox.weekends"/></span>
			<p>租用時段？</p>
			<input type="radio" name="facilitiesOpeningPeriod" class="checkbox" value="1"><span style="margin-right:16px;"><spring:message code="searchResult.left.searchBox.morning"/></span> 
			<input type="radio" name="facilitiesOpeningPeriod" class="checkbox" value="2"><span style="margin-right:16px;"><spring:message code="searchResult.left.searchBox.afternoon"/></span> 
			<input type="radio" name="facilitiesOpeningPeriod" class="checkbox" value="3"><span style="margin-right:16px;"><spring:message code="searchResult.left.searchBox.night"/></span>
			<input type="radio" name="facilitiesOpeningPeriod" class="checkbox" value="0"><span style="margin-right:16px;"><spring:message code="searchResult.left.searchBox.midnight"/></span> 
			<input type="submit" class="search-submit" value="<spring:message code="searchResult.left.searchBox.searchButton"/>">
		</div>
		</form>
		
		<!-- --------------------右側區塊-------------------- -->
		<div style="margin-top:100px;">
		<c:forEach var="facilitiesByMainSearch" items="${facilitiesByMainSearch}">
			<div class="search_result">
				<a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesByMainSearch.id}">
				<c:if test="${empty facilitiesByMainSearch.facilitiesImages}">
					<div class="search_result_item" style="background-image: url(img/default.png); background-position:center;"></div>
				</c:if>
				<c:if test="${not empty facilitiesByMainSearch.facilitiesImages}">
					<div class="search_result_item" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesByMainSearch.facilitiesImages.toArray()[0].name});"></div>
				</c:if>
				</a>
				<table>
					<tr>
						<td class="facilities_name"><a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesByMainSearch.id}">${facilitiesByMainSearch.name}</a></td>
					</tr>
					<tr>
						<td class="facilities_info"><i class="fas fa-house-user"></i>
							<span>${facilitiesByMainSearch.facilitiesOwner.name}│${facilitiesByMainSearch.city}</span></td>
					</tr>
					<tr>
						<td class="facilities_info"><i class="fas fa-map-marker-alt"></i>
							<span>${facilitiesByMainSearch.city} ${facilitiesByMainSearch.town}</span> 
							<i class="fas fa-user"></i> 
							<span>${facilitiesByMainSearch.guests}<spring:message code="searchResult.right.resultBox.person"/></span>
						</td>
					</tr>
					<tr>
						<td class="facilities_info"><i class="fas fa-tags"></i> 
							<span>
							<c:forEach var="facilitiesTypeByMainSearch" items="${facilitiesByMainSearch.facilitiesType}">
									<a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=${facilitiesTypeByMainSearch.facilitiesTypeId}">${facilitiesTypeByMainSearch.name}</a>｜ 
							</c:forEach>
							</span>
						</td>
					</tr>
				</table>
				<a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesByMainSearch.id}">
					<div class="facilities_expense_per_hour">
						<p><spring:message code="searchResult.right.resultBox.perHour"/>${facilitiesByMainSearch.minBudget}<spring:message code="searchResult.right.resultBox.atLeast"/></p>
					</div>
				</a>
			</div>
		</c:forEach>
		<!-- 若無搜尋結果則呈現此div -->
		<c:if test="${empty facilitiesByMainSearch}">
			<div class="search_result" style="
											  background-color:transparent;
											  font-size:30px;
											  color:gray;
											  text-align:center;
											  letter-spacing:5px;
											  padding-top:120px;">
				<i class="fas fa-exclamation-circle"></i>查無結果，請重設查詢條件
			</div>
		</c:if>
		</div>
	</div>

	<script src="vendors/jquery/jquery-3.6.0.min.js"></script>
</body>
</html>