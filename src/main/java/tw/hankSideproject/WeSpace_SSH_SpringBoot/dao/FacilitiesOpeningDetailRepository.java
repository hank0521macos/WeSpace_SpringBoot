package tw.hankSideproject.WeSpace_SSH_SpringBoot.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Facilities;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpening;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOpeningDetail;

public interface FacilitiesOpeningDetailRepository extends JpaRepository<FacilitiesOpeningDetail,Integer >{

	
	@Transactional
	@Modifying
	@Query(value="delete from facilities_opening_detail where facilities_id=?1",nativeQuery = true)
	void deleteFacilitiesOpeningDetail(int id);
	
	@JsonIgnore
	@JsonManagedReference
	@Query(value="select * from facilities_opening_detail where facilities_id=?1 and facilities_opening_id=?2",nativeQuery = true)
	FacilitiesOpeningDetail findByFacilitiesAndFacilitiesOpening(Integer facilitiesId,Integer facilitiesOpeningId);
}
