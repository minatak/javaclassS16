<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HomeLink</title>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    color: #333;
  }

  .content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
  }

  .header {
    background-color: #fff;
    padding: 20px 0;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .logo {
    font-size: 24px;
    font-weight: 700;
    color: #3b5998;
  }

  .nav-link {
    color: #333;
    font-weight: 500;
  }

  .main-content {
    display: flex;
    margin-top: 30px;
  }

  .left-sidebar {
    width: 250px;
    margin-right: 30px;
  }

  .right-content {
    flex: 1;
  }

  .card {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    overflow: hidden;
  }

  .card-header {
    background-color: #3b5998;
    color: #fff;
    padding: 15px 20px;
    font-weight: 500;
  }

  .card-body {
    padding: 20px;
  }

  .quick-menu {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
  }

  .quick-menu-item {
    text-align: center;
    padding: 15px;
    background-color: #f0f2f5;
    border-radius: 8px;
    transition: background-color 0.3s;
  }

  .quick-menu-item:hover {
    background-color: #e4e6eb;
  }

  .quick-menu-item i {
    font-size: 24px;
    color: #3b5998;
    margin-bottom: 10px;
  }

  .calendar {
    height: 300px;
    /* FullCalendar styles will be applied here */
  }

  @media (max-width: 768px) {
    .main-content {
      flex-direction: column;
    }

    .left-sidebar {
      width: 100%;
      margin-right: 0;
      margin-bottom: 30px;
    }
  }
</style>
<script>
  'use strict';
  
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      height: 'auto',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,listWeek'
      },
      initialView: 'dayGridMonth',
      navLinks: true,
      editable: true,
      dayMaxEvents: true,
      events: function(fetchInfo, successCallback, failureCallback) {
        $.ajax({
          url: "${ctp}/calendar/calendarListAll",
          type: "POST",
          dataType: "json",
          success: function(data) {
            successCallback(data.map(function(event) {
              return {
                title: event.title,
                start: event.startTime,
                end: event.endTime,
                allDay: event.allDay
              };
            }));
          },
          error: function() {
            failureCallback("연결 오류");
          }
        });
      }
    });
    calendar.render();
  });
</script>
</head>
<body>

<header class="header">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center">
      <div class="logo">HomeLink</div>
      <nav>
        <a href="#" class="nav-link">홈</a>
        <a href="#" class="nav-link">설정</a>
        <a href="#" class="nav-link">로그아웃</a>
      </nav>
    </div>
  </div>
</header>

<main class="content">
  <div class="main-content">
    <div class="left-sidebar">
      <div class="card">
        <div class="card-header">
          빠른 메뉴
        </div>
        <div class="card-body">
          <div class="quick-menu">
            <div class="quick-menu-item">
              <i class="fas fa-calendar-alt"></i>
              <div>일정</div>
            </div>
            <div class="quick-menu-item">
              <i class="fas fa-tasks"></i>
              <div>할 일</div>
            </div>
            <div class="quick-menu-item">
              <i class="fas fa-shopping-basket"></i>
              <div>장보기</div>
            </div>
            <div class="quick-menu-item">
              <i class="fas fa-bullhorn"></i>
              <div>공지사항</div>
            </div>
            <div class="quick-menu-item">
              <i class="fas fa-images"></i>
              <div>앨범</div>
            </div>
            <div class="quick-menu-item">
              <i class="fas fa-vote-yea"></i>
              <div>투표</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="right-content">
      <div class="card">
        <div class="card-header">
          가족 캘린더
        </div>
        <div class="card-body">
          <div id="calendar" class="calendar"></div>
        </div>
      </div>
      <div class="card">
        <div class="card-header">
          공지사항
        </div>
        <div class="card-body">
          <p>작성된 알림장이 없습니다.</p>
        </div>
      </div>
      <div class="card">
        <div class="card-header">
          추억 앨범
        </div>
        <div class="card-body">
          <p>작성된 앨범이 없습니다.</p>
        </div>
      </div>
    </div>
  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>