package com.spring.javaclassS16.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level2Interceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		// κ΄?λ¦¬μ(0), ?°???(1), ? ??(2), μ€???(3), λΉν?(99), ??΄??(999)
		// ? ???΄? ?¬?©μ²λ¦¬
		if(level > 2) {
			RequestDispatcher dispatcher;
			if(level == 99) {	// λΉν? μ²λ¦¬
				dispatcher = request.getRequestDispatcher("/message/memberNo");
			}
			else {	// μ€???
				dispatcher = request.getRequestDispatcher("/message/memberLevelNo");
			}
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
