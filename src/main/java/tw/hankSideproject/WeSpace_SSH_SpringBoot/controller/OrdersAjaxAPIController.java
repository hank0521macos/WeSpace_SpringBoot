package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.MemberRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.OrdersRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesImages;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.OrdersRequest;

@CrossOrigin(maxAge = 3600)
@RestController
public class OrdersAjaxAPIController {
	
	@Autowired
	FacilitiesRepository facilitiesRepository;
	
	@Autowired
	MemberRepository memberRepository;
	
	@Autowired
	OrdersRepository ordersRepository;
	
	////////////////////預訂單管理按鈕API////////////////////
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
	//i按鈕訂單明細資料刷新
	@CrossOrigin
	@GetMapping("/listOrdersById/{id}")
	public Orders listOrdersById(@PathVariable(value = "id") Integer id) {
		   return ordersRepository.listOrdersById(id);
	}
	
	//i按鈕訂單明細資料圖片刷新
	@CrossOrigin
	@GetMapping("/listOrdersImgById/{id}")
	public FacilitiesImages listOrdersImgById(@PathVariable(value = "id") Integer id) {
		   Facilities facilities = ordersRepository.listOrdersById(id).getFacilities();
		   Set<FacilitiesImages> facilitiesImage = facilities.getFacilitiesImages();
		   
		   return facilitiesImage.iterator().next();
	}
	
	////////////////////全部訂單按鈕API////////////////////
	//訂單表格刷新api-訂單狀態未處理/處理中(status=1)
	@CrossOrigin
	@GetMapping("/listPendingOrders")
	public List<Orders> listPendingOrders(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listPendingOrdersByLoginMemberId(member.getId());
	}
	
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
    public ResponseEntity<Orders> refuseOrders(@PathVariable(value = "id") Integer id, @RequestBody Orders orders2) {
    	Orders orders = ordersRepository.getById(id);
    	orders.setStatus(3);
    	orders.setStatusNote(orders2.getStatusNote());
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
    
	//訂單表格搜尋關鍵字查詢
	@SuppressWarnings("serial")
	@PostMapping("/listOrdersByMultipleCondition")
	public List<Orders> listOrdersByMultipleCondition(HttpSession session, @RequestBody OrdersRequest request) {
			Member member = (Member)session.getAttribute("loginData"); 
			Specification<Orders> specification = new Specification<Orders>() {
				 @Override
		         public Predicate toPredicate(Root<Orders> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder builder) {
					 //所有的斷言 及條件
		             List<Predicate> predicates = new ArrayList<>();
		             
		             Predicate predicate = builder.equal(root.get("member"), member);
		             
		             if(request.getSpaceName() != null && !request.getSpaceName().equals("")) {
		            	 predicates.add(builder.like(root.get("spaceName"), "%" + request.getSpaceName() + "%"));
		             }
					 
		             if(request.getContactName() != null && !request.getContactName().equals("")) {
		            	 predicates.add(builder.like(root.get("contactName"), "%" + request.getContactName() + "%"));
		             }
		             
		             if(request.getContactMobilePhone() != null && !request.getContactMobilePhone().equals("")) {
		            	 predicates.add(builder.like(root.get("contactMobilePhone"), "%" + request.getContactMobilePhone() + "%"));
		             }
		             
		             Predicate finalPredicate
		             = builder.and(builder.or(predicates.toArray(new Predicate[predicates.size()])), predicate);

					 return finalPredicate;
				 }
			 };
		   List<Orders> orders = ordersRepository.findAll(specification);
		   return orders;
	}
	
	//訂單表格日期動態查詢
	@SuppressWarnings("serial")
	@PostMapping("/listOrdersByDateCondition")
	public List<Orders> listOrdersByDateCondition(HttpSession session, @RequestBody OrdersRequest request) {
			Member member = (Member)session.getAttribute("loginData"); 
			Specification<Orders> specification = new Specification<Orders>() {
				 @Override
		         public Predicate toPredicate(Root<Orders> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder builder) {
					 //所有的斷言 及條件
		             List<Predicate> predicates = new ArrayList<>();
		             
		             Predicate predicate = builder.equal(root.get("member"), member);
		             
		             if(request.getBeginningDate() != null && request.getEndingDate() != null) {
		            	 predicates.add(builder.between(root.get("date"),request.getBeginningDate(),request.getEndingDate()));
//		            	 predicates.add(builder.and(builder.equal(root.get("date"),request.getBeginningDate()),builder.equal(root.get("date"),request.getEndingDate())));
		             }
		             
		             if(request.getBeginningCreateDate() != null && request.getEndingCreateDate() != null) {
		            	 predicates.add(builder.between(root.get("createTime"),request.getBeginningCreateDate(),request.getEndingCreateDate()));
//		            	 predicates.add(builder.and(builder.equal(root.get("createTime"),request.getBeginningCreateDate()),builder.equal(root.get("createTime"),request.getEndingCreateDate())));
		             }
		             
		             Predicate finalPredicate
		             = builder.and(builder.or(predicates.toArray(new Predicate[predicates.size()])), predicate);

					 return finalPredicate;
				 }
			 };
		   List<Orders> orders = ordersRepository.findAll(specification);
		   return orders;
	}
	
	////////////////////付款明細按鈕API////////////////////
	//訂單表格刷新api-訂單狀態已完成/已收款(status=4)
	//已完成/已收款(status=4)訂單表格刷新api-訂單號遞增
	@CrossOrigin
	@GetMapping("/listFinishOrders")
	public List<Orders> listFinishOrders(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByAsc(member.getId());
	}
	
	//已完成/已收款(status=4)訂單表格刷新api-訂單號遞減
	@CrossOrigin
	@GetMapping("/listFinishOrdersIdDesc")
	public List<Orders> listFinishOrdersIdDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByDesc(member.getId());
	}
	
	//已完成/已收款(status=4)訂單表格刷新api-訂單活動日期遞增
	@CrossOrigin
	@GetMapping("/listFinishOrdersDateAsc")
	public List<Orders> listFinishOrdersDateAsc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByDateAsc(member.getId());
	}
	
	//已完成/已收款(status=4)訂單表格刷新api-訂單活動日期遞減
	@CrossOrigin
	@GetMapping("/listFinishOrdersDateDesc")
	public List<Orders> listFinishOrdersDateDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByDateDesc(member.getId());
	}
	
	//已完成/已收款(status=4)訂單表格刷新api-訂單價格遞增
	@CrossOrigin
	@GetMapping("/listFinishOrdersExpenseAsc")
	public List<Orders> listFinishOrdersExpenseAsc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByExpenseAsc(member.getId());
	}
	
	//已完成/已收款(status=4)訂單表格刷新api-訂單價格遞減
	@CrossOrigin
	@GetMapping("/listFinishOrdersExpenseDesc")
	public List<Orders> listFinishOrdersExpenseDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByExpenseDesc(member.getId());
	}
	
	//已完成/已收款(status=4)訂單表格刷新api-訂單下訂時間遞增
	@CrossOrigin
	@GetMapping("/listFinishOrdersTimeAsc")
	public List<Orders> listFinishOrdersTimeAsc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByTimeAsc(member.getId());
	}
	
	//已完成/已收款(status=4)訂單表格刷新api-訂單下訂時間遞減
	@CrossOrigin
	@GetMapping("/listFinishOrdersTimeDesc")
	public List<Orders> listFinishOrdersTimeDesc(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return ordersRepository.listFinishOrdersByLoginMemberIdOrderByTimeDesc(member.getId());
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
	
	//付款明細表格日期動態查詢
	@SuppressWarnings("serial")
	@PostMapping("/listFinishOrdersByDateCondition")
	public List<Orders> listFinishOrdersByDateCondition(HttpSession session, @RequestBody OrdersRequest request) {
			Member member = (Member)session.getAttribute("loginData"); 
			Specification<Orders> specification = new Specification<Orders>() {
				 @Override
		         public Predicate toPredicate(Root<Orders> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder builder) {
					 //所有的斷言 及條件
		             List<Predicate> predicates = new ArrayList<>();
		             
		             Predicate predicate = builder.equal(root.get("member"), member);
		             
		             Predicate predicate2 = builder.equal(root.get("status"), 4);
		             
		             if(request.getBeginningDate() != null && request.getEndingDate() != null) {
		            	 predicates.add(builder.between(root.get("date"),request.getBeginningDate(),request.getEndingDate()));
//		            	 predicates.add(builder.and(builder.equal(root.get("date"),request.getBeginningDate()),builder.equal(root.get("date"),request.getEndingDate())));
		             }
		             
		             if(request.getBeginningCreateDate() != null && request.getEndingCreateDate() != null) {
		            	 predicates.add(builder.between(root.get("createTime"),request.getBeginningCreateDate(),request.getEndingCreateDate()));
//		            	 predicates.add(builder.and(builder.equal(root.get("createTime"),request.getBeginningCreateDate()),builder.equal(root.get("createTime"),request.getEndingCreateDate())));
		             }
		             
		             Predicate finalPredicate
		             = builder.and(builder.or(predicates.toArray(new Predicate[predicates.size()])), predicate, predicate2);

					 return finalPredicate;
				 }
			 };
		   List<Orders> orders = ordersRepository.findAll(specification);
		   return orders;
	}
}
