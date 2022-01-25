package tw.hankSideproject.WeSpace_SSH_SpringBoot.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.FacilitiesImages;

public interface FacilitiesImagesRepository extends JpaRepository<FacilitiesImages, Integer>{
	
	@Transactional
	@Modifying
	@Query(value="delete from facilities_images where facilities_id=?1",nativeQuery = true)
	public void deleteFacilitiesImages(int id);
	
	@Transactional
	@Modifying
	@Query(value="delete from facilities_images where facilities_images_name=?1",nativeQuery = true)
	public void deleteFacilitiesImagesByName(String name);

	@Transactional
	@Query(value="select * from facilities_images where facilities_id=?1",nativeQuery = true)
	public List<FacilitiesImages> getFacilitiesImagesByFacilitiesId(int id);
	
	@Transactional
	@Query(value="select * from facilities_images where facilities_images_name=?1",nativeQuery = true)
	public FacilitiesImages getFacilitiesImagesByName(String name);
}
