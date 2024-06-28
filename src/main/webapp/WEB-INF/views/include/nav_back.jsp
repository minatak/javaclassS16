<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- Navigation -->
<div class="w3-top navbar">
  <div class="w3-bar w3-white w3-card">
    <a class="w3-bar-item w3-button w3-padding-large navbar-brand" href="Main.com">FamilyNote</a>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <div class="w3-right w3-hide-small">
      <!-- Profile Dropdown -->
      <!-- <c:if test="${!empty sMid}"> -->
      <div class="w3-dropdown-hover w3-right w3-padding-large">
        <button class="w3-button" title="Profile"><img src="images/111.jpg" alt="Profile Picture" style="height:30px;"></button>
        <div class="w3-dropdown-content w3-bar-block w3-card-4 w3-white">
          <a href="MemberMain.mem" class="w3-bar-item w3-button">대시보드</a>
          <a href="MemberInfo.mem" class="w3-bar-item w3-button">정보 확인</a>
          <a href="MemberUpdate.mem" class="w3-bar-item w3-button">정보 수정</a>
          <hr class="w3-divider">
          <c:if test="${sLevel == 0}">
            <a href="AdminMemberList.ad" class="w3-bar-item w3-button">회원 리스트</a>
            <a href="AdminReports.ad" class="w3-bar-item w3-button">신고 관리</a>
            <hr class="w3-divider">
          </c:if>
          <a href="MemberLogout.mem" class="w3-bar-item w3-button">Logout</a>
        </div>
      </div>
      <!-- </c:if> -->
    </div>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="MemberMain.mem" class="w3-bar-item w3-button">대시보드</a>
  <a href="MemberInfo.mem" class="w3-bar-item w3-button">정보 확인</a>
  <a href="MemberUpdate.mem" class="w3-bar-item w3-button">정보 수정</a>
  <c:if test="${sLevel == 0}">
    <a href="AdminMemberList.ad" class="w3-bar-item w3-button">회원 리스트</a>
    <a href="AdminReports.ad" class="w3-bar-item w3-button">신고 관리</a>
  </c:if>
  <a href="MemberLogout.mem" class="w3-bar-item w3-button">Logout</a>
</div>

<style>
	body {
		font-family: 'SCoreDream';
    font-weight: 300; 
	}
	a {
		font-family: 'SCoreDream';
    font-weight: 300; 
	}
	h1,h2,h3,h4,h5 {
		font-family: 'SCoreDream';
    font-weight: 500; 
	}
	
	.profile-dropdown img {
    border-radius: 50%;
    width: 40px;
    height: 40px;
    object-fit: cover;
	}
	.navbar {
	    display: flex;
	    justify-content: flex-end;
	    padding-left: 0;
	    padding-right: 0;
	}
	.navbar-brand {
	    color: #35ae5f !important;
	    font-weight: bold;
	    margin: 0;
	}
</style>