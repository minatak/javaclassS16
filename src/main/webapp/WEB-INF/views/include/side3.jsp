<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	.profile-image {
	    width: 25%; /* Reduced to half of 50% */
	    border-radius: 50%; /* Makes the image circular */
	}
	.profile-name {
	    font-weight: bold; /* Makes the name bold */
	}
	.profile-age {
	    color: grey; /* Makes the age grey */
	}
	.sidebar {
	  width: 280px;
	  background-color: #f8f9fa;
	  position: fixed;
	  top: 0;
	  left: 0;
	  height: 100%;
	  padding-top: 60px;
	  border-right: 1px solid #e7e7e7;
	}
	.sidebar a {
	  display: block;
	  color: black;
	  padding: 16px;
	  text-decoration: none;
	}
	.sidebar a:hover {
	  background-color: #ddd;
	}
	.profile-img {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: #ddd;
  }
</style>
</head>
<body>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white sidebar" id="mySidebar">
  <div class="w3-container text-center">
    <img src="${ctp}/member/${sPhoto}" class="w3-round profile-image"><br><br> 
    <h5 class="profile-name">${sName}</h5>
    <p class="profile-age">만 0세</p>
    <div class="dropdown">
      <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        호칭: 딸
      </button>
      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <a class="dropdown-item" href="#">호칭 변경</a>
      </div>
    </div>
  </div>
  <div class="w3-bar-block mt-5 ml-2">
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-home fa-fw w3-margin-right"></i>홈</a>
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-calendar fa-fw w3-margin-right"></i>일정 관리</a>
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-tasks fa-fw w3-margin-right"></i>가사 분담</a>
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bullhorn fa-fw w3-margin-right"></i>공지사항</a>
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-shopping-cart fa-fw w3-margin-right"></i>위치 공유</a>
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-poll fa-fw w3-margin-right"></i>가족 투표</a>
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-photo fa-fw w3-margin-right"></i>앨범</a>
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
// Script to open and close sidebar
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}
</script>