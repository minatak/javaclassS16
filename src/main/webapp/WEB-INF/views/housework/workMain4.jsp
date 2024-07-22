<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>가사 분담 목록 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: 'Pretendard' !important;
      background-color: #ffffff;
    }
    .workContainer {
      max-width: 1000px;
      background-color: white;
      padding: 40px;
      margin: 30px auto;
    } 
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .home-icon:hover {color: #c6c6c6;}
    h2 {
      font-family: 'Pretendard' !important;
      color: #333;
      margin-bottom: 30px;
      font-weight: 700;
    }
    h3 {
      font-family: 'Pretendard' !important;
      color: #333;
      margin-bottom: 30px;
      font-weight: 700;
    }
    .work-card {
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
    .work-card:hover {
      transform: scale(1.02);
      box-shadow: 0 3px 6px rgba(0,0,0,0.07); 
    }
    .work-icon-container {
      height: 35%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 5px 0;
      background-color: #f0f5f1;
    }
    .work-icon {
      font-size: 36px;
      color: #b8c9bc;
    }
    .days-left {
      margin-top: 5px;
      font-size: 14px;
      color: #84a98c;
      font-weight: bold;
    }
    .work-content {
      height: 55%;
      background-color:#fff;
      padding: 5px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .work-status {
      font-size: 12px;
      padding: 2px 5px;
      border-radius: 3px;
      color: white;
      display: inline-block;
      margin-bottom: 5px;
    }
    .work-status-ongoing {
      background-color: #84a98c;
    }
    .work-status-completed {
      background-color: #6c757d;
    }
    .work-card h5 {
      margin: 5px 0;
      font-size: 16px;
      font-weight: bold;
      color: #333;
      overflow: hidden;
    }
    .work-card p {
      font-size: 14px;
      color: #555;
      margin-bottom: 5px;
      line-height: 1.4;
      overflow: hidden;
    }
    .work-card small {
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
    .work-list-item {
      border: 1px solid #ddd;
      padding: 15px;
      margin-bottom: 15px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      cursor: pointer;
      border-radius: 8px;
    }
    .work-list-item:hover {
      background-color: #f8f9fa; 
      transform: scale(1.01);
      box-shadow: 0 2px 4px rgba(0,0,0,0.05); 
    }
    .hidden {
      display: none;
    }
     .progress-section {
      margin-bottom: 30px;
    }
    .progress {
      height: 25px;
    }
    .progress-bar {
      line-height: 25px;
    }
    .member-progress {
      margin-bottom: 15px;
    }
     .btn-primary {
      background-color: #84a98c;
      border: none;
    }
    .btn-primary:hover {
      background-color: #6b8e76;
    }
    .progress {
      height: 10px;
      border-radius: 5px;
    }
    .progress-bar {
      background-color: #84a98c;
    }
    .task-card {
      height: 100%;
    }
    .task-icon {
      font-size: 2rem;
      color: #84a98c;
    }
    .task-status {
      font-size: 0.8rem;
      padding: 3px 8px;
      border-radius: 20px;
    }
    .task-status-ongoing {
      background-color: #ffd166;
      color: #333;
    }
    .task-status-completed {
      background-color: #06d6a0;
      color: white;
    }
    .filters {
      background-color: white;
      padding: 15px;
      border-radius: 10px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
  </style>
  <script>
  	'use strict';
  	
  	
  	
  	function addNewTask() {
  	  var taskData = {
  	    category: $('#taskCategory').val(),
  	    task: $('#taskName').val(),
  	    description: $('#taskDescription').val(),
  	    startDate: new Date().toISOString().split('T')[0],
  	    endDate: $('#taskDueDate').val(),
  	    rotationPeriod: 7 // 기본값으로 7일 설정
  	  };

  	  $.ajax({
  	    url: '${ctp}/housework/addTask',
  	    type: 'POST',
  	    data: taskData,
  	    success: function(response) {
  	      if(response.success) {
  	        alert('새로운 할 일이 등록되었습니다.');
  	        location.reload();
  	      } else {
  	        alert('할 일 등록에 실패했습니다.');
  	      }
  	    },
  	    error: function() {
  	      alert('서버 오류가 발생했습니다.');
  	    }
  	  });
  	}

  	function updateTaskStatus(taskId, newStatus) {
  	  var memberId = ${sMid}; // 세션에서 현재 로그인한 사용자의 ID를 가져옵니다.

  	  $.ajax({
  	    url: '${ctp}/housework/updateTaskStatus',
  	    type: 'POST',
  	    data: {
  	    	houseworkIdx: houseworkIdx,
  	      newStatus: newStatus,
  	      memberId: memberId
  	    },
  	    success: function(response) {
  	      if(response.success) {
  	        alert('작업 상태가 업데이트되었습니다.');
  	        location.reload();
  	      } else {
  	        alert('작업 상태 업데이트에 실패했습니다.');
  	      }
  	    },
  	    error: function() {
  	      alert('서버 오류가 발생했습니다.');
  	    }
  	  });
  	}
  	
  	 function showMyTasks() {
  	      // AJAX 요청을 통해 현재 사용자의 할 일만 불러오기
  	      $.ajax({
  	        url: '${ctp}/housework/myTasks',
  	        type: 'GET',
  	        success: function(response) {
  	          // 응답으로 받은 할 일 목록으로 화면 업데이트
  	          updateTaskList(response);
  	        },
  	        error: function() {
  	          alert('내 할 일을 불러오는데 실패했습니다.');
  	        }
  	      });
  	    }

  	    function updateTaskList(tasks) {
  	      var taskListHtml = '';
  	      tasks.slice(0, 6).forEach(function(task) {
  	        taskListHtml += `
  	          <div class="col-md-4 mb-4">
  	            <div class="card task-card">
  	              <div class="card-body">
  	                <div class="d-flex justify-content-between align-items-center mb-3">
  	                  <i class="fas fa-tasks task-icon"></i>
  	                  <span class="task-status ${task.status == '진행중' ? 'task-status-ongoing' : 'task-status-completed'}">
  	                    ${task.status}
  	                  </span>
  	                </div>
  	                <h5 class="card-title">${task.category} - ${task.task}</h5>
  	                <p class="card-text">${fn:substring(task.description, 0, 50)}${fn:length(task.description) > 50 ? '...' : ''}</p>
  	                <p class="card-text"><small class="text-muted">담당: ${task.memberName}</small></p>
  	                <p class="card-text"><small class="text-muted">마감일: ${task.endDate}</small></p>
  	                <p class="card-text"><small class="text-muted">남은 일수: ${task.daysLeft}일</small></p>
  	                <button class="btn btn-sm btn-outline-primary" onclick="viewTaskDetails(${task.idx})">자세히 보기</button>
  	              </div>
  	            </div>
  	          </div>
  	        `;
  	      });
  	      
  	      if (tasks.length > 6) {
  	        taskListHtml += `
  	          <div class="col-12 text-center">
  	            <button class="btn btn-link" onclick="showAllTasks()">더 보기...</button>
  	          </div>
  	        `;
  	      }
  	      
  	      $('#taskList').html(taskListHtml);
  	    }

  	  let currentlyShown = 6;
  	const totalTasks = ${fn:length(vos)};

  	function showMoreTasks() {
  	  const taskItems = document.querySelectorAll('.task-item.hidden');
  	  const itemsToShow = Math.min(6, taskItems.length);
  	  
  	  for (let i = 0; i < itemsToShow; i++) {
  	    taskItems[i].classList.remove('hidden');
  	  }
  	  
  	  currentlyShown += itemsToShow;
  	  
  	  if (currentlyShown >= totalTasks) {
  	    document.getElementById('showMoreBtn').style.display = 'none';
  	  }
  	}

  	function viewTaskDetails(taskId) {
  	  // AJAX를 사용하여 서버에서 task 세부 정보를 가져옵니다.
  	  $.ajax({
  	    url: '${ctp}/housework/getTaskDetails',
  	    type: 'GET',
  	  	data: { houseworkIdx: idx },
  	    success: function(response) {
  	      // 모달을 생성하고 세부 정보를 표시합니다.
  	      var modal = `
  	        <div class="modal fade" id="taskDetailModal" tabindex="-1" role="dialog" aria-labelledby="taskDetailModalLabel" aria-hidden="true">
  	          <div class="modal-dialog" role="document">
  	            <div class="modal-content">
  	              <div class="modal-header">
  	                <h5 class="modal-title" id="taskDetailModalLabel">할 일 세부 정보</h5>
  	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	                  <span aria-hidden="true">&times;</span>
  	                </button>
  	              </div>
  	              <div class="modal-body">
  	                <h4>${response.taskName}</h4>
  	                <p><strong>카테고리:</strong> ${response.category}</p>
  	                <p><strong>설명:</strong> ${response.description}</p>
  	                <p><strong>담당자:</strong> ${response.memberName}</p>
  	                <p><strong>상태:</strong> ${response.status}</p>
  	                <p><strong>시작일:</strong> ${response.startDate}</p>
  	                <p><strong>마감일:</strong> ${response.endDate}</p>
  	                <p><strong>남은 일수:</strong> ${response.daysLeft}일</p>
  	              </div>
  	              <div class="modal-footer">
  	                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
  	              </div>
  	            </div>
  	          </div>
  	        </div>
  	      `;
  	      
  	      // 기존 모달이 있다면 제거
  	      $('#taskDetailModal').remove();
  	      
  	      // 새 모달을 body에 추가하고 표시
  	      $('body').append(modal);
  	      $('#taskDetailModal').modal('show');
  	    },
  	    error: function() {
  	      alert('할 일 세부 정보를 불러오는데 실패했습니다.');
  	    }
  	  });
  	}
  	
  	document.addEventListener('DOMContentLoaded', function() {
  	    // 필터 요소들 선택
  	    var categoryFilter = document.getElementById('categoryFilter');
  	    var statusFilter = document.getElementById('statusFilter');
  	    var memberFilter = document.getElementById('memberFilter');
  	    var sortFilter = document.getElementById('sortFilter');

  	    // 필터 요소들이 존재하는 경우에만 이벤트 리스너 추가
  	    if (categoryFilter && statusFilter && memberFilter && sortFilter) {
  	        categoryFilter.addEventListener('change', getFilteredTasks);
  	        statusFilter.addEventListener('change', getFilteredTasks);
  	        memberFilter.addEventListener('change', getFilteredTasks);
  	        sortFilter.addEventListener('change', getFilteredTasks);
  	    }

  	    // 초기 데이터 로드
  	    getFilteredTasks();
  	});

  	function getFilteredTasks() {
  	    var category = document.getElementById('categoryFilter')?.value || '';
  	    var status = document.getElementById('statusFilter')?.value || '';
  	    var memberIdx = document.getElementById('memberFilter')?.value || '';
  	    var sortBy = document.getElementById('sortFilter')?.value || '';

  	    $.ajax({
  	        url: '/javaclassS16/housework/getFilteredTasks',
  	        type: 'GET',
  	        data: {
  	            category: category,
  	            status: status,
  	            memberIdx: memberIdx,
  	            sortBy: sortBy
  	        },
  	        success: function(response) {
  	            updateTaskTable(response.tasks);
  	            updatePagination(response.pageVO);
  	        },
  	        error: function(xhr, status, error) {
  	            console.error("Error fetching filtered tasks:", error);
  	            alert('할 일 목록을 불러오는데 실패했습니다. 다시 시도해주세요.');
  	        }
  	    });
  	}
  	function updateTaskTable(tasks) {
  	    var tableBody = document.querySelector('#taskTable tbody');
  	    if (!tableBody) return;

  	    tableBody.innerHTML = ''; // 테이블 내용 초기화

  	    tasks.forEach(function(task) {
  	        var row = tableBody.insertRow();
  	        row.insertCell(0).textContent = task.category;
  	        row.insertCell(1).textContent = task.task;
  	        // ... 나머지 열 추가

  	        // '자세히 보기' 버튼 추가
  	        var detailCell = row.insertCell();
  	        var detailButton = document.createElement('button');
  	        detailButton.textContent = '자세히 보기';
  	        detailButton.onclick = function() { viewTaskDetails(task.idx); };
  	        detailCell.appendChild(detailButton);
  	    });
  	}

  	function viewTaskDetails(taskId) {
  	    if (!taskId) {
  	        console.error("Task ID is undefined");
  	        return;
  	    }

  	    $.ajax({
  	        url: '/javaclassS16/housework/getTaskDetails',
  	        type: 'GET',
  	        data: { houseworkIdx: taskId },
  	        success: function(response) {
  	            // 상세 정보를 모달이나 다른 방식으로 표시
  	            console.log(response);
  	            // TODO: 상세 정보 표시 로직 구현
  	        },
  	        error: function(xhr, status, error) {
  	            console.error("Error fetching task details:", error);
  	            alert('상세 정보를 불러오는데 실패했습니다.');
  	        }
  	    });
  	}

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <div class="workContainer">
    <div style="display: flex; align-items: center; gap: 20px;" class="mb-5"> 
      <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
      <h2 class="mb-4">우리 집 가사 관리</h2>
    </div>

  <!-- 대시보드 섹션 -->
<div class="row mb-4">
  <div class="col-md-3">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">전체 할 일</h5>
        <h2 class="card-text">${dashboardData.totalTasks}</h2>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">완료한 일</h5>
        <h2 class="card-text">${dashboardData.completedTasks}</h2>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">진행 중인 일</h5>
        <h2 class="card-text">${dashboardData.ongoingTasks}</h2>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">오늘의 할 일</h5>
        <h2 class="card-text">${dashboardData.todayTasks}</h2>
      </div>
    </div>
  </div>
</div>

  <button class="btn btn-secondary mb-4 mr-2" onclick="showMyTasks()">
      <i class="fas fa-user"></i> 내가 해야하는 일만 보기
    </button>

    <!-- 할 일 등록 버튼 -->
    <button class="btn btn-primary mb-4" data-toggle="modal" data-target="#addTaskModal">
      <i class="fas fa-plus"></i> 새로운 할 일 등록
    </button>

    <!-- 가족 구성원별 진행률 섹션 -->
		<div class="card mb-4">
		  <div class="card-body">
		    <h3 class="card-title">가족 구성원별 진행률</h3>
		    <c:forEach var="member" items="${familyMembers}">
		      <div class="mb-3">
		        <div class="d-flex justify-content-between align-items-center mb-1">
		          <span>${member.memberName}</span>
		          <span>${String.format("%.1f", member.progressPercentage)}%</span>
		        </div>
		        <div class="progress">
		          <div class="progress-bar" role="progressbar" style="width: ${member.progressPercentage}%;" 
		               aria-valuenow="${member.progressPercentage}" aria-valuemin="0" aria-valuemax="100">
		          </div>
		        </div>
		      </div>
		    </c:forEach>
		  </div>
		</div>


  <!-- 필터 및 정렬 -->
  <div class="filters mb-4">
    <div class="row">
      <div class="col-md-3">
        <select class="form-control" id="categoryFilter">
          <option value="">모든 카테고리</option>
          <option value="청소">청소</option>
          <option value="설거지">설거지</option>
          <option value="빨래">빨래</option>
          <option value="요리">요리</option>
        </select>
      </div>
      <div class="col-md-3">
        <select class="form-control" id="statusFilter">
          <option value="">모든 상태</option>
          <option value="ongoing">진행 중</option>
          <option value="completed">완료</option>
        </select>
      </div>
      <div class="col-md-3">
        <select class="form-control" id="memberFilter" >
          <option value="">모든 구성원</option>
          <c:forEach var="member" items="${familyMembers}">
            <option value="${member.memberId}">${member.memberName}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-3">
        <select class="form-control" id="sortBy">
          <option value="dueDate">마감일순</option>
          <option value="priority">우선순위순</option>
          <option value="category">카테고리순</option>
        </select>
      </div>
    </div>
  </div>

  <!-- 할 일 목록 -->
	<div class="row" id="taskList">
  <c:forEach var="task" items="${vos}" varStatus="status">
    <div class="col-md-4 mb-4 task-item ${status.index >= 6 ? 'hidden' : ''}">
      <div class="card task-card">
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <i class="fas fa-tasks task-icon"></i>
            <span class="task-status ${task.status == 'ONGOING' ? 'task-status-ongoing' : 'task-status-completed'}">
              ${task.status == 'ONGOING' ? '진행 중' : '완료'}
            </span>
          </div>
          <h5 class="card-title">${task.category} - ${task.taskName}</h5>
          <p class="card-text">${fn:substring(task.description, 0, 50)}${fn:length(task.description) > 50 ? '...' : ''}</p>
          <p class="card-text"><small class="text-muted">담당: ${task.memberName}</small></p>
          <p class="card-text"><small class="text-muted">마감일: ${fn:substring(task.endDate, 0, 10)}</small></p>
          <p class="card-text"><small class="text-muted">남은 일수: ${task.daysLeft}일</small></p>
          <button class="btn btn-sm btn-outline-primary" onclick="viewTaskDetails(${task.id})">자세히 보기</button>
        </div>
      </div>
    </div>
  </c:forEach>
</div>

<c:if test="${fn:length(vos) > 6}">
  <div class="col-12 text-center">
    <button id="showMoreBtn" class="btn btn-link" onclick="showMoreTasks()">더 보기...</button>
  </div>
</c:if>

</div>

  <!-- 블록페이지 시작 -->
		<div class="d-flex justify-content-center my-4">
		  <ul class="pagination">
		    <c:if test="${pageVO.pag > 1}">
		      <li><a href="workMain?pag=1&pageSize=${pageVO.pageSize}">처음</a></li>
		    </c:if>
		    <c:if test="${pageVO.curBlock > 0}">
		      <li><a href="workMain?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">&laquo;</a></li>
		    </c:if>
		    <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
		      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
		        <li class="active"><a href="workMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li>
		      </c:if>
		      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		        <li><a href="workMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li>
		      </c:if>
		    </c:forEach>
		    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		      <li><a href="workMain?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">&raquo;</a></li>
		    </c:if>
		    <c:if test="${pageVO.pag < pageVO.totPage}">
		      <li><a href="workMain?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">끝</a></li>
		    </c:if>
		  </ul>
		</div>
		<!-- 블록페이지 끝 -->

<!-- 할 일 등록 모달 -->
<div class="modal fade" id="addTaskModal" tabindex="-1" role="dialog" aria-labelledby="addTaskModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addTaskModalLabel">새로운 할 일 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="addTaskForm">
          <div class="form-group">
            <label for="taskCategory">카테고리</label>
            <select class="form-control" id="taskCategory" required>
              <option value="청소">청소</option>
              <option value="설거지">설거지</option>
              <option value="빨래">빨래</option>
              <option value="요리">요리</option>
            </select>
          </div>
          <div class="form-group">
            <label for="taskName">할 일 이름</label>
            <input type="text" class="form-control" id="taskName" required>
          </div>
          <div class="form-group">
            <label for="taskDescription">설명</label>
            <textarea class="form-control" id="taskDescription" rows="3"></textarea>
          </div>
          <div class="form-group">
            <label for="taskAssignee">담당자</label>
            <select class="form-control" id="taskAssignee" required>
              <c:forEach var="member" items="${familyMembers}">
                <option value="${member.memberId}">${member.memberName}</option>
              </c:forEach>
            </select>
          </div>
          <div class="form-group">
            <label for="taskDueDate">마감일</label>
            <input type="date" class="form-control" id="taskDueDate" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="addNewTask()">등록</button>
      </div>
    </div>
  </div>
</div>
  
</div>  
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('cardViewBtn').addEventListener('click', function() {
    document.getElementById('cardView').classList.remove('hidden');
    document.getElementById('listView').classList.add('hidden');
  });

  document.getElementById('listViewBtn').addEventListener('click', function() {
    document.getElementById('listView').classList.remove('hidden');
    document.getElementById('cardView').classList.add('hidden');
  });
</script>
</body>
</html>