<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HomeLink</title>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
<style>
  :root {
    --primary-color: #4a90e2;
    --secondary-color: #f5f7fa;
    --text-color: #333;
    --light-text-color: #6c757d;
    --border-color: #e0e0e0;
  }
  
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: var(--secondary-color);
    color: var(--text-color);
  }
  
  .content {
    max-width: 1200px;
    margin: 50px auto;
    padding: 0 20px;
  }
  
  .card {
    background-color: #fff;
    border: none;
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    padding: 25px;
    margin-bottom: 30px;
    transition: all 0.3s ease;
  }
  
  .card:hover {
    box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
    transform: translateY(-5px);
  }
  
  .card h4 {
    color: var(--primary-color);
    font-weight: 700;
    margin-bottom: 20px;
    font-size: 22px;
  }
  
  .btn-custom {
    background-color: var(--primary-color);
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-size: 16px;
    transition: background-color 0.3s ease;
  }
  
  .btn-custom:hover {
    background-color: #3a7bd5;
  }
  
  .photo-preview {
    width: 100%;
    height: 180px;
    object-fit: cover;
    border-radius: 8px;
    transition: transform 0.3s ease;
  }
  
  .photo-preview:hover {
    transform: scale(1.05);
  }
  
  ul {
    list-style-type: none;
    padding-left: 0;
  }
  
  li {
    margin-bottom: 12px;
    font-size: 16px;
    display: flex;
    align-items: center;
  }
  
  li i {
    margin-right: 10px;
    color: var(--primary-color);
  }
  
  a {
    color: var(--primary-color);
    text-decoration: none;
    transition: color 0.3s ease;
  }
  
  a:hover {
    color: #3a7bd5;
  }
  
  .section-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    border-bottom: 2px solid var(--primary-color);
    padding-bottom: 10px;
  }
  
  .view-all {
    font-size: 16px;
    color: var(--primary-color);
  }
  
  .weather-icon {
    width: 120px;
    height: 120px;
    margin-bottom: 20px;
  }
  
  .weather-info {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    text-align: center;
  }
  
  .weather-description {
    font-size: 24px;
    font-weight: 500;
    margin-bottom: 15px;
    color: var(--primary-color);
  }
  
  .weather-advice {
    font-size: 16px;
    color: var(--light-text-color);
    margin-top: 15px;
  }
  
  .empty-message {
    text-align: center;
    color: var(--light-text-color);
    font-size: 18px;
    margin-top: 20px;
  }
  
  .empty-message i {
    font-size: 48px;
    margin-bottom: 10px;
    color: var(--primary-color);
  }
</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav.jsp" %>
<%@ include file = "/WEB-INF/views/include/side.jsp" %>
<main role="main" class="content">
  <div class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="section-title">
          <h4><i class="fas fa-cloud-sun"></i> 오늘의 날씨</h4>
        </div>
        <c:if test="${not empty weatherDescription}">
        <div class="weather-info">
          <img src="http://openweathermap.org/img/wn/${weatherIconCode}@2x.png" alt="날씨 아이콘" class="weather-icon">
          <p class="weather-description">${weatherDescription}</p>
          <p class="weather-advice">${weatherAdvice}</p>
        </div>
        </c:if>
        <c:if test="${empty weatherDescription}">
          <div class="empty-message">
            <i class="fas fa-cloud-sun"></i>
            <p>날씨 정보를 불러올 수 없습니다.</p>
          </div>
        </c:if>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card">
        <div class="section-title">
          <h4><i class="fas fa-tasks"></i> 오늘의 할일</h4>
          <a href="${ctp}/housework/workMain" class="view-all">전체보기 <i class="fas fa-arrow-right"></i></a>
        </div>
        <c:if test="${not empty houseworks}">
          <ul>
            <c:forEach items="${houseworks}" var="work">
              <li><i class="fas fa-check-circle"></i> ${work.description}</li>
            </c:forEach>
          </ul>
        </c:if>
        <c:if test="${empty houseworks}">
          <div class="empty-message">
            <i class="fas fa-clipboard-list"></i>
            <p>오늘의 할일이 없습니다.</p>
          </div>
        </c:if>
      </div>
    </div>
  </div>
  
  <div class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="section-title">
          <h4>최근 공지사항</h4>
          <a href="${ctp}/notice/noticeList" class="view-all">전체보기</a>
        </div>
        <c:if test="${not empty notices}">
          <ul>
            <c:forEach items="${notices}" var="notice">
              <li><a href="${ctp}/notice/noticeContent?idx=${notice.idx}">${notice.title}</a></li>
            </c:forEach>
          </ul>
        </c:if>
        <c:if test="${empty notices}">
          <div class="empty-message">
            <i class="fas fa-bullhorn"></i>
            <p>등록된 공지사항이 없습니다.</p>
          </div>
        </c:if>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card">
        <div class="section-title">
          <h4>예정된 회의</h4>
          <a href="${ctp}/familyMeeting/meetingList" class="view-all">전체보기</a>
        </div>
        <c:if test="${not empty meetings}">
          <ul>
            <c:forEach items="${meetings}" var="meeting">
              <li>${meeting.title} - ${meeting.meetingDate}</li>
            </c:forEach>
          </ul>
        </c:if>
        <c:if test="${empty meetings}">
          <div class="empty-message">
            <i class="fas fa-users"></i>
            <p>예정된 회의가 없습니다.</p>
          </div>
        </c:if>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="section-title">
          <h4>진행 중인 투표</h4>
          <a href="${ctp}/vote/voteList" class="view-all">전체보기</a>
        </div>
        <c:if test="${not empty votes}">
          <ul>
            <c:forEach items="${votes}" var="vote">
              <li><a href="${ctp}/vote/voteContent?idx=${vote.idx}">${vote.title}</a></li>
            </c:forEach>
          </ul>
        </c:if>
        <c:if test="${empty votes}">
          <div class="empty-message">
            <i class="fas fa-vote-yea"></i>
            <p>진행 중인 투표가 없습니다.</p>
          </div>
        </c:if>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card">
        <div class="section-title">
          <h4>최근 사진</h4>
          <a href="${ctp}/photo/photoList" class="view-all">전체보기</a>
        </div>
        <c:if test="${not empty photos}">
          <div class="row">
            <c:forEach items="${photos}" var="photo">
              <div class="col-md-4 mb-3">
                <a href="${ctp}/photo/photoContent?idx=${photo.idx}">
                  <img src="${ctp}/thumbnail/${photo.thumbnail}" class="photo-preview">
                </a>
              </div>
            </c:forEach>
          </div>
        </c:if>
        <c:if test="${empty photos}">
          <div class="empty-message">
            <i class="fas fa-images"></i>
            <p>등록된 사진이 없습니다.</p>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</main>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>