package tw.hankSideproject.WeSpace_SSH_SpringBoot.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesImagesRepository;
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

@Service
@Transactional
public class MemberBackEndService {
	
	@Autowired
	private FacilitiesRepository facilitiesRepository;

	@Autowired
	private FacilitiesTypeRepository facilitiesTypeRepository;

	@Autowired
	private FacilitiesItemsRepository facilitiesItemsRepository;
	
	@Autowired
	private FacilitiesOpeningRepository facilitiesOpeningRepository;
	
	@Autowired
	private FacilitiesOpeningDetailRepository facilitiesOpeningDetailRepository;
	
	@Autowired
	private FacilitiesOwnerRepository facilitiesOwnerRepository;
	
	@Autowired
	private FacilitiesImagesRepository facilitiesImagesRepository;
	
	public FacilitiesOwner saveOwner(FacilitiesOwner facilitiesOwner,Member member,String ownerImageFileName){
			//存入memberBackEnd controller中所抓取的Session會員登入資料
			facilitiesOwner.setMember(member);
			facilitiesOwner.setImage(ownerImageFileName);
			//配置多表關係
			member.getFacilitiesOwner().add(facilitiesOwner);			
			return facilitiesOwnerRepository.save(facilitiesOwner);
	}
		
	public List<FacilitiesOwner> listAllFacilitiesOwner() {
        return facilitiesOwnerRepository.findAll();
    }
    
	//空間新增
	public void saveFacilities(
			List<String> facilitiesTypeId,
			List<String> facilitiesItemsId,
			List<String> facilitiesOpeningId,
			List<String> startTime,
			List<String> closeTime,
			List<Double> expense,
			Facilities facilities,
			Member member,
			FacilitiesType facilitiesType,
			FacilitiesOpening facilitiesOpening,
			FacilitiesOpeningDetail facilitiesOpeningDetail) {
		//存入memberBackEnd controller中所抓取的Session會員登入資料
		facilities.setMember(member);
		//配置多表關係
		member.getFacilities().add(facilities);
		//存入初始化狀態為０：尚未認證通過
		facilities.setStatus(0);
		//判斷空間類型checkbox是否有被選擇
		if(facilitiesTypeId!=null) {
			//Value取得checkbox的值，另用jpa的getid方法得出facilities的類型依序加入set集合裏
			for(int i=0;i<facilitiesTypeId.size();i++) {
				facilities.getFacilitiesType().add(facilitiesTypeRepository.getById(Integer.parseInt(facilitiesTypeId.get(i))));
			}
		}
		//判斷空間設備checkbox是否有被選擇
		if(facilitiesItemsId!=null) {
			//Value取得checkbox的值，另用jpa的getid方法得出facilities的設施依序加入set集合裏
			for(int i=0;i<facilitiesItemsId.size();i++) {
				facilities.getFacilitiesItems().add(facilitiesItemsRepository.getById(Integer.parseInt(facilitiesItemsId.get(i))));
			}
		}
		
		//調用save方法，insert空間資料
		facilitiesRepository.save(facilities);
		
		//判斷空間開放時間checkbox是否有被選擇
		if(facilitiesOpeningId!=null) {
			List<Double> expenseList = new ArrayList<Double>();
			//Value取得checkbox的值，另用jpa的getid方法得出facilities的場地費用與明細依序加入set集合裏
			for(int i=0;i<facilitiesOpeningId.size();i++) {
				FacilitiesOpeningDetail facilitiesOpeningDetail2 = new FacilitiesOpeningDetail();
				//存入memberBackEnd controller中所抓取的新增空間店家資料
				facilitiesOpeningDetail2.setFacilities(facilities);
				//配置多表關係
				facilities.getFacilitiesOpeningDetail().add(facilitiesOpeningDetail2);
				//存入memberBackEnd controller中所抓取的新增空間店家資料
				facilitiesOpeningDetail2.setFacilitiesOpening(facilitiesOpeningRepository.getById(Integer.parseInt(facilitiesOpeningId.get(i))));
				//配置多表關係
				facilitiesOpening.getFacilitiesOpeningDetail().add(facilitiesOpeningDetailRepository.getById(Integer.parseInt(facilitiesOpeningId.get(i))));
				//存入memberBackEnd controller中所抓取的開放時間及費用細項資料
				facilitiesOpeningDetail2.setStartTime(startTime.get(i));
				facilitiesOpeningDetail2.setCloseTime(closeTime.get(i));
				if(expense.get(i)==null) {
					facilitiesOpeningDetail2.setExpense(0.0);
					//花費清單作為等等取出最低/高價格用
					expenseList.add(0.0);
					
				}else {
					facilitiesOpeningDetail2.setExpense(expense.get(i));
					//花費清單作為等等取出最低/高價格用
					expenseList.add(expense.get(i));
				}
				//調用save方法，insert場地開放時間及費用資料
				facilitiesOpeningDetailRepository.save(facilitiesOpeningDetail2);			
			}
			//存入最低價格為opening detail裡最低的價格
			facilities.setMinBudget(Collections.min(expenseList));
			//存入最高價格為opening detail裡最高的價格
			facilities.setMaxBudget(Collections.max(expenseList));
			
		}
	}
	
	//空間更新
	public void updateFacilities(
			List<String> facilitiesTypeId,
			List<String> facilitiesItemsId,
			List<String> facilitiesOpeningId,
			List<String> startTime,
			List<String> closeTime,
			List<Double> expense,
			FacilitiesOpening facilitiesOpening,
			Facilities facilities,
			Member member) {
		
		Facilities facilitiesToUpdate = facilitiesRepository.getById(facilities.getId());
		facilitiesToUpdate.setName(facilities.getName());
		facilitiesToUpdate.setRules(facilities.getRules());
		facilitiesToUpdate.setCancellationPolicy(facilities.getCancellationPolicy());
		facilitiesToUpdate.setCity(facilities.getCity());
		facilitiesToUpdate.setTown(facilities.getTown());
		facilitiesToUpdate.setAddress(facilities.getAddress());
		facilitiesToUpdate.setTakeByTrain(facilities.getTakeByTrain());
		facilitiesToUpdate.setTakeByBus(facilities.getTakeByBus());
		facilitiesToUpdate.setTakeByCar(facilities.getTakeByCar());
		facilitiesToUpdate.setSize(facilities.getSize());
		facilitiesToUpdate.setGuests(facilities.getGuests());
		facilitiesToUpdate.setStatus(0);
		facilitiesToUpdate.setFacilitiesOwner(facilities.getFacilitiesOwner());
		facilitiesToUpdate.setMember(member);
		//配置多表關係
		member.getFacilities().add(facilitiesToUpdate);
		//判斷空間類型checkbox是否有被選擇
		if(facilitiesTypeId!=null) {
			facilitiesToUpdate.getFacilitiesType().clear();
			//Value取得checkbox的值，另用jpa的getid方法得出facilities的類型依序加入set集合裏
			for(int i=0;i<facilitiesTypeId.size();i++) {
				facilitiesToUpdate.getFacilitiesType().add(facilitiesTypeRepository.getById(Integer.parseInt(facilitiesTypeId.get(i))));
			}
		}else {
			facilitiesToUpdate.getFacilitiesType().clear();
		}
		//判斷空間設備checkbox是否有被選擇
		if(facilitiesItemsId!=null) {
			facilitiesToUpdate.getFacilitiesItems().clear();
			//Value取得checkbox的值，另用jpa的getid方法得出facilities的設施依序加入set集合裏
			for(int i=0;i<facilitiesItemsId.size();i++) {
				facilitiesToUpdate.getFacilitiesItems().add(facilitiesItemsRepository.getById(Integer.parseInt(facilitiesItemsId.get(i))));
			}
		}else {
			facilitiesToUpdate.getFacilitiesItems().clear();
		}
		
		//判斷空間開放時間checkbox是否有被選擇
		if(facilitiesOpeningId!=null) {
			facilitiesOpeningDetailRepository.deleteFacilitiesOpeningDetail(facilities.getId());
			List<Double> expenseList = new ArrayList<Double>();
			//Value取得checkbox的值，另用jpa的getid方法得出facilities的場地費用與明細依序加入set集合裏
			for(int i=0;i<facilitiesOpeningId.size();i++) {
				FacilitiesOpeningDetail facilitiesOpeningDetail2 = new FacilitiesOpeningDetail();
				//存入memberBackEnd controller中所抓取的新增空間店家資料
				facilitiesOpeningDetail2.setFacilities(facilitiesToUpdate);
				//配置多表關係
				facilitiesToUpdate.getFacilitiesOpeningDetail().add(facilitiesOpeningDetail2);
				//存入memberBackEnd controller中所抓取的新增空間店家資料
				facilitiesOpeningDetail2.setFacilitiesOpening(facilitiesOpeningRepository.getById(Integer.parseInt(facilitiesOpeningId.get(i))));
				//配置多表關係
				facilitiesOpening.getFacilitiesOpeningDetail().add(facilitiesOpeningDetailRepository.getById(Integer.parseInt(facilitiesOpeningId.get(i))));
				//存入memberBackEnd controller中所抓取的開放時間及費用細項資料
				facilitiesOpeningDetail2.setStartTime(startTime.get(i));
				facilitiesOpeningDetail2.setCloseTime(closeTime.get(i));
				if(expense.get(i)==null) {
					facilitiesOpeningDetail2.setExpense(0.0);
					//花費清單作為等等取出最低/高價格用
					expenseList.add(0.0);
				}else {
					facilitiesOpeningDetail2.setExpense(expense.get(i));
					//花費清單作為等等取出最低/高價格用
					expenseList.add(expense.get(i));
				}
				//調用save方法，insert場地開放時間及費用資料
				facilitiesOpeningDetailRepository.save(facilitiesOpeningDetail2);			
			}
			//存入最低價格為opening detail裡最低的價格
			facilitiesToUpdate.setMinBudget(Collections.min(expenseList));
			//存入最高價格為opening detail裡最高的價格
			facilitiesToUpdate.setMaxBudget(Collections.max(expenseList));
		}
		
		//調用save方法，insert空間資料
		facilitiesRepository.save(facilitiesToUpdate);
		
	}
	
	//空間刪除
	public void deleteFacilities(Integer id, Member member) {
		//取出要被刪除的facilities實體
		Facilities facilities = facilitiesRepository.getById(id);
		//找出關聯facilities的owner實體
		FacilitiesOwner facilitiesOwner = facilities.getFacilitiesOwner();
		//會員移除facilities關聯
		if(member!=null) {
			member.getFacilities().remove(facilities);
		}
		//owner移除facilities關聯
		if(facilitiesOwner!=null) {
			facilitiesOwner.getFacilities().remove(facilities);
		}
		//刪除與faiclities關聯的圖片
		Set<FacilitiesImages> facilitiesImages = facilities.getFacilitiesImages();
    	if(facilitiesImages!=null) {
	    	for (FacilitiesImages n : facilitiesImages) {
				facilitiesImagesRepository.deleteFacilitiesImages(id);
			}
    	}
    	//刪除與faiclities關聯的營業時間明細-多對多(兩者均需被刪除)
		Set<FacilitiesOpeningDetail> facilitiesOpeningDetail = facilities.getFacilitiesOpeningDetail();
		
    	if(facilitiesOpeningDetail !=null) {
	    	for (FacilitiesOpeningDetail  n : facilitiesOpeningDetail ) {
	    		facilitiesOpeningDetailRepository.deleteFacilitiesOpeningDetail(id);
			}
    	}
    	//刪除與faiclities關聯的類型明細-多對多(兩者均需被刪除)
    	Set<FacilitiesType> facilitiesType = facilities.getFacilitiesType();
    	if(facilitiesType !=null) {
	    	for (FacilitiesType  n : facilitiesType) {
	    		facilitiesRepository.deleteFacilitiesTypeDetail(id);
			}
    	}
    	//刪除與faiclities關聯的類型明細-多對多(兩者均需被刪除)
    	Set<FacilitiesItems> facilitiesItems = facilities.getFacilitiesItems();
    	if(facilitiesItems !=null) {
	    	for (FacilitiesItems  n : facilitiesItems) {
	    		facilitiesRepository.deleteFacilitiesItemsDetail(id);
			}
    	}
		
		facilitiesRepository.deleteFacilities(id);;
	}
	
	//空間圖片新增
	public void saveFacilitiesImage(List<String> facilitiesImageName,Facilities facilities) {
		
		if(facilitiesImageName != null) {
			for(int i=0;i<facilitiesImageName.size();i++) {
				
				FacilitiesImages facilitiesImages2 = new FacilitiesImages();
				//存入memberBackEnd controller中所抓取的新增空間店家資料
				facilitiesImages2.setFacilities(facilities);
				//配置多表關係
				facilities.getFacilitiesImages().add(facilitiesImages2);
				//存入memberBackEnd controller中所抓取的開放時間及費用細項資料
				facilitiesImages2.setName(facilitiesImageName.get(i));
				
				//調用save方法，insert場地圖片
				facilitiesImagesRepository.save(facilitiesImages2);			
				
			}
		}
	}
	
	//空間圖片更新
	public void updateFacilitiesImage(List<String> facilitiesImageName,Facilities facilities) {
		//找出被編輯的空間圖片實體
		Facilities facilitiesToUpdate = facilitiesRepository.getById(facilities.getId());
		
		if(facilitiesImageName.size()!=0) {
			//存入更新後圖片及建立與該空間關聯
			for(int i=0;i<facilitiesImageName.size();i++) {
				FacilitiesImages facilitiesImages2 = new FacilitiesImages();
				//存入關聯空間
				facilitiesImages2.setFacilities(facilitiesToUpdate);
				//配置與空間的表關係
				facilitiesToUpdate.getFacilitiesImages().add(facilitiesImages2);
				//存入圖片名
				facilitiesImages2.setName(facilitiesImageName.get(i));
				//調用save方法，insert場地圖片
				facilitiesImagesRepository.save(facilitiesImages2);			
			}
		}
	}
	
	
	public Facilities listOneFacilities(int id) {
		return facilitiesRepository.findById(id).get();
	}
	
	
}
