$(document).ready(function() {
	assignDataToOrdersTable();
	assignDataToOrdersDetailCountsData();
	//	使用者/開發者
	//	--退訂--
	//	0: 已退訂/使用者取消
	//	--處理中--
	//	1: 處理中/未處理
	//	--已預訂--
	//	2: 預訂成功/已預訂
	//	--已結束--
	//	3: 預訂失敗/已拒絕
	//	4: 完成預訂/已完成
	//	5: 取消預訂/預訂取消
	//ajax動態刷新訂單table
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
	}

})
