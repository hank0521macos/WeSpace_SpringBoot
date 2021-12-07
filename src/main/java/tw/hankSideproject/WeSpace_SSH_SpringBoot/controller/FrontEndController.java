package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesTypeRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesType;

@Controller
public class FrontEndController {
	
	@Autowired
	FacilitiesRepository facilitiesRepository;
	
	@Autowired
	FacilitiesTypeRepository facilitiesTypeRepository;
	
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
	
	//搜尋頁面導向
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
		System.out.println("查詢條件："+facilitiesTypeId+facilitiesCity+facilitiesGuestsMin+facilitiesGuestsMax);
		List<Facilities> mainSearch = facilitiesRepository.findFacilitiessByMainSearch(facilitiesTypeId, facilitiesCity, facilitiesGuestsMin, facilitiesGuestsMax);
		model.addAttribute("facilitiesByMainSearch",mainSearch);
		return "SearchResult";
	}

}
