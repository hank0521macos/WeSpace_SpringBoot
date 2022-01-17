package tw.hankSideproject.WeSpace_SSH_SpringBoot.domain;

import java.util.Date;

public class OrdersRequest {
	
	private String spaceName;
	
	private String contactName;
	
	private String contactMobilePhone;
	
	private Date beginningDate;
	
	private Date endingDate;
	
	private Date beginningCreateDate;
	
	private Date endingCreateDate;
	
	private Member member;

	public String getContactMobilePhone() {
		return contactMobilePhone;
	}

	public void setContactMobilePhone(String contactMobilePhone) {
		this.contactMobilePhone = contactMobilePhone;
	}

	public String getSpaceName() {
		return spaceName;
	}

	public void setSpaceName(String spaceName) {
		this.spaceName = spaceName;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public Date getBeginningDate() {
		return beginningDate;
	}

	public void setBeginningDate(Date beginningDate) {
		this.beginningDate = beginningDate;
	}

	public Date getEndingDate() {
		return endingDate;
	}

	public void setEndingDate(Date endingDate) {
		this.endingDate = endingDate;
	}

	public Date getBeginningCreateDate() {
		return beginningCreateDate;
	}

	public void setBeginningCreateDate(Date beginningCreateDate) {
		this.beginningCreateDate = beginningCreateDate;
	}

	public Date getEndingCreateDate() {
		return endingCreateDate;
	}

	public void setEndingCreateDate(Date endingCreateDate) {
		this.endingCreateDate = endingCreateDate;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
}
