<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeSpace | 預訂單管理</title>
<link rel="stylesheet" href="css/OrdersDetail/ordersDetail.css">
<script src="https://kit.fontawesome.com/d210246855.js" crossorigin="anonymous"></script>
<script src="vendors/jquery/jquery-3.6.0.min.js"></script>
<script src="js/OrdersDetail/ajaxCRUD.js"></script>
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
            <a href="/ordersDetailInfo"><div class="ordersDetailButton">訂單明細<i class="fas fa-arrow-right"></i></div></a>
		</div>
        <div class="ordersDetailCounts">
            <div class="c1">
                <i class="fas fa-star"></i>
                <div class="ordersDetailCountsData" id="c1"></div>
            </div>
            <div class="c2">
                <i class="fas fa-thumbs-up"></i>
                <div class="ordersDetailCountsData" id="c2"></div>
            </div>
            <div class="c3">
                <i class="fas fa-thumbs-down"></i>
                <div class="ordersDetailCountsData" id="c3"></div>
            </div>
            <div class="c4">
                <i class="fas fa-question-circle"></i>
                <div class="ordersDetailCountsData" id="c4"></div>
        </div>
        <div class="searchCondition">
            <select name="" id="">
                <option value="">無</option>
                <option value="">活動日期</option>
                <option value="">下訂日期</option>
            </select>
            <input id="date" type="date" class="searchConditionDate">&nbsp;<span style="color:black;">至</span>
            <input id="date" type="date" class="searchConditionDate">
            <input type="text" placeholder="關鍵字" class="searchConditionName">
            <input type="submit" value="篩選"  class="searchConditionSubmit">
        </div>
        <div class="undisposed">
            <input type="checkbox"> 僅顯示未處理訂單
        </div>
        <div>
            <table class="ordersList" id="ordersTable" ></table>
        </div>
	</div>
</div>


<div class="bg-modal">
	<div class="modal-contents">
		<div class="close" onclick="close123();">+</div>
	</div>
</div>


<script>
	function infoBox(ordersId){
		document.querySelector('.bg-modal').style.display = "flex";
	}
	
	function close123(){
		document.querySelector('.bg-modal').style.display = "none";
	}
	
	

	//接受訂單
	function acceptOrders(ordersId) {
	  $.ajax({
            type:"PUT",
            url:"http://localhost:8081/acceptOrders/" + ordersId,
            success: function(){
            	 assignDataToOrdersTable();
            	 assignDataToOrdersDetailCountsData();
            },
            error: function(err) {  
                console.log(err);
                alert(err);
            }
	   });
	};
	
	//取消訂單
	function cancelOrders(ordersId) {
		var agree = confirm("確定要取消此筆訂單？");
		if(agree){
		  $.ajax({
	            type:"PUT",
	            url:"http://localhost:8081/cancelOrders/" + ordersId,
	            success: function(){
	            	 assignDataToOrdersTable();	
	            	 assignDataToOrdersDetailCountsData();
	            },
	            error: function(err) {  
	                console.log(err);
	                alert(err);
	            }
		   });
		};
	};
	
	//拒絕訂單
	function refuseOrders(ordersId) {
		var agree = confirm("確定要拒絕此筆訂單？");
		if(agree){
		  $.ajax({
	            type:"PUT",
	            url:"http://localhost:8081/refuseOrders/" + ordersId,
	            success: function(){
	            	 assignDataToOrdersTable();
	            	 assignDataToOrdersDetailCountsData();
	            },
	            error: function(err) {  
	                console.log(err);
	                alert(err);
	            }
		   });
		};
	};
	
	//刪除訂單
    function deleteOrders(ordersId){
		var agree = confirm("確定要刪除此筆訂單？");
		if(agree){
		  $.ajax({
	            type:"DELETE",
	            url:"http://localhost:8081/deleteOrders/" + ordersId,
	            success: function(){
	            	 assignDataToOrdersTable();
	            	 assignDataToOrdersDetailCountsData();
	            },
	            error: function(err) {  
	                console.log(err);
	                alert(err);
	            }
		   });
		};
 	};
 	
	//ajax動態刷新次數統計
	function assignDataToOrdersDetailCountsData(){
		//所有筆數
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersCounts",
			success: function(data) {
				var counts = JSON.parse(JSON.stringify(data));
				$('#c1').html(''+counts+'<br>所有筆數<br>&nbsp;<br>&nbsp;');
			},
			error: function(data) {
				console.log(data);
			}
		});
		//接受預訂
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersCountsStatus2",
			success: function(data) {
				var counts = JSON.parse(JSON.stringify(data));
				$('#c2').html(''+counts+'<br>接受預訂<br>');
			},
			error: function(data) {
				console.log(data);
			}
		});
		//接受預訂的金額
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/acceptOrdersPrice",
			success: function(data) {
				var counts = JSON.parse(JSON.stringify(data));
				$('#c2').append('$'+counts+'<br>&nbsp;');
			},
			error: function(data) {
				console.log(data);
			}
		});
		//拒絕預訂
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersCountsStatus3",
			success: function(data) {
				var counts = JSON.parse(JSON.stringify(data));
				$('#c3').html(''+counts+'<br>拒絕預訂<br>&nbsp;<br>&nbsp;');
			},
			error: function(data) {
				console.log(data);
			}
		});
		//尚未處理
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersCountsStatus1",
			success: function(data) {
				var counts = JSON.parse(JSON.stringify(data));
				$('#c4').html(''+counts+'<br>尚未處理<br>&nbsp;<br>&nbsp;');
			},
			error: function(data) {
				console.log(data);
			}
		});
	};
 	
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
 	//訂單狀態排序
 	var s = 0;
 	function sortOrdersByStatus(){
 		if(s==0){
 			assignDataToOrdersTableStatusDesc();
 		}if(s==1){
 			assignDataToOrdersTableStatusAsc();
 			s=-1;
 		}
 		s++;
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
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrders",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-id遞減
	function assignDataToOrdersTableIdDesc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersIdDesc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-活動日期遞減
	function assignDataToOrdersTableDateAsc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersDateAsc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-活動日期遞減
	function assignDataToOrdersTableDateDesc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersDateDesc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-訂單價格遞增
	function assignDataToOrdersTableExpenseAsc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersExpenseAsc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-訂單價格遞減
	function assignDataToOrdersTableExpenseDesc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersExpenseDesc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-訂單狀態遞增
	function assignDataToOrdersTableStatusAsc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersStatusAsc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-訂單狀態遞減
	function assignDataToOrdersTableStatusDesc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersStatusDesc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
	
	//ajax動態刷新訂單table-訂單下訂遞增
	function assignDataToOrdersTableTimeAsc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersTimeAsc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
 
	//ajax動態刷新訂單table-訂單下訂遞減
	function assignDataToOrdersTableTimeDesc() {
		$('#ordersTable').empty();
		$('#ordersTable').append(
			'<thead>'+
			'<tr>'+
                '<th><button onclick="sortOrdersById();">訂單編號<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">場地<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">姓名<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByDate();">活動日期<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersById();">電話<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByExpense();">訂單金額<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByStatus();">狀態<i class="fas fa-sort"></i></button></th>'+
                '<th><button onclick="sortOrdersByTime();">下訂日期<i class="fas fa-sort"></i></button></th>'+
                '<th>處理</th>'+
                '<th>詳情</th>'+
                '<th>刪除</th>'+
            '</tr>'+
        '</thead>'
		)
		
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOrdersTimeDesc",
			success: function(data) {
				var orders = JSON.parse(JSON.stringify(data));
				
				for (var i in orders) {
					if(orders[i].status ==0){
						var status = '使用者取消';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '未處理';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '已預訂';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消預訂</button>';
					}else if(orders[i].status ==3){
						var status = '已拒絕';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '完成預訂';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '預訂取消';
						var edit = '-';
					};
					
					var orders_date = new Date(orders[i].date);
					let orders_formatted_date = orders_date.getFullYear() + "-" + (orders_date.getMonth() + 1) + "-" + orders_date.getDate();
					
					var created_date = new Date(orders[i].createTime);
					let orders_formatted_created_date = created_date.getFullYear() + "-" + (created_date.getMonth() + 1) + "-" + created_date.getDate();
				
					$('#ordersTable').append(
	                '<tbody>'+
	                    '<tr>'+
	                        '<td>'+orders[i].id+'</td>'+
	                        '<td>'+orders[i].spaceName+'</td>'+
	                        '<td>'+orders[i].contactName+'</td>'+
	                        '<td>'+orders_formatted_date+'</td>'+
	                        '<td>'+orders[i].contactMobilePhone+'</td>'+
	                        '<td>$'+orders[i].expense+'</td>'+
	                        '<td>'+status+'</td>'+
	                        '<td>'+orders_formatted_created_date+'</td>'+
	                        '<td>'+edit+'</td>'+
	                        '<td>'+
	                            '<button><i class="fas fa-info-circle"></i></button>'+
	                        '</td>'+
	                        '<td>'+
	                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
	                        '</td>'+
	                    '</tr>'+
	                '</tbody>')};

			},
			error: function(data) {
				console.log(data);
			}
		});
	};
</script>
</body>
</html>