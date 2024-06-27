package com.spring.javaclassS16.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level3Interceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		// �?리자(0), ?��?��?��?��(1), ?��?��?��(2), �??��?��(3), 비회?��(99), ?��?��?��?��(999)
		// �??��?��?��?��(비회?��(99)) ?��?��처리
		if(level > 3) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/memberNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
