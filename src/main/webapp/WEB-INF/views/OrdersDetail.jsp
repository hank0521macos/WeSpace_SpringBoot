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
				<li><a href="/mySpace">我的空間</a></li>
			</ul>
		</div>
		<div class="ordersButton">
            <a href="/ordersDetailInfo"><div class="ordersDetailButton">付款明細<i class="fas fa-arrow-right"></i></div></a>
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
            <select id="dateCondition">
                <option value="0">無</option>
                <option value="1">活動日期</option>
                <option value="2">下訂日期</option>
            </select>
            <input id="beforeDate" type="date" class="searchConditionDate">&nbsp;<span style="color:black;">至</span>
            <input id="afterDate" type="date" class="searchConditionDate">
            <input type="text" placeholder="關鍵字" name="spaceName" id="spaceName" class="searchConditionName">
            <input type="button" value="篩選" onclick="searchConditionSubmit();" class="searchConditionSubmit" id="searchConditionSubmit">
        </div>
        <div class="undisposed">
            <input type="checkbox" id="showPendingOrders"> 僅顯示未處理訂單
        </div>
        <div>
            <table class="ordersList" id="ordersTable" ></table>
        </div>
        <div style="height:100px;"></div>
	</div>
</div>

<!-- i按鈕訂單明細顯示的區塊 -->
<div class="bg-modal">
	<div class="modal-contents" id="modal-contents"></div>
</div>

<!-- 拒絕按鈕的form表單顯示區塊 -->
<div class="bg-modal2">
	<div class="modal-contents2" id="modal-contents2">
		<div class="close" onclick="close123();">+</div>
		<div class="ordersTitle">拒絕原因</div>
		<select class="refuseSelect" id="refuseSelect">
			<option selected disabled>請選擇原因：</option>
			<option value="1">當日訂位已額滿</option>
			<option value="2">訂單資料不正確</option>
			<option value="3">無法提供您所需要的要求</option>
			<option value="4">當天暫停營業</option>
			<option value="5">其它</option>
		</select>
		<textarea name="statusNote" class="refuseTextArea" id="refuseTextArea"></textarea>
		<input type="button" class="refuseSubmit" value="送出" onclick="refuseOrdersSubmit();">
	</div>
</div>

<script>
	//搜尋欄輸入後自動更新ajax Table
	var ele_key = document.getElementById("spaceName");
	var val;
	ele_key.onkeyup = function (e) {
		  val = this.value;
	      var jsonVar = {
	    		  ordersId: val,
		          spaceName: val,
		          contactName: val,
		          contactMobilePhone: val
		  }
	      if(val != ''){
	 		  $.ajax({
		            type:"POST",
		            url:"http://localhost:8081/listOrdersByMultipleCondition",
		            data: JSON.stringify(jsonVar),
		            contentType: "application/json",
		            success: function(data){
		            	var orders = JSON.parse(JSON.stringify(data));
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
		    			
						for (var i in orders) {
							if(orders[i].status ==0){
								var status = '<font style="color:gray;">使用者取消</font>';
								var edit = '-';
							}else if(orders[i].status ==1){
								var status = '<font style="color:#FF3333;">未處理</font>';
								var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
							}else if(orders[i].status ==2){
								var status = '<font style="color:#5cb85c;">已預訂</font>';
								var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
							}else if(orders[i].status ==3){
								var status = '<font style="color:#428bca;">已拒絕</font>';
								var edit = '-';
							}else if(orders[i].status ==4){
								var status = '<font style="color:gray;">已完成</font>';
								var edit = '-';
							}else if(orders[i].status ==5){
								var status = '<font style="color:gray;">預訂取消</font>';
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
			                        	'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
			                        '</td>'+
			                        '<td>'+
			                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
			                        '</td>'+
			                    '</tr>'+
			                '</tbody>')};
			                
			                var table,tr,filter,k,td1,td2,j;
			                table = document.getElementById("ordersTable");
			                tr = table.getElementsByTagName("tr");
			                filter = val.toUpperCase();
			                for(k = 1;k < tr.length; k++){
			                	td1 = tr[k].getElementsByTagName("td")[1];
			                	td2 = tr[k].getElementsByTagName("td")[2];
			                	td4 = tr[k].getElementsByTagName("td")[4];
			                    if(td1 || td2 || td4){
			                    	
			                  		if(td1.innerHTML.toUpperCase().indexOf(filter)>-1){
			                  		   td1.innerHTML = td1.innerHTML.replace(val,'<span style="color:red; background-color:yellow;">'+val+'</span>');
			                 		} 
			                  		if(td2.innerHTML.toUpperCase().indexOf(filter)>-1){
				                  	   td2.innerHTML = td2.innerHTML.replace(val,'<span style="color:red; background-color:yellow;">'+val+'</span>');
				                 	} 
			                  		if(td4.innerHTML.toUpperCase().indexOf(filter)>-1){
				                  	   td4.innerHTML = td4.innerHTML.replace(val,'<span style="color:red; background-color:yellow;">'+val+'</span>');
					                }
			                    	
			                    }
			                }
		            },
		            error: function(err) {  
		                console.log(err);
		                alert(err);
		            }
			  })
	      }else{
	    	  assignDataToOrdersTable();
	      }
	}

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
	      
  		  $.ajax({
	            type:"POST",
	            url:"http://localhost:8081/listOrdersByDateCondition",
	            data: JSON.stringify(jsonVar),
	            contentType: "application/json",
	            success: function(data){
	            	var orders = JSON.parse(JSON.stringify(data));
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
	    			
					for (var i in orders) {
						if(orders[i].status ==0){
							var status = '<font style="color:gray;">使用者取消</font>';
							var edit = '-';
						}else if(orders[i].status ==1){
							var status = '<font style="color:#FF3333;">未處理</font>';
							var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
						}else if(orders[i].status ==2){
							var status = '<font style="color:#5cb85c;">已預訂</font>';
							var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
						}else if(orders[i].status ==3){
							var status = '<font style="color:#428bca;">已拒絕</font>';
							var edit = '-';
						}else if(orders[i].status ==4){
							var status = '<font style="color:gray;">已完成</font>';
							var edit = '-';
						}else if(orders[i].status ==5){
							var status = '<font style="color:gray;">預訂取消</font>';
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
		                        	'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
		                        '</td>'+
		                        '<td>'+
		                            '<button onclick="deleteOrders('+orders[i].id+');"><i class="far fa-trash-alt"></i></button>'+
		                        '</td>'+
		                    '</tr>'+
		                '</tbody>')};
	            },
	            error: function(err) {  
	                console.log(err);
	                alert(err);
	            }
		  })

	};
	
	//顯示未處理status=1的訂單
	var showPendingOrders = document.getElementById('showPendingOrders');
	showPendingOrders.onchange = function(){
		if(this.checked){
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
				url: "http://localhost:8081/listPendingOrders",
				success: function(data) {
					var orders = JSON.parse(JSON.stringify(data));
					
					for (var i in orders) {
						if(orders[i].status ==0){
							var status = '<font style="color:gray;">使用者取消</font>';
							var edit = '-';
						}else if(orders[i].status ==1){
							var status = '<font style="color:#FF3333;">未處理</font>';
							var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
						}else if(orders[i].status ==2){
							var status = '<font style="color:#5cb85c;">已預訂</font>';
							var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
						}else if(orders[i].status ==3){
							var status = '<font style="color:#428bca;">已拒絕</font>';
							var edit = '-';
						}else if(orders[i].status ==4){
							var status = '<font style="color:gray;">已完成</font>';
							var edit = '-';
						}else if(orders[i].status ==5){
							var status = '<font style="color:gray;">預訂取消</font>';
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
		                            '<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
			
		}else{
			assignDataToOrdersTable();
		};
	}



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
		document.querySelector('.bg-modal2').style.display = "none";
	}
	
	//接受訂單
	function acceptOrders(ordersId) {
	  var agree = confirm("確定要接受此筆訂單？");
	  if(agree){
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
	};
	
	//完成訂單
	function finishOrders(ordersId) {
	  var agree = confirm("確定此筆訂單已完成？");
	  if(agree){
	  $.ajax({
            type:"PUT",
            url:"http://localhost:8081/finishOrders/" + ordersId,
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
		document.querySelector('.bg-modal2').style.display = "flex";
		$('#modal-contents2').append('<input type="hidden" id="ordersId" value='+ordersId+'>');
	};
	
	//拒絕訂單
	function refuseOrdersSubmit() {
 		var agree = confirm("確定要拒絕此筆訂單？");
 		var ordersId = $('#ordersId').val();
        var jsonVar = {
            statusNote: $("#refuseTextArea").val(),
        };
		if(agree){
		  $.ajax({
	            type:"PUT",
	            url:"http://localhost:8081/refuseOrders/" + ordersId,
	            data: JSON.stringify(jsonVar),
	            contentType: "application/json",
	            success: function(data){
	            	 close123();
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
	
	//拒絕表單內的select事件
	$('#refuseSelect').on('change', function() {
		var selectValue =  this.value;
		switch (selectValue) {
		case '1':
			$('#refuseTextArea').val('很抱歉，當日訂位已額滿，恕無法提供您當日訂位！');
			break;
		case '2':
			$('#refuseTextArea').val('很抱歉，您提供的資料不正確，恕無法為您保留訂位！');
			break;
		case '3':
			$('#refuseTextArea').val('很抱歉，您備註上的需求，恕無法提供！');
			break;
		case '4':
			$('#refuseTextArea').val('很抱歉，當日因有特殊原因，故暫停營業！');
			break;
		case '5':
			$('#refuseTextArea').val('');
			break;
		}
	});
	
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
	                        	'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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
						var status = '<font style="color:gray;">使用者取消</font>';
						var edit = '-';
					}else if(orders[i].status ==1){
						var status = '<font style="color:#FF3333;">未處理</font>';
						var edit = '<button onclick="acceptOrders('+orders[i].id+');">接受</button>/<button onclick="refuseOrders('+orders[i].id+');">拒絕</button>';
					}else if(orders[i].status ==2){
						var status = '<font style="color:#5cb85c;">已預訂</font>';
						var edit = '<button onclick="cancelOrders('+orders[i].id+');">取消</button>/<button onclick="finishOrders('+orders[i].id+');">完成</button>';
					}else if(orders[i].status ==3){
						var status = '<font style="color:#428bca;">已拒絕</font>';
						var edit = '-';
					}else if(orders[i].status ==4){
						var status = '<font style="color:gray;">已完成</font>';
						var edit = '-';
					}else if(orders[i].status ==5){
						var status = '<font style="color:gray;">預訂取消</font>';
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
                        		'<button onclick="infoBox('+orders[i].id+');"><i class="fas fa-info-circle"></i></button>'+
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