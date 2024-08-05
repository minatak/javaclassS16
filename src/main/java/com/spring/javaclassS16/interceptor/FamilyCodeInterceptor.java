package com.spring.javaclassS16.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class FamilyCodeInterceptor extends HandlerInterceptorAdapter {
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
    
    // 로그인 상태일 경우 가족 코드 확인
    String sFamCode = (String) session.getAttribute("sFamCode");
    
    // sFamCode가 없거나 비어있으면 가족 코드 없음 메시지 페이지로 보냄
    if(sFamCode == null || sFamCode.isEmpty()) {
      RequestDispatcher dispatcher = request.getRequestDispatcher("/message/FamilyNo");
      dispatcher.forward(request, response);
      return false;
    }
    
    return true;
  }
}