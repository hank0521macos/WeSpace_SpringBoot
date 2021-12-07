package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name = "facilities_type")
@EntityListeners(AuditingEntityListener.class)
public class FacilitiesType {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "facilities_type_id")
	private Integer facilitiesTypeId;
	
	@Column(name = "facilities_type_name")
	private String name;
	
	@ManyToMany(mappedBy = "facilitiesType",cascade = CascadeType.ALL)
	private Set<Facilities> facilities = new HashSet<Facilities>();

	public Integer getfacilitiesTypeId() {
		return facilitiesTypeId;
	}

	public void setfacilitiesTypeId(Integer facilitiesTypeId) {
		this.facilitiesTypeId = facilitiesTypeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<Facilities> getFacilities() {
		return facilities;
	}

	public void setFacilities(Set<Facilities> facilities) {
		this.facilities = facilities;
	}

}
