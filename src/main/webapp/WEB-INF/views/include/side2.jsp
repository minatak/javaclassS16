<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${ctp}/path/to/w3.css"> <!-- Make sure to include the path to W3.CSS -->
<link rel="stylesheet" href="${ctp}/path/to/font-awesome.min.css"> <!-- Make sure to include the path to Font Awesome -->
<link rel="stylesheet" href="${ctp}/path/to/bootstrap.min.css"> <!-- Make sure to include the path to Bootstrap CSS -->
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
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link active" href="#">
          <i class="fa fa-home"></i> 홈
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-calendar"></i> 일정 관리
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-tasks"></i> 가사 분담
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-bullhorn"></i> 공지사항
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-shopping-cart"></i> 위치 공유
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-poll"></i> 가족 투표
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-photo"></i> 앨범
        </a>
      </li>
    </ul>
  </div>
</nav>
<%-- <script src="${ctp}/path/to/jquery.min.js"></script> <!-- Make sure to include the path to jQuery -->
<script src="${ctp}/path/to/bootstrap.bundle.min.js"></script> <!-- Make sure to include the path to Bootstrap JS --> --%>
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