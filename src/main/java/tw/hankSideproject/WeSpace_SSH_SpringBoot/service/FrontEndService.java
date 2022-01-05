package tw.hankSideproject.WeSpace_SSH_SpringBoot.service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.OrdersRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;

@Service
@Transactional
public class FrontEndService {
	
	@Autowired
	private OrdersRepository ordersRepository;
	
	@Autowired
    private JavaMailSender mailSender;
	
	//新增訂單
	public void saveOrders(Orders orders) throws UnsupportedEncodingException, MessagingException {		
		// 調用save方法，insert訂單資料
		ordersRepository.save(orders);
		// 傳入寄信方法所需要的訂單資料
		sendOrdersEmail(orders);
	}
	
	//寄送訂單確認信的內容
	public void sendOrdersEmail(Orders orders)
	        throws MessagingException, UnsupportedEncodingException {
	    String toAddress = orders.getMember().getEmail();
	    String fromAddress = "hank0521macos@gmail.com";
	    String senderName = "WeSpace";
	    String subject = "【WeSpace - 預訂通知】您好"+orders.getMember().getFirstname()+orders.getMember().getLastname()+"感謝您使用WeSpace 線上預訂【預訂方案】";
	    String content = "Dear &ensp;" + orders.getMember().getFirstname() +" &ensp; 先生/小姐 <br><br>"
	            + "【請注意】<br><br>"
	            + "收到此封信件僅代表您的「預約申請」已經送出，不代表「預訂成功」，場地會<br>"
	            + "在24小時內回覆您預訂結果，若48小時內場地沒有回覆預訂結果，訂單將會自動<br>"
	            + "取消，請留意您的郵件。"
	            + "<br><br>"
	            + "若您收到綠界科技的刷卡成功郵件，僅代表完成信用卡授權，待場地確認後才會<br>刷卡扣款，謝謝！<br><br>"
	            + "感謝您使用WeSpace 租場地的服務，我們將立即處理您的預訂<br><br>"
	            + "WeSpace 團隊";
	     
	    MimeMessage message = mailSender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message);
	     
	    helper.setFrom(fromAddress, senderName);
	    helper.setTo(toAddress);
	    helper.setSubject(subject);
	    helper.setText(content, true); 
	    
	    mailSender.send(message);  
	}
}
