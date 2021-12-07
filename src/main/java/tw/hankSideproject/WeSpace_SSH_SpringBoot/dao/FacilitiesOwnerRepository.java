package tw.hankSideproject.WeSpace_SSH_SpringBoot.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesOwner;

public interface FacilitiesOwnerRepository extends JpaRepository<FacilitiesOwner,Integer >{
		
		@Transactional
		@Modifying
		@Query(value="delete from facilities_owner where facilities_owner_id=?1",nativeQuery = true)
		void deleteOwner(int id);
		
		
		@Transactional
		@Modifying
		@Query(value="select * from facilities_owner where member_id=?1",nativeQuery = true)
		public List<FacilitiesOwner> listOwner(int id);
		

}
