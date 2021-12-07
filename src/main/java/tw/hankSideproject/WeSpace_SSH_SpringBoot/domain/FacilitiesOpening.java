package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "facilities_opening")
@EntityListeners(AuditingEntityListener.class)
public class FacilitiesOpening {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "facilities_opening_id")
	private Integer facilitiesOpeningId;
	
	@Column(name = "facilities_opening_name")
	private String name;
	
	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER, mappedBy="facilities")
	private Set<FacilitiesOpeningDetail> facilitiesOpeningDetail = new HashSet<FacilitiesOpeningDetail>();

	
	public Integer getFacilitiesOpeningId() {
		return facilitiesOpeningId;
	}

	public void setFacilitiesOpeningId(Integer facilitiesOpeningId) {
		this.facilitiesOpeningId = facilitiesOpeningId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<FacilitiesOpeningDetail> getFacilitiesOpeningDetail() {
		return facilitiesOpeningDetail;
	}

	public void setFacilitiesOpeningDetail(Set<FacilitiesOpeningDetail> facilitiesOpeningDetail) {
		this.facilitiesOpeningDetail = facilitiesOpeningDetail;
	}
	
}
