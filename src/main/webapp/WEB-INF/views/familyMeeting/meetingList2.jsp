<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>가족 회의 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      font-family: 'Pretendard' !important;
      background-color: #ffffff;
    }
    .header {
      margin-bottom: 50px;
    }
    .header .h2 {
      font-family: 'pretendard' !important;
      font-weight: 600;
      font-size: 24px;
      color: #333c47;
      text-align: center;
      margin-bottom: 50px;
    }
    .meetingContainer {
      max-width: 900px;
      background-color: white;
      padding: 40px; 
      margin: 30px auto;
    }
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .home-icon:hover {color: #c6c6c6;}
    .meeting-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
      width: 230px;
      height: 300px;
      display: flex;
      flex-direction: column;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      box-sizing: border-box;
      background-color: #fff; 
    }
    .meeting-card:hover {
      transform: scale(1.02);
      box-shadow: 0 3px 6px rgba(0,0,0,0.07); 
    }
    .meeting-icon-container {
      height: 35%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 5px 0;
      background-color: #f0f5f1;
    }
    .meeting-icon {
      font-size: 36px;
      color: #b8c9bc;
    }
    .meeting-status {
      font-size: 12px;
      padding: 2px 5px;
      border-radius: 3px;
      color: white;
      display: inline-block;
      margin-bottom: 5px;
    }
    .meeting-status-upcoming { background-color: #84a98c; }
    .meeting-status-ongoing { background-color: #f4a261; }
    .meeting-status-completed { background-color: #6c757d; }
    .meeting-content {
      height: 55%;
      background-color:#fff;
      padding: 5px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .meeting-card h5 {
      margin: 5px 0;
      font-size: 16px;
      font-weight: bold;
      color: #333;
      overflow: hidden;
    }
    .meeting-card p {
      font-size: 14px;
      color: #555;
      margin-bottom: 5px;
      line-height: 1.4;
      overflow: hidden;
    }
    .meeting-card small {
      font-size: 12px;
      color: #777;
    }
    .btn {
      background-color: #84a98c;
      color: white;
      border: none;
      border-radius: 0px;
      padding: 8px 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-weight: 600;
      font-size: 14px;
    }
    .btn:hover {
      color: white;
      background-color: #6b8e76;
    }
    .cardList {
      background-color: #fff;
      color: #333;
      border: 1px solid #dbdbdb;
    }
    .cardList:hover {
      background-color: #d7d7d7;
      color: #333;
      border: 1px solid #dbdbdb;
    }
    .search-bar {
      display: flex;
      align-items: center;
    }
    select {
      background-color: white;
      border: 1px solid #dbdbdb;
      padding: 8px;
      font-size: 14px;
    }
    .meeting-list-item {
      border: 1px solid #ddd;
      padding: 15px;
      margin-bottom: 15px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      border-radius: 8px;
    }
    .meeting-list-item:hover {
      background-color: #f8f9fa; 
      transform: scale(1.01);
      box-shadow: 0 2px 4px rgba(0,0,0,0.05); 
    }
    .hidden {
      display: none;
    }
    .stats-card {
      background-color: #f8f9fa;
      border-left: 5px solid #84a98c;
    }
    .topic-card {
      background-color: #e9ecef;
    }
  </style>
  <script>
    'use strict';
    
    function viewMeetingDetails(idx) {
      location.href = "${ctp}/familyMeeting/meetingContent?idx=" + idx;
    }

    function addNewMeeting() {
      location.href = "${ctp}/familyMeeting/meetingInput";
    }

    function proposeTopic() {
      location.href = "${ctp}/familyMeeting/topicInput";
    }

    $(document).ready(function() {
      $("#statusFilter, #sortBy").change(function() {
        $("#meetingFilterForm").submit();
      });

      document.getElementById('cardViewBtn').addEventListener('click', function() {
        document.getElementById('cardView').classList.remove('hidden');
        document.getElementById('listView').classList.add('hidden');
      });

      document.getElementById('listViewBtn').addEventListener('click', function() {
        document.getElementById('listView').classList.remove('hidden');
        document.getElementById('cardView').classList.add('hidden');
      });
    });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="meetingContainer">
    <div class="header">
      <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
      <font size="5" class="mb-4 h2">가족 회의</font>
    </div>

    <!-- 회의 통계 섹션 -->
    <div class="row mb-4">
      <div class="col-md-3">
        <div class="card stats-card">
          <div class="card-body">
            <h5 class="card-title">전체 회의</h5>
            <h2 class="card-text">${totalMeetings}</h2>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card stats-card">
          <div class="card-body">
            <h5 class="card-title">완료된 회의</h5>
            <h2 class="card-text">${completedMeetings}</h2>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card stats-card">
          <div class="card-body">
            <h5 class="card-title">예정된 회의</h5>
            <h2 class="card-text">${upcomingMeetings}</h2>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card stats-card">
          <div class="card-body">
            <h5 class="card-title">이번 달 회의</h5>
            <h2 class="card-text">${thisMonthMeetings}</h2>
          </div>
        </div>
      </div>
    </div>

    <!-- 필터 및 버튼 -->
    <div class="d-flex justify-content-between mb-3">
      <div class="search-bar">
        <select class="form-control" id="statusFilter" name="statusFilter">
          <option value="">모든 상태</option>
          <option value="예정" ${statusFilter == '예정' ? 'selected' : ''}>예정</option>
          <option value="진행 중" ${statusFilter == '진행 중' ? 'selected' : ''}>진행 중</option>
          <option value="완료" ${statusFilter == '완료' ? 'selected' : ''}>완료</option>
        </select>
      </div>
      <div>
        <button class="btn cardList" id="cardViewBtn">안건 보기</button>
        <button class="btn cardList" id="listViewBtn">회의록 보기</button>
        <button type="button" class="btn" onclick="addNewMeeting()">
          <i class="fas fa-plus"></i> 새 회의 등록
        </button>
        <button type="button" class="btn" onclick="proposeTopic()">
          <i class="fas fa-lightbulb"></i> 안건 제안하기
        </button>
      </div>
    </div>

    <!-- 카드 뷰 -->
   <%--  <div id="cardView">
      <div class="row">
        <c:forEach var="vo" items="${vos}" varStatus="status">
          <div class="col-md-3 mb-4">
            <div class="meeting-card" onclick="viewMeetingDetails(${vo.idx})">
              <div>
                <span class="meeting-status ${vo.status == '예정' ? 'meeting-status-upcoming' : 
                                             vo.status == '진행 중' ? 'meeting-status-ongoing' : 
                                             'meeting-status-completed'}">
                  ${vo.status}
                </span>
              </div>
              <div class="meeting-icon-container">
                <i class="fas fa-users meeting-icon"></i>
              </div>
              <div class="meeting-content">
                <h5>${vo.title}</h5>
                <p>${fn:substring(vo.description, 0, 50)}${fn:length(vo.description) > 50 ? '...' : ''}</p>
                <small>일시: ${fn:substring(vo.meetingDate, 0, 16)}</small>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div> --%>

    <!-- 리스트 뷰 -->
    <div id="listView" class="hidden">
      <c:forEach var="vo" items="${vos}" varStatus="status">
        <div class="meeting-list-item" onclick="viewMeetingDetails(${vo.idx})">
          <div class="d-flex justify-content-between align-items-center">
            <h5 class="mb-1">${vo.title}</h5>
            <span class="meeting-status ${vo.status == '예정' ? 'meeting-status-upcoming' : 
                                         vo.status == '진행 중' ? 'meeting-status-ongoing' : 
                                         'meeting-status-completed'}">
              ${vo.status}
            </span>
          </div>
          <p class="mb-1">${fn:substring(vo.description, 0, 100)}${fn:length(vo.description) > 100 ? '...' : ''}</p>
          <small>일시: ${fn:substring(vo.meetingDate, 0, 16)}</small>
        </div>
      </c:forEach>
    </div>

    <!-- 제안된 안건 목록 -->
    <h3 class="mt-5 mb-3">제안된 안건</h3>
    <div class="row">
      <c:forEach var="topic" items="${proposedTopics}" varStatus="status">
        <div class="col-md-4 mb-4">
          <div class="card topic-card h-100">
            <div class="card-body">
              <h5 class="card-title">${topic.title}</h5>
              <p class="card-text"><small class="text-muted">제안자: ${topic.memberName}</small></p>
              <p class="card-text"><small class="text-muted">우선순위: ${topic.priority}</small></p>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- 페이지네이션 -->
    <div class="d-flex justify-content-center my-4">
      <ul class="pagination">
        <!-- 페이지네이션 로직 -->
      </ul>
    </div>

  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>