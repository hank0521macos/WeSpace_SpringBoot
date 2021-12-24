package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "facilities_opening_detail")
@EntityListeners(AuditingEntityListener.class)
public class FacilitiesOpeningDetail {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "facilities_opening_detail_id")
	private Integer id;
	
	@Column(name = "facilities_opening_start")
	private String startTime;
	
	@Column(name = "facilities_opening_close")
	private String closeTime;
	
	@Column(name = "facilities_opening_expense")
	private Double expense;
	
	@JsonIgnoreProperties
	@JsonBackReference
	@ManyToOne(targetEntity=Facilities.class)
	@JoinColumn(name = "facilities_id",referencedColumnName="facilities_id")
	private Facilities facilities;
	
	@JsonBackReference
	@ManyToOne(targetEntity=FacilitiesOpening.class)
	@JoinColumn(name = "facilities_opening_id",referencedColumnName="facilities_opening_id")
	private FacilitiesOpening facilitiesOpening;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public Double getExpense() {
		return expense;
	}

	public void setExpense(Double expense) {
		this.expense = expense;
	}

	public Facilities getFacilities() {
		return facilities;
	}

	public void setFacilities(Facilities facilities) {
		this.facilities = facilities;
	}

	public FacilitiesOpening getFacilitiesOpening() {
		return facilitiesOpening;
	}

	public void setFacilitiesOpening(FacilitiesOpening facilitiesOpening) {
		this.facilitiesOpening = facilitiesOpening;
	}

}
