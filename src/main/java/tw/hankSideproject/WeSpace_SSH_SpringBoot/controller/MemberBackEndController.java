package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesImagesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesItemsCatgRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesItemsRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOpeningDetailRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOpeningRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOwnerRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesTypeRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesImages;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesItems;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpening;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpeningDetail;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOwner;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesType;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.service.MemberBackEndService;
import tw.hankSideproject.WeSpcae_SSH_imageUpload.util.FileUtils;

@Controller
public class MemberBackEndController {
	
	@Autowired
	MemberBackEndService memberBackEndService;
	
	@Autowired
	FacilitiesRepository facilitiesRepository;
	
	@Autowired
	FacilitiesTypeRepository facilitiesTypeRepository;
	
	@Autowired
	FacilitiesItemsRepository facilitiesItemsRepository;
	
	@Autowired
	FacilitiesItemsCatgRepository facilitiesItemsCatgRepository;
	
	@Autowired
	FacilitiesOpeningRepository facilitiesOpeningRepository;
	
	@Autowired
	FacilitiesOpeningDetailRepository facilitiesOpeningDetasilRepository;
	
	@Autowired
	FacilitiesImagesRepository facilitiesImagesRepository;
	
	@Autowired
	FacilitiesOwnerRepository facilitiesOwnerRepository;
	
	//ownerSave裡ownerImage的fileName
	static String ownerImageFileName;
	
	//facilitiesImagesSave裡facilitiesImage的fileName
	List<String> filenameList = new ArrayList<String>();
	
	
	//場地管理頁面導向
	@GetMapping("/mySpace")
	public String mySpace(Model model,HttpSession session){
		Member member = (Member)session.getAttribute("loginData");
		List<Facilities> facilities = facilitiesRepository.listFacilitiesByMemberId(member.getId());
		model.addAttribute("facilities", facilities);
		return "FacilitiesMySpace";
	}
	
	//新增管理員照片API(Ajax)
	@PostMapping("/uploadOwnerImg")
	public String uploadOwnerImg(HttpServletRequest req,@RequestParam("file") MultipartFile file,Model m) 
	{		//1. 接受上傳的檔案 @RequestParam("file") MultipartFile file
		try {
			//2.根據時間戳建立新的檔名，這樣即便是第二次上傳相同名稱的檔案，也不會把第一次的檔案覆蓋了
			 ownerImageFileName = System.currentTimeMillis() + file.getOriginalFilename();
			//3.通過req.getServletContext().getRealPath("") 獲取當前專案的真實路徑，然後拼接前面的檔名
			 String destFileName = req.getServletContext().getRealPath("") + "uploaded" +File.separator + ownerImageFileName;
			//4.第一次執行的時候，這個檔案所在的目錄往往是不存在的，這裡需要建立一下目錄（建立到了webapp下uploaded資料夾下
			 File destFile = new File(destFileName);
			 destFile.getParentFile().mkdirs();
			//5.把瀏覽器上傳的檔案複製到希望的位置
			 file.transferTo(destFile);
			//6.把檔名放在model裡，以便後續顯示用
			 m.addAttribute("ownerImageFileName",ownerImageFileName);
		} catch (FileNotFoundException e) {
			 e.printStackTrace();
			 return "上傳失敗," + e.getMessage();
		} catch (IOException e) {
			e.printStackTrace();
			return "上傳失敗," + e.getMessage();
		}	
		return "FacilitiesMySpace";
	}
	
	//管理員新增API
	@PostMapping("/saveOwner")
	public String saveOwner(@ModelAttribute("facilitiesOwner") FacilitiesOwner facilitiesOwner, HttpSession session){
			Member member = (Member)session.getAttribute("loginData");
			if(member != null) {
			memberBackEndService.saveOwner(facilitiesOwner,member,ownerImageFileName);
			return "FacilitiesMySpace";
		}
		return "FacilitiesMySpace";
	}
		
	//場地管理頁面導向
	@GetMapping("/spacePage")
	public String spacePage(Model model,HttpSession session){
		Member member = (Member)session.getAttribute("loginData");
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		model.addAttribute("facilitiesItemsAll",facilitiesItemsRepository.findAll());
		model.addAttribute("facilitiesItemsCatgAll",facilitiesItemsCatgRepository.findAll());
		model.addAttribute("facilitiesOpeningAll",facilitiesOpeningRepository.findAll());
		model.addAttribute("facilitiesOwnerAll", member.getFacilitiesOwner());
		return "addSpace";
	}
	
   //場地圖片上傳API
   @RequestMapping("/multipleImageUpload")
   public String multipleImageUpload(@RequestParam("uploadFiles") MultipartFile[] files){
        //循環保存文件
        for (MultipartFile file : files) {
            //判斷上傳文件格式
            String fileType = file.getContentType();
            if (fileType.equals("image/jpeg") || fileType.equals("image/png") || fileType.equals("image/jpeg")) {
                // 要上傳的目標文件存放路徑
            	// /Users/hank/Desktop/WeSpace_SSH_SpringBoot/WeSpace_SSH_SpringBoot/src/main/webapp/uploaded
                final String localPath="/Users/hank/Desktop/WeSpace_SSH_SpringBoot/WeSpace_SSH_SpringBoot/src/main/webapp/uploaded";
                //上傳後保存的文件名(需要防止圖片重名導致的文件覆蓋)
                //獲取文件名
                String fileName = file.getOriginalFilename();
                fileName = System.currentTimeMillis() + file.getOriginalFilename();
                if (FileUtils.upload(file, localPath, fileName)) {
                	//加入存入資料庫的圖片名給新增取值用
                    filenameList.add(fileName);
                }
            }
        }
        return "FacilitiesMySpace";
    }
		
	
	//新增Space成功導向
	@PostMapping("/addSpace") 
	public String addSpace(
			@RequestParam(value="facilitiesTypeId",required=false) List<String> facilitiesTypeId,
			@RequestParam(value="facilitiesItemsId",required=false) List<String> facilitiesItemsId,
			@RequestParam(value="facilitiesOpeningId",required=false) List<String> facilitiesOpeningId,
			@RequestParam(value="startTime",required=false) List<String> startTime,
			@RequestParam(value="closeTime",required=false) List<String> closeTime,
			@RequestParam(value="expense",required=false) List<Double> expense,
			@ModelAttribute Facilities facilities,
			@ModelAttribute FacilitiesType facilitiesType,
			@ModelAttribute FacilitiesOpening facilitiesOpening,
			@ModelAttribute FacilitiesOpeningDetail facilitiesOpeningDetail,
			BindingResult bindingResult, 
			HttpServletRequest request, 
			HttpSession session) throws InterruptedException {
		//讓新增晚一秒執行,避免ajax新增時造成取參數問題
		Thread.sleep(1000);
		Member member = (Member)session.getAttribute("loginData");
		if(member != null) {	
			//確認錯誤後調用service方法新增空間資料
			memberBackEndService.saveFacilities(facilitiesTypeId,facilitiesItemsId,facilitiesOpeningId,startTime,
					closeTime,expense,facilities,member,facilitiesType,facilitiesOpening,facilitiesOpeningDetail);
			//調用service存圖片的方法
			memberBackEndService.saveFacilitiesImage(filenameList,facilities);
			//清空List中留存的圖片名
			filenameList.clear();
			return "redirect:/mySpace";
		}
		return "redirect:/";
	}
	
	@GetMapping("/deleteSpace") 
	public String deleteSpace(@RequestParam("id") Integer id,HttpSession session){
		//找出登入者會員實體
		Member member = (Member)session.getAttribute("loginData");
    	//執行service的facilities刪除
		memberBackEndService.deleteFacilities(id,member);
		//刷新頁面
		return "redirect:/mySpace";
	}
	
	static Integer facilitiesIdForImages;
	
	@GetMapping("/listOneSpace") 
	public String listOneSpace(@RequestParam("id") Integer id,HttpSession session,Model model){
		//找出登入者會員實體
		Member member = (Member)session.getAttribute("loginData");
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		model.addAttribute("facilitiesItemsAll",facilitiesItemsRepository.findAll());
		model.addAttribute("facilitiesItemsCatgAll",facilitiesItemsCatgRepository.findAll());
		model.addAttribute("facilitiesOpeningAll",facilitiesOpeningRepository.findAll());
		model.addAttribute("facilitiesOwnerAll", member.getFacilitiesOwner());
		facilitiesIdForImages = id;
    	//取出指定id的facilities物件
		Facilities facilities = memberBackEndService.listOneFacilities(id);
		//設置參數將值傳給前端頁面
		model.addAttribute("facilitiesRecord",facilities);
		
		//取出指定id的facilities物件中關聯的facilitiesType物件
		Set<FacilitiesType> facilitiesType = facilities.getFacilitiesType();
		List<Integer> facilitiesTypeList = new ArrayList<Integer>();
		for(FacilitiesType t:facilitiesType ) {
			facilitiesTypeList.add(t.getfacilitiesTypeId());
		}
		//設置空間類型參數將值傳給前端頁面
		model.addAttribute("facilitiesTypeRecord",facilitiesTypeList);
		
		//取出指定id的facilities物件中關聯的facilitiesItems物件
		Set<FacilitiesItems> facilitiesItems = facilities.getFacilitiesItems();
		List<Integer> facilitiesItemsList = new ArrayList<Integer>();
		for(FacilitiesItems t:facilitiesItems ) {
			facilitiesItemsList.add(t.getId());
		}
		//設置空間設施參數將值傳給前端頁面
		model.addAttribute("facilitiesItemsRecord",facilitiesItemsList);
		
		//取出指定id的facilities物件中關聯的facilitiesItems物件
		Set<FacilitiesOpeningDetail> facilitiesOpeningDetail = facilities.getFacilitiesOpeningDetail();
		List<Integer> facilitiesOpeningDetailList = new ArrayList<Integer>();
		for(FacilitiesOpeningDetail  t:facilitiesOpeningDetail  ) {
			facilitiesOpeningDetailList.add(t.getFacilitiesOpening().getFacilitiesOpeningId());
		}
		//設置空間開放時間參數將值傳給前端頁面
		model.addAttribute("facilitiesOpeningRecord",facilitiesOpeningDetailList);
		
		//取出指定id的facilities物件中關聯的facilitiesImages物件
		Set<FacilitiesImages> facilitiesImages = facilities.getFacilitiesImages();
		//設置空間圖片參數將值傳給前端頁面
		model.addAttribute("facilitiesImagesRecord",facilitiesImages);
		
		//刷新頁面
		return "updateSpace";
	}
	
	//新增Space成功導向
	@PostMapping("/updateSpace") 
	public String updateSpace(
			@RequestParam(value="facilitiesTypeId",required=false) List<String> facilitiesTypeId,
			@RequestParam(value="facilitiesItemsId",required=false) List<String> facilitiesItemsId,
			@RequestParam(value="facilitiesOpeningId",required=false) List<String> facilitiesOpeningId,
			@RequestParam(value="startTime",required=false) List<String> startTime,
			@RequestParam(value="closeTime",required=false) List<String> closeTime,
			@RequestParam(value="expense",required=false) List<Double> expense,
			@ModelAttribute Facilities facilities,
			@ModelAttribute FacilitiesType facilitiesType,
			@ModelAttribute FacilitiesOpening facilitiesOpening,
			@ModelAttribute FacilitiesOpeningDetail facilitiesOpeningDetail,
			HttpServletRequest request,
			HttpSession session) throws InterruptedException {
		//讓更新晚一秒執行,避免ajax新增時造成取參數問題
		Thread.sleep(1000);
		Member member = (Member)session.getAttribute("loginData");
    	//執行service的facilities更新
		memberBackEndService.updateFacilities(facilitiesTypeId,facilitiesItemsId,facilitiesOpeningId,
				startTime,closeTime,expense,facilitiesOpening,facilities,member);
		//調用service存圖片的方法
		memberBackEndService.updateFacilitiesImage(filenameList,facilities);
		//清空static List中留存的圖片名
		filenameList.clear();
	
		return "redirect:/mySpace";
	}
	
	
	

}
