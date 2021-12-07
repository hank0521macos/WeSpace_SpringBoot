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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "facilities_owner")
@EntityListeners(AuditingEntityListener.class)
public class FacilitiesOwner {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "facilities_owner_id")
	private Integer id;
	
	@Column(name = "facilities_owner_name")
	private String name;
	
	@Column(name = "facilities_owner_image")
	private String image;
	
	@Column(name = "facilities_owner_description")
	private String description;
	
	@Column(name = "facilities_owner_contact_name")
	private String contactName;
	
	@Column(name = "facilities_owner_contact_phone")
	private String contactPhone;
	
	@Column(name = "facilities_owner_contact_mobile_phone")
	private String contactMobilePhone;
	
	@Column(name = "facilities_owner_invoice_heading")
	private String invoiceHeading;
	
	@Column(name = "facilities_owner_tax_id")
	private String taxId;
	
	@Column(name = "facilities_owner_payee_name")
	private String payeeName;
	
	@Column(name = "facilities_owner_payee_bank_name")
	private String payeeBankName;
	
	@Column(name = "facilities_owner_payee_branch_name")
	private String payeeBranchName;
	
	@Column(name = "facilities_owner_account")
	private String account;
	
	@ManyToOne(targetEntity=Member.class)
	@JoinColumn(name = "member_id",referencedColumnName="member_id")
	private Member member;
	
	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL,mappedBy="facilitiesOwner")
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public String getContactMobilePhone() {
		return contactMobilePhone;
	}

	public void setContactMobilePhone(String contactMobilePhone) {
		this.contactMobilePhone = contactMobilePhone;
	}

	public String getInvoiceHeading() {
		return invoiceHeading;
	}

	public void setInvoiceHeading(String invoiceHeading) {
		this.invoiceHeading = invoiceHeading;
	}

	public String getTaxId() {
		return taxId;
	}

	public void setTaxId(String taxId) {
		this.taxId = taxId;
	}

	public String getPayeeName() {
		return payeeName;
	}

	public void setPayeeName(String payeeName) {
		this.payeeName = payeeName;
	}

	public String getPayeeBankName() {
		return payeeBankName;
	}

	public void setPayeeBankName(String payeeBankName) {
		this.payeeBankName = payeeBankName;
	}

	public String getPayeeBranchName() {
		return payeeBranchName;
	}

	public void setPayeeBranchName(String payeeBranchName) {
		this.payeeBranchName = payeeBranchName;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Set<Facilities> getFacilities() {
		return facilities;
	}

	public void setFacilities(Set<Facilities> facilities) {
		this.facilities = facilities;
	}

}
