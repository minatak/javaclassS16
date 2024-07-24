<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>우리 가족의 따뜻한 공간</title>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600&display=swap');

  body {
    font-family: 'Pretendard' !important;
    background-color: #faf3e0;
    color: #5d4037;
  }
  
  .content {
    max-width: 900px;
    margin: 40px auto;
    padding: 30px;
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 15px;
    box-shadow: 0 8px 32px rgba(93, 64, 55, 0.1);
  }
  
  h2 {
  	font-family: 'Pretendard' !important;
    color: #8d6e63;
    margin-bottom: 25px;
    font-weight: 500;
    text-align: center;
    font-size: 2.2rem;
  }
  
  .weather-banner {
    background: linear-gradient(45deg, #a1887f, #8d6e63);
    color: white;
    padding: 20px;
    border-radius: 15px;
    margin-bottom: 35px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 15px rgba(141, 110, 99, 0.2);
  }
  
  .weather-icon {
    width: 60px;
    height: 60px;
    margin-right: 20px;
  }
  
  .card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 6px 20px rgba(93, 64, 55, 0.08);
    margin-bottom: 30px;
    transition: all 0.4s ease;
    overflow: hidden;
  }
  
  .card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 28px rgba(93, 64, 55, 0.15);
  }
  
  .card-header {
    background: linear-gradient(45deg, #bcaaa4, #a1887f);
    color: white;
    font-weight: 500;
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    padding: 18px 25px;
    font-size: 1.2rem;
  }
  
  .card-body {
    padding: 25px;
    background-color: #fff8e1;
  }
  
  .list-group-item {
    border: none;
    padding: 12px 0;
    border-bottom: 1px dashed #d7ccc8;
    background-color: transparent;
    transition: all 0.3s ease;
  }
  
  .list-group-item:last-child {
    border-bottom: none;
  }
  
  .list-group-item:hover {
    background-color: #ffecb3;
    padding-left: 10px;
  }
  
  .view-all {
    font-size: 0.9rem;
    color: #ffffff;
    text-decoration: none;
    float: right;
    transition: all 0.3s ease;
  }
  
  .view-all:hover {
    text-decoration: none;
    color: #ffe0b2;
  }
  
  .empty-message {
    text-align: center;
    color: #8d6e63;
    font-size: 1rem;
    padding: 25px 0;
    font-style: italic;
  }
  
  .photo-preview {
    width: 100%;
    height: 180px;
    object-fit: cover;
    border-radius: 10px;
    transition: all 0.4s ease;
  }
  
  .photo-preview:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 20px rgba(93, 64, 55, 0.2);
  }

  a {
    color: #6d4c41;
    transition: all 0.3s ease;
  }

  a:hover {
    color: #4e342e;
    text-decoration: none;
  }

  .weather-advice {
    font-size: 1.1rem;
    line-height: 1.6;
  }
</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav.jsp" %>
<%@ include file = "/WEB-INF/views/include/side.jsp" %>
<main role="main" class="content">
  <h2>우리 가족의 아름다운 하루</h2>
  
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
      <i class="fas fa-users"></i> 다가오는 가족 모임
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
        <div class="empty-message">예정된 모임이 없어요. 새로운 추억을 만들어볼까요?</div>
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