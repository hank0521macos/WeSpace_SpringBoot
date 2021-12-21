package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOpeningDetailRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOpeningRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesTypeRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.MemberRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesType;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;

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
	public String orderPage(HttpSession session,Model model) {
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		Member member = (Member)session.getAttribute("loginData");
		model.addAttribute("member",member);
		Orders orders = new Orders();
		
		session.setAttribute("orderData", orders); 
		
		return "OrderPage";
	}
	
}
