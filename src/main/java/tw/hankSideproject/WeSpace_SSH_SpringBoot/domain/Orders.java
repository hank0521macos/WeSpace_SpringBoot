package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import java.util.Date;

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
@Table(name = "orders")
@EntityListeners(AuditingEntityListener.class)
public class Orders {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "orders_id")
	private Integer id;
	
	@Column(name = "orders_space_name")
	private String spaceName;
	
	@Column(name = "orders_date")
	private Date date;
	
	@Column(name = "orders_period_start")
	private Integer startTime;
	
	@Column(name = "orders_period_end")
	private Integer endTime;
	
	@Column(name = "orders_expense")
	private Double expense;
	
	@Column(name = "orders_guests")
	private Integer guests;
	
	@Column(name = "orders_note")
	private String note;
	
	@Column(name = "orders_contact_name")
	private String contactName;
	
	@Column(name = "orders_contact_mobile_phone")
	private String contactMobilePhone;
	
	@Column(name = "orders_contact_email")
	private String contactEmail;
	
	@Column(name = "orders_credit_card_no")
	private String creditCardNo;
	
	@Column(name = "orders_credit_card_month")
	private String creditCardMonth;
	
	@Column(name = "orders_credit_card_year")
	private String creditCardYear;
	
	@Column(name = "orders_credit_card_cvc")
	private String creditCardCvc;
	
	@Column(name = "orders_time")
	private Date createTime;
	
	@Column(name = "orders_status")
	private Integer status;
	
	@JsonIgnoreProperties
	@JsonBackReference
	@ManyToOne(targetEntity=Member.class)
	@JoinColumn(name = "member_id",referencedColumnName="member_id")
	private Member member;
	
	@JsonIgnoreProperties
	@JsonBackReference
	@ManyToOne(targetEntity=Facilities.class)
	@JoinColumn(name = "facilities_id",referencedColumnName="facilities_id")
	private Facilities facilities;
	
	@JsonIgnoreProperties
	@JsonBackReference
	@ManyToOne(targetEntity=FacilitiesType.class)
	@JoinColumn(name = "facilities_type_id",referencedColumnName="facilities_type_id")
	private FacilitiesType facilitiesType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSpaceName() {
		return spaceName;
	}

	public void setSpaceName(String spaceName) {
		this.spaceName = spaceName;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getStartTime() {
		return startTime;
	}

	public void setStartTime(Integer startTime) {
		this.startTime = startTime;
	}

	public Integer getEndTime() {
		return endTime;
	}

	public void setEndTime(Integer endTime) {
		this.endTime = endTime;
	}

	public Double getExpense() {
		return expense;
	}

	public void setExpense(Double expense) {
		this.expense = expense;
	}

	public Integer getGuests() {
		return guests;
	}

	public void setGuests(Integer guests) {
		this.guests = guests;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getContactMobilePhone() {
		return contactMobilePhone;
	}

	public void setContactMobilePhone(String contactMobilePhone) {
		this.contactMobilePhone = contactMobilePhone;
	}

	public String getContactEmail() {
		return contactEmail;
	}

	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}
	
	public String getCreditCardNo() {
		return creditCardNo;
	}

	public void setCreditCardNo(String creditCardNo) {
		this.creditCardNo = creditCardNo;
	}

	public String getCreditCardMonth() {
		return creditCardMonth;
	}

	public void setCreditCardMonth(String creditCardMonth) {
		this.creditCardMonth = creditCardMonth;
	}

	public String getCreditCardYear() {
		return creditCardYear;
	}

	public void setCreditCardYear(String creditCardYear) {
		this.creditCardYear = creditCardYear;
	}

	public String getCreditCardCvc() {
		return creditCardCvc;
	}

	public void setCreditCardCvc(String creditCardCvc) {
		this.creditCardCvc = creditCardCvc;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Facilities getFacilities() {
		return facilities;
	}

	public void setFacilities(Facilities facilities) {
		this.facilities = facilities;
	}

	public FacilitiesType getFacilitiesType() {
		return facilitiesType;
	}

	public void setFacilitiesType(FacilitiesType facilitiesType) {
		this.facilitiesType = facilitiesType;
	}
	
	
}
