<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
  .sidebar-profile-image {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 15px;
    border: 1px solid #ccc;
  }
  
  .sidebar-profile-name {
    font-weight: bold;
    margin-bottom: 5px;
    font-size: 16px;
  }
  .sidebar-profile-age {
    color: grey;
    margin-bottom: 20px;
    font-size: 14px;
  }
  
   .sidebar {
    width: 250px;
    background-color: #f8f9fa;
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    padding-top: 40px;
    border-right: 1px solid #e7e7e7;
  }

  .w3-bar-block {
    margin-top: 25px !important;
  }

  .sidebar a {
    display: block;
    color: black;
    padding: 12px 12px !important;   
    font-size: 16px;
    transition: all 0.3s ease;
    text-decoration: none; /* 기본 상태에서 밑줄 제거 */
    border-bottom: 1px solid transparent; /* 투명한 밑줄 추가 */
  }

  .sidebar a:hover {
    background-color: #f1f1f1;
    color: black;
    text-decoration: none; /* 호버 시 밑줄 제거 */
  }

  .sidebar a i {
    margin-right: 18px;
    margin-left: 8px;
    font-size: 18px; 
  }

  /* 각 메뉴 항목 사이의 간격 제거 */
  .w3-bar-item {
    margin-bottom: 0;
  }

  /* 활성 메뉴 항목의 스타일 변경 */
  .w3-bar-item.active {
    color: #84a98c !important;
    background-color: transparent;
    font-weight: bold;
  }

  /* 호버 시 배경색 변경을 위한 추가 스타일 */
  .sidebar a:hover {
    background-color: #f1f1f1;
    color: black;
    width: 100%; /* 호버 시 배경색이 꽉 차도록 설정 */
  }
</style>
</head>
<body>
<nav class="w3-sidebar w3-collapse w3-white sidebar" style="z-index:3;width:250px;" id="mySidebar"><br>

  <div class="w3-container text-center">
    <img src="${ctp}/member/${sPhoto}" class="sidebar-profile-image"><br>
    <div class="sidebar-profile-name">${sName}</div>
    <p class="sidebar-profile-age">만 ${sAge}세</p>
  </div> 
   <div class="w3-bar-block">
    <a href="${ctp}/home" onclick="w3_close()" class="w3-bar-item w3-button w3-padding ${pageContext.request.servletPath == '/' ? 'active' : ''}"><i class="fa fa-home fa-fw"></i>홈</a>
    <a href="${ctp}/notice/noticeList" onclick="w3_close()" class="w3-bar-item w3-button w3-padding ${fn:contains(pageContext.request.servletPath, '/notice/') ? 'active' : ''}"><i class="fa fa-bullhorn fa-fw"></i>가족소식</a>
    <a href="${ctp}/calendar/calendarMain" onclick="w3_close()" class="w3-bar-item w3-button w3-padding ${fn:contains(pageContext.request.servletPath, '/calendar/') ? 'active' : ''}"><i class="fa fa-calendar fa-fw"></i>일정관리</a>
    <a href="${ctp}/housework/workMain" onclick="w3_close()" class="w3-bar-item w3-button w3-padding ${fn:contains(pageContext.request.servletPath, '/housework/') ? 'active' : ''}"><i class="fa fa-tasks fa-fw"></i>가사분담</a>
    <a href="${ctp}/vote/voteList" onclick="w3_close()" class="w3-bar-item w3-button w3-padding ${fn:contains(pageContext.request.servletPath, '/vote/') ? 'active' : ''}"><i class="fa fa-poll fa-fw"></i>가족투표</a>
    <a href="${ctp}/familyMeeting/meetingList" onclick="w3_close()" class="w3-bar-item w3-button w3-padding ${fn:contains(pageContext.request.servletPath, '/familyMeeting/') ? 'active' : ''}"><i class="fa fa-solid fa-users-line fa-fw"></i>가족회의</a>
    <a href="${ctp}/photo/photoList" onclick="w3_close()" class="w3-bar-item w3-button w3-padding ${fn:contains(pageContext.request.servletPath, '/photo/') ? 'active' : ''}"><i class="fa fa-photo fa-fw"></i>앨범</a>
  </div>
</nav>

<!-- Hamburger menu for small screens -->
<div class="w3-top w3-hide-large">
  <div class="w3-bar w3-white w3-padding">
    <a href="javascript:void(0)" class="w3-bar-item w3-button" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<script>
	function w3_open() {
	    document.getElementById("mySidebar").style.display = "block";
	    document.getElementById("myOverlay").style.display = "block";
	}
	 
	function w3_close() {
	    document.getElementById("mySidebar").style.display = "none";
	    document.getElementById("myOverlay").style.display = "none";
	}
</script>