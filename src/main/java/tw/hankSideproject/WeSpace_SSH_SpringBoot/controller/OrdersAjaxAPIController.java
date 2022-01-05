package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.MemberRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.OrdersRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOwner;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;

@CrossOrigin(maxAge = 3600)
@RestController
public class OrdersAjaxAPIController {
	
	@Autowired
	FacilitiesRepository facilitiesRepository;
	
	@Autowired
	MemberRepository memberRepository;
	
	@Autowired
	OrdersRepository ordersRepository;
	
	//訂單表格刷新api-訂單號遞增
	@CrossOrigin
	@GetMapping("/listOrders")
	public List<Orders> listOrders(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberId(member.getId());
	}
	
	//訂單表格刷新api-訂單號遞減
	@CrossOrigin
	@GetMapping("/listOrdersIdDesc")
	public List<Orders> listOrdersIdDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByDesc(member.getId());
	}
	
	//訂單表格刷新api-訂單活動日期遞增
	@CrossOrigin
	@GetMapping("/listOrdersDateAsc")
	public List<Orders> listOrdersDateAsc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByDateAsc(member.getId());
	}
	
	//訂單表格刷新api-訂單活動日期遞減
	@CrossOrigin
	@GetMapping("/listOrdersDateDesc")
	public List<Orders> listOrdersDateDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByDateDesc(member.getId());
	}
	
	//訂單表格刷新api-訂單價格遞增
	@CrossOrigin
	@GetMapping("/listOrdersExpenseAsc")
	public List<Orders> listOrdersExpenseAsc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByExpenseAsc(member.getId());
	}
	
	//訂單表格刷新api-訂單價格遞減
	@CrossOrigin
	@GetMapping("/listOrdersExpenseDesc")
	public List<Orders> listOrdersExpenseDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByExpenseDesc(member.getId());
	}
	
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
	//訂單表格刷新api-訂單狀態遞增
	@CrossOrigin
	@GetMapping("/listOrdersStatusAsc")
	public List<Orders> listOrdersStatusAsc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByStatusAsc(member.getId());
	}
	
	//訂單表格刷新api-訂單狀態遞減
	@CrossOrigin
	@GetMapping("/listOrdersStatusDesc")
	public List<Orders> listOrdersStatusDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByStatusDesc(member.getId());
	}
	
	//訂單表格刷新api-訂單下訂時間遞增
	@CrossOrigin
	@GetMapping("/listOrdersTimeAsc")
	public List<Orders> listOrdersTimeAsc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByTimeAsc(member.getId());
	}
	
	//訂單表格刷新api-訂單下訂時間遞減
	@CrossOrigin
	@GetMapping("/listOrdersTimeDesc")
	public List<Orders> listOrdersTimeDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listOrdersByLoginMemberIdOrderByTimeDesc(member.getId());
	}
	
	//計次統計刷新api-所有筆數
	@CrossOrigin
	@GetMapping("/listOrdersCounts")
	public Integer listOrdersCounts(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.allOrdersCounts(member.getId());
	}

	//計次統計刷新api-尚未處理
	@CrossOrigin
	@GetMapping("/listOrdersCountsStatus1")
	public Integer listOrdersCountsStatus1(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.allOrdersCountsByStatus1(member.getId());
	}
	
	//計次統計刷新api-已預訂
	@CrossOrigin
	@GetMapping("/listOrdersCountsStatus2")
	public Integer listOrdersCountsStatus2(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.allOrdersCountsByStatus2(member.getId());
	}
	
	//計次統計刷新api-已拒絕
	@CrossOrigin
	@GetMapping("/listOrdersCountsStatus3")
	public Integer listOrdersCountsStatus3(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.allOrdersCountsByStatus3(member.getId());
	}
	
	//計算已預訂總金額api
	@CrossOrigin
	@GetMapping("/acceptOrdersPrice")
	public Integer allOrdersByStatus2(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   List<Orders> orders = ordersRepository.allOrdersByStatus2(member.getId());
		   Integer price = 0;
		   for(Orders o:orders){
			  price += (int)Math.round(o.getExpense());
		   }
		   return price;
	}
	
    //訂單狀態更新為預訂成功/已預訂(status=2)api
    @CrossOrigin
    @PutMapping("/acceptOrders/{id}")
    public ResponseEntity<Orders> acceptOrders(@PathVariable(value = "id") Integer id) {
    	Orders orders = ordersRepository.getById(id);
    	orders.setStatus(2);
        Orders updatedOrders = ordersRepository.save(orders);
        return ResponseEntity.ok(updatedOrders); 
    }
    
    //訂單狀態更新為預訂失敗/已拒絕(status=3)api
    @CrossOrigin
    @PutMapping("/refuseOrders/{id}")
    public ResponseEntity<Orders> refuseOrders(@PathVariable(value = "id") Integer id) {
    	Orders orders = ordersRepository.getById(id);
    	orders.setStatus(3);
        Orders updatedOrders = ordersRepository.save(orders);
        return ResponseEntity.ok(updatedOrders); 
    }
    
    //訂單狀態更新為完成預訂/已完成(status=4)api
    @CrossOrigin
    @PutMapping("/finishOrders/{id}")
    public ResponseEntity<Orders> finishOrders(@PathVariable(value = "id") Integer id) {
    	Orders orders = ordersRepository.getById(id);
    	orders.setStatus(4);
        Orders updatedOrders = ordersRepository.save(orders);
        return ResponseEntity.ok(updatedOrders); 
    }
    
    //訂單狀態更新為取消預訂/預訂取消(status=5)api
    @CrossOrigin
    @PutMapping("/cancelOrders/{id}")
    public ResponseEntity<Orders> cancelOrders(@PathVariable(value = "id") Integer id) {
    	Orders orders = ordersRepository.getById(id);
    	orders.setStatus(5);
        Orders updatedOrders = ordersRepository.save(orders);
        return ResponseEntity.ok(updatedOrders); 
    }
    
	//刪除訂單API
    @CrossOrigin
    @DeleteMapping("/deleteOrders/{id}")
    public ResponseEntity<Orders> deleteOrders(@PathVariable(value = "id") Integer id) {
    	Orders orders = ordersRepository.getById(id);
    	if(orders == null) {
            return ResponseEntity.notFound().build();
        }
    	ordersRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
