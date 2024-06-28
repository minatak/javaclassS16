<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home</title>
	 <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
	<style>
    body, a {
    font-family: 'SCoreDream', sans-serif;
    font-weight: 300;
    }
    h1, h2, h3, h4, h5 {
    font-family: 'SCoreDream', sans-serif;
    font-weight: 500;
    }
    .profile-img {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: #ddd;
    }
    .profile-dropdown img {
    border-radius: 50%;
    width: 40px;
    height: 40px;
    object-fit: cover;
    }
    .navbar .container {
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
    .serviceCard {
    cursor: pointer;
    text-align: center;
    border: 1px solid #e7e7e7;
    border-radius: 8px;
    padding: 20px;
    transition: transform 0.2s;
    }
    .serviceCard:hover {
    transform: scale(1.05);
    }
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
    .content {
    margin-left: 300px;
    padding: 20px;
    padding-top: 60px;
    text-align: center;
    max-width: 900px;
    margin: 0 auto;
    }
    .footer {
    background-color: #f8f9fa;
    text-align: center;
    padding: 10px;
    /* position: fixed; */
    left: 0;
    bottom: 0;
    width: 100%;
    border-top: 1px solid #e7e7e7;
    }
    .family-schedule {
    background: #fff;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    }
</style>
		<!-- .serviceCard {
	    cursor: pointer;
	    text-align: center;
	    border: 1px solid #e7e7e7;
	    border-radius: 8px;
	    padding: 20px;
	    transition: transform 0.2s;
    }
    .serviceCard:hover {
   		transform: scale(1.05);
    }
    .content {
	    margin-left: 300px;
	    padding: 20px;
	    padding-top: 60px;
	    text-align: center;
	    max-width: 900px;
	    margin: 0 auto;
    }
    .family-schedule {
	    background: #fff;
	    padding: 20px;
	    border-radius: 15px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	    margin-bottom: 20px;
    }
	</style> -->
</head>
<body>
<!-- Navbar -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<!-- Page content -->
<div class="w3-content" style="max-width:2000px;margin-top:46px">

<!-- Main Content -->
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 content">
        <div class="family-schedule">
            <h2>가족 일정 한눈에 보기</h2>
            <p>가족들의 중요한 일정을 한눈에 확인할 수 있습니다.</p>
            <!-- 가족 일정 내용 추가 -->
            </div>  
                <div class="row mb-4">
                    <div class="col-12">
                    <div class="family-schedule">
                        <h4 class="border-bottom pb-2">공지사항 0개</h4>
                        <p>작성된 알림장이 없습니다.</p>
                    </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                    <div class="family-schedule">
                        <h4 class="border-bottom pb-2">추억 앨범 0개</h4>
                        <p>작성된 앨범이 없습니다.</p>
                    </div>
                </div>
            </div>
        </main>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-calendar fa-2x"></i>
                    <h4 class="mt-2">일정 관리</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-tasks fa-2x"></i>
                    <h4 class="mt-2">가사 분담</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-bullhorn fa-2x"></i>
                    <h4 class="mt-2">공지사항</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-shopping-cart fa-2x"></i>
                    <h4 class="mt-2">쇼핑 리스트</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-poll fa-2x"></i>
                    <h4 class="mt-2">가족 투표</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-photo fa-2x"></i>
                    <h4 class="mt-2">앨범</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
        </div>
    
  
<!-- End Page Content -->
</div>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
