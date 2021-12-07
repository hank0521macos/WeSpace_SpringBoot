package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
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
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "member")
@EntityListeners(AuditingEntityListener.class)
public class Member {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "member_id")
	private Integer id;
	
	@Column(name = "member_account")
	private String account;
	
	@Column(name = "member_password")
	private String password;
	
	@Column(name = "member_email")
	private String email;
	
	@Column(name = "member_firstname")
	private String firstname;
	
	@Column(name = "member_lastname")
	private String lastname;
	
	@Column(name = "member_mobile_phone")
	private String mobilePhone;
	
	@Column(name = "member_create_time")
	@CreatedDate
	private Date createTime;
	
	@Column(name = "member_validate_code")
	private String validateCode;
	
	@Column(name = "member_token")
	private String token;
	
	@Column(name = "member_status")
	private int status;
	
	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER, mappedBy="member")
	private Set<Facilities> facilities = new HashSet<Facilities>();
	
	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER, mappedBy="member")
	private List<FacilitiesOwner> facilitiesOwner = new ArrayList<FacilitiesOwner>();
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getValidateCode() {
		return validateCode;
	}

	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public Set<Facilities> getFacilities() {
		return facilities;
	}

	public void setFacilities(Set<Facilities> facilities) {
		this.facilities = facilities;
	}

	public List<FacilitiesOwner> getFacilitiesOwner() {
		return facilitiesOwner;
	}

	public void setFacilitiesOwner(List<FacilitiesOwner> facilitiesOwner) {
		this.facilitiesOwner = facilitiesOwner;
	}
	
	
}
