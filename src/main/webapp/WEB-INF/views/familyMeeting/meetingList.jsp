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
    .card {
      border: none;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      transition: all 0.3s;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }
    .meeting-icon {
      font-size: 2rem;
      color: #84a98c;
    }
    .meeting-status {
      font-size: 0.8rem;
      padding: 3px 8px;
      border-radius: 12px;
    }
    .meeting-status-upcoming { background-color: #84a98c; color: white; }
    .meeting-status-ongoing { background-color: #f4a261; color: white; }
    .meeting-status-completed { background-color: #e9ecef; color: #495057; }
    .btn-view-details {
      background-color: #84a98c;
      color: white;
      border: none;
    }
    .btn-view-details:hover {
      background-color: #52796f;
      color: white;
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
    });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="workContainer">
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
    <div class="row mb-4">
      <div class="col-md-3">
        <select class="form-control" id="statusFilter" name="statusFilter">
          <option value="">모든 상태</option>
          <option value="예정" ${statusFilter == '예정' ? 'selected' : ''}>예정</option>
          <option value="진행 중" ${statusFilter == '진행 중' ? 'selected' : ''}>진행 중</option>
          <option value="완료" ${statusFilter == '완료' ? 'selected' : ''}>완료</option>
        </select>
      </div>
      <div class="col-md-3">
        <select class="form-control" id="sortBy" name="sortBy">
          <option value="meetingDate" ${sortBy == 'meetingDate' ? 'selected' : ''}>날짜순</option>
          <option value="status" ${sortBy == 'status' ? 'selected' : ''}>상태순</option>
        </select>
      </div>
      <div class="col-md-3">
        <button type="button" class="btn btn-primary w-100" onclick="addNewMeeting()">
          <i class="fas fa-plus"></i> 새 회의 등록
        </button>
      </div>
      <div class="col-md-3">
        <button type="button" class="btn btn-secondary w-100" onclick="proposeTopic()">
          <i class="fas fa-lightbulb"></i> 안건 제안하기
        </button>
      </div>
    </div>

    <!-- 회의 목록 -->
    <div class="row" id="meetingList">
      <c:forEach var="vo" items="${vos}" varStatus="status">
        <div class="col-md-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <i class="fas fa-users meeting-icon"></i>
                <span class="meeting-status ${vo.status == '예정' ? 'meeting-status-upcoming' : 
                                             vo.status == '진행 중' ? 'meeting-status-ongoing' : 
                                             'meeting-status-completed'}">
                  ${vo.status}
                </span>
              </div>
              <h5 class="card-title">${vo.title}</h5>
              <p class="card-text">${fn:substring(vo.description, 0, 50)}${fn:length(vo.description) > 50 ? '...' : ''}</p>
              <p class="card-text"><small class="text-muted">일시: ${fn:substring(vo.meetingDate, 0, 16)}</small></p>
            </div>
            <div class="card-footer bg-transparent border-0">
              <button class="btn btn-sm btn-view-details w-100" onclick="viewMeetingDetails(${vo.idx})">자세히 보기</button>
            </div>
          </div>
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