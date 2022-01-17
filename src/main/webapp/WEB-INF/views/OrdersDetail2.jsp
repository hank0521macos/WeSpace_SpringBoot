<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeSpace | 預訂單管理</title>
<link rel="stylesheet" href="css/OrdersDetail/ordersDetail2.css">
<script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
<script src="vendors/jquery/jquery-3.6.0.min.js"></script>
<script src="js/OrdersDetail/ajaxCRUD2.js"></script>
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
				<li><a href="/mySpace">我的空間</a></li>
			</ul>
		</div>
		<div class="ordersButton">
            <a href="/ordersDetail"><div class="ordersDetailButton"><i class="fas fa-arrow-left"></i>返回全部訂單</div></a>
		</div>
        <div class="priceCounting">
            <div class="priceBox" id="totalPrice"></div>
            <i class="fas fa-minus"></i>
            <div class="priceBox" id="servicePrice"></div>
            <i class="fas fa-equals"></i>
            <div class="priceBoxTotal" id="totalIncome"></div>
        </div>
        <div class="searchCondition">
            <select id="dateCondition">
                <option value="0">無</option>
                <option value="1">活動日期</option>
                <option value="2">下訂日期</option>
            </select>
            <input id="beforeDate" type="date" class="searchConditionDate">&nbsp;<span style="color:black;">至</span>
            <input id="afterDate" type="date" class="searchConditionDate">
            <input type="button" value="篩選" onclick="searchConditionSubmit();" class="searchConditionSubmit" id="searchConditionSubmit">
        </div>
        <div>
            <table id="ordersTable" class="ordersList"></table>
        </div>
	</div>
	
	<!-- i按鈕訂單明細顯示的區塊 -->
	<div class="bg-modal">
		<div class="modal-contents" id="modal-contents"></div>
	</div>
<script>
//查詢日期條件
function searchConditionSubmit(){
	  
	  var beginningDate;
	  var endingDate;
	  var beginningCreateDate;
	  var endingCreateDate;
	  
	  if($('#dateCondition').val() == 0){
		  assignDataToOrdersTable();
	  }
	  
	  if($('#dateCondition').val() == 1){
		  beginningDate = $("#beforeDate").val();
		  endingDate = $("#afterDate").val();
	  }else{
		  beginningDate = null;
		  endingDate = null;
	  }
	  
	  if($('#dateCondition').val() == 2){
		  beginningCreateDate = $("#beforeDate").val();
		  endingCreateDate = $("#afterDate").val();
	  }else{
		  beginningCreateDate = null;
		  endingCreateDate = null;
	  }
	  
      var jsonVar = {
	      beginningDate: beginningDate,
	      endingDate: endingDate,
	      beginningCreateDate: beginningCreateDate,
	      endingCreateDate: endingCreateDate
	  }
  	$('#totalPrice').empty();
  	$('#servicePrice').empty();
  	$('#totalIncome').empty();
  	$('#ordersTable').empty();
  	$('#ordersTable').append(
  		'<thead>'+
  		'<tr>'+
              '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
              '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
              '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
  			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
              '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
              '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
              '<th>詳情</th>'+
          '</tr>'+
      '</thead>'
  	)
  	
  	$.ajax({
        type:"POST",
        url:"http://localhost:8081/listFinishOrdersByDateCondition",
        data: JSON.stringify(jsonVar),
        contentType: "application/json",
        success: function(data){
  			var orders = JSON.parse(JSON.stringify(data));
  			let totalPrice = 0;
  			let servicePrice = 0;
  			let totalIncome = 0;
  			
  			for (var i in orders) {
  				totalPrice += orders[i].expense;
  				servicePrice += Math.round(orders[i].expense*0.15);
  				totalIncome = (totalPrice-servicePrice);
  				
  				var orders_date = new Date(orders[i].date);
  				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
  				
  				var created_date = new Date(orders[i].createTime);
  				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
  				
  				$('#ordersTable').append(
                  '<tbody>'+
                      '<tr>'+
                          '<td>'+orders[i].id+'</td>'+
                          '<td>'+orders[i].contactName+'</td>'+
                          '<td>'+orders_formatted_date+'</td>'+
                          '<td>'+orders_formatted_created_date+'</td>'+
                          '<td>$'+orders[i].expense+'</td>'+
                          '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                          '<td>'+
                              '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                          '</td>'+
                      '</tr>'+
                  '</tbody>')};
  		$('#totalPrice').append('總金額<br>$'+totalPrice);
  		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
  		$('#totalIncome').append('收款金額<br>$'+totalIncome);
  		},
  		error: function(data) {
  			console.log(data);
  		}
  	}); 
};

//顯示i按鈕的訂單明細
function infoBox(ordersId){
  $.ajax({
        type:"GET",
        url:"http://localhost:8081/listOrdersById/" + ordersId,
        success: function(data){
        	var orders = JSON.parse(JSON.stringify(data));
        	
			if(orders.status ==0){
				var status = '<font style="color:gray;">使用者取消</font>';
			}else if(orders.status ==1){
				var status = '<font style="color:#FF3333;">未處理</font>';
			}else if(orders.status ==2){
				var status = '<font style="color:#5cb85c;">已預訂/進行中</font>';
			}else if(orders.status ==3){
				var status = '<font style="color:#428bca;">已拒絕</font>';
			}else if(orders.status ==4){
				var status = '<font style="color:gray;">已完成</font>';
			}else if(orders.status ==5){
				var status = '<font style="color:gray;">預訂取消</font>';
			};
        	
			var orders_date = new Date(orders.date);
			let orders_formatted_date = orders_date.getFullYear() + "/" + (orders_date.getMonth() + 1) + "/" + orders_date.getDate();
			
			var created_date = new Date(orders.createTime);
			let orders_formatted_created_date = created_date.getFullYear() + "/" + (created_date.getMonth() + 1) + "/" + created_date.getDate()
												+"  "+ created_date.getHours() + ":" + created_date.getMinutes() + ":" + created_date.getSeconds();
        	
        	document.querySelector('.bg-modal').style.display = "flex";
        	$('#modal-contents').empty();
        	$('#modal-contents').append(
        	'<div class="close" onclick="close123();">+</div>'+
    		'<div class="ordersTitle">訂單資訊</div>'+
    		'<div class="ordersInformation">'+
    			'<div class="ordersInformationLeft">'+
    				'<div class="ordersSubTitle">訂單編號:<br>'+orders.id+'</div>'+
    				'<div class="ordersSubTitle">訂單金額:<br>$'+orders.expense+'</div>'+
    			'</div>'+
    			'<div class="ordersInformationRight">'+
    				'<div class="ordersSubTitle">訂單狀態:<br>'+status+'</div>'+
    				'<div class="ordersSubTitle">訂單建立時間:<br>'+orders_formatted_created_date+'</div>'+
    			'</div>'+
    		'</div>'+
    		'<div class="ordersTitle">活動資訊</div>'+
    		'<div class="spaceInfo">'+
    			'<table>'+
    				'<tr>'+
    					'<th></th>'+
    					'<th>空間名稱</th>'+
    					'<th>活動開始時間</th>'+
    					'<th>活動人數</th>'+
    				'</tr>'+
    				'<tr>'+
    					'<td width="200px; id="spaceImage""><div class="spaceImg" id="spaceImg"></div></td>'+
    					'<td>'+orders.spaceName+'</td>'+
    					'<td width="160px;">'+orders_formatted_date+'<br>'+orders.startTime+':00~'+orders.endTime+':00</td>'+
    					'<td>'+orders.guests+'人</td>'+
    				'</tr>'+
    			'</table>'+
    		'</div>'+
    		'<div class="ordersTitle">訂購人資訊</div>'+
    		'<div class="ordersInformation">'+
    			'<div class="ordersInformationLeft">'+
    				'<div class="ordersSubTitle">聯絡人姓名:<br>'+orders.contactName+'</div>'+
    				'<div class="ordersSubTitle">聯絡人電話:<br>'+orders.contactMobilePhone+'</div>'+
    			'</div>'+
    			'<div class="ordersInformationRight">'+
    				'<div class="ordersSubTitle">聯絡人信箱:<br>'+orders.contactEmail+'</div>'+
    				'<div class="ordersSubTitle">備註:<br>'+orders.note+'</div>'+
    			'</div>'+
    		'</div>'+
    		'<div class="closeButtonArea">'+
    			'<button id="closeButtonArea" onclick="close123();">關閉視窗</button>'+
    		'</div>'
    		)
        	
    		//顯示訂單明細的圖片
    		  $.ajax({
    	          type:"GET",
    	          url:"http://localhost:8081/listOrdersImgById/" + ordersId,
    	          success: function(data){
    	          	var ordersImg = JSON.parse(JSON.stringify(data));
    	  			$('#spaceImg').css({
    	  				'background-image':'url(/uploaded/'+ordersImg.name+')',
    	  			});
    	          },
    	          error: function(err) {  
    	              console.log(err);
    	              alert(err);
    	          }
    		   });
        	
        	
        },
        error: function(err) {  
            console.log(err);
            alert(err);
        }
   });
}

function close123(){
	document.querySelector('.bg-modal').style.display = "none";
}

//訂單編號排序
var f = 0;
function sortOrdersById(){
	if(f==0){
		assignDataToOrdersTableIdDesc();
	}if(f==1){
	assignDataToOrdersTable();
		f=-1;
	}
	f++;
};

//訂單活動日期排序
var g = 0;
function sortOrdersByDate(){
	if(g==0){
		assignDataToOrdersTableDateDesc();
	}if(g==1){
		assignDataToOrdersTableDateAsc();
		g=-1;
	}
	g++;
};

//訂單價格排序
var p = 0;
function sortOrdersByExpense(){
	if(p==0){
		assignDataToOrdersTableExpenseDesc();
	}if(p==1){
		assignDataToOrdersTableExpenseAsc();
		p=-1;
	}
	p++;
};

//訂單下訂排序
var t = 0;
function sortOrdersByTime(){
	if(t==0){
		assignDataToOrdersTableTimeDesc();
	}if(t==1){
		assignDataToOrdersTableTimeAsc();
		t=-1;
	}
	t++;
};

//ajax動態刷新訂單table-id遞增
function assignDataToOrdersTable() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrders",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};

//ajax動態刷新訂單table-id遞減
function assignDataToOrdersTableIdDesc() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrdersIdDesc",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};

//ajax動態刷新訂單table-date遞增
function assignDataToOrdersTableDateAsc() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrdersDateAsc",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};

//ajax動態刷新訂單table-date遞減
function assignDataToOrdersTableDateDesc() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrdersDateDesc",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};

//ajax動態刷新訂單table-time遞增
function assignDataToOrdersTableTimeAsc() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrdersTimeAsc",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};

//ajax動態刷新訂單table-time遞減
function assignDataToOrdersTableTimeDesc() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrdersTimeDesc",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};

//ajax動態刷新訂單table-expense遞增
function assignDataToOrdersTableExpenseAsc() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrdersExpenseAsc",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};

//ajax動態刷新訂單table-expense遞減
function assignDataToOrdersTableExpenseDesc() {
	$('#totalPrice').empty();
	$('#servicePrice').empty();
	$('#totalIncome').empty();
	$('#ordersTable').empty();
	$('#ordersTable').append(
		'<thead>'+
		'<tr>'+
            '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByDate();">預訂日期<i class="fas fa-sort"></i></button></th>'+
			'<th><button onclick="sortOrdersByTime();">產生日期<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
            '<th><button onclick="sortOrdersByExpense();">服務費(15%)<i class="fas fa-sort"></i></button></th>'+
            '<th>詳情</th>'+
        '</tr>'+
    '</thead>'
	)
	
	$.ajax({
		type: "GET",
		url: "http://localhost:8081/listFinishOrdersExpenseDesc",
		success: function(data) {
			var orders = JSON.parse(JSON.stringify(data));
			let totalPrice = 0;
			let servicePrice = 0;
			let totalIncome = 0;
			
			for (var i in orders) {
				totalPrice += orders[i].expense;
				servicePrice += Math.round(orders[i].expense*0.15);
				totalIncome = (totalPrice-servicePrice);
				
				var orders_date = new Date(orders[i].date);
				let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
				
				var created_date = new Date(orders[i].createTime);
				let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
				$('#ordersTable').append(
                '<tbody>'+
                    '<tr>'+
                        '<td>'+orders[i].id+'</td>'+
                        '<td>'+orders[i].contactName+'</td>'+
                        '<td>'+orders_formatted_date+'</td>'+
                        '<td>'+orders_formatted_created_date+'</td>'+
                        '<td>$'+orders[i].expense+'</td>'+
                        '<td>'+Math.round(orders[i].expense*0.15)+'</td>'+
                        '<td>'+
                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
                        '</td>'+
                    '</tr>'+
                '</tbody>')};
		$('#totalPrice').append('總金額<br>$'+totalPrice);
		$('#servicePrice').append('服務費金額<br>$'+servicePrice);
		$('#totalIncome').append('收款金額<br>$'+totalIncome);
		},
		error: function(data) {
			console.log(data);
		}
	});
};
</script>
</body>
</html>