<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<nav class="navbar navbar-expand-lg">
  <div class="container px-5">
    <a class="navbar-brand" href="Main.com">Homelink</a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
        <c:if test="${empty sMid}">
	        <a class="dropdown-item" href="${ctp}/member/memberLogin">로그인</a> 
	        <a class="dropdown-item" href="${ctp}/member/memberJoin">회원가입</a> 
      	</c:if>
        <!-- Profile Dropdown -->
        <c:if test="${!empty sMid}">
          <li class="nav-item dropdown profile-dropdown ml-3">
            <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <!-- <img src="${ctp}/member/${sPhoto}" alt="Profile Picture"> -->
              <img src="${ctp}/member/noimage.png" alt="Profile Picture">
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
              <li><a class="dropdown-item" href="${ctp}/member/memberInfo"><i class="fa-solid fa-user"></i>내 정보 확인</a></li>
              <li><a class="dropdown-item" href="${ctp}/member/memberUpdate"><i class="fa-solid fa-gear"></i>정보 수정</a></li>
              <li><a class="dropdown-item" href="${ctp}/member/memberLogout"><i class="fa-solid fa-right-from-bracket"></i>로그아웃</a></li>
            </ul>
          </li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>
<style>
	.navbar-brand {font-family: 'Cafe24Ssurround';}
</style>