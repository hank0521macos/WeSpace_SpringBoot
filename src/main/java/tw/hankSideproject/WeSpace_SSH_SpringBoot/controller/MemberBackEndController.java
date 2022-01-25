package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.OrdersRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesImages;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesItems;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpening;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpeningDetail;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOwner;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesType;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.imageUpload.util.FileUtils;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.service.MemberBackEndService;

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
	
	@Autowired
	OrdersRepository ordersRepository;
	
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
		return "MySpace";
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
			 System.out.println(destFileName);
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
		return "MySpace";
	}
	
	//管理員新增API
	@PostMapping("/saveOwner")
	public String saveOwner(@ModelAttribute("facilitiesOwner") FacilitiesOwner facilitiesOwner, HttpSession session){
			Member member = (Member)session.getAttribute("loginData");
			if(member != null) {
			memberBackEndService.saveOwner(facilitiesOwner,member,ownerImageFileName);
			return "MySpace";
		}
		return "MySpace";
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
   public String multipleImageUpload(HttpServletRequest req,@RequestParam("uploadFiles") MultipartFile[] files){
        //循環保存文件
        for (MultipartFile file : files) {
            //判斷上傳文件格式
            String fileType = file.getContentType();
            if (fileType.equals("image/jpeg") || fileType.equals("image/png") || fileType.equals("image/jpeg")) {
                // 要上傳的目標文件存放路徑
            	// /Users/hank/Desktop/WeSpace_SSH_SpringBoot/WeSpace_SSH_SpringBoot/src/main/webapp/uploaded
                final String localPath=req.getServletContext().getRealPath("") + "uploaded";
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
        return "MySpace";
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
			HttpSession session,Model model) throws InterruptedException {
		Member member = (Member)session.getAttribute("loginData");
		model.addAttribute("facilitiesTypeAll",facilitiesTypeRepository.findAll());
		model.addAttribute("facilitiesItemsAll",facilitiesItemsRepository.findAll());
		model.addAttribute("facilitiesItemsCatgAll",facilitiesItemsCatgRepository.findAll());
		model.addAttribute("facilitiesOpeningAll",facilitiesOpeningRepository.findAll());
		model.addAttribute("facilitiesOwnerAll", member.getFacilitiesOwner());
		
		
		model.addAttribute("facilitiesRecord", facilities);
		model.addAttribute("facilitiesTypeRecord",facilitiesTypeId);
		model.addAttribute("facilitiesItemsRecord",facilitiesItemsId);
		model.addAttribute("facilitiesOpeningRecord",facilitiesOpeningId);
		
		
		if(facilitiesTypeId==null || facilities.getName()==null || facilities.getName().trim().length() == 0 || 
		   facilities.getAddress()==null || facilities.getAddress().trim().length() == 0 ||
		   facilities.getSize()==null || facilities.getSize() == 0 || 
		   facilities.getGuests()==null || facilities.getGuests() == 0) {
			//空間類型未填錯誤訊息
			if(facilitiesTypeId==null) {
				model.addAttribute("spaceTypeError","請至少選擇一種活動類型！");
			}
			//空間名稱不得為空
			if(facilities.getName()==null || facilities.getName().trim().length() == 0) {
				model.addAttribute("spaceNameError","請務必輸入空間名稱！");
			}
			//空間地址不得為空
			if(facilities.getAddress()==null || facilities.getAddress().trim().length() == 0) {
				model.addAttribute("spaceAddressError","請務必輸入空間地址！");
			}
			//空間大小不得為空
			if(facilities.getSize()==null || facilities.getSize() == 0) {
				model.addAttribute("spaceSizeError","請務必輸入空間坪數大小！");
			}
			//空間容納人數不得為空
			if(facilities.getGuests()==null || facilities.getGuests() == 0) {
				model.addAttribute("spaceGuestsError","請務必輸入可容納人數！");
			}
			//空間開放日不得為空
			if(facilitiesOpeningId==null) {
				model.addAttribute("spaceOpeningError","請至少選取一個開放日！");
			}
			return "addSpace";
		}else if(member != null) {	
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
	
	//訂單管理頁面導向
	@GetMapping("/myOrders")
	public String myOrders(Model model,HttpSession session){
		Member member = (Member)session.getAttribute("loginData");
		List<Orders> orders = ordersRepository.listPendingOrdersByMemberId(member.getId());
		model.addAttribute("orders",orders);
		return "MyOrders";
	}

	//已預訂訂單頁面導向
	@GetMapping("/myOrdersAccept")
	public String myOrdersAccept(Model model,HttpSession session){
		Member member = (Member)session.getAttribute("loginData");
		List<Orders> orders = ordersRepository.listAcceptOrdersByMemberId(member.getId());
		model.addAttribute("orders",orders);
		return "MyOrdersAccept";
	}	
	
	//取消訂單頁面導向
	@GetMapping("/myOrdersCancel")
	public String myOrdersCancel(Model model,HttpSession session){
		Member member = (Member)session.getAttribute("loginData");
		List<Orders> orders = ordersRepository.listRejectOrdersByMemberId(member.getId());
		model.addAttribute("orders",orders);
		return "MyOrdersCancel";
	}
	
	//完成訂單頁面導向
	@GetMapping("/myOrdersFinish")
	public String myOrdersFinish(Model model,HttpSession session){
		Member member = (Member)session.getAttribute("loginData");
		List<Orders> orders = ordersRepository.listRefuseOrFinishOrCancelOrdersByMemberId(member.getId());
		model.addAttribute("orders",orders);
		return "MyOrdersFinish";
	}
	
	//退訂按鈕
	@GetMapping("/cancelOrders")
	public String cancelOrders(Model model,HttpSession session,@RequestParam(value="ordersId",required=false) Integer ordersId) {
		Orders orders = ordersRepository.getById(ordersId);
		orders.setStatus(0);
		ordersRepository.save(orders);
		Member member = (Member)session.getAttribute("loginData");
		List<Orders> orders2 = ordersRepository.listPendingOrdersByMemberId(member.getId());
		model.addAttribute("orders",orders2);
		return "MyOrders";
	}
	
	//取消退訂按鈕
	@GetMapping("/reCancelOrders")
	public String reCancelOrders(Model model,HttpSession session,@RequestParam(value="ordersId",required=false) Integer ordersId) {
		Orders orders = ordersRepository.getById(ordersId);
		orders.setStatus(1);
		ordersRepository.save(orders);
		Member member = (Member)session.getAttribute("loginData");
		List<Orders> orders2 = ordersRepository.listRejectOrdersByMemberId(member.getId());
		model.addAttribute("orders",orders2);
		return "MyOrdersCancel";
	}
	
	//我的場地-訂單明細頁面
	@GetMapping("/ordersDetail")
	public String ordersDetail(Model model,HttpSession session) {
		Member member = (Member)session.getAttribute("loginData");
		List<Orders> orders = ordersRepository.listOrdersByLoginMemberId(member.getId());
		model.addAttribute("orders",orders);
		model.addAttribute("allCounts",ordersRepository.allOrdersCounts(member.getId()));
		model.addAttribute("status1Counts",ordersRepository.allOrdersCountsByStatus1(member.getId()));
		return "OrdersDetail";
	}
	
	//我的場地-訂單明細2頁面
	@GetMapping("/ordersDetailInfo")
	public String ordersDetailInfo(Model model,HttpSession session) {
		return "OrdersDetail2";
	}

}
