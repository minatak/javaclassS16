<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HomeLink</title>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<style>
  body {
    font-family: 'pretendard' !important;
    background-color: #ffffff;
    color: #333;
  }
  
  .content {
    max-width: 900px;
    margin: 50px auto;
    padding: 40px;
    background-color: white;
  }
  
  h2 {
  	font-family: 'pretendard' !important;
    color: #333;
    margin-bottom: 30px;
    font-weight: 700;
  }
  
  .card {
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 30px;
    margin-bottom: 20px;
    cursor: pointer;
    background-color: #fff;
  }
  
  .card h4 {
  	font-family: 'pretendard' !important;
    color: #333;
    font-weight: 700;
    margin-bottom: 15px;
    font-size: 20px;
  }
  
  .section-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    border-bottom: 2px solid #84a98c;
    padding-bottom: 10px;
  }
  
  .view-all {
    font-size: 14px;
    color: #84a98c;
    text-decoration: none;
  }
  
  .view-all:hover {
    color: #6b8e76;
  }
  
  .empty-message {
    text-align: center;
    color: #777;
    font-size: 16px;
    margin-top: 20px;
  }
  
  .empty-message i {
    font-size: 36px;
    margin-bottom: 10px;
    color: #84a98c;
  }
</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav.jsp" %>
<%@ include file = "/WEB-INF/views/include/side.jsp" %>
<main role="main" class="content">
  
  <div class="card">
    <div class="section-title">
      <h4><i class="fas fa-cloud-sun"></i> 오늘의 날씨</h4>
    </div>
    <c:if test="${not empty weatherAdvice}">
    <div class="weather-info">
      <img src="http://openweathermap.org/img/wn/${weatherIconCode}@2x.png" alt="날씨 아이콘" class="weather-icon">
      <p class="weather-advice">${weatherAdvice}</p>
    </div>
    </c:if>
    <c:if test="${empty weatherAdvice}">
      <div class="empty-message">
        <i class="fas fa-cloud-sun"></i>
        <p>날씨 정보를 불러올 수 없습니다.</p>
      </div>
    </c:if>
  </div>

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
</main>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>