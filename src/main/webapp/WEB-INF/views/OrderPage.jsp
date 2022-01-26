<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/OrderPage/orderPage.css">
    <script src="vendors/jquery/jquery-3.6.0.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <title>WeSpace</title>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
    <script src="js//OrderPage/orderPage.js"></script>
</head>
<body>
	<c:if test="${loginData == null || loginData.status == 0}">
		<jsp:include page="Header.jsp" flush="true" />
	</c:if>

	<c:if test="${loginData != null && loginData.status == 1}">
		<jsp:include page="HeaderLogin.jsp" flush="true" />
	</c:if>
	
	<form action="/addOrders" method="post" onsubmit="return checkError();">
    <div class="tab1">
        <div class="contentPageLeft">
            <div class="step">
                <a href="${pageContext.request.contextPath}/oneSpacePage?facilitiesId=${orderData.facilities.id}"><i class="far fa-arrow-alt-circle-left"></i></a>
                <span>第1步/共2步</span>
            </div>
            <div class="barLine">
                <div class="barLineLeft"></div>
                <div class="barLineRight"></div>
            </div>

            <div class="formTitle">
                <span class="formTitleLeft">你將如何使用空間*</span>
                <span class="formTitleRight">使用人數*</span>
            </div>

            <div class="form">
                <select name="facilitiesType" class="spaceType">
                    <option value="" disabled selected>使用目的</option>
                    <c:forEach var="facilitiesType" items="${facilitiesTypeAll}">
                    	<option value="${facilitiesType.facilitiesTypeId}">${facilitiesType.name}</option>
                    </c:forEach>
                </select>

                <div class="input-group">
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-default btn-number" disabled="disabled" data-type="minus" data-field="quantity">
                            <span class="glyphicon glyphicon-minus"></span>
                        </button>
                    </span>
                    <input type="text" onkeyup="value=value.replace( /[^\d]/g,'')" name="quantity" class="form-control input-number" value="1" min="1" max="${orderData.facilities.guests}" style="text-align:center;">
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-default btn-number" data-type="plus" data-field="quantity">
                            <span class="glyphicon glyphicon-plus"></span>
                        </button>
                    </span>
                </div>
            </div>

            <div class="formTitle">
                <span>備註</span>
            </div>
            <div class="form">
                <textarea name="note" placeholder="您可以留言或詢問場地主:可否提供折疊椅或投影機、寵物可否進入等等"></textarea>
            </div>
            <div class="bottomLine"></div>
            <div class="buttonArea">
                <p>您還不會被收費</p>
                <p style="color: #53A385;">*必填</p>
                <a href="javascript:;" class="tab" id="tab1">下一步</a>
            </div>
        </div>
        
        <div class="contentPageRight">
            <div class="spaceInfo">
            	<c:forEach var="facilitiesImage" items="${orderData.facilities.facilitiesImages}" begin="0" end="0">
                	<div class="spaceImg" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});"></div>
                </c:forEach>
                <div class="spaceName">${orderData.facilities.name}</div>
                <div class="spaceAddress">
                    <i class="far fa-compass"></i>
                    ${orderData.facilities.city}${orderData.facilities.town}${orderData.facilities.address}
                </div>
                <div class="orderDate">
                	<fmt:formatDate value='${orderData.date}' pattern='yyyy 年 MM 月 dd 日'/>
                </div>
                <div class="orderTime">${orderData.startTime}:00-${orderData.endTime}:00</div>
                <div class="subTotal">
                    <span>$${periodExpense} x ${orderData.endTime-orderData.startTime} 小時</span>
                    <span class="subTotalPrice">$${periodExpense*(orderData.endTime-orderData.startTime)}</span>
                </div>
                <div class="total">
                    <span>總計(TWD)</span>
                    <span class="totalPrice">$${orderData.expense}</span>
                </div>
            </div>
        </div>
    </div>
	<input type="hidden" name="facilitiesId" value="${orderData.facilities.id}">
	<input type="hidden" name="date" value="${orderData.date}">
	<input type="hidden" name="startTime" value="${orderData.startTime}">
	<input type="hidden" name="endTime" value="${orderData.endTime}">
	<input type="hidden" name="expense" value="${orderData.expense}">
	
    <!-- 第二步驟 -->
    <div class="tab2">
        <div class="contentPageLeft2">
            <div class="step">
                <i class="far fa-arrow-alt-circle-left" id="backTo1"></i>
                <span>第2步/共2步</span>
            </div>
            <div class="barLine">
                <div class="barLineLeft2"></div>
                <div class="barLineRight2"></div>
            </div>
            <div class="contactInfo">聯絡人資料</div>
            <div class="formTitle">
                <span class="formTitleLeft2" id="firstnameError">聯絡人姓*</span>
                <span class="formTitleRight2" id="lastnameError">名*</span>
            </div>

            <div class="form">
                <input type="text" name="firstname" id="firstname" value="${member.firstname}">
                <input type="text" name="lastname" id="lastname" value="${member.lastname}">
            </div>

            <div class="formTitle">
                <span class="formTitleLeft2" id="contactMobilePhoneError">聯絡電話*</span>
            </div>

            <div class="form">
                <input type="text" placeholder="Taiwan (+886)" disabled>
                <input type="text" id="contactMobilePhone" onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="10" name="contactMobilePhone" value="${member.mobilePhone}">
            </div>


            <div class="formTitle">
                <span class="formTitleLeft2" id="contactEmailError">Email*</span>
            </div>

            <div class="form">
                <input type="email" id="contactEmail" name="contactEmail" style="width:70%" value="${member.email}">
            </div>

            <div class="contactInfo">選擇付款信用卡</div>
            <div class="formTitle">
                <span class="formTitleLeft2" id="creditCardNoError">信用卡號*</span>
            </div>
            <div class="form">
                <input type="text" id="creditCardNo1" name="creditCardNo" maxlength="4" size="4" onkeyup="value=value.replace( /[^\d]/g,'')" onKeyUp="next(this)" class="creditCardNumber" style="margin-right: 5px;">-
                <input type="text" id="creditCardNo2" name="creditCardNo" maxlength="4" size="4" onkeyup="value=value.replace( /[^\d]/g,'')" onKeyUp="next(this)" class="creditCardNumber" style="margin-right: 5px;">-
                <input type="text" id="creditCardNo3" name="creditCardNo" maxlength="4" size="4" onkeyup="value=value.replace( /[^\d]/g,'')" onKeyUp="next(this)" class="creditCardNumber" style="margin-right: 5px;">-
                <input type="text" id="creditCardNo4" name="creditCardNo" maxlength="4" size="4" onkeyup="value=value.replace( /[^\d]/g,'')" onKeyUp="next(this)" class="creditCardNumber" style="margin-right: 5px;">
            </div>
            <div class="formTitle">
                <span class="formTitleLeft2" id="creditCardDateError">到期月年*</span>
                <span class="formTitleRight2" style="margin-left: 185px;" id="creditCardCvcError">驗證碼</span>
            </div>
            <div class="form">
                <input type="text" id="creditCardMonth" name="creditCardMonth" class="creditCardDate" onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="2" style="margin-right: 10px;" placeholder="01">
                <input type="text" id="creditCardYear" name="creditCardYear" class="creditCardDate" onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="2" style="margin-right: 10px;" placeholder="23">
                <input type="text" id="creditCardCvc" name="creditCardCvc" class="creditCardDate" onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="3" style="margin-right: 10px;" placeholder="123">
            </div>
            <div class="bottomLine2"></div>
            <div class="buttonArea">
                <h5>三大保證，安心交易</h5>
                <p>幕後授權服務由第三方金流「綠界金流」提供，WeSpace不會儲存您的任何信用卡資訊。</p>
                <input type="submit" value="送出預訂" class="orderSubmit">
            </div>
        </div>
        
     	<div class="contentPageRight2">
            <div class="spaceInfo">
                <c:forEach var="facilitiesImage" items="${orderData.facilities.facilitiesImages}" begin="0" end="0">
                	<div class="spaceImg" style="background-image: url(${pageContext.request.contextPath}/uploaded/${facilitiesImage.name});"></div>
                </c:forEach>
                <div class="spaceName">${orderData.facilities.name}</div>
                <div class="spaceAddress">
                    <i class="far fa-compass"></i>
                    ${orderData.facilities.city}${orderData.facilities.town}${orderData.facilities.address}
                </div>
                <div class="orderDate">
                	<fmt:formatDate value='${orderData.date}' pattern='yyyy 年 MM 月 dd 日'/>
                </div>
                <div class="orderTime">${orderData.startTime}:00-${orderData.endTime}:00</div>
                <div class="subTotal">
                    <span>$${periodExpense} x ${orderData.endTime-orderData.startTime} 小時</span>
                    <span class="subTotalPrice">$${periodExpense*(orderData.endTime-orderData.startTime)}</span>
                </div>
                <div class="total">
                    <span>總計(TWD)</span>
                    <span class="totalPrice">$${orderData.expense}</span>
                </div>
            </div>
        </div>
    </div>
    </form>

    <script>
        $(document).ready(function(){
            $("#tab1").click(function(){
                $(".tab1").css("display","none");
                $(".tab2").css("display","block");
            })

            $("#backTo1").click(function(){
                $(".tab1").css("display","block");
                $(".tab2").css("display","none");
            })
            
        })
        
        function checkError(){
        	if($('#firstname').val()==''||$('#lastname').val()==''||$('#contactMobilePhone').val()==''||
        	   $('#contactEmail').val()==''|| $('#creditCardMonth').val()==''||$('#creditCardCvc').val()==''){
				if($('#firstname').val()==''){
					$('#firstname').css("border","1px solid red");
					$('#firstnameError').css("color","red");
				}
				if($('#lastname').val()==''){
					$('#lastname').css("border","1px solid red");
					$('#lastnameError').css("color","red");
				}
				if($('#contactMobilePhone').val()==''){
					$('#contactMobilePhone').css("border","1px solid red");
					$('#contactMobilePhoneError').css("color","red");
				}
				if($('#contactEmail').val()==''){
					$('#contactEmail').css("border","1px solid red");
					$('#contactEmailError').css("color","red");
				}
				if($('#creditCardNo1').val()==''){
					$('#creditCardNo1').css("border","1px solid red");
				}
				if($('#creditCardNo2').val()==''){
					$('#creditCardNo2').css("border","1px solid red");
				}
				if($('#creditCardNo3').val()==''){
					$('#creditCardNo3').css("border","1px solid red");
				}
				if($('#creditCardNo4').val()==''){
					$('#creditCardNo4').css("border","1px solid red");
				}
				if($('#creditCardNo1').val()==''|| $('#creditCardNo2').val()==''|| $('#creditCardNo3').val()==''|| $('#creditCardNo4').val()==''){
					$('#creditCardNoError').css("color","red");
				}
				if($('#creditCardMonth').val()==''){
					$('#creditCardMonth').css("border","1px solid red");
					$('#creditCardDateError').css("color","red");
				}
				if($('#creditCardYear').val()==''){
					$('#creditCardYear').css("border","1px solid red");
					$('#creditCardDateError').css("color","red");
				}
				if($('#creditCardCvc').val()==''){
					$('#creditCardCvc').css("border","1px solid red");
					$('#creditCardCvcError').css("color","red");
				}
				return false;
        	}else{
        		return true;
        	}
        }
    </script>
</body>
</html>