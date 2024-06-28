<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.sidebar {
    width: 300px;
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

</style>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white sidebar" id="mySidebar">
    <div class="w3-container text-center">
    <img img src="images/111.jpg" style="width:50%;" class="w3-round"><br><br>
    <h5>h</h5>
    <p>24.6.25. (만 0세)</p>
    <div class="dropdown">
        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        호칭: 딸
        </button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <a class="dropdown-item" href="#">호칭 변경</a>
            <a class="dropdown-item" href="#">소속 추가</a>
            <a class="dropdown-item" href="#">어른신 추가</a>
        </div>
    </div>
    </div>
    <div class="w3-bar-block mt-3">
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