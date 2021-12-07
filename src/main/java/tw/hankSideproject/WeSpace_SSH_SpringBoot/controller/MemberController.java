package tw.hankSideproject.WeSpace_SSH_SpringBoot.controller;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.MemberRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.service.MemberService;


@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MemberRepository memberRepository;
	
	//註冊頁面導向
	@RequestMapping("/regist")
	public String regist(){
		return "Regist";
	}
	
	//登入頁面導向
	@RequestMapping("/login")
	public String login(){
		return "Login";
	}
	
	//忘記密碼頁面導向
	@RequestMapping("/forgot")
	public String forgot(){
		return "ResetPassword";
	}
	
	//註冊成功導向
	@PostMapping("/save-member") 
	public String registerMember(@ModelAttribute Member member, BindingResult bindingResult, HttpServletRequest request, HttpSession session) 
			throws UnsupportedEncodingException, MessagingException {
		
		// 檢查帳號是否已被註冊
		Member account = memberRepository.findByAccount(member.getAccount());
		if(account != null) {
			request.setAttribute("duplicatedError", "* 此信箱已被人註冊囉");		
			return "Regist";
		}
		
		// 檢查密碼是否符合格式
		if(!member.getPassword().matches("^[a-zA-Z]{1}[a-zA-Z0-9]{7,15}$")) {		
			request.setAttribute("passwordError", "* 密碼長度需8位以上，至少包含一個英文字母");		
			return "Regist";
		}
			
		// 確認錯誤後註冊會員資料
		memberService.saveMember(member,getSiteURL(request));
		
		// 註冊後同時登入
		session.setAttribute("loginData", member); 
		
		return "VerifyWaiting";
	}
	
	//登入成功導向
	@RequestMapping ("/login-member")
	public String loginMember(@ModelAttribute Member member, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Member loginData = memberService.findByAccountAndPassword(member.getAccount(), member.getPassword());
		Member loginDataWithoutMd5 = memberService.findByAccountAndPasswordWithoutMd5(member.getAccount(), member.getPassword());
		String remember = request.getParameter("remember");
		
		//未自動登入且勾選記住帳密存入session會員資料
		if("true".equals(remember) && loginData != null && loginData.getStatus()==1) {
			Cookie ck1 = new Cookie("remember",remember);
			ck1.setMaxAge(60*60*24);
			response.addCookie(ck1);
			
			Cookie ck2 = new Cookie("account",loginData.getAccount());
			ck2.setMaxAge(60*60*24);
			response.addCookie(ck2);
			
			Cookie ck3 = new Cookie("password",loginData.getPassword());
			ck3.setMaxAge(60*60*24);
			response.addCookie(ck3);
			
			session.setAttribute("loginData", loginData); 			
			return "redirect:/"; 
			
		  //自動登入後且勾選記住帳密存入session會員資料
		} else if("true".equals(remember) && loginDataWithoutMd5 != null && loginDataWithoutMd5.getStatus()==1) {

			Cookie ck1 = new Cookie("remember",remember);
			ck1.setMaxAge(60*60*24);
			response.addCookie(ck1);
			
			Cookie ck2 = new Cookie("account",loginDataWithoutMd5.getAccount());
			ck2.setMaxAge(60*60*24);
			response.addCookie(ck2);
			
			Cookie ck3 = new Cookie("password",loginDataWithoutMd5.getPassword());
			ck3.setMaxAge(60*60*24);
			response.addCookie(ck3);
					
			session.setAttribute("loginData", loginDataWithoutMd5); 			
			return "redirect:/"; 
		  //未自動登入且不勾選記住帳密存入session會員資料
		} else if(remember == null && loginData != null && loginData.getStatus()==1){
			//清除cookie
			Cookie cookie = new Cookie("remember", "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
			session.setAttribute("loginData", loginData);
			return "redirect:/"; 
		//自動登入後不勾選記住帳密存入session會員資料
		} else if(loginDataWithoutMd5 != null && loginDataWithoutMd5.getStatus()==1) {
			//清除cookie
			Cookie cookie = new Cookie("remember", "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
			session.setAttribute("loginData", loginDataWithoutMd5);
			return "redirect:/";
		//錯誤:信箱未認證
		} else if(loginData != null && loginData.getStatus()==0) {
			request.setAttribute("errorVerifyMail", "此帳號尚未完成信箱認證！");	
			session.setAttribute("loginData", loginData); 
			return "Login";
		//錯誤:帳密未通過
		} else {
			//清除cookie
			Cookie[] cks = request.getCookies();
			if(cks != null) {
				for(Cookie c:cks) {
					c.setMaxAge(0);
					response.addCookie(c);
				}
			}		
			
			session.removeAttribute("loginData");
			request.setAttribute("error", "錯誤的帳號或密碼，請重新輸入");		
			return "Login";
		}
		
	}
	
	//登出成功導向
	@GetMapping("/logout-member")
    public String logout(HttpSession session,HttpServletRequest request, HttpServletResponse response){	
        session.removeAttribute("loginData");
        return "redirect:/";
    }
	
	//重新寄認證信-註冊
	@RequestMapping("/reVerifyMailRegist")
	public String reVerifyMailRegist(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, MessagingException {
		Member loginData = (Member) session.getAttribute("loginData");
		memberService.sendVerificationEmail(loginData,getSiteURL(request));
		return "VerifyWaiting";
	}
	
	//重新寄認證信-登入
	@RequestMapping("/reVerifyMailLogin")
	public String resendMailLogin(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, MessagingException {
		Member loginData = (Member) session.getAttribute("loginData");
		memberService.sendVerificationEmail(loginData,getSiteURL(request));
		request.setAttribute("errorVerifyMail", "已為您重新寄發驗證信！");	
		return "Login";
	}
	
	//取得requestURL方法
	private String getSiteURL(HttpServletRequest request) {		
        String siteURL = request.getRequestURL().toString();        
        return siteURL.replace(request.getServletPath(), "");    
    }  
	
	//確認信件導向
	@GetMapping("/verify")
	public String verifyMember(@Param("code") String code, HttpSession session) {
		
		Member member = memberRepository.findByValidateCode(code);
		
	    if (memberService.verify(code)) {
	    	session.setAttribute("loginData", member); 
	        return "VerifySuccess";
	    } else {
	        return "VerifyFail";
	    }
	}
	
	//密碼重置信導向
	@RequestMapping("/forgotPassword")
	public String forgotPassword(@ModelAttribute Member member,HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, MessagingException {
		
		Member loginData = memberService.findByAccount(member.getAccount());
		session.setAttribute("loginData", loginData); 
		
		if(loginData != null) {
			memberService.sendResetPasswordEmail(loginData,getSiteURL(request));
			return "ResetResult";
		}else {
			request.setAttribute("error", "不存在的帳號，請重新輸入");	
			return "ResetPassword";
		}
	}
	
	//重新寄密碼重置信
	@RequestMapping("/resendForgotPassword")
	public String resendForgotPassword(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, MessagingException {
		
		Member loginData = (Member) session.getAttribute("loginData");
		memberService.sendResetPasswordEmail(loginData,getSiteURL(request));
		request.setAttribute("errorVerifyMail", "已為您重新寄發驗證信！");	
		return "ResetResult";
	}
	
	//重置密碼頁面導向
	@GetMapping("/resetPassword")
	public String resetPassword(@Param("token") String token, HttpServletRequest request) {
		
		Member loginData = memberService.findByToken(token);
		
		if(loginData == null) {
			return "ResetLinkFailed";
		}else {
			return "PasswordUpdate";
		}
	}
	
	//重置密碼請求
	@PostMapping("/resetResult2")
	public String resetResult2(@RequestParam("token") String token, @RequestParam("password") String password,
			@RequestParam("passwordCheck") String passwordCheck, HttpServletRequest request) {
		
		// 檢查密碼驗證是否相符
		if(!password.equals(passwordCheck)) {
			request.setAttribute("passwordError", "驗證密碼不一致！");
			return "PasswordUpdate";
		}
		
		// 檢查密碼是否符合格式
		if(!password.matches("^[a-zA-Z]{1}[a-zA-Z0-9]{7,15}$")) {		
			request.setAttribute("passwordError", "密碼長度需8位以上，至少包含一個英文字母！");		
			return "PasswordUpdate";
		}
		memberService.resetPassword(token, password);
		return "ResetResult2";
	}
	
}
