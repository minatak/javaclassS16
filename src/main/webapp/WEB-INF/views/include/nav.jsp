<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
  .navbar {
    background-color: #fff;
    border-bottom: 1px solid #e7e7e7;
    padding: 10px 0;
  }
  .navbar-brand img {
    width: 130px;
  }
  .nav-link {
    color: black;
    font-size: 16px;
    transition: all 0.3s ease;
    padding: 8px 15px !important;
  }
  .nav-link:hover {
    background-color: #fff;
    color: #84a98c;
  }
  .profile-dropdown img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    border: 1px solid #ccc;
  }
  .dropdown-menu {
    border: none;
  }
  .dropdown-item {
    padding: 10px 20px;
    transition: all 0.3s ease;
  }
 /*  .dropdown-item:hover {
    background-color: #fff;
    color: #84a98c;
  } */
  .dropdown-item i {
    width: 20px;
    text-align: center;
    margin-right: 10px;
  }
  
  .nav-link:focus,
  .dropdown-item:focus,
  .dropdown-item:active {
    background-color: transparent !important;
    color: #333 !important;
  }
  
  .dropdown-item:hover {
    background-color: #f8f9fa;
    /* color: #84a98c;*/
  } 
</style>

<nav class="navbar navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand" href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" alt="Logo"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
      <ul class="navbar-nav">
        <c:if test="${empty sMid}">
          <li class="nav-item">
            <a class="nav-link" href="${ctp}/member/memberLogin">로그인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${ctp}/member/memberJoin0">회원가입</a>
          </li>
        </c:if>
        <c:if test="${!empty sMid}">
          <c:if test="${empty sFamCode}">
            <li class="nav-item">
              <a class="nav-link" href="${ctp}/member/memberFamCode">가족 코드 등록하기</a>
            </li>
          </c:if>
          <li class="nav-item dropdown profile-dropdown">
            <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <img src="${ctp}/member/${sPhoto}" alt="Profile Picture">
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
              <li><a class="dropdown-item" href="${ctp}/member/memberInfo"><i class="fa-solid fa-user"></i>내 정보</a></li>
              <li><a class="dropdown-item" href="${ctp}/member/memberFamCode"><i class="fa-solid fa-circle-nodes"></i>가족코드</a></li>
              <li><a class="dropdown-item" href="${ctp}/member/linkedFamily"><i class="fa-solid fa-house"></i>우리 가족</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="${ctp}/member/memberLogout"><i class="fa-solid fa-right-from-bracket"></i>로그아웃</a></li>
            </ul>
          </li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>