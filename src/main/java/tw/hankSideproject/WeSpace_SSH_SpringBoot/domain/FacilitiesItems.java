package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "facilities_items")
@EntityListeners(AuditingEntityListener.class)
public class FacilitiesItems {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "facilities_items_id")
	private Integer id;
	
	@Column(name = "facilities_items_name")
	private String name;
	
	@ManyToOne(targetEntity=FacilitiesItemsCatg.class)
	@JsonBackReference
	@JoinColumn(name = "facilities_items_catg_id",referencedColumnName="facilities_items_catg_id")
	private FacilitiesItemsCatg facilitiesItemsCatg;

	@JsonBackReference
	@ManyToMany(mappedBy = "facilitiesItems")
	private Set<Facilities> facilities = new HashSet<Facilities>();
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public FacilitiesItemsCatg getFacilitiesItemsCatg() {
		return facilitiesItemsCatg;
	}

	public void setFacilitiesItemsCatg(FacilitiesItemsCatg facilitiesItemsCatg) {
		this.facilitiesItemsCatg = facilitiesItemsCatg;
	}

	public Set<Facilities> getFacilities() {
		return facilities;
	}

	public void setFacilities(Set<Facilities> facilities) {
		this.facilities = facilities;
	}
	

}
