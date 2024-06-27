package com.spring.javaclassS16.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level1Interceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		// ê´?ë¦¬ì(0), ?š°?ˆ˜?šŒ?›(1), ? •?šŒ?›(2), ì¤??šŒ?›(3), ë¹„íšŒ?›(99), ?ƒˆ?‡´?šŒ?›(999)
		// ?š°?ˆ˜?šŒ?›?´?ƒ ?‚¬?š©ì²˜ë¦¬
		if(level > 1) {
			RequestDispatcher dispatcher;
			if(level == 99) {	// ë¹„íšŒ?› ì²˜ë¦¬
				dispatcher = request.getRequestDispatcher("/message/memberNo");
			}
			else {	// ? •?šŒ?›, ì¤??šŒ?›
				dispatcher = request.getRequestDispatcher("/message/memberLevelNo");
			}
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
