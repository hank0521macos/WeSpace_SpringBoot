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
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "facilities_items_catg")
@EntityListeners(AuditingEntityListener.class)
public class FacilitiesItemsCatg {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "facilities_items_catg_id")
	private Integer id;
	
	@Column(name = "facilities_items_catg_name")
	private String name;
	
	@JsonIgnore
	@JsonManagedReference
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER, mappedBy="facilitiesItemsCatg")
	private Set<FacilitiesItems> facilitiesItems = new HashSet<FacilitiesItems>();

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

	public Set<FacilitiesItems> getFacilitiesItems() {
		return facilitiesItems;
	}

	public void setFacilitiesItems(Set<FacilitiesItems> facilitiesItems) {
		this.facilitiesItems = facilitiesItems;
	}

	
	
	
}
