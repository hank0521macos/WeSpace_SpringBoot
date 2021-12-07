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
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "facilities")
@EntityListeners(AuditingEntityListener.class)
public class Facilities {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "facilities_id")
	private Integer id;
	
	@Column(name = "facilities_name")
	private String name;
	
	@Column(name = "facilities_rules")
	private String rules;
	
	@Column(name = "facilities_cancellation_policy")
	private String cancellationPolicy;
	
	@Column(name = "facilities_city")
	private String city;
	
	@Column(name = "facilities_town")
	private String town;
	
	@Column(name = "facilities_address")
	private String address;
	
	@Column(name = "facilities_bytrain")
	private String takeByTrain;
	
	@Column(name = "facilities_bybus")
	private String takeByBus;
	
	@Column(name = "facilities_bycar")
	private String takeByCar;
	
	@Column(name = "facilities_size")
	private Integer size;
	
	@Column(name = "facilities_guests")
	private Integer guests;
	
	@Column(name = "facilities_status")
	private Integer status;
	
	@Column(name = "facilities_min_budget")
	private Double minBudget;
	
	@Column(name = "facilities_max_budget")
	private Double maxBudget;
	
	@ManyToOne(targetEntity=FacilitiesOwner.class)
	@JoinColumn(name = "facilities_owner_id",referencedColumnName="facilities_owner_id")
	private FacilitiesOwner facilitiesOwner;
	
	@ManyToOne(targetEntity=Member.class)
	@JoinColumn(name = "member_id",referencedColumnName="member_id")
	private Member member;
	
	@JsonIgnore
	@JsonManagedReference
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="facilities")
	private Set<FacilitiesImages> facilitiesImages = new HashSet<FacilitiesImages>();
	
	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER, mappedBy="facilities")
	private Set<FacilitiesOpeningDetail> facilitiesOpeningDetail = new HashSet<FacilitiesOpeningDetail>();
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "facilities_type_detail",
			joinColumns = {@JoinColumn(name = "facilities_id",referencedColumnName = "facilities_id")},
			inverseJoinColumns = {@JoinColumn(name = "facilities_type_id",referencedColumnName = "facilities_type_id")}
	)  
	private Set<FacilitiesType> facilitiesType = new HashSet<FacilitiesType>();
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "facilities_items_detail",
			joinColumns = {@JoinColumn(name = "facilities_id",referencedColumnName = "facilities_id")},
			inverseJoinColumns = {@JoinColumn(name = "facilities_items_id",referencedColumnName = "facilities_items_id")}
	)  
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

	public String getRules() {
		return rules;
	}

	public void setRules(String rules) {
		this.rules = rules;
	}

	public String getCancellationPolicy() {
		return cancellationPolicy;
	}

	public void setCancellationPolicy(String cancellationPolicy) {
		this.cancellationPolicy = cancellationPolicy;
	}
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getTown() {
		return town;
	}

	public void setTown(String town) {
		this.town = town;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTakeByTrain() {
		return takeByTrain;
	}

	public void setTakeByTrain(String takeByTrain) {
		this.takeByTrain = takeByTrain;
	}

	public String getTakeByBus() {
		return takeByBus;
	}

	public void setTakeByBus(String takeByBus) {
		this.takeByBus = takeByBus;
	}

	public String getTakeByCar() {
		return takeByCar;
	}

	public void setTakeByCar(String takeByCar) {
		this.takeByCar = takeByCar;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public Integer getGuests() {
		return guests;
	}

	public void setGuests(Integer guests) {
		this.guests = guests;
	}
	
	public FacilitiesOwner getFacilitiesOwner() {
		return facilitiesOwner;
	}

	public void setFacilitiesOwner(FacilitiesOwner facilitiesOwner) {
		this.facilitiesOwner = facilitiesOwner;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Double getMinBudget() {
		return minBudget;
	}

	public void setMinBudget(Double minBudget) {
		this.minBudget = minBudget;
	}

	public Double getMaxBudget() {
		return maxBudget;
	}

	public void setMaxBudget(Double maxBudget) {
		this.maxBudget = maxBudget;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	public Set<FacilitiesImages> getFacilitiesImages() {
		return facilitiesImages;
	}

	public void setFacilitiesImages(Set<FacilitiesImages> facilitiesImages) {
		this.facilitiesImages = facilitiesImages;
	}

	public Set<FacilitiesOpeningDetail> getFacilitiesOpeningDetail() {
		return facilitiesOpeningDetail;
	}

	public void setFacilitiesOpeningDetail(Set<FacilitiesOpeningDetail> facilitiesOpeningDetail) {
		this.facilitiesOpeningDetail = facilitiesOpeningDetail;
	}

	public Set<FacilitiesType> getFacilitiesType() {
		return facilitiesType;
	}

	public void setFacilitiesType(Set<FacilitiesType> facilitiesType) {
		this.facilitiesType = facilitiesType;
	}

	public Set<FacilitiesItems> getFacilitiesItems() {
		return facilitiesItems;
	}

	public void setFacilitiesItems(Set<FacilitiesItems> facilitiesItems) {
		this.facilitiesItems = facilitiesItems;
	}
	
}
