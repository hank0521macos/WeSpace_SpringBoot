<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WeSpace</title>
    <link rel="stylesheet" href="css/HomePage/HomePage.css">
    <link rel="stylesheet" href="css/HomePage/slider.css">
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
</head>
<body>
	<c:if test="${loginData == null || loginData.status == 0}">
		<jsp:include page="Header.jsp" flush="true" />
	</c:if>
	
	<c:if test="${loginData != null && loginData.status == 1}">
		<jsp:include page="HeaderLogin.jsp" flush="true" />
	</c:if> 
	
	<form action="/searchResult"" method="get" id="form1">
    <div class="search_area">
        <div class="slideshow">
            <img src="img/MainPhoto1.jpg" alt="">
            <img src="img/MainPhoto2.jpg" alt="">
        </div>
        <div class="option_menu_1">
            <select name="facilitiesTypeId">
                <option disabled selected><spring:message code="homepage.searchBox.spaceType"/></option>
	            <c:forEach var="facilitiesType" items="${facilitiesTypeAll}">
	            	<option value="${facilitiesType.facilitiesTypeId}">${facilitiesType.name}</option>
	            </c:forEach>    
            </select>
        </div>
        <div class="option_menu_2">
            <select name="facilitiesCity">
                <option disabled selected><spring:message code="homepage.searchBox.spaceLocation"/></option>
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
        </div>
        <div class="option_menu_3">
            <select name="facilitiesGuests">
                <option disabled selected><spring:message code="homepage.searchBox.spaceGuests"/></option>
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
        </div>
        <input type="submit" value="<spring:message code="homepage.searchButton"/>" class="search_area_button">
    </div>
    </form>

    <div class="slidermenu_area">
        <div class="sliderBox">
            <div class="slider">
              <ul class="list">
                <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=5">
                        <h1><spring:message code="homepage.catg.lecture"/></h1>
                        <p><i class="fas fa-chalkboard"></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
                 <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=2">
                        <h1><spring:message code="homepage.catg.party"/></h1>
                        <p><i class="fas fa-birthday-cake"></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
                 <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=1">
                        <h1><spring:message code="homepage.catg.meeting"/></h1>
                        <p><i class="far fa-handshake"></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
                 <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=3">
                        <h1><spring:message code="homepage.catg.dinner"/></h1>
                        <p><i class="fas fa-utensils"></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
                 <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=11">
                        <h1><spring:message code="homepage.catg.photography"/></h1>
                        <p><i class="fas fa-video"></i></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
                 <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=9">
                        <h1><spring:message code="homepage.catg.show"/></h1>
                        <p><i class="fas fa-drum"></i></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
                 <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=8">
                        <h1><spring:message code="homepage.catg.exhibition"/></h1>
                        <p><i class="fas fa-beer"></i></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
                 <li>
                    <a href="${pageContext.request.contextPath}/searchResult?facilitiesTypeId=15">
                        <h1><spring:message code="homepage.catg.conference"/></h1>
                        <p><i class="fas fa-book-reader"></i></i></p>
                        <h2><spring:message code="homepage.catg.seeMore"/></h2>  
                    </a>
                 </li>
              </ul>
            </div>
            <a href="javascript:;" class="dIcon next">Next</a>
            <a href="javascript:;" class="dIcon prev">Prev</a>
          </div>
        </div>
    </div>

    <div class="special_collections">
        <div class="special_collections_mark"><i class="fas fa-laptop-house"></i></div>
        <div class="special_collections_title"><spring:message code="homepage.hotSpace"/></div>
        
        <c:forEach var="facilities" items="${facilitiesAll}" begin="0" end="0">
            <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilities.id}">
            <c:if test="${empty facilities.facilitiesImages}">
                <div class="special_collections_item_long_1" style="background-image: url(img/default.png);">
                    <c:if test="${facilities.name == '' or facilities.name == null}">
						<h1>未命名</h1>
					</c:if>  
                    <h1>${facilities.name}</h1>
                </div>
            </c:if>
            	<c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="0" end="0">
	                <div class="special_collections_item_long_1" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});">
	                 	<c:if test="${facilities.name == '' or facilities.name == null}">
								<h1>未命名</h1>
						</c:if>
	                 	<h1>${facilities.name}</h1>
	                </div>
                </c:forEach>
            </a>
        </c:forEach>
        
        <c:forEach var="facilities" items="${facilitiesAll}" begin="1" end="2">
            <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilities.id}">
           	<c:if test="${empty facilities.facilitiesImages}">
                <div class="special_collections_item_short_1" style="background-image: url(img/default.png);">
                    <c:if test="${facilities.name == '' or facilities.name == null}">
						<h1>未命名</h1>
					</c:if>  
                    <h1>${facilities.name}</h1>
                </div>
            </c:if>
            	<c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="0" end="0">
	                <div class="special_collections_item_short_1" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});">
	                    <c:if test="${facilities.name == '' or facilities.name == null}">
								<h1>未命名</h1>
						</c:if>
	                    <h1>${facilities.name}</h1>
	                </div>
                </c:forEach>
            </a>
        </c:forEach>
        
		<c:forEach var="facilities" items="${facilitiesAll}" begin="3" end="4">
            <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilities.id}">
            <c:if test="${empty facilities.facilitiesImages}">
                <div class="special_collections_item_short_2" style="background-image: url(img/default.png);">
                    <c:if test="${facilities.name == '' or facilities.name == null}">
						<h1>未命名</h1>
					</c:if>  
                    <h1>${facilities.name}</h1>
                </div>
            </c:if>
            <c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="0" end="0">
                <div class="special_collections_item_short_2" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});">
                 	<c:if test="${facilities.name == '' or facilities.name == null}">
						<h1>未命名</h1>
					</c:if>                   
                    <h1>${facilities.name}</h1>
                </div>
            </c:forEach>
            </a>
        </c:forEach>
        
		<c:forEach var="facilities" items="${facilitiesAll}" begin="5" end="5">
            <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilities.id}">
            <c:if test="${empty facilities.facilitiesImages}">
                <div class="special_collections_item_long_2" style="background-image: url(img/default.png);">
                    <c:if test="${facilities.name == '' or facilities.name == null}">
						<h1>未命名</h1>
					</c:if>  
                    <h1>${facilities.name}</h1>
                </div>
            </c:if>
            <c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="0" end="0">
                <div class="special_collections_item_long_2" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});">
                    <c:if test="${facilities.name == '' or facilities.name == null}">
						<h1>未命名</h1>
					</c:if>  
                    <h1>${facilities.name}</h1>
                </div>
           </c:forEach>
            </a>
        </c:forEach>
    </div>

    <div id="advertise"></div>

    <div class="catg">
        <h2><spring:message code="homepage.catg.lecture"/></h2>
        <p><spring:message code="homepage.lecture.title"/></p>
        <div data-aos="fade-up" data-aos-delay="150" data-aos-duration="1000">
            <ul>
            <c:forEach var="facilitiesType5" items="${facilitiesType5}" begin="0" end="2">
	            <c:if test="${empty facilitiesType5.facilitiesImages}">
	                <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesType5.id}">
	                    <li style="background-image: url(img/default.png);">
	                        <div class="catg_info_1">${facilitiesType5.city}．${facilitiesType5.guests}人</div>
	                        <div class="catg_info_2">$${facilitiesType5.minBudget}/hr</div>
			                <c:if test="${facilitiesType5.name == '' or facilitiesType5.name == null}">
								<div class="catg_info_3">未命名</div>
							</c:if>       
	                        <div class="catg_info_3">${facilitiesType5.name}</div>
	                    </li>
	                </a>
	             </c:if>
                <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesType5.id}">
                	<c:forEach var="facilitiesImage" items="${facilitiesType5.facilitiesImages}" begin="0" end="0">
	                    <li style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});">
	                        <div class="catg_info_1">${facilitiesType5.city}．${facilitiesType5.guests}人</div>
	                        <div class="catg_info_2">$${facilitiesType5.minBudget}/hr</div>
	                        <c:if test="${facilitiesType5.name == '' or facilitiesType5.name == null}">
								<div class="catg_info_3">未命名</div>
							</c:if>    
	                        <div class="catg_info_3">${facilitiesType5.name}</div>
	                    </li>
                    </c:forEach>
                </a>
           	</c:forEach>
            </ul>
        </div>
    </div>

    <div class="catg">
        <h2><spring:message code="homepage.catg.meeting"/></h2>
        <p><spring:message code="homepage.meeting.title"/></p>
        <div data-aos="fade-up" data-aos-delay="150" data-aos-duration="1000">
            <ul>
             <c:forEach var="facilitiesType1" items="${facilitiesType1}" begin="0" end="2">
             <c:if test="${empty facilitiesType1.facilitiesImages}">
                <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesType1.id}">
                    <li style="background-image: url(img/default.png);">
                        <div class="catg_info_1">${facilitiesType1.city}．${facilitiesType1.guests}人</div>
                        <div class="catg_info_2">$${facilitiesType1.minBudget}/hr</div>
                        <c:if test="${facilitiesType1.name == '' or facilitiesType1.name == null}">
							<div class="catg_info_3">未命名</div>
						</c:if>    
                        <div class="catg_info_3">${facilitiesType1.name}</div>
                    </li>
                </a>
             </c:if>
                <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesType1.id}">
                	<c:forEach var="facilitiesImage" items="${facilitiesType1.facilitiesImages}" begin="0" end="0">
	                    <li style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});">
	                        <div class="catg_info_1">${facilitiesType1.city}．${facilitiesType1.guests}人</div>
	                        <div class="catg_info_2">$${facilitiesType1.minBudget}/hr</div>
		                   	<c:if test="${facilitiesType1.name == '' or facilitiesType1.name == null}">
								<div class="catg_info_3">未命名</div>
							</c:if>    
	                        <div class="catg_info_3">${facilitiesType1.name}</div>
	                    </li>
                    </c:forEach>
                </a>
           	</c:forEach>
            </ul>
        </div>
    </div>

    <div class="catg">
        <h2><spring:message code="homepage.catg.dinner"/></h2>
        <p><spring:message code="homepage.dinner.title"/></p>
        <div data-aos="fade-up" data-aos-delay="150" data-aos-duration="1000">
            <ul>
             <c:forEach var="facilitiesType3" items="${facilitiesType3}" begin="0" end="2">
	             <c:if test="${empty facilitiesType3.facilitiesImages}">
	                <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesType3.id}">
	                    <li style="background-image: url(img/default.png);">
	                        <div class="catg_info_1">${facilitiesType3.city}．${facilitiesType3.guests}人</div>
	                        <div class="catg_info_2">$${facilitiesType3.minBudget}/hr</div>
		                  	<c:if test="${facilitiesType3.name == '' or facilitiesType3.name == null}">
								<div class="catg_info_3">未命名</div>
							</c:if>    
	                        <div class="catg_info_3">${facilitiesType3.name}</div>
	                    </li>
	                </a>
	             </c:if>
                <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${facilitiesType3.id}">
                	<c:forEach var="facilitiesImage" items="${facilitiesType3.facilitiesImages}" begin="0" end="0">
	                    <li style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});">
	                        <div class="catg_info_1">${facilitiesType3.city}．${facilitiesType3.guests}人</div>
	                        <div class="catg_info_2">$${facilitiesType3.minBudget}/hr</div>
	                        <c:if test="${facilitiesType3.name == '' or facilitiesType3.name == null}">
								<div class="catg_info_3">未命名</div>
							</c:if>   
	                        <div class="catg_info_3">${facilitiesType3.name}</div>
	                    </li>
                    </c:forEach>
                </a>
           	</c:forEach>
            </ul>
        </div>
    </div>
    
	<form action="/OneSearchResult" method="get" id="form2">
	    <div class="search_area_2">
	        <h2><spring:message code="homepage.footer.search.title"/></h2>
	        <div class="search_area_2_select">
	          	<select name="facilitiesTypeId">
	                <option disabled selected><spring:message code="homepage.footer.search.spaceType"/></option>
		            <c:forEach var="facilitiesType" items="${facilitiesTypeAll}" varStatus="loot">
		            	<option value="${facilitiesType.facilitiesTypeId}">${facilitiesType.name}</option>
		            </c:forEach>    
	            </select>
	        </div>
	        <input type="submit" value="<spring:message code="homepage.footer.searchButton"/>" class="search_area2_button">
	    </div>
    </form>

    <script src="vendors/jquery/jquery-3.6.0.min.js"></script>
    <script src="js/HomePage/SliderShow.js"></script>
    <script src="js/HomePage/slider.js"></script>
    <!-- 捲軸監聽淡出 -->
    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
    <script>
      AOS.init();
    </script>
</body>
</html>