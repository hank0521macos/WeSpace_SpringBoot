package tw.hankSideproject.WeSpace_SSH_SpringBoot.dao;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesImages;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpeningDetail;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOwner;

public interface FacilitiesRepository extends JpaRepository<Facilities, Integer> {
				
		Facilities findByFacilitiesOwner(FacilitiesOwner facilitiesOwner);
		
		@Transactional
		@Modifying
		@Query(value="delete from facilities where facilities_id=?1",nativeQuery = true)
		void deleteFacilities(int id);
		
		@Transactional
		@Modifying
		@Query(value="delete from facilities_type_detail where facilities_id=?1",nativeQuery = true)
		void deleteFacilitiesTypeDetail(int id);
		
		@Transactional
		@Modifying
		@Query(value="delete from facilities_items_detail where facilities_id=?1",nativeQuery = true)
		void deleteFacilitiesItemsDetail(int id);
		
		@Transactional
		@Modifying
		@Query(value="select * from facilities where member_id=?1",nativeQuery = true)
		public List<Facilities> listFacilitiesByMemberId(int id);
		
		
		@Transactional
		@Modifying
		@Query(value="select * from facilities where facilities_owner_id=?1",nativeQuery = true)
		public List<Facilities> listFacilitiesByFacilitiesOwnerId(int id);
		
		
		@Transactional
		@Modifying
		@Query(value="select * from facilities_images where facilities_id=?1",nativeQuery = true)
		public List<Map<String,FacilitiesImages>> listFacilitiesImagesByFacilitiesId(int id);
		
		@Transactional
		@Modifying
		@Query(value="select * from facilities_opening_detail where facilities_id=?1",nativeQuery = true)
		public List<FacilitiesOpeningDetail> listFacilitiesOpeningDetailByFacilitiesId(int id);
		
		@Query(value = "call mainSearch(:spaceType,:spaceCity,:spaceGuestsMin,:spaceGuestsMax);", nativeQuery = true)
		List<Facilities> findFacilitiessByMainSearch(
				@Param("spaceType") Integer facilitiesTypeId,
				@Param("spaceCity") String	facilitiesCity,
				@Param("spaceGuestsMin") Integer facilitiesGuestsMin,
				@Param("spaceGuestsMax") Integer facilitiesGuestsMax
		);
		
		@Query(value = "call subSearch(:spaceType,:spaceGuestsMin,:spaceGuestsMax,:spaceCity,:spaceMaxBudget,:spaceMinBudget,:spaceName,:spaceMinOpeningDay,:spaceMaxOpeningDay,:spacePeriod);", nativeQuery = true)
		List<Facilities> findFacilitiessBysubSearch(
				@Param("spaceType") Integer facilitiesTypeId,
				@Param("spaceGuestsMin") Integer facilitiesGuestsMin,
				@Param("spaceGuestsMax") Integer facilitiesGuestsMax,
				@Param("spaceCity") String	facilitiesCity,
				@Param("spaceMaxBudget") Integer facilitiesMaxBudget,
				@Param("spaceMinBudget") Integer facilitiesMinBudget,
				@Param("spaceName") String facilitiesName,
				@Param("spaceMinOpeningDay") Integer facilitiesMinOpeningDay,
				@Param("spaceMaxOpeningDay") Integer facilitiesMaxOpeningDay,
				@Param("spacePeriod") Integer facilitiesPeriod
				
		);
}
