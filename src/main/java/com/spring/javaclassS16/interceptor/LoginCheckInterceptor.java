package com.spring.javaclassS16.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
      
    HttpSession session = request.getSession();
    Integer sIdx = (Integer) session.getAttribute("sIdx");
    
    // sIdx가 없으면 (로그인하지 않은 상태) 로그인 메시지 페이지로 보냄
    if(sIdx == null) {
      RequestDispatcher dispatcher = request.getRequestDispatcher("/message/LoginNo");
      dispatcher.forward(request, response);
      return false;
    }
    
    return true;
  }
}