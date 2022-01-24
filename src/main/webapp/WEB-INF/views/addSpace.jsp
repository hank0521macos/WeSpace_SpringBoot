<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WeSpace | 新增空間</title>
    <link rel="stylesheet" href="vendors/dist/switchery.css">
    <link rel="stylesheet" href="css/MemberBackEnd/addSpace.css">
    <script src="vendors/jquery/jquery-3.6.0.min.js"></script>
    <script src="vendors/dist/switchery.js"></script>
    <script src="vendors/jquery/jquery.twzipcode.min.js"></script>
    <script src="js/addSpace/addSpace.js"></script>
    <script src="js/addSpace/ajaxCRUD.js"></script>
    <script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
    
</head>
<body>
    <div class="tabs-container">
    
  		<!--  --------------------導航列-------------------- -->
        <div class="tabs-pages">          
            <div class="navbar">
            	<a href="${pageContext.request.contextPath}/mySpace">回前頁</a>
                <a href="javascript:;" class="tab active" id="tab1">
                	<c:if test="${spaceTypeError!=null}"><i class="fas fa-exclamation-triangle" style="color:red;"></i></c:if>
                	活動類型
                </a>
                <a href="javascript:;" class="tab" id="tab2">
                	<c:if test="${spaceNameError!=null}"><i class="fas fa-exclamation-triangle" style="color:red;"></i></c:if>
                	基本資訊
                </a>
                <a href="javascript:;" class="tab" id="tab3">
                    <c:if test="${spaceAddressError!=null}"><i class="fas fa-exclamation-triangle" style="color:red;"></i></c:if>
                	位置
                </a>
                <a href="javascript:;" class="tab" id="tab4">
                    <c:if test="${spaceSizeError!=null || spaceGuestsError!=null}"><i class="fas fa-exclamation-triangle" style="color:red;"></i></c:if>
                	空間配置
                </a>
                <a href="javascript:;" class="tab" id="tab5">設備</a>
                <a href="javascript:;" class="tab" id="tab6">相片</a>
                <a href="javascript:;" class="tab" id="tab7">
                    <c:if test="${spaceOpeningError!=null || spaceOpeningError!=null}"><i class="fas fa-exclamation-triangle" style="color:red;"></i></c:if>
                	定價</a>
                <a href="javascript:;" class="tab" id="tab8">管理者</a>
            </div>
        </div>	
        <div class="tabs-contents">
<!-- ---------------------------------新增空間的form1表單--------------------------------- -->        
        <form action="/addSpace" method="post" id="form1" enctype="multipart/form-data">
        <!--  --------------------空間類型-------------------- -->
            <div class="tab-c active">
                 <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="space-type" id="space-type">
                                <div class="title">請選擇您的空間適合舉辦的活動<span class="title-2">複選</span></div>
                               		<c:forEach var="facilitiesType" items="${facilitiesTypeAll}" varStatus="loot">
                                    	<input type="checkbox" name="facilitiesTypeId" value="${facilitiesType.facilitiesTypeId}" class="checkbox">
                                    	<span class="type">${facilitiesType.name}</span><br>
                                   </c:forEach>
                            </div>
                            <div class="nextAndPreButton">
                                <div class="next-button" id="next" onclick="nextStep()">下一步</div>
                            </div>
                        </div>
                    </div>
                    <div class="inner-content-right">
                    	<c:if test="${spaceTypeError!=null}">
                         	<div class="error-hint"><i class="fas fa-exclamation-triangle" style="color:red;margin: 0 10px 0 20px;"></i>${spaceTypeError}</div>
                    	</c:if>
                    </div>
                 </div>
            </div>

        <!--  --------------------基本資訊-------------------- -->
            <div class="tab-c">
                <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="title">基本資訊</div>
                            <div class="inputName">空間名稱<span class="title-2">必填</span></div>
                            <input type="text" name="name" value="${facilitiesRecord.name}" class="facilitiesName" placeholder="例：中山捷運站步行五分鐘，大型陽光會議室"
                            	<c:if test="${spaceNameError!=null}">style="border:1px solid rgb(255, 30, 30);"</c:if>>
                            <div class="inputName">場地規範<span class="title-2">選填</span></div>
                            <textarea name="rules" class="facilitiesRules" placeholder="例：禁帶寵物">${facilitiesRecord.rules}</textarea>
                            <div class="inputName">退訂政策<span class="title-2">選填</span></div>
                            <textarea name="cancellationPolicy" class="facilitiesCancellationPolicy" placeholder="例：7天前可全額退費，3天內取消恕不退費！">${facilitiesRecord.cancellationPolicy}</textarea>
                        </div>
                        <div class="nextAndPreButton2">
                            <div class="pre-button2" onclick="preStep2()">上一步</div>
                            <div class="next-button2" onclick="nextStep2()">下一步</div>
                        </div>
                    </div>
                    <div class="inner-content-right">
                        <div class="remind-tip"><i class="fas fa-exclamation-circle"></i>請勿填寫聯絡資訊，以免審核失敗</div>
                        <c:if test="${spaceNameError!=null}">
                         	<div class="error-hint"><i class="fas fa-exclamation-triangle" style="color:red;margin: 0 10px 0 20px;"></i>${spaceNameError}</div>
                    	</c:if>
                    </div>
                </div>
            </div>
            
        <!--  --------------------位置-------------------- -->
            <div class="tab-c">
                <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="addressTitle">地址<span class="title-2">必填</span></div>
                            <div id="twzipcode"></div>
                            <input type="text" id="search_input" name="address" class="facilitiesAddress" placeholder="例：新生南路二段..." value="${facilitiesRecord.address}"
                            	<c:if test="${spaceAddressError!=null}">style="border:1px solid rgb(255, 30, 30);"</c:if>>
                            <div class="addressTitle">提供交通方式<span class="title-2">選填</span></div>
                            <div class="addressSubtitle">搭乘捷運</div>
                            <input type="text" name="takeByTrain" value="${facilitiesRecord.takeByTrain}" class="facilitiesTransportation"
                                placeholder="例：大安站1號出口步行三分鐘">
                            <div class="addressSubtitle">搭乘公車</div>
                            <input type="text" name="takeByBus" value="${facilitiesRecord.takeByBus}" class="facilitiesTransportation"
                                placeholder="例：200號公車站大安站步行5分鐘">
                            <div class="addressSubtitle">開車或停車資訊</div>
                            <input type="text" name="takeByCar" value="${facilitiesRecord.takeByCar}" class="facilitiesTransportation"
                                placeholder="例：於145巷右轉有停車場">
                        </div>

                        <div class="nextAndPreButton3">
                            <div class="pre-button2" onclick="preStep3()">上一步</div>
                            <div class="next-button2" onclick="nextStep3()">下一步</div>
                        </div>
                    </div>
                    <div class="inner-content-right">
                        <c:if test="${spaceAddressError!=null}">
                         	<div class="error-hint"><i class="fas fa-exclamation-triangle" style="color:red;margin: 0 10px 0 20px;"></i>${spaceAddressError}</div>
                    	</c:if>
                    </div>
                </div>
            </div>
            
        <!--  --------------------空間配置-------------------- -->
            <div class="tab-c">
                <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="addressTitle">空間配置<span class="title-2">必填</span></div>
                            <span>空間大小</span><input type="text" name="size" value="${facilitiesRecord.size}" <c:if test="${spaceSizeError!=null}">style="border:1px solid rgb(255, 30, 30);"</c:if>
                            						onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="5" class="facilitiesSize">
                            <span>坪</span><br>
                            <span>空間可容納</span><input type="text" name="guests" value="${facilitiesRecord.guests}" <c:if test="${spaceGuestsError!=null}">style="border:1px solid rgb(255, 30, 30);"</c:if>
                            						onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="8" class="facilitiesGuests"><span>人</span>
                        </div>
                        <div class="nextAndPreButton3">
                            <div class="pre-button2" onclick="preStep4()">上一步</div>
                            <div class="next-button2" onclick="nextStep4()">下一步</div>
                        </div>
                    </div>
                    <div class="inner-content-right">
                        <c:if test="${spaceSizeError!=null}">
                         	<div class="error-hint"><i class="fas fa-exclamation-triangle" style="color:red;margin: 0 10px 0 20px;"></i>${spaceSizeError}</div>
                    	</c:if>
                    	 <c:if test="${spaceGuestsError!=null}">
                         	<div class="error-hint"><i class="fas fa-exclamation-triangle" style="color:red;margin: 0 10px 0 20px;"></i>${spaceGuestsError}</div>
                    	</c:if>
                    </div>
                </div>
            </div>

        <!--  --------------------設備-------------------- -->
            <div class="tab-c">
                <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="addressTitle">設備<span class="title-2">選填</span></div>
                            <c:forEach var="facilitiesItemsCatg" items="${facilitiesItemsCatgAll}">
                            <div class="facilitiesServiceTitle"><a href="javascript:;" class="service_button" id="btn${facilitiesItemsCatg.id}">${facilitiesItemsCatg.name}</a>
                                <div class="facilitiesServiceCheckbox" id="toggle${facilitiesItemsCatg.id}">                         
	                          		<c:forEach var="facilitiesItems" items="${facilitiesItemsAll}">
		                          		<c:if test="${facilitiesItems.facilitiesItemsCatg.id == facilitiesItemsCatg.id}">
		                                	<input type="checkbox" class="checkboxService" value="${facilitiesItems.id}" name="facilitiesItemsId"><span class="service">${facilitiesItems.name}</span><br>
		                                 </c:if>                           
	                                </c:forEach>
                                </div>                         
                            </div>
                            </c:forEach>
                        </div>
                        <div class="nextAndPreButton3">
                            <div class="pre-button2" onclick="preStep5()">上一步</div>
                            <div class="next-button2" onclick="nextStep5()">下一步</div>
                        </div>
                    </div>
                    <div class="inner-content-right">
                        <div class="remind-tip"><i class="fas fa-exclamation-circle"></i>清楚的設備資訊可大幅提升預訂率</div>
                    </div>
                </div>
            </div>

        <!--  --------------------相片-------------------- -->
            <div class="tab-c">
                <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="addressTitle">上傳空間相片<span class="title-2">建議選填</span></div>
                            <div class="subtitle">上傳至少3~10張不同角度的相片</div>
                            <div class="uploadImage">
                            	<div class="uploadFakeButton">上傳空間圖片</div>
                            		<input type="file" name="fileName" id="filename" accept="image/png, image/jpeg, image/jpg" multiple="multiple" onchange="checkImage(this)">
                            	<div id="onLoadImage"></div>
                            </div>
                        </div>
                        <div class="nextAndPreButton3">
                            <div class="pre-button2" onclick="preStep6()">上一步</div>
                            <div class="next-button2" onclick="nextStep6()">下一步</div>
                        </div>
                    </div>
                    <div class="inner-content-right">
                        <div class="remind-tip"><i class="fas fa-exclamation-circle"></i>各種角度的照片能取代場勘需求。
                            光線充足的照片能讓訂購率大增。</div>
                    </div>
                </div>
            </div>

        <!--  --------------------定價-------------------- -->
            <div class="tab-c">
                <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="addressTitle">計費設定<span class="title-2">必填</span></div>
                            
                            <c:forEach var="facilitiesOpening" items="${facilitiesOpeningAll}">
	                            <div class="checkbox-days">
	                                <input type="checkbox" name="facilitiesOpeningId" class="js-switch" 
	                                id="switch${facilitiesOpening.facilitiesOpeningId}" value="${facilitiesOpening.facilitiesOpeningId}"/>
	                                <span>${facilitiesOpening.name}</span>
		                                <select class="timeSelect" name="startTime" id="timeStart${facilitiesOpening.facilitiesOpeningId}" style="display: none;">
	                               			<option value="0">00:00</option>
	                               			<option value="1">01:00</option>
	                               			<option value="2">02:00</option>
	                               			<option value="3">03:00</option>
	                               			<option value="4">04:00</option>
	                               			<option value="5">05:00</option>
	                               			<option value="6">06:00</option>
	                               			<option value="7">07:00</option>
	                               			<option value="8">08:00</option>
	                               			<option value="9">09:00</option>
	                               			<option value="10">10:00</option>
	                               			<option value="11">11:00</option>
	                               			<option value="12">12:00</option>
	                               			<option value="13">13:00</option>
	                               			<option value="14">14:00</option>
	                               			<option value="15">15:00</option>
	                               			<option value="16">16:00</option>
	                               			<option value="17">17:00</option>
	                               			<option value="18">18:00</option>
	                               			<option value="19">19:00</option>
	                               			<option value="20">20:00</option>
	                               			<option value="21">21:00</option>
	                               			<option value="22">22:00</option>
	                               			<option value="23">23:00</option>
	                               		</select>
	                                <strong id="dash${facilitiesOpening.facilitiesOpeningId}" style="display: none;"> ~ </strong>
	                                  	 <select class="timeSelect" name="closeTime" id="timeEnd${facilitiesOpening.facilitiesOpeningId}" style="display: none;"><option value="24">00:00</option>
	                               			<option value="24">00:00</option>
	                               			<option value="1">01:00</option>
	                               			<option value="2">02:00</option>
	                               			<option value="3">03:00</option>
	                               			<option value="4">04:00</option>
	                               			<option value="5">05:00</option>
	                               			<option value="6">06:00</option>
	                               			<option value="7">07:00</option>
	                               			<option value="8">08:00</option>
	                               			<option value="9">09:00</option>
	                               			<option value="10">10:00</option>
	                               			<option value="11">11:00</option>
	                               			<option value="12">12:00</option>
	                               			<option value="13">13:00</option>
	                               			<option value="14">14:00</option>
	                               			<option value="15">15:00</option>
	                               			<option value="16">16:00</option>
	                               			<option value="17">17:00</option>
	                               			<option value="18">18:00</option>
	                               			<option value="19">19:00</option>
	                               			<option value="20">20:00</option>
	                               			<option value="21">21:00</option>
	                               			<option value="22">22:00</option>
	                               			<option value="23">23:00</option>
	                               	    </select>
	                                <div class="checkbox-hours" id="checkbox-hours${facilitiesOpening.facilitiesOpeningId}">
	                                    <input type="text" name="expense" maxlength="8" onkeyup="value=value.replace( /[^\d]/g,'')" > 元/小時
	                                </div>
	                            </div>
                            </c:forEach>
                      
                        </div>
                        <div class="nextAndPreButton3">
                            <div class="pre-button2" onclick="preStep7()">上一步</div>
                            <div class="next-button2" onclick="nextStep7()">下一步</div>
                        </div>
                    </div>
                    <div class="inner-content-right">
                        <c:if test="${spaceOpeningError!=null}">
                         	<div class="error-hint"><i class="fas fa-exclamation-triangle" style="color:red;margin: 0 10px 0 20px;"></i>${spaceOpeningError}</div>
                    	</c:if>
                    </div>
                </div>
            </div>
		</form>
		
        <!--  --------------------管理者-------------------- -->
            <div class="tab-c">
                <div class="inner-content">
                    <div class="inner-content-left">
                        <div class="space-info">
                            <div class="addressTitle">管理者資訊<span class="title-2">必填</span></div>
                            <div class="subtitle">空間皆需要一個管理者，讓客戶了解管理者是誰，並代表空間接收並支付款項。</div>
                            <div class="selectOwnerArea" id="selectOwnerArea">
                            	<select class="selectOwner" id="ownerSelect" form="form1" name="facilitiesOwner"></select>
                            </div>                         
<!-- ---------------------------------新增管理員的form2表單--------------------------------- -->
                            <form action="/saveOwner" method="post" id="form2" enctype="multipart/form-data">
                            <div id="showOwnerArea"><i class="fas fa-plus-circle"></i></div>
                            <div class="facilitiesOwnerArea" id="facilitiesOwnerArea">
                                <div class="facilities_owner_image">
                                	<div id="previewImage"></div>
                                    <input type="file" name="file" id="file" accept="image/*"/> 
                                    <div id="fakeFileImgUpload" onclick="fakeUploadButton();">
                                    	<i class="fas fa-plus-circle"></i>
                                    </div>
                                    <div id="FileImgUploadTitle">* 請至少上傳一張照片</div>
                                    <br>
                                </div>
                                <div class="facilities_owner_data">
                                    <h3>公開基本資料</h3>
                                    <div class="owner_data_title">管理單位名稱 *<span id="ownerNameError" class="ownerError">管理單位名稱不得為空！</span></div>
                                    <input type="text" id="name" name="name" placeholder="例：滿客連鎖出租空間">
                                    <div class="owner_data_title">管理單位介紹</div>
                                    <input type="text" id="description" name="description" placeholder="例：我們是經營兩年的連鎖空間...">
                                    <h3>保密資訊</h3>
                                    <div class="owner_data_title">聯絡人 *<span id="ownerContactNameError" class="ownerError">聯絡人名稱不得為空！</span></div>
                                    <input type="text" id="contactName" name="contactName" placeholder="請填寫真實姓名">
                                    <div class="owner_data_title">常用電話/公司電話</div>
                                    <input type="text" id="contactPhone" name="contactPhone" placeholder="例：0228123456"  onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="10">
                                    <div class="owner_data_title">手機</div>
                                    <input type="text" id="contactMobilePhone" name="contactMobilePhone" placeholder="例：0912345678"  onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="10">
                                    <div class="owner_data_title">發票抬頭</div>
                                    <input type="text" id="invoiceHeading" name="invoiceHeading">
                                    <div class="owner_data_title">發票統編</div>
                                    <input type="text" id="taxId" name="taxId"  onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="8">
                                    <h3>收款資訊</h3>
                                    <div class="owner_data_title">收款銀行名稱與代號 *</div>
                                    <select id="payeeBankName" name="payeeBankName" class="owner_bank">
                                        <option value="004">004 – 臺灣銀行</option>
                                        <option value="005">005 – 土地銀行</option>
                                        <option value="006">006 – 合作商銀</option>
                                        <option value="007">007 – 第一銀行</option>
                                        <option value="008">008 – 華南銀行</option>
                                        <option value="009">009 – 彰化銀行</option>
                                        <option value="011">011 – 上海商業儲蓄銀行</option>
                                        <option value="012">012 – 台北富邦銀行</option>
                                        <option value="013">013 – 國泰世華銀行</option>
                                        <option value="016">016 – 高雄銀行</option>
                                        <option value="017">017 – 兆豐國際商業銀行</option>
                                        <option value="018">018 – 農業金庫</option>
                                        <option value="021">021 – 花旗(台灣)商業銀行</option>
                                        <option value="025">025 – 首都銀行</option>
                                        <option value="039">039 – 澳商澳盛銀行</option>
                                        <option value="040">040 – 中華開發工業銀行</option>
                                        <option value="050">050 – 臺灣企銀</option>
                                        <option value="052">052 – 渣打國際商業銀行</option>
                                        <option value="053">053 – 台中商業銀行</option>
                                        <option value="054">054 – 京城商業銀行</option>
                                        <option value="072">072 – 德意志銀行</option>
                                        <option value="075">075 – 東亞銀行</option>
                                        <option value="081">081 – 匯豐(台灣)商業銀行</option>
                                        <option value="085">085 – 新加坡商新加坡華僑銀行</option>
                                        <option value="101">101 – 大台北銀行</option>
                                        <option value="102">102 – 華泰銀行</option>
                                        <option value="103">103 – 臺灣新光商銀</option>
                                        <option value="104">104 – 台北五信</option>
                                        <option value="106">106 – 台北九信</option>
                                        <option value="108">108 – 陽信商業銀行</option>
                                        <option value="114">114 – 基隆一信</option>
                                        <option value="115">115 – 基隆二信</option>
                                        <option value="118">118 – 板信商業銀行</option>
                                        <option value="119">119 – 淡水一信</option>
                                        <option value="120">120 – 淡水信合社</option>
                                        <option value="124">124 – 宜蘭信合社</option>
                                        <option value="127">127 – 桃園信合社</option>
                                        <option value="130">130 – 新竹一信</option>
                                        <option value="132">132 – 新竹三信</option>
                                        <option value="146">146 – 台中二信</option>
                                        <option value="147">147 – 三信商業銀行</option>
                                        <option value="158">158 – 彰化一信</option>
                                        <option value="161">161 – 彰化五信</option>
                                        <option value="162">162 – 彰化六信</option>
                                        <option value="163">163 – 彰化十信</option>
                                        <option value="165">165 – 鹿港信合社</option>
                                        <option value="178">178 – 嘉義三信</option>
                                        <option value="179">179 – 嘉義四信</option>
                                        <option value="188">188 – 台南三信</option>
                                        <option value="204">204 – 高雄三信</option>
                                        <option value="215">215 – 花蓮一信</option>
                                        <option value="216">216 – 花蓮二信</option>
                                        <option value="222">222 – 澎湖一信</option>
                                        <option value="223">223 – 澎湖二信</option>
                                        <option value="224">224 – 金門信合社</option>
                                        <option value="512">512 – 雲林區漁會</option>
                                        <option value="515">515 – 嘉義區漁會</option>
                                        <option value="517">517 – 南市區漁會</option>
                                        <option value="518">518 – 南縣區漁會</option>
                                        <option value="520">520 – 小港區漁會；高雄區漁會</option>
                                        <option value="521">521 – 彌陀區漁會；永安區漁會；興達港區漁會；林園區漁會</option>
                                        <option value="523">523 – 東港漁會；琉球區漁會；林邊區漁會</option>
                                        <option value="524">524 – 新港區漁會</option>
                                        <option value="525">525 – 澎湖區漁會</option>
                                        <option value="605">605 – 高雄市農會</option>
                                        <option value="612">612 – 豐原市農會；神岡鄉農會</option>
                                        <option value="613">613 – 名間農會</option>
                                        <option value="614">614 – 彰化地區農會</option>
                                        <option value="616">616 – 雲林地區農會</option>
                                        <option value="617">617 – 嘉義地區農會</option>
                                        <option value="618">618 – 台南地區農會</option>
                                        <option value="619">619 – 高雄地區農會</option>
                                        <option value="620">620 – 屏東地區農會</option>
                                        <option value="621">621 – 花蓮地區農會</option>
                                        <option value="622">622 – 台東地區農會</option>
                                        <option value="624">624 – 澎湖農會</option>
                                        <option value="625">625 – 台中市農會</option>
                                        <option value="627">627 – 連江縣農會</option>
                                        <option value="700">700 – 中華郵政</option>
                                        <option value="803">803 – 聯邦商業銀行</option>
                                        <option value="805">805 – 遠東銀行</option>
                                        <option value="806">806 – 元大銀行</option>
                                        <option value="807">807 – 永豐銀行</option>
                                        <option value="808">808 – 玉山銀行</option>
                                        <option value="809">809 – 萬泰銀行</option>
                                        <option value="810">810 – 星展銀行</option>
                                        <option value="812">812 – 台新銀行</option>
                                        <option value="814">814 – 大眾銀行</option>
                                        <option value="815">815 – 日盛銀行</option>
                                        <option value="816">816 – 安泰銀行</option>
                                        <option value="822">822 – 中國信託</option>
                                        <option value="901">901 – 大里市農會</option>
                                        <option value="903">903 – 汐止農會</option>
                                        <option value="904">904 – 新莊農會</option>
                                        <option value="910">910 – 財團法人農漁會聯合資訊中心</option>
                                        <option value="912">912 – 冬山農會</option>
                                        <option value="916">916 – 草屯農會</option>
                                        <option value="922">922 – 台南市農會</option>
                                        <option value="928">928 – 板橋農會</option>
                                        <option value="951">951 – 北農中心</option>
                                        <option value="954">954 – 中南部地區農漁會</option>
                                    </select>
                                    <div class="owner_data_title">分行 *<span id="ownerPayeeBranchNameError" class="ownerError">分行名稱不得為空！</span></div>
                                    <input type="text" id="payeeBranchName" name="payeeBranchName">
                                    <div class="owner_data_title">收款帳號 *<span id="ownerAccountError" class="ownerError">收款帳號不得為空！</span></div>
                                    <input type="text" id="account" name="account" placeholder="勿填寫符號或空白"  onkeyup="value=value.replace( /[^\d]/g,'')" maxlength="14">
                                    <div class="owner_data_title">戶名 *<span id="ownerPayeeNameError" class="ownerError">戶名不得為空！</span></div>
                                    <input type="text" id="payeeName" name="payeeName">
                                    <button type="button" id="ownerCancel" onclick="showAreaButton()">取消</button>
                                    <button type="button" class="ownerButton" id="ownerSave">新增管理員</button>
                                    <button type="button" class="ownerButton" id="ownerUpdate"
                                    	onclick="updateOwner();" style="display:none;">更新管理員</button>
                                </div>
                            </div>
                            </form>
                            <div id="ownerDetail"></div>
                            <br><br><br><br><br><br><hr>
                        </div>              
                        <div class="nextAndPreButton3" style="margin-bottom:140px;">
                            <div class="pre-button2" onclick="preStep8()">上一步</div>
                        </div>
                    </div>
                     <div class="inner-content-right">
                        <div class="remind-tip"><i class="fas fa-exclamation-circle"></i>
                        指定專責管理者管理此空間，讓消費者可以取得正確的聯絡負責人</div>
                    </div>
                </div>
            </div>
            	<input type="submit" value="儲存並離開" class="spaceSubmit" form="form1" onclick="checkSubmit()">
        </div>
    </div>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCelgQQuBsyBirT-R-gE3kEt9HyLO7fyH0&libraries=places"></script>
<script>
	/* var searchInput = 'search_input';
	
	$(document).ready(function () {
	 var autocomplete;
	 autocomplete = new google.maps.places.Autocomplete((document.getElementById(searchInput)), {
	  types: ['geocode'],
	  componentRestrictions: {
	   country: "tw"
	  }
	 });
	  
	 google.maps.event.addListener(autocomplete, 'place_changed', function () {
	  var near_place = autocomplete.getPlace();
	 });
	}); */
</script>  
    
    <script>
    //確認刪除提交
    function confirmSubmit() {
    	var agree = confirm("你確定要刪除此管理者嗎？");
    	if (agree)
    		return true;
    	else
    		return false;
    };
    
	//ajax動態刷新select表單方法
	function assignDataToOwnerSelect() {
		$('#ownerSelect').empty();

		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOwners",
			success: function(data) {
				var owners = JSON.parse(JSON.stringify(data));
				$('#ownerSelect').append('<option selected disabled>請選擇一名管理者</option>');
				for (var i in owners) {
					$('#ownerSelect').append('<option value="' + owners[i].id + '">' + owners[i].name + '</option>');
				}
			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//刪除管理員按鈕
    function deleteOwner(){
		   let select = document.querySelector("#ownerSelect");
	       const ownerId = select.options[select.selectedIndex].value;
	       $.ajax({
	            type:"DELETE",
	            url:"http://localhost:8081/deleteOwner/" + ownerId,
	            success: function(data){
	                assignDataToOwnerSelect();
					alert("成功刪除此管理員");
					$('#ownerDetail').empty();
	            },
	            error: function(err) {  
	                console.log(err);
	                alert(err);
	            }
	        });
 	};
    
  //更新管理員啟動
    function InitUpdateOwner(){
    	  $('#ownerDetail').hide();
	  	  $('#facilitiesOwnerArea').toggleClass('open');
		  $('#showOwnerArea').toggleClass('close');
		  $('#ownerSave').hide();
		  $('#ownerUpdate').show();
		  
		  let select = document.querySelector("#ownerSelect");
	      const ownerId = select.options[select.selectedIndex].value;
	      
		   $.ajax({    
		          type:"GET",
		          contentType: "application/json",
		          url:"http://localhost:8081/listOwners/" + ownerId,
		          success: function(data) {
		            var owner = JSON.parse(JSON.stringify(data));
					$('#name').val(owner.name);
					$('#description').val(owner.description);
					$('#contactName').val(owner.contactName);
					$('#contactPhone').val(owner.contactPhone);
					$('#contactMobilePhone').val(owner.contactMobilePhone);
					$('#invoiceHeading').val(owner.invoiceHeading);
					$('#taxId').val(owner.taxId);
					$('#payeeBankName').val(owner.payeeBankName);
					$('#payeeBranchName').val(owner.payeeBranchName);
					$('#account').val(owner.account);
					$('#payeeName').val(owner.payeeName);
		          },
		          error: function(data) { 
		            console.log(data);
		            }
		        });   
  	};
	
	
	
	//更新管理員按鈕
    function updateOwner(){
		    let select = document.querySelector("#ownerSelect");
	        const ownerId = select.options[select.selectedIndex].value;
			event.preventDefault();
			var formData = new FormData();
			var file = $('#file')[0].files[0];
			formData.append("file", file);
			
           var jsonVar = {
                   name: $("#name").val(),
                   description: $("#description").val(),
                   contactName: $("#contactName").val(),
                   contactPhone: $("#contactPhone").val(),
                   contactMobilePhone: $("#contactMobilePhone").val(),
                   invoiceHeading: $("#invoiceHeading").val(),
                   taxId: $("#taxId").val(),
                   payeeBankName: $("#payeeBankName").val(),
                   payeeBranchName: $("#payeeBranchName").val(),
                   account: $("#account").val(),
                   payeeName: $("#payeeName").val(),
               };
   		$.ajax({
			url: 'http://localhost:8081/uploadOwnerImg',
			type: 'POST',
			data: formData,
			enctype: 'multipart/form-data',
			contentType: false,
			cache: false,
			processData: false,
			sync: true,
			success: function() {
			       $.ajax({
			            type:"PUT",
			            url:"http://localhost:8081/updateOwner/" + ownerId,
			            data: JSON.stringify(jsonVar),
		                contentType: "application/json",
			            success: function(data){
			            	  assignDataToOwnerSelect();
							  alert("更新管理員資料成功");
							  $('#ownerDetail').empty();
					    	  $('#ownerDetail').show();
						  	  $('#facilitiesOwnerArea').toggleClass('open');
							  $('#showOwnerArea').toggleClass('close');
							  $('#ownerSave').show();
							  $('#ownerUpdate').hide();						 
			            },
			            error: function(err) {  
			                console.log(err);
			                alert(err);
			            }
			        });
				
			},
			error: function() {
				alert("請至少上傳一張管理員照片");
			}
		});

	};
	
    //顯示owner form表單區塊
    $('#showOwnerArea').click(function(){
   	    $('#facilitiesOwnerArea').toggleClass('open');
   	    $('#showOwnerArea').toggleClass('close');
   		$('#ownerDetail').toggle();
  	    $('#ownerSave').show();
	    $('#ownerUpdate').hide();
	    
		$('#name').val('');
		$('#description').val('');
		$('#contactName').val('');
		$('#contactPhone').val('');
		$('#contactMobilePhone').val('');
		$('#invoiceHeading').val('');
		$('#taxId').val('');
		$('#payeeBranchName').val('');
		$('#account').val('');
		$('#payeeName').val('');
   	});
    
    //假上傳按鈕
    function fakeUploadButton() {
        document.getElementById("file").click();
    };

 // -----------------------------上傳多張空間圖片-----------------------------
	var curFiles = [];//文件數組，用來保存上傳的文件


    //檢查上傳的文件
    function checkImage(obj) {
        var files = obj.files;
        console.log(files.length);
        if(files){

            if(files.length <= 10) {//把一次上傳的圖片限制在十張內
                for (var i = 0; i < files.length; i++) {
                    var item = files.item(i);
                    var size = item.size;
                    if (size / 1000 < 10000) { //简易大小限制10000K
                        curFiles.push(item);
                    }
                    else {
                        alert("第" + (i + 1) + "張圖片太大，請上傳不超過10MB的大小");
                    }
                }
            }
            else{
                $("#filename").val("");
                alert("一次最多上傳10張圖片！");
            }
        }
        else {
            $("#filename").val("");
            alert("請選擇上傳的圖片");
        }

        //去除文件名相同的情况（上傳列表中多次出現同一物件）
        for (var i = 0; i < curFiles.length - 1; i++) {
            for (var j = 1; j < curFiles.length; j++) {
                if (i != j) {
                    if (curFiles[i].name == curFiles[j].name) {
                        curFiles.splice(j, 1)
                    }
                }
            }
        }

        //判斷上傳圖片的大小(10MB)
        for(var i = 0; i < curFiles.length; i++){
            var size = curFiles[i].size;
            if(size/1000>100000){
                curFiles.splice(i, 1);
            }

        }

        console.log(curFiles);

        onLoadImage();
    };

    //預覽圖片
    function onLoadImage() {
       	$("#onLoadImage").html("<p class='preImageTitle'>預覽圖</p>");
       	if(curFiles.length ==0){
       		$("#onLoadImage").html("");
       	}
        for(var i = 0; i < curFiles.length; i++){
            (function(i){
                var file = curFiles[i];
                var reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = function(){
                    $('#onLoadImage').append("<div class='spaceImageArea'><img class='spaceImage' src='"+reader.result+"'/><span><span style='display:none;'>"+file.name+"</span><button class='deleteImgButton' id='"+i+"' onclick='del(this.id)'><i class='fas fa-minus-circle'></i></button></span></div>");
                };
            })(i)
        };
    };

    //刪除功能
    function del(id) {
        var name = $("#"+id).prev().text();
        console.log(name);
        curFiles = curFiles.filter(function(file) {
            return file.name !== name;
        });
        console.log(curFiles);
        onLoadImage();
    };

    //上傳功能的實現
    function checkSubmit() {
        if(curFiles.length>0){
            var formdata =  new FormData($('#form1')[0]);
            for (var i = 0; i<curFiles.length; i++) {
                formdata.append('uploadFiles', curFiles[i]);
            }
            $.ajax({
                url: 'http://localhost:8081/multipleImageUpload',
                type: 'post',
                data: formdata,
                processData: false,
                contentType: false,
                success: function(data) {
                },
                error: function(err) {
                }
            });
        };
    };

        //navbar標籤class切換
        $(".tab").each(function(index) {
        $(this).click(function(e) {
            triggletab();
            triigletabcontent();
            $(this).toggleClass("active");
            $(".tab-c")
            .eq(index)
            .toggleClass("active");
        });
        });

        //to remove all tab headers
        function triggletab() {
        $(".tab").each(function() {
            $(this).removeClass("active");
        });
        };
        
        //triggle the tab content
        function triigletabcontent() {
        $(".tab-c").each(function() {
            $(this).removeClass("active");
        });
        };

        //checkbox點擊出現下一步的按鈕
        var checkboxes = $("input[name='facilitiesTypeId']");
        checkboxes.click(function() {
            if(!checkboxes.is(":checked")){
                document.getElementById("next").style.display="none";

            }else if(checkboxes.is(":checked")){
                document.getElementById("next").style.display="block";
            }
        });

        // Multiple switches
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));

        elems.forEach(function(html) {
            var switchery = new Switchery(html);
        });
        
        //開啟/隱藏checkbox的div
        var items = Array.prototype.slice.call(document.querySelectorAll('.switchery'));
        var clickCheckbox1= $("input[id='switch1']");
        var clickCheckbox2= $("input[id='switch2']");
        var clickCheckbox3= $("input[id='switch3']");
        var clickCheckbox4= $("input[id='switch4']");
        var clickCheckbox5= $("input[id='switch5']");
        var clickCheckbox6= $("input[id='switch6']");
        var clickCheckbox7= $("input[id='switch7']");
        
        items[0].addEventListener('click', function() {
            if(clickCheckbox1.is(":checked")){
                document.getElementById("checkbox-hours1").style.display="block";
                document.getElementById("dash1").style.display="";
                document.getElementById("timeStart1").style.display="";
                document.getElementById("timeEnd1").style.display="";
            }else{
                document.getElementById("checkbox-hours1").style.display="none";
                document.getElementById("dash1").style.display="none";
                document.getElementById("timeStart1").style.display="none";
                document.getElementById("timeEnd1").style.display="none";
            }
        });
        
        items[1].addEventListener('click', function() {
            if(clickCheckbox2.is(":checked")){
                document.getElementById("checkbox-hours2").style.display="block";
                document.getElementById("dash2").style.display="";
                document.getElementById("timeStart2").style.display="";
                document.getElementById("timeEnd2").style.display="";
            }else{
                document.getElementById("checkbox-hours2").style.display="none";
                document.getElementById("dash2").style.display="none";
                document.getElementById("timeStart2").style.display="none";
                document.getElementById("timeEnd2").style.display="none";
            }
        });  

        items[2].addEventListener('click', function() {
            if(clickCheckbox3.is(":checked")){
                document.getElementById("checkbox-hours3").style.display="block";
                document.getElementById("dash3").style.display="";
                document.getElementById("timeStart3").style.display="";
                document.getElementById("timeEnd3").style.display="";
            }else{
                document.getElementById("checkbox-hours3").style.display="none";
                document.getElementById("dash3").style.display="none";
                document.getElementById("timeStart3").style.display="none";
                document.getElementById("timeEnd3").style.display="none";
            }
        });  

        items[3].addEventListener('click', function() {
            if(clickCheckbox4.is(":checked")){
                document.getElementById("checkbox-hours4").style.display="block";
                document.getElementById("dash4").style.display="";
                document.getElementById("timeStart4").style.display="";
                document.getElementById("timeEnd4").style.display="";
            }else{
                document.getElementById("checkbox-hours4").style.display="none";
                document.getElementById("dash4").style.display="none";
                document.getElementById("timeStart4").style.display="none";
                document.getElementById("timeEnd4").style.display="none";
            }
        });  

        items[4].addEventListener('click', function() {
            if(clickCheckbox5.is(":checked")){
                document.getElementById("checkbox-hours5").style.display="block";
                document.getElementById("dash5").style.display="";
                document.getElementById("timeStart5").style.display="";
                document.getElementById("timeEnd5").style.display="";
            }else{
                document.getElementById("checkbox-hours5").style.display="none";
                document.getElementById("dash5").style.display="none";
                document.getElementById("timeStart5").style.display="none";
                document.getElementById("timeEnd5").style.display="none";
            }
        });  

        items[5].addEventListener('click', function() {
            if(clickCheckbox6.is(":checked")){
                document.getElementById("checkbox-hours6").style.display="block";
                document.getElementById("dash6").style.display="";
                document.getElementById("timeStart6").style.display="";
                document.getElementById("timeEnd6").style.display="";
            }else{
                document.getElementById("checkbox-hours6").style.display="none";
                document.getElementById("dash6").style.display="none";
                document.getElementById("timeStart6").style.display="none";
                document.getElementById("timeEnd6").style.display="none";
            }
        });  

        items[6].addEventListener('click', function() {
            if(clickCheckbox7.is(":checked")){
                document.getElementById("checkbox-hours7").style.display="block";
                document.getElementById("dash7").style.display="";
                document.getElementById("timeStart7").style.display="";
                document.getElementById("timeEnd7").style.display="";
            }else{
                document.getElementById("checkbox-hours7").style.display="none";
                document.getElementById("dash7").style.display="none";
                document.getElementById("timeStart7").style.display="none";
                document.getElementById("timeEnd7").style.display="none";
            }
        });  

        //台灣地址初始化
        $("#twzipcode").twzipcode({
            countySel: "臺北市", // 城市預設值, 字串一定要用繁體的 "臺", 否則抓不到資料
            districtSel: "大安區", // 地區預設值
            zipcodeIntoDistrict: true, // 郵遞區號自動顯示在地區
            css: ["city form-control", "town form-control"], // 自訂 "城市"、"地區" class 名稱
            countyName: "city", // 自訂城市 select 標籤的 name 值
            districtName: "town" // 自訂地區 select 標籤的 name 值
        });
    </script>
    
    <script>
   	window.addEventListener("load", function(){ 
   	    //編輯頁面載入後facilitiesType的checkbox自動checked
   	    var checkTypeArray =${facilitiesTypeRecord};
   	    var checkTypeBoxAll = $("input[name='facilitiesTypeId']");
   	    
        for(var i=0;i<checkTypeArray.length;i++){
	    	$.each(checkTypeBoxAll,function(j,checkbox){
	             //獲取facilitiesType複選框的value屬性
	             var checkValue=$(checkbox).val();
	             if(checkTypeArray[i]==checkValue){
	                 $(checkbox).attr("checked",true);
	             }
	        })
        };
        
   	    //編輯頁面載入後facilitiesItems的checkbox自動checked
   	    var checkItemsArray =${facilitiesItemsRecord};
   	    var checkItemsBoxAll = $("input[name='facilitiesItemsId']");
   	    
        for(var i=0;i<checkItemsArray.length;i++){
	    	$.each(checkItemsBoxAll,function(j,checkbox){
	             //獲取facilitiesType複選框的value屬性
	             var checkValue=$(checkbox).val();
	             if(checkItemsArray[i]==checkValue){
	                 $(checkbox).attr("checked",true);
	             }
	        })
        };
        
   	    //編輯頁面載入後facilitiesItems的checkbox自動checked
  /*  	    var checkOpeningArray =${facilitiesOpeningRecord};
   	    var checkOpeningBoxAll = $("input[name='facilitiesOpeningId']");
   	    
        for(var i=0;i<checkOpeningArray.length;i++){
	    	$.each(checkOpeningBoxAll,function(j,checkbox){
	             //獲取facilitiesType複選框的value屬性
	             var checkValue=$(checkbox).val();
	             if(checkOpeningArray[i]==checkValue){
	                 $(checkbox).attr("checked",true);
	             }
	        })
        }; */
        
   	    //編輯頁面載入後facilities的city使select自動selected
/*    	    var selectCity = '${facilitiesRecord.city}';
   	    var selectCityAll = $("select[name='city']");
        selectCityAll.val(selectCity); */
        
   	    //編輯頁面載入後facilities的town使select自動selected
   /* 	    var selectTown = '${facilitiesRecord.town}';
   	    var selectTownAll = $("select[name='town']");
        selectTownAll.val(selectTown); */
        
   	});
    </script>
</body>
</html>