package tw.hankSideproject.WeSpace_SSH_SpringBoot.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = "/*",filterName = "loginFilter",initParams = {
		@WebInitParam(name="indexPage",value = "/"),
        @WebInitParam(name="loginPage",value = "/login"),
        @WebInitParam(name="registPage",value = "/regist"),
        @WebInitParam(name="forgotPage",value = "/forgot"),
        @WebInitParam(name="addMember",value = "/save-member"),
        @WebInitParam(name="loginMember",value = "/login-member"),
        @WebInitParam(name="logoutMember",value = "/logout-member"),
        @WebInitParam(name="reVerifyMailRegist",value = "/reVerifyMailRegist"),
        @WebInitParam(name="reVerifyMailLogin",value = "/reVerifyMailLogin"),
        @WebInitParam(name="verify",value = "verify"),
        @WebInitParam(name="forgotPassword",value = "/forgotPassword"),
		@WebInitParam(name="resendForgotPassword",value = "/resendForgotPassword"),
		@WebInitParam(name="resetPassword",value = "/resetPassword"),
		@WebInitParam(name="resetResult2",value = "/resetResult2")
})
public class LoginFilter implements Filter {
	
    //不需要登入就可以訪問的路徑(比如:註冊登入等)
	private String indexPage;
    private String loginPage;
    private String registPage;
    private String forgotPage;
    private String addMember;
    private String loginMember;
    private String logoutMember;
    private String reVerifyMailRegist;
    private String reVerifyMailLogin;
    private String verify;
    private String forgotPassword;
    private String resendForgotPassword;
    private String resetPassword;
    private String resetResult2;

    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }
    
	public void init(FilterConfig fConfig) throws ServletException {
		 //獲取初始化filter的引數
        this.indexPage=fConfig.getInitParameter("indexPage");
        this.loginPage=fConfig.getInitParameter("loginPage");
        this.registPage=fConfig.getInitParameter("registPage");
        this.forgotPage=fConfig.getInitParameter("forgotPage");
        this.addMember=fConfig.getInitParameter("addMember");
        this.loginMember=fConfig.getInitParameter("loginMember");
        this.logoutMember=fConfig.getInitParameter("logoutMember");
        this.reVerifyMailRegist=fConfig.getInitParameter("reVerifyMailRegist");
        this.reVerifyMailLogin=fConfig.getInitParameter("reVerifyMailLogin");
        this.verify=fConfig.getInitParameter("verify");
        this.forgotPassword=fConfig.getInitParameter("forgotPassword");
        this.resendForgotPassword=fConfig.getInitParameter("resendForgotPassword");
        this.resetPassword=fConfig.getInitParameter("resetPassword");
        this.resetResult2=fConfig.getInitParameter("resetResult2");
	}
	

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		String uri = httpRequest.getRequestURI();
		
		//不需要過濾直接傳給下一個過濾器
		if (uri.contains("/lang")||uri.contains("/listTime")||uri.contains("/oneSpacePage")||
			uri.contains("/OneSearchResult")||uri.contains("/subSearchResult")||uri.contains("/searchResult")||
			uri.equals(forgotPassword)||uri.equals(resendForgotPassword)||
			uri.equals(resetPassword)||uri.equals(resetResult2)||uri.equals(verify)||
			uri.equals(reVerifyMailRegist)||uri.equals(reVerifyMailLogin)||uri.equals(logoutMember)||
			uri.equals(loginMember)||uri.equals(addMember)||uri.equals(forgotPage)||
			uri.equals(registPage)||uri.equals(indexPage)||uri.equals(loginPage)||
			uri.contains("/css")||uri.contains("/img")||uri.contains("/js")||
			uri.contains("/uploaded")||uri.contains("/vendors")) {
            chain.doFilter(request, response);
	    } else {
            //需要過濾器
            //session中包含loginData物件,則是登入狀態
            if(session!=null&&session.getAttribute("loginData") != null){
                chain.doFilter(httpRequest,httpResponse);
            }else{
                //重定向到登入頁
            	httpResponse.sendRedirect(httpRequest.getContextPath()+"/login");
                return;
            }
        }
		
	}

	public void destroy() {
		// TODO Auto-generated method stub
	}

}
