package tw.hankSideproject.WeSpace_SSH_SpringBoot.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;

public interface OrdersRepository extends JpaRepository<Orders,Integer> ,JpaSpecificationExecutor<Orders>{
	
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
	
	@Query(value="select * from orders where orders_id=?1",nativeQuery = true)
	public Orders listOrdersById(int id);

	//查詢圖表訂單所屬活動類型次數
	@Query(value="select count(*) from orders O "
			+ "left join facilities_type T "
			+ "on O.facilities_type_id = T.facilities_type_id "
			+ "where O.facilities_id = ?1 and T.facilities_type_name = ?2",nativeQuery = true)
	public Double countSpaceType(int facilitiesId,String facilitiesTypeId);
	
	//查詢圖表總訂單數：算比例用
	@Query(value="select count(*) from orders O where O.facilities_id = ?1",nativeQuery = true)
	public Double countSpaceOrders(int facilitiesId);
	
	//僅顯示登入者未處理訂單
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '1'"
			+ "order by orders_id asc",nativeQuery = true)
	public List<Orders> listPendingOrdersByLoginMemberId(int id);
	
	//狀態0: 已退訂/使用者取消
	@Query(value="select * from orders where member_id=?1 and orders_status = '0'",nativeQuery = true)
	public List<Orders> listRejectOrdersByMemberId(int id);
	
	//狀態1: 處理中/未處理
	@Query(value="select * from orders where member_id=?1 and orders_status = '1'",nativeQuery = true)
	public List<Orders> listPendingOrdersByMemberId(int id);
	
	//狀態2: 預訂成功/已預訂
	@Query(value="select * from orders where member_id=?1 and orders_status = '2'",nativeQuery = true)
	public List<Orders> listAcceptOrdersByMemberId(int id);
	
	//狀態4: 完成預訂/已完成/已結束
	@Query(value="select * from orders where member_id=?1 and orders_status = '4'",nativeQuery = true)
	public List<Orders> listFinishOrdersByMemberId(int id);
	
	//狀態3,4和5: 拒絕預訂/取消預訂/完成預訂/已完成/已結束
	@Query(value="select * from orders where member_id=?1 and (orders_status = '3' or orders_status = '4' or orders_status = '5')",nativeQuery = true)
	public List<Orders> listRefuseOrFinishOrCancelOrdersByMemberId(int id);
	
	//列出所有訂單-訂單號遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_id asc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberId(int id);
	
	//列出所有訂單-訂單號遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_id desc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByDesc(int id);

	//列出所有訂單-訂單活動日期遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_date asc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByDateAsc(int id);	
	
	//列出所有訂單-訂單活動日期遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_date desc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByDateDesc(int id);
	
	//列出所有訂單-訂單金額遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_expense asc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByExpenseAsc(int id);
	
	//列出所有訂單-訂單金額遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_expense desc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByExpenseDesc(int id);
	
	//列出所有訂單-狀態遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_status asc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByStatusAsc(int id);
	
	//列出所有訂單-狀態遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_status desc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByStatusDesc(int id);
	
	//列出所有訂單-下訂日期遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_time asc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByTimeAsc(int id);
	
	//列出所有訂單-下訂日期遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 "
			+ "order by orders_time desc",nativeQuery = true)
	public List<Orders> listOrdersByLoginMemberIdOrderByTimeDesc(int id);
	
	////////////////////////////////付款明細的排序方法/////////////////////////////////////
	
	//列出所有訂單-訂單號遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_id asc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByAsc(int id);
	
	//列出所有訂單-訂單號遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_id desc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByDesc(int id);

	//列出所有訂單-訂單活動日期遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_date asc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByDateAsc(int id);	
	
	//列出所有訂單-訂單活動日期遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_date desc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByDateDesc(int id);
	
	//列出所有訂單-訂單金額遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_expense asc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByExpenseAsc(int id);
	
	//列出所有訂單-訂單金額遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_expense desc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByExpenseDesc(int id);
	
	//列出所有訂單-下訂日期遞增
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_time asc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByTimeAsc(int id);
	
	//列出所有訂單-下訂日期遞減
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '4'"
			+ "order by orders_time desc",nativeQuery = true)
	public List<Orders> listFinishOrdersByLoginMemberIdOrderByTimeDesc(int id);
	
	//所有筆數
	@Query(value="select count(*) from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 ",nativeQuery = true)
	public Integer allOrdersCounts(int id);
	
	//尚未處理筆數
	@Query(value="select count(*) from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '1'",nativeQuery = true)
	public Integer allOrdersCountsByStatus1(int id);
	
	//接受預訂筆數
	@Query(value="select count(*) from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '2'",nativeQuery = true)
	public Integer allOrdersCountsByStatus2(int id);
	
	//拒絕預訂筆數
	@Query(value="select count(*) from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '3'",nativeQuery = true)
	public Integer allOrdersCountsByStatus3(int id);
	
	//接受預訂的訂單-計算已預訂訂單金額用
	@Query(value="select * from orders O "
			+ "left join facilities F "
			+ "on O.facilities_id = F.facilities_id "
			+ "where F.member_id=?1 and O.orders_status = '2'",nativeQuery = true)
	public List<Orders> allOrdersByStatus2(int id);
}
