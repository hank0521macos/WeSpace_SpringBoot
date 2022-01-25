<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WeSpace</title>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCelgQQuBsyBirT-R-gE3kEt9HyLO7fyH0&callback=initMap"></script>
<script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
<script src='//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js'></script>
<link href="https://unpkg.com/nanogallery2/dist/css/nanogallery2.min.css" rel="stylesheet" type="text/css"></link>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sticky-sidebar/3.3.1/sticky-sidebar.min.js"></script>
<link rel="stylesheet" href="css/SpacePage/SpacePage.css"><script type="text/javascript" src="https://unpkg.com/nanogallery2/dist/jquery.nanogallery2.min.js"></script>
<script src="js/SpacePage/SpacePage.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.css" />
<link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
<link type='text/css' href='css/SpacePage/basic.css' rel='stylesheet' media='screen' />
</head>

<body>
	<c:if test="${loginData == null || loginData.status == 0}">
		<jsp:include page="Header.jsp" flush="true" />
	</c:if>

	<c:if test="${loginData != null && loginData.status == 1}">
		<jsp:include page="HeaderLogin.jsp" flush="true" />
	</c:if>
    <div class="main">
        <div class="spaceImgArea">
        	<c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="0" end="0">
            	<a data-fancybox="gallery" href="${pageContext.request.contextPath}/uploaded/${facilitiesImage.name}"><div class="spaceImgLeft" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});"></div></a>
            </c:forEach>
            
            <div class="spaceImgRight">
	            <c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="1" end="1">
	                <a data-fancybox="gallery" href="${pageContext.request.contextPath}/uploaded/${facilitiesImage.name}"><div class="spaceImgRightTop" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});"></div></a>
	             </c:forEach>
	             
	             <c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="2" end="2">
	                <a data-fancybox="gallery" href="${pageContext.request.contextPath}/uploaded/${facilitiesImage.name}"><div class="spaceImgRightBottom" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});"></div></a>
	         	</c:forEach>
	         	
	            <c:forEach var="facilitiesImage" items="${facilities.facilitiesImages}" begin="3">
	            	<a data-fancybox="gallery" href="${pageContext.request.contextPath}/uploaded/${facilitiesImage.name}" style="display:none;"></a>
	            </c:forEach>
            </div>
        </div>
    </div>
        <div id="main-content" class="main clearfix">
        <!-- ------------左側訂單資訊------------ -->
            <form action="/orderPage" method="post">
	            <div id="sidebar" class="sidebar">
	                <div class="sidebar__inner">
	                    <div class="spaceExpense" id="spaceExpense">
	                        <p>每小時</p>
	                        $${facilities.minBudget} - ${facilities.maxBudget}
	                    </div>
	                    <div class="orderDate" id="orderDate">
	                        請選擇日期
	                    </div>
	                    <div class="orderTime">
	                   		<select class="selectTime" id="startTime" name="startTime">
	                   			<option disabled selected>開始時間</option>
	                   		</select>
	                   		<i class="fas fa-long-arrow-alt-right"></i>
	                   		<select class="selectTime" id="closeTime" name="endTime">
	                   			<option disabled selected>結束時間</option>
	                   		</select>
	                    </div>
	                    <div class="subTotal"></div>
	                    <!-- 透過js賦值傳遞參數給結帳頁面 -->
	                    <input type="hidden" name="periodExpense">
	                    <input type="hidden" name="facilities" value="${facilities.id}">
	                    <input type="hidden" name="ordersDate">
	                    <input type="hidden" name="expense">
	                    
	                    <div class="Total"></div>
	                    <div class="orderSubmit">
	                        <input type="button" value="線上預訂" disabled>
	                    </div>
	                </div>
	            </div>
			</form>
			
			<!-- ------------右側空間資訊------------ -->
            <div id="content" class="content">
                <div class="contentPageQQ" style="background-image: url(img/contentPageQQ.png);"></div>

                <div class="spaceBasicInfo">
                    <h1>${facilities.name}</h1>
                    <p>台灣 > ${facilities.city} > ${facilities.town} &nbsp; &nbsp; 
                        <i class="fas fa-map-marker-alt"></i>
                        ${facilities.address}</p>
                </div>

                <div class="spaceSize">
<!--                     <div class="spaceSizeInfo">
                        <i class="far fa-star"></i>
                        4.6 / 5則評價
                    </div> -->
                    <div class="spaceSizeInfo">
                        <i class="fas fa-user-friends"></i>
                        可容納${facilities.guests}人
                    </div>
                    <div class="spaceSizeInfo">
                        <i class="fab fa-artstation"></i>
                        面積${facilities.size}坪
                    </div>
                    <div class="spaceItem">
                        <h1>設備與服務</h1>
                        <table>
                            <tr>
	                            <c:forEach var="facilitiesItems" items="${facilities.facilitiesItems}" begin="0" end="2">
	                                <td><i class="fas fa-check"></i>&nbsp;${facilitiesItems.name}</td>
	                           	</c:forEach>	
                            </tr>
                            <tr>
	                            <c:forEach var="facilitiesItems" items="${facilities.facilitiesItems}" begin="3" end="5">
	                                <td><i class="fas fa-check"></i>&nbsp;${facilitiesItems.name}</td>
	                           	</c:forEach>
                            </tr>
                        </table>
                        <button id="showAllItems">顯示全部設備與服務</button>
                    </div>
                    <div class="spaceType">
                        <div id="chartContainer" class="chartContainer"></div>
                        <div class="block1"></div>
                        <div class="block2"></div>
                    </div>
                    <div class="datePickerArea">
                        <h1>預約狀況</h1>
                        <div id="datepicker"></div>
                    </div>
                    <div class="spacePolicy">
                        <h1>場地規範</h1>
                        <p>${facilities.rules}</p>
                    </div>
                    <div class="spaceLocation">
                        <div class="spaceAddress">
                            <h1>位置資訊</h1>
                            <p>台灣 ${facilities.city} ${facilities.town}</p>
                            <p>${facilities.address}</p>
                        </div>
                        <div class="spaceTransportation">
                            <h1>交通資訊</h1>
                            <p>【捷運】 ${facilities.takeByTrain}</p>
                            <p>【公車】 ${facilities.takeByBus}</p>
                            <p>【停車資訊】 ${facilities.takeByCar}</p>
                        </div>
                        <div id="map"></div>
                    </div>
                    <div class="spaceOwner">
                        <h1>管理者資訊</h1>
                        <div class="spaceOwnerInfo">
                            <div class="ownerPic" style="background-image:url(${pageContext.request.contextPath}/uploaded/${facilities.facilitiesOwner.image});"></div>
                            <div class="ownerDetail">
                                ${facilities.facilitiesOwner.name}
                            </div>
                        </div>
                    </div>
                    <div class="spaceCancellation">
                        <h1>退訂政策</h1>
                        <p>${facilities.cancellationPolicy}</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 設備的modal content -->
        <div id="basic-modal-content">
        	<div class="spaceSupply">
	        	<h1>設備</h1>
	        	<c:forEach var="facilitiesItems" items="${facilities.facilitiesItems}">
	        		<p><i class="fas fa-check"></i>&nbsp;&nbsp;${facilitiesItems.name}</p>
	        	</c:forEach>
	        </div>
        </div>
        <!-- 讀取設備視窗的xx圖片 -->
        <div style='display:none'>
            <img src='img/x.png' alt='' />
        </div>

	<!-- ------------下面footer資訊------------ -->
    <div class="banner" style="background-image: url(img/banner.png);"></div>

    <script src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.js"></script>
    <script type="text/javascript" src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
    <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
	<script type='text/javascript' src='js/SpacePage/jquery.simplemodal.js'></script>
	<script type='text/javascript' src='js/SpacePage/basic.js'></script>
	
	
	<!-- <script type='text/javascript' src='js/SpacePage/jquery.js'></script> -->
    <script>
	// Load dialog on click
	$('#showAllItems').click(function (e) {
		$('#basic-modal-content').modal();
		return false;
	});
	
    var sidebar = new StickySidebar('#sidebar', { // 要固定的側邊欄
            containerSelector: '#main-content', // 側邊欄外面的區塊
            innerWrapperSelector: '.sidebar__inner',
            topSpacing: 100, // 距離頂部 20px，可理解成 padding-top:20px
            bottomSpacing: 250 // 距離底部 20px，可理解成 padding-bottom:20px
        });
    </script>
    <script>
        $("#my_nanogallery2").nanogallery2({
            thumbnailWidth: 400, // 縮圖寬度
            thumbnailHeight: 300, // 縮圖高度
            galleryDisplayMode: "moreButton",
            galleryDisplayMoreStep: 2, // 最多顯示幾行
            galleryTheme: {
            thumbnail : { background: '#666666', borderColor: '#F1F2F2'}},
        });
    </script>

    <script>
    	const type = ${ordersTypeList};
    	var dataPoints = [];
        for (var i = 0; i <= (type.length/3-1); i++){
        	dataPoints.push({ y: type[i*3], label: type[i*3+1], indexLabel: type[i*3+2]});
        }
        window.onload = function () {
        //Better to construct options first and then pass it as a parameter
        var options = {
            animationEnabled: true,
            title: {
                text: "適合的活動",             
                fontColor: "#4e4e4e",
                horizontalAlign: "center",
                fontSize:20,
                fontWeight:"bold",
                margin:22
            },	
            axisY: {
                tickThickness: 0,
                lineThickness: 0,
                valueFormatString: " ",
                gridThickness: 0                    
            },
            axisX: {
                tickThickness: 0,
                lineThickness: 0,
                labelFontSize: 18,
                labelFontColor: "gray"				
            },
            data: [{
                indexLabelFontSize: 12,
                toolTipContent: "<span style=\"color:#95bfaf\">{indexLabel}:</span> <span style=\"color:#95bfaf\"><strong>{y}</strong></span>",
                indexLabelPlacement: "inside",
                indexLabelFontColor: "white",
                indexLabelFontWeight: 600,
                indexLabelFontFamily: "Verdana",
                color: "#95bfaf",
                type: "bar",
                dataPoints: dataPoints
            }]
        };
        
        
        $("#chartContainer").CanvasJSChart(options);
        }
        </script>
        <script>    
            var opt={
               dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
               dayNamesMin:["日","一","二","三","四","五","六"],
               monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
               monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
               prevText:"上月",
               nextText:"次月",
               weekHeader:"週",
               showMonthAfterYear:true,
               dateFormat:"yy-mm-dd",
               numberOfMonths: 2,
               minDate: new Date(),
               onSelect: show_select,
               beforeShowDay: function(date) { 
               var day = date.getDay();
               var facilitiesOpeningDays = ${facilitiesOpeningDays}
               for(i=0;i<=6;i++){
	               if(facilitiesOpeningDays[i]==7){
	            	   facilitiesOpeningDays[i]=0
	               }
               }
               return [(day == facilitiesOpeningDays[0])||(day == facilitiesOpeningDays[1])||(day == facilitiesOpeningDays[2])||(day == facilitiesOpeningDays[3])||
            	   (day == facilitiesOpeningDays[4])||(day == facilitiesOpeningDays[5])||(day == facilitiesOpeningDays[6]), '']; 
               } 
           };
            $("#datepicker").datepicker(opt);
            
            function show_select() {
            	   $(".orderTime").css("display","block");
            	   var date=$("#datepicker").datepicker("getDate");
            	   var day = toweek(date);
            	   refreshStartTimeSelect(date);
            	   date = $.datepicker.formatDate("yy-mm-dd", date);
            	   $("#orderDate").html(date +"&nbsp;&nbsp;"+ day);
            	   $("input[name='ordersDate']").val(date);
            	   $(".spaceExpense p").css("color","rgb(78,78,78)");
            	   $("#spaceExpense").css("color","rgb(78,78,78)");
            	   $('#closeTime').empty();
            	   $('#closeTime').append('<option selected disabled>結束時間</option>');
           		   $(".subTotal").css("display","none");
        		   $(".Total").css("display","none");
        		   $('.subTotal').empty();
        		   $('.Total').empty();
           		   $('.orderSubmit').empty();
        		   $('.orderSubmit').append('<input type="button" value="線上預訂" disabled>');
           	}
            
            function toweek(date){
            	let datelist = ['週日','週一','週二','週三','週四','週五','週六']
            	return datelist[new Date(date).getDay()];
            }
            
        	//ajax動態刷新select表單方法
        	function refreshStartTimeSelect(date) {
        		$('#startTime').empty();
				var openingDayId = new Date(date).getDay();
				if(openingDayId == 0){
					openingDayId = 7;
				}
        		$.ajax({
        			type: "GET",
        			url: "/listTime/"+${facilities.id}+"&"+openingDayId,
        			success: function(data) {
        				var openingDetail = JSON.parse(JSON.stringify(data));
        				$('#startTime').append('<option selected disabled>開始時間</option>');
        				for(i=0;i<=openingDetail.closeTime-openingDetail.startTime;i++){
        					var sum =parseInt(openingDetail.startTime)+parseInt(i)
        					$('#startTime').append('<option value="'+sum+'">'+sum+':00</option>');
        				}
        			},
        			error: function(data) {
        				console.log(data);
        			}
        		});
        	};
        	
        	$("#startTime").change(refreshCloseTimeSelect);
        	
          	//ajax動態刷新select表單方法
        	function refreshCloseTimeSelect() {
        		let switchValue = $(this).val();
        		var date=$("#datepicker").datepicker("getDate");
         		$('#closeTime').empty();
				var openingDayId = new Date(date).getDay();
				if(openingDayId == 0){
					openingDayId = 7;
				}
        		$.ajax({
        			type: "GET",
        			url: "/listTime/"+${facilities.id}+"&"+openingDayId,
        			success: function(data) {
        				var openingDetail = JSON.parse(JSON.stringify(data));
        				$('#closeTime').append('<option selected disabled>結束時間</option>');
        				for(i=0;i<=openingDetail.closeTime-switchValue;i++){
        					var sum =parseInt(switchValue)+parseInt(i)
        					$('#closeTime').append('<option value="'+sum+'">'+sum+':00</option>');
        				}
        			},
        			error: function(data) {
        				console.log(data);
        			}
        		});
        	};
            
        	$("#closeTime").change(displaySubTotal);
        	
        	//出現小計區塊
        	function displaySubTotal(){
        		$(".subTotal").css("display","block");
        		$(".Total").css("display","block");
        		$('.subTotal').empty();
        		$('.Total').empty();
        		let closeTime = $(this).val();
        		let startTime = $("#startTime").val();
        		var date=$("#datepicker").datepicker("getDate");
				var openingDayId = new Date(date).getDay();
				if(openingDayId == 0){
					openingDayId = 7;
				}
        		$.ajax({
        			type: "GET",
        			url: "/listTime/"+${facilities.id}+"&"+openingDayId,
        			success: function(data) {
        				var openingDetail = JSON.parse(JSON.stringify(data));
                		$('.subTotal').append('<span class="subTotalLeft">$'+openingDetail.expense+' x '+(closeTime-startTime)+'小時</span><span class="subTotalRight">$'+(openingDetail.expense*(closeTime-startTime))+'</span>');
                		$('.Total').append('<span class="twd">TWD</span><span class="totalPrice">$'+(openingDetail.expense*(closeTime-startTime))+'</span>');
                		$("input[name='expense']").val(openingDetail.expense*(closeTime-startTime));
                		$("input[name='periodExpense']").val(openingDetail.expense);
                		$('.orderSubmit').empty();
                		$('.orderSubmit').append('<input type="submit" style="background-color:rgb(249, 111, 72);" value="線上預訂">');
        			},
        			error: function(data) {
        				console.log(data);
        			}
        		});
        	
        	
        	}
            
        </script>
        <script>
            let map;
			var address = '台灣'+'${facilities.city}'+'${facilities.town}'+'${facilities.address}';
			var geocoder = new google.maps.Geocoder(); 
			 geocoder.geocode( { 'address': address}, function(results, status) {
		            //狀態為OK才可以進行
		            if (status == google.maps.GeocoderStatus.OK) {
		                var latitude = results[0].geometry.location.lat(); 
		                var longitude = results[0].geometry.location.lng();
		                
		                //使用Map JavaScript API的LatLng物件當經緯度
		                Latlng = new google.maps.LatLng(latitude,longitude);
		                
		                //用變數在地圖使用哪些參數
		                var mapOptions = {
		                    zoom:16,
		                    zoomControl:true,
		                    center:Latlng,
		                    mapTypeId: google.maps.MapTypeId.ROADMAP
		                }
		            
		            //在頁面上使用Map JavaScript API的Map物件檔地圖(map與copy_map)
		            var map = new google.maps.Map(document.getElementById('map'),mapOptions);
		
		            //使用Map JavaScript API的marker物件設定經緯度 
		            var marker = new google.maps.Marker({
		                position: Latlng
		            });
		            
		            //id為map與copy_map區塊 set地圖物件
	                marker.setMap(map);
	            	
	                //顯示id為map區塊，隱藏id為copy_map區塊
	                $("#map").show();
	               
	                console.log(results[0].formatted_address);
	            } else {
	                alert("Geocode was not successful for the following reason: "+status);
	            }
	        });
		           
            
        </script>
</body>

</html>