$(document).ready(function(){
	assignDataToOrdersTable();

	//ajax動態刷新訂單table
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
			url: "/listFinishOrders",
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

})
