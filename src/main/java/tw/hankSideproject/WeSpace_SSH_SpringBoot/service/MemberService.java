package tw.hankSideproject.WeSpace_SSH_SpringBoot.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.MemberRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;

@Service
@Transactional
public class MemberService {
	
	@Autowired
	private final MemberRepository memberRepository;
	
	@Autowired
    private JavaMailSender mailSender;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	
	//會員註冊
	public void saveMember(Member member,String siteURL) throws UnsupportedEncodingException, MessagingException {		
		// 密碼加密
		String md5Password = getMd5Password(member.getPassword());
		member.setPassword(md5Password);
		//生成唯一標識符作為驗證碼並使用MD5加密
		String code = UUID.randomUUID().toString(); 
		String validatecode = getMd5Password(code);
		// 存入驗證碼
		member.setValidateCode(validatecode);
		// 調用save方法，insert會員資料
		memberRepository.save(member);
		// 傳入寄信方法所需要的會員資料及requestURL
		sendVerificationEmail(member, siteURL);
	}

	public List<Member> showAllMembers() {
		List<Member> members = new ArrayList<Member>();
		for (Member member : memberRepository.findAll()) {
			members.add(member);
		}

		return members;
	}

	public void deleteMember(int id) {
		memberRepository.deleteById(id);;
	}

	public Member editMember(int id) {
		return memberRepository.findById(id).get();
	}
	
	//密碼重置信確認用的帳號查詢
	public Member findByAccount(String account) {	
		return memberRepository.findByAccount(account);
	}
	
	//密碼重置頁面確認用的token查詢
	public Member findByToken(String token) {	
		return memberRepository.findByToken(token);
	}
	
	//登入時確認用的帳號密碼查詢
	public Member findByAccountAndPassword(String account, String password) {	
		// 密碼進行MD5加密作為比對
		String md5Password = getMd5Password(password);	
		return memberRepository.findByAccountAndPassword(account, md5Password);
	}
	
	//自動記錄登入時確認用的帳號密碼查詢
	public Member findByAccountAndPasswordWithoutMd5(String account, String password) {	
		return memberRepository.findByAccountAndPassword(account, password);
	}
	
	//寄送註冊確認信的內容
	public void sendVerificationEmail(Member member, String siteURL)
	        throws MessagingException, UnsupportedEncodingException {
	    String toAddress = member.getEmail();
	    String fromAddress = "hank0521macos@gmail.com";
	    String senderName = "WeSpace";
	    String subject = "WeSpace 帳戶確認信連結";
	    String content = "Dear &ensp;" + member.getFirstname() +" &ensp; 先生/小姐 <br>"
	            + "請點擊以下連結完成帳號啟動:<br>"
	            + "<h3><a href=\"[[URL]]\" target=\"_self\">VERIFY</a></h3>"
	            + "Best,<br><br>"
	            + "WeSpace 團隊";
	     
	    MimeMessage message = mailSender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message);
	     
	    helper.setFrom(fromAddress, senderName);
	    helper.setTo(toAddress);
	    helper.setSubject(subject);
	     
	    String verifyURL = siteURL + "/verify?code=" + member.getValidateCode();     
	    content = content.replace("[[URL]]", verifyURL);     
	    helper.setText(content, true);    
	    mailSender.send(message);  
	}
	
	//確認信件點擊後，更改會員的狀態=1(啟用)並且清空驗證碼
	public boolean verify(String validateCode) {		
	    Member member = memberRepository.findByValidateCode(validateCode);
	    // 如果有此帳號並且狀態未啟用則更改會員的狀態=1(啟用)並且清空驗證碼
	    if (member == null || member.getStatus()!=0) {    	
	        return false;
	    } else {    	
	    	member.setValidateCode(null);
	        member.setStatus(1);
	        memberRepository.save(member);
	        return true;
	    }     
	}
	
	//寄送密碼重置信的內容
	public void sendResetPasswordEmail(Member member, String siteURL)
	        throws MessagingException, UnsupportedEncodingException {
		//生成唯一標識符作為驗證碼並使用MD5加密
		String token = UUID.randomUUID().toString(); 
		// 存入驗證碼
		member.setToken(token);
		// 調用save方法，更新會員的token欄位
		memberRepository.save(member);
		
	    String toAddress = member.getEmail();
	    String fromAddress = "hank0521macos@gmail.com";
	    String senderName = "WeSpace";
	    String subject = "WeSpace 密碼重置";
	    String content = "Dear &ensp;" + member.getFirstname() +" &ensp; 先生/小姐 <br>"
	            + "請點擊以下連結進行密碼重置:<br>"
	            + "<h3><a href=\"[[URL]]\" target=\"_self\">PASSWORD RESET</a></h3>"
	            + "Best,<br><br>"
	            + "WeSpace ";
	     
	    MimeMessage message = mailSender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message);
	     
	    helper.setFrom(fromAddress, senderName);
	    helper.setTo(toAddress);
	    helper.setSubject(subject);
	     
	    String resetPasswordURL = siteURL + "/resetPassword?token=" + member.getToken();     
	    content = content.replace("[[URL]]", resetPasswordURL);     
	    helper.setText(content, true);    
	    mailSender.send(message);  
	}

	//重置密碼信件的submit點擊後，更改會員的密碼並且清空token
	public boolean resetPassword(String token, String password) {		
	    Member member = memberRepository.findByToken(token);
	    // 如果有此帳號則更改密碼並且清空token
	    if (member == null) {    	
	        return false;
	    } else {    	
	    	String md5Password = getMd5Password(password);
	        member.setPassword(md5Password);
	        member.setToken(null);
	        memberRepository.save(member);
	        return true;
	    }     
	}
	
	//MD5密碼轉換器
	private String getMd5Password(String password) {
		String str = password;
		// 對password 進行三次加密
		for (int i = 0; i < 3; i++) {
			str = DigestUtils.md5DigestAsHex(str.getBytes()).toUpperCase();
		}
		return str;
	}

}
