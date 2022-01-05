package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOpeningDetailRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOpeningRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesTypeRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.MemberRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.OrdersRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesType;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.service.FrontEndService;

@Controller
public class FrontEndController {
	
	@Autowired
	MemberRepository memberRepository;
	
	@Autowired
	FacilitiesRepository facilitiesRepository;
	
	@Autowired
	FacilitiesTypeRepository facilitiesTypeRepository;
	
	@Autowired
	FacilitiesOpeningRepository facilitiesOpeningRepository;
	
	@Autowired
	FacilitiesOpeningDetailRepository facilitiesOpeningDetailRepository;
	
	@Autowired
	OrdersRepository ordersRepository;
	
	@Autowired
	FrontEndService frontEndService;
	
	//首頁頁面導向
	@RequestMapping("/")
	public String index(Model model){
		FacilitiesType facilitiesType5 = facilitiesTypeRepository.getById(5);
		FacilitiesType facilitiesType1 = facilitiesTypeRepository.getById(1);
		FacilitiesType facilitiesType3 = facilitiesTypeRepository.getById(3);
		
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		model.addAttribute("facilitiesAll",facilitiesRepository.findAll());
		model.addAttribute("facilitiesType5",facilitiesType5.getFacilities());
		model.addAttribute("facilitiesType1",facilitiesType1.getFacilities());
		model.addAttribute("facilitiesType3",facilitiesType3.getFacilities());
		
		return "HomePage";
	}
	
	//主頁搜尋頁面導向
	@GetMapping("/searchResult")
	public String searchResult(
			Model model,
			@RequestParam(value="facilitiesTypeId",required=false) Integer facilitiesTypeId,
			@RequestParam(value="facilitiesCity",required=false) String facilitiesCity,
			@RequestParam(value="facilitiesGuests",required=false) String facilitiesGuests
			)
	{
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		model.addAttribute("facilitiesAll",facilitiesRepository.findAll());
		//初始化搜尋條件並且呼叫sp方法查詢出符合條件的空間實體
		Integer facilitiesGuestsMin ;
		Integer facilitiesGuestsMax ;
		if(facilitiesGuests != null) {
			facilitiesGuestsMin = Integer.parseInt(facilitiesGuests);
			facilitiesGuestsMax = Integer.parseInt(facilitiesGuests);
			if(facilitiesGuestsMin<=20) {
				facilitiesGuestsMax += 9;
			}else if(facilitiesGuestsMin>=21 && facilitiesGuestsMin <=100) {
				facilitiesGuestsMax += 19;
			}else if(facilitiesGuestsMin>=101 && facilitiesGuestsMin <=500) {
				facilitiesGuestsMax += 99;
			}else if(facilitiesGuestsMin>=501){
				facilitiesGuestsMax += 9999;
			}
		}else {
			facilitiesGuestsMin = 0;
			facilitiesGuestsMax = 9999;
		}
		List<Facilities> mainSearch = facilitiesRepository.findFacilitiessByMainSearch(facilitiesTypeId, facilitiesCity, facilitiesGuestsMin, facilitiesGuestsMax);
		model.addAttribute("facilitiesByMainSearch",mainSearch);
		return "SearchResult";
	}
	
	//次搜尋頁面導向
	@GetMapping("/subSearchResult")
	public String subSearchResult(
			Model model,
			@RequestParam(value="facilitiesTypeId",required=false) Integer facilitiesTypeId,
			@RequestParam(value="facilitiesGuests",required=false) String facilitiesGuests,
			@RequestParam(value="facilitiesCity",required=false) String facilitiesCity,
			@RequestParam(value="facilitiesMaxBudget",required=false) Integer facilitiesMaxBudget,
			@RequestParam(value="facilitiesMinBudget",required=false) Integer facilitiesMinBudget,
			@RequestParam(value="facilitiesName",required=false) String facilitiesName,
			@RequestParam(value="facilitiesOpeningDay",required=false) Integer facilitiesOpeningDay,
			@RequestParam(value="facilitiesOpeningPeriod",required=false) Integer facilitiesOpeningPeriod
			)
	{
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		model.addAttribute("facilitiesAll",facilitiesRepository.findAll());
		//初始化搜尋條件並且呼叫sp方法查詢出符合條件的空間實體
		Integer facilitiesGuestsMin ;
		Integer facilitiesGuestsMax ;
		if(facilitiesGuests != null) {
			facilitiesGuestsMin = Integer.parseInt(facilitiesGuests);
			facilitiesGuestsMax = Integer.parseInt(facilitiesGuests);
			if(facilitiesGuestsMin<=20) {
				facilitiesGuestsMax += 9;
			}else if(facilitiesGuestsMin>=21 && facilitiesGuestsMin <=100) {
				facilitiesGuestsMax += 19;
			}else if(facilitiesGuestsMin>=101 && facilitiesGuestsMin <=500) {
				facilitiesGuestsMax += 99;
			}else if(facilitiesGuestsMin>=501){
				facilitiesGuestsMax += 9999;
			}
		}else {
			facilitiesGuestsMin = 0;
			facilitiesGuestsMax = 9999;
		};
		
		Integer facilitiesMinOpeningDay = null;
		Integer facilitiesMaxOpeningDay = null;
		if(facilitiesOpeningDay != null) {
			//平日
			if(facilitiesOpeningDay ==1) {
				facilitiesMinOpeningDay = 1;
				facilitiesMaxOpeningDay = 5;
			//假日
			}else if(facilitiesOpeningDay ==2){
				facilitiesMinOpeningDay = 6;
				facilitiesMaxOpeningDay = 7;
			//全日
			}else {
				facilitiesMinOpeningDay = 1;
				facilitiesMaxOpeningDay = 7;
			}
		}else {
			//全日
			facilitiesMinOpeningDay = 1;
			facilitiesMaxOpeningDay = 7;
		};
		
		List<Facilities> subSearch = facilitiesRepository.findFacilitiessBysubSearch(
				facilitiesTypeId, facilitiesGuestsMin, facilitiesGuestsMax,facilitiesCity,
				facilitiesMaxBudget,facilitiesMinBudget,'%'+facilitiesName+'%',facilitiesMinOpeningDay,
				facilitiesMaxOpeningDay,facilitiesOpeningPeriod);
		model.addAttribute("facilitiesByMainSearch",subSearch);
		
		return "SearchResult";
	}
	
	//首頁最下方單一查詢頁面導向
	@GetMapping("/OneSearchResult")
	public String OneSearchResult(Model model,@RequestParam(value="facilitiesTypeId",required=false) Integer facilitiesTypeId){
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		model.addAttribute("facilitiesAll",facilitiesRepository.findAll());
		
		if(facilitiesTypeId == null) {
			List<Facilities> oneSearch = new ArrayList<Facilities>();
			oneSearch = facilitiesRepository.findAll();
			model.addAttribute("facilitiesByMainSearch",oneSearch);
		}else if(facilitiesTypeId != null){
			FacilitiesType facilitiesType = facilitiesTypeRepository.getById(facilitiesTypeId);
			Set<Facilities> oneSearch = facilitiesType.getFacilities();
			model.addAttribute("facilitiesByMainSearch",oneSearch);
		}
		return "SearchResult";
	}
	
	@GetMapping("/oneSpacePage")
	public String spacePage(Model model,@RequestParam(value="facilitiesId",required=false)Integer facilitiesId) {
		model.addAttribute("facilities",facilitiesRepository.getById(facilitiesId));
		List<Integer> facilitiesOpeningId = facilitiesRepository.listFacilitiesOpeningIdByFacilitiesId(facilitiesId);
		model.addAttribute("facilitiesOpeningDays",facilitiesOpeningId);
		return "spacePage";
	}
	
	@PostMapping("/orderPage")
	public String orderPage(
			HttpSession session,Model model,
			@ModelAttribute Orders orders,
			@RequestParam(value="facilities",required=false) Integer id,
			@RequestParam(value="ordersDate",required=false) String date,
			@RequestParam(value="periodExpense",required=false) Integer periodExpense)
	throws ParseException {
		//傳遞類型select表單
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		Member member = (Member)session.getAttribute("loginData");
		//傳遞會員資料
		model.addAttribute("member",member);
		//將字串轉成日期格式
		Date date1=new SimpleDateFormat("yyyy-MM-dd").parse(date);
		orders.setDate(date1);
		Facilities facilities = facilitiesRepository.getById(id);
		orders.setFacilities(facilities);
		//傳遞order物件資料
		model.addAttribute("orderData", orders);
		//傳遞時段所需費用
		model.addAttribute("periodExpense", periodExpense);
		
		return "OrderPage";
	}
	
	@PostMapping("/addOrders")
	public String addOrders(HttpSession session,Model model,
			@ModelAttribute Orders orders,
			@RequestParam(value="facilitiesId",required=false) Integer facilitiesId,
			@RequestParam(value="quantity",required=false) Integer quantity,
			@RequestParam(value="firstname",required=false) String firstname,
			@RequestParam(value="lastname",required=false) String lastname) throws UnsupportedEncodingException, MessagingException {
		Facilities facilities = facilitiesRepository.getById(facilitiesId);
		Member member = (Member)session.getAttribute("loginData");
		orders.setSpaceName(facilities.getName());
		orders.setGuests(quantity);
		orders.setContactName(firstname+lastname);
		orders.setCreateTime(new java.sql.Timestamp(new java.util.Date().getTime()));
		orders.setStatus(1); //0:取消訂單/退訂 1:處理中 2:已預訂 3:已結束
		orders.setMember(member);
		orders.setFacilities(facilities);
		
		frontEndService.saveOrders(orders);
		//傳遞order物件資料
		model.addAttribute("orders", orders);
		return "OrdersResult";
	}
	
}
