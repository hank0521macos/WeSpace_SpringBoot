package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.util.List;
import java.util.Set;

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

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesImagesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOpeningDetailRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOwnerRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.MemberRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesImages;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpeningDetail;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOwner;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.service.MemberBackEndService;

@CrossOrigin(maxAge = 3600)
@RestController
public class AjaxAPIController {
	
	@Autowired
	MemberBackEndService memberBackEndService;
	
	@Autowired
	FacilitiesOwnerRepository facilitiesOwnerRepository;
	
	@Autowired
	FacilitiesOpeningDetailRepository facilitiesOpeningDetailRepository;
	
	@Autowired
	FacilitiesImagesRepository facilitiesImagesRepository;
   
	@Autowired
	FacilitiesRepository facilitiesRepository;
	
	@Autowired
	MemberRepository memberRepository;
	
	//會員新增管理員select表單更新所用的API
	@CrossOrigin
	@GetMapping("/listOwners")
	public List<FacilitiesOwner> listOwners(HttpSession session) {
		   Member member = (Member)session.getAttribute("loginData");
		   return facilitiesOwnerRepository.listOwner(member.getId());
	}
	
	//會員select表單做選取時建立的管理員查詢API
	@CrossOrigin
    @GetMapping("/listOwners/{id}")
    public ResponseEntity<FacilitiesOwner> getOwnerById(@PathVariable(value = "id") Integer id) {
    	FacilitiesOwner facilitiesOwner = facilitiesOwnerRepository.findById(id).get();
        if(facilitiesOwner == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(facilitiesOwner);
    }
	
	//刪除管理員API
    @CrossOrigin
    @DeleteMapping("/deleteOwner/{id}")
    public ResponseEntity<FacilitiesOwner> deleteOwner(@PathVariable(value = "id") Integer id,HttpSession session) {
    	
    	FacilitiesOwner facilitiesOwner = facilitiesOwnerRepository.findById(id).get();
    	Member member = (Member)session.getAttribute("loginData");
    	
    	if(facilitiesOwner == null) {
            return ResponseEntity.notFound().build();
        }
    	
    	List<Facilities> facilities= facilitiesRepository.listFacilitiesByFacilitiesOwnerId(id);
    	for (Facilities n : facilities) {
			n.setFacilitiesOwner(null);
		}
    	
    	member.getFacilitiesOwner().remove(facilitiesOwner);
    	facilitiesOwnerRepository.deleteOwner(id);
        return ResponseEntity.ok().build();
    }
	
    //更新管理員API
    @CrossOrigin
    @PutMapping("/updateOwner/{id}")
    public ResponseEntity<FacilitiesOwner> updateOwner(@PathVariable(value = "id") Integer id,
    		@RequestBody FacilitiesOwner facilitiesOwner,HttpSession session) {
    	
    	FacilitiesOwner owners = facilitiesOwnerRepository.findById(id).get();
    	Member member = (Member)session.getAttribute("loginData");
    	String ownerImageFileName = MemberBackEndController.ownerImageFileName;
        if(owners == null) {
            return ResponseEntity.notFound().build();
        }
       
        owners.setName(facilitiesOwner.getName());
        owners.setImage(ownerImageFileName);
        owners.setDescription(facilitiesOwner.getDescription());
        owners.setContactName(facilitiesOwner.getContactName());
        owners.setContactPhone(facilitiesOwner.getContactPhone());
        owners.setContactMobilePhone(facilitiesOwner.getContactMobilePhone());
        owners.setInvoiceHeading(facilitiesOwner.getInvoiceHeading());
        owners.setTaxId(facilitiesOwner.getTaxId());
        owners.setPayeeBankName(facilitiesOwner.getPayeeBankName());
        owners.setPayeeBranchName(facilitiesOwner.getPayeeBranchName());
        owners.setAccount(facilitiesOwner.getAccount());
        owners.setPayeeName(facilitiesOwner.getPayeeName());
        owners.setMember(member);
        
        FacilitiesOwner updatedOwner = facilitiesOwnerRepository.save(owners);
        return ResponseEntity.ok(updatedOwner); 
    }
    
	//會員修改空間圖片div區塊更新所用的API
	@GetMapping("/listSpaceImages")
	public Set<FacilitiesImages> listSpaceImages() {
			Integer facilitiesIdForImages = MemberBackEndController.facilitiesIdForImages;
			Facilities facilities = facilitiesRepository.getById(facilitiesIdForImages);
			return facilities.getFacilitiesImages(); 
	}
    
	//刪除圖片API
    @CrossOrigin
    @DeleteMapping("/deleteSpaceImages/{id}")
    public ResponseEntity<FacilitiesImages> deleteSpaceImages(@PathVariable(value = "id") String id,HttpSession session) {
    	FacilitiesImages facilitiesImages = facilitiesImagesRepository.getById(Integer.parseInt(id));
    	if(facilitiesImages == null) {
            return ResponseEntity.notFound().build();
        }
    	facilitiesImagesRepository.deleteById(Integer.parseInt(id));
        return ResponseEntity.ok().build();
    }
    
	//消費者選擇日期時同時更動時間select表單查詢API
	@CrossOrigin
    @GetMapping("/listTime/{facilitiesId}&{facilitiesOpeningId}")
    public ResponseEntity<FacilitiesOpeningDetail> getFacilitiesOpeningDetailById(@PathVariable(value = "facilitiesId") Integer id1,@PathVariable(value = "facilitiesOpeningId") Integer id2) {
		FacilitiesOpeningDetail facilitiesOpeningDetail = facilitiesOpeningDetailRepository.findByFacilitiesAndFacilitiesOpening(id1, id2);
        
		if(facilitiesOpeningDetail == null) {
            return ResponseEntity.notFound().build();
        }
		System.out.println("開始營業時間"+facilitiesOpeningDetail.getStartTime());
        return ResponseEntity.ok().body(facilitiesOpeningDetail);
    }
	
}
