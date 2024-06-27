package com.spring.javaclassS16.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level0Interceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		// Í¥?Î¶¨ÏûêÍ∞? ?ïÑ?ãà?ùºÎ©? Ï¥àÍ∏∞?ôîÎ©¥Ï∞Ω?úºÎ°? Î≥¥ÎÇ∏?ã§.
		if(level != 0) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/adminNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
