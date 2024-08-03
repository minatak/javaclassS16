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
    font-family: 'Pretendard', sans-serif !important;
    background-color: #ffffff;
    color: #333c47;
  }
  
  .content {
    max-width: 900px;
    margin: 40px auto;
    padding: 40px;
  }
  
  .header {
    margin-bottom: 50px;
  }

  .header .h2 {
    font-weight: 600;
    font-size: 24px;
    color: #333c47;
    text-align: center;
    margin-bottom: 50px;
  }
  
  .card {
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-bottom: 30px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    overflow: hidden;
  }
  
  .card:hover {
    transform: scale(1.02);
    box-shadow: 0 3px 6px rgba(0,0,0,0.07);
  }
  
  .card-header {
    background-color: #f0f5f1;
    color: #84a98c;
    font-weight: 600;
    padding: 15px 20px;
    border-bottom: 1px solid #ddd;
  }
  
  .card-body {
    padding: 20px;
    background-color: #fff;
  }
  
  .list-group-item {
    border: none;
    padding: 10px 0;
    border-bottom: 1px solid #f0f0f0;
    transition: background-color 0.3s ease;
  }
  
  .list-group-item:last-child {
    border-bottom: none;
  }
  
  .list-group-item:hover {
    background-color: #f8f9fa;
  }
  
  .view-all {
    font-size: 14px;
    color: #84a98c;
    text-decoration: none;
    float: right;
    transition: color 0.3s ease;
  }
  
  .view-all:hover {
    color: #6b8e76;
    text-decoration: none;
  }
  
  .empty-message {
    text-align: center;
    color: #6c757d;
    font-size: 14px;
    padding: 20px 0;
    font-style: italic;
  }
  
  .weather-banner {
    background-color: #f0f5f1;
    color: #333c47;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  }
  
  .weather-icon {
    width: 50px;
    height: 50px;
    margin-right: 20px;
  }
  
  .weather-advice {
    font-size: 16px;
    line-height: 1.5;
  }

  .photo-preview {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 8px;
    transition: transform 0.3s ease;
  }
  
  .photo-preview:hover {
    transform: scale(1.05);
  }

  a {
    color: #333c47;
    transition: color 0.3s ease;
  }

  a:hover {
    color: #84a98c;
    text-decoration: none;
  }
</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav.jsp" %>
<%@ include file = "/WEB-INF/views/include/side.jsp" %>
<main role="main" class="content">
  <div class="weather-banner">
    <c:if test="${not empty weatherAdvice}">
      <img src="http://openweathermap.org/img/wn/${weatherIconCode}@2x.png" alt="오늘의 날씨" class="weather-icon">
      <p class="weather-advice mb-0">${weatherAdvice}</p>
    </c:if>
    <c:if test="${empty weatherAdvice}">
      <p class="mb-0">날씨 정보를 불러올 수 없습니다. 하지만 우리의 하루는 언제나 밝고 따뜻할 거예요.</p>
    </c:if>
  </div>

  <div class="card">
    <div class="card-header">
      <i class="fas fa-heart"></i> 오늘 우리가 함께할 일
      <a href="${ctp}/housework/workMain" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="card-body">
      <c:if test="${not empty houseworks}">
        <ul class="list-group list-group-flush">
          <c:forEach items="${houseworks}" var="work" varStatus="status">
            <li class="list-group-item">${status.count}. ${work.description}</li>
          </c:forEach>
        </ul>
      </c:if>
      <c:if test="${empty houseworks}">
        <div class="empty-message">오늘은 특별한 할 일이 없어요. 가족과 함께 즐거운 시간 보내세요!</div>
      </c:if>
    </div>
  </div>
    
    
  <div class="card">
    <div class="card-header">
      <i class="fas fa-bell"></i> 우리 가족 소식
      <a href="${ctp}/notice/noticeList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="card-body">
      <c:if test="${not empty notices}">
        <ul class="list-group list-group-flush">
          <c:forEach items="${notices}" var="notice">
            <li class="list-group-item">
              <a href="${ctp}/notice/noticeContent?idx=${notice.idx}">${notice.title}</a>
            </li>
          </c:forEach>
        </ul>
      </c:if>
      <c:if test="${empty notices}">
        <div class="empty-message">새로운 소식이 없어요. 오늘 하루 어떠셨나요?</div>
      </c:if>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <i class="fas fa-users"></i> 다가오는 가족 회의
      <a href="${ctp}/familyMeeting/meetingList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="card-body">
      <c:if test="${not empty meetings}">
        <ul class="list-group list-group-flush">
          <c:forEach items="${meetings}" var="meeting">
            <li class="list-group-item">${meeting.title} - ${meeting.meetingDate}</li>
          </c:forEach>
        </ul>
      </c:if>
      <c:if test="${empty meetings}">
        <div class="empty-message">예정된 회의가 없어요.</div>
      </c:if>
    </div>
  </div>
    
  <div class="card">
    <div class="card-header">
      <i class="fas fa-poll"></i> 우리 가족의 선택
      <a href="${ctp}/vote/voteList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="card-body">
      <c:if test="${not empty votes}">
        <ul class="list-group list-group-flush">
          <c:forEach items="${votes}" var="vote">
            <li class="list-group-item">
              <a href="${ctp}/vote/voteContent?idx=${vote.idx}">${vote.title}</a>
            </li>
          </c:forEach>
        </ul>
      </c:if>
      <c:if test="${empty votes}">
        <div class="empty-message">진행 중인 투표가 없어요. 가족과 함께 결정할 일이 있나요?</div>
      </c:if>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <i class="fas fa-camera-retro"></i> 추억의 순간들
      <a href="${ctp}/photo/photoList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="card-body">
      <c:if test="${not empty photos}">
        <div class="row">
          <c:forEach items="${photos}" var="photo">
            <div class="col-md-3 mb-3">
              <a href="${ctp}/photo/photoContent?idx=${photo.idx}">
                <img src="${ctp}/thumbnail/${photo.thumbnail}" class="photo-preview" alt="가족 사진">
              </a>
            </div>
          </c:forEach>
        </div>
      </c:if>
      <c:if test="${empty photos}">
        <div class="empty-message">아직 추억이 없어요. 오늘 새로운 추억을 만들어볼까요?</div>
      </c:if>
    </div>
  </div>
</main>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>