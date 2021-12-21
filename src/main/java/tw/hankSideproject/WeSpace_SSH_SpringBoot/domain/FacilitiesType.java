package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

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
	
	@JsonIgnore
	@JsonManagedReference
	@OneToMany(cascade=CascadeType.ALL,mappedBy="facilitiesType")
	private List<Orders> order = new ArrayList<Orders>();

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

	public List<Orders> getOrder() {
		return order;
	}

	public void setOrder(List<Orders> order) {
		this.order = order;
	}
	
	

}
