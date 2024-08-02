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
    h1, h2, h3, h4, h5 {font-family: 'Pretendard' !important;}
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
      border-radius: 5px;
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
    select {
		  background-color: white;
		  border: 1px solid #dbdbdb;
		  padding: 8px;
		  font-size: 14px;
		  width: auto; /* 내용에 맞게 너비 조절 */
		  min-width: 120px; /* 최소 너비 설정 */
		}
		.search-bar {
		  display: flex;
		  align-items: center;
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
  	.nav-pills .nav-link.active {
      background-color: #84a98c;
    }
    .nav-pills .nav-link {
      color: #333;
    }
    
    .meetingList {
		  max-width: 800px; /* 전체 너비를 줄입니다 */
		  margin: 20px auto; /* 중앙 정렬을 위해 auto 마진 적용 */
		  /* padding : 15px; */
		}
		
		.meeting-list-item {
		  border: 1px solid #ddd;
		  padding: 10px 20px;
		  margin-bottom: 15px;
		  cursor: pointer;
		  overflow: hidden;
		  border-radius: 8px;
		  background-color: #fff;
		  transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.meeting-list-item:hover {
		  background-color: #f8f9fa; 
		  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		}
		
		.meeting-list-item h5 {
		  color: #333;
		  font-weight: 600;
		  margin-bottom: 10px;
		}
		
		.meeting-list-item p {
		  color: #4d4d4d;
		  font-size: 15px;
		  margin-bottom: 10px;
		  line-height: 1.4;
		}
		
		.meeting-list-item small {
		  color: #888;
		  font-size: 12px;
		  display: inline-block;
		  margin-right: 15px;
		}
		
		.meeting-status {
		  font-size: 12px;
		  padding: 3px 8px;
		  border-radius: 12px;
		  color: white;
		  font-weight: bold;
		  float: right;
		}
		
		.meeting-info {
		  margin-top: 10px;
		}
		
		.meeting-info i {
		  margin-right: 5px;
		  width: 16px;
		  text-align: center;
		}
		
		.btn-secondary {
		  background-color: #6c757d;
		  border-color: #6c757d;
		}
		
		.btn-secondary:hover {
		  background-color: #5a6268;
		  border-color: #5a6268;
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

    function viewProposedTopics() {
      location.href = "${ctp}/familyMeeting/topicList";
    }

    $(document).ready(function() {
      $("#statusFilter, #sortBy").change(function() {
        $("#hiddenStatusFilter").val($("#statusFilter").val());
        $("#hiddenSortBy").val($("#sortBy").val());
        $("#meetingFilterForm").submit();
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

    <form id="meetingFilterForm" action="${ctp}/familyMeeting/meetingList" method="get">
      <input type="hidden" name="statusFilter" id="hiddenStatusFilter">
      <input type="hidden" name="sortBy" id="hiddenSortBy">
    </form>

    <!-- 필터 및 버튼 -->
    <div class="d-flex justify-content-between mb-3">
      <div class="search-bar">
        <select class="form-control mr-2" id="statusFilter" name="statusFilter">
          <option value="">모든 상태</option>
          <option value="예정" ${statusFilter == '예정' ? 'selected' : ''}>예정</option>
          <%-- <option value="진행 중" ${statusFilter == '진행 중' ? 'selected' : ''}>진행 중</option> --%>
          <option value="완료" ${statusFilter == '완료' ? 'selected' : ''}>완료</option>
        </select>
        <select class="form-control" id="sortBy" name="sortBy">
          <option value="date" ${sortBy == 'date' ? 'selected' : ''}>날짜순</option>
          <option value="status" ${sortBy == 'status' ? 'selected' : ''}>상태순</option>
        </select>
      </div>
      <div>
        <button type="button" class="btn mr-1" onclick="addNewMeeting()">
          <i class="fas fa-plus"></i> 새 회의 등록
        </button>
        <button type="button" class="btn" onclick="viewProposedTopics()">제안된 안건 보기</button>
      </div>
    </div>

		<!-- 회의 목록 -->
		<div id="meetingList" class="meetingList">
		  <c:forEach var="vo" items="${vos}" varStatus="status">
		    <div class="meeting-list-item" onclick="viewMeetingDetails(${vo.idx})">
		      <div class="d-flex justify-content-between align-items-center">
		        <h5 class="mb-0">${vo.title}</h5>
		        <span class="meeting-status ${vo.status == '예정' ? 'meeting-status-upcoming' : 
		                                     vo.status == '진행 중' ? 'meeting-status-ongoing' : 
	                                     	'meeting-status-completed'}">
		          ${vo.status}
		        </span>
		      </div>
		      <p class="mt-2">${fn:substring(vo.description, 0, 100)}${fn:length(vo.description) > 100 ? '...' : ''}</p>
		      <div class="meeting-info">
		        <small><i class="fas fa-calendar-alt"></i> ${fn:substring(vo.meetingDate, 0, 16)}</small>
		        <small><i class="fas fa-list-ul"></i> 안건 ${vo.topicCount}개</small>
		        <small><i class="fas fa-user-tie"></i> 진행: ${vo.facilitatorName}</small>
		        <small><i class="fas fa-pen"></i> 기록: ${vo.recorderName}</small>
		      </div>
		    </div>
		  </c:forEach>
		</div>

    <!-- 페이지네이션 -->
		<div class="d-flex justify-content-center my-4">
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageVO.pag > 1}">
		      <li class="page-item">
		        <a class="page-link text-secondary" href="meetingList?pag=1&pageSize=${pageVO.pageSize}&statusFilter=${statusFilter}&sortBy=${sortBy}">첫페이지</a>
		      </li>
		    </c:if>
		    <c:if test="${pageVO.curBlock > 0}">
		      <li class="page-item">
		        <a class="page-link text-secondary" href="meetingList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}&statusFilter=${statusFilter}&sortBy=${sortBy}">이전블록</a>
		      </li>
		    </c:if>
		    <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
		      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
		        <li class="page-item active">
		          <a class="page-link bg-secondary border-secondary" href="meetingList?pag=${i}&pageSize=${pageVO.pageSize}&statusFilter=${statusFilter}&sortBy=${sortBy}">${i}</a>
		        </li>
		      </c:if>
		      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		        <li class="page-item">
		          <a class="page-link text-secondary" href="meetingList?pag=${i}&pageSize=${pageVO.pageSize}&statusFilter=${statusFilter}&sortBy=${sortBy}">${i}</a>
		        </li>
		      </c:if>
		    </c:forEach>
		    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		      <li class="page-item">
		        <a class="page-link text-secondary" href="meetingList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&statusFilter=${statusFilter}&sortBy=${sortBy}">다음블록</a>
		      </li>
		    </c:if>
		    <c:if test="${pageVO.pag < pageVO.totPage}">
		      <li class="page-item">
		        <a class="page-link text-secondary" href="meetingList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&statusFilter=${statusFilter}&sortBy=${sortBy}">마지막페이지</a>
		      </li>
		    </c:if>
		  </ul>
		</div>
    <!-- 블록페이지 끝 -->

  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>