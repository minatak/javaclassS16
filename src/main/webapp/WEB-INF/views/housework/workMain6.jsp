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
      font-family: 'Pretendard', sans-serif;
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
    .home-icon:hover {
      color: #c6c6c6;
    }
    h2, h3 {
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
    .hidden {
      display: none;
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
    
     .modal-content {
      border-radius: 15px;
    }
    .modal-header {
      background-color: #84a98c;
      color: white;
      border-top-left-radius: 15px;
      border-top-right-radius: 15px;
    }
    .modal-body {
      padding: 20px;
    }
    .modal-footer {
      border-bottom-left-radius: 15px;
      border-bottom-right-radius: 15px;
    }
    .form-control:focus {
      border-color: #84a98c; 
      box-shadow: 0 0 0 0.2rem rgba(132, 169, 140, 0.25);
    }
    .btn-primary {
      background-color: #84a98c;
      border-color: #84a98c;
    }
    .btn-primary:hover {
      background-color: #6b8e76;
      border-color: #6b8e76;
    }
    .task-template {
      margin-bottom: 10px;
    }
    .switch {
      position: relative;
      display: inline-block;
      width: 60px;
      height: 34px;
    }

    .switch input {
      opacity: 0;
      width: 0;
      height: 0;
    }

    .slider {
      position: absolute;
      cursor: pointer;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: #ccc;
      transition: .4s;
      border-radius: 34px;
    }

    .slider:before {
      position: absolute;
      content: "";
      height: 26px;
      width: 26px;
      left: 4px;
      bottom: 4px;
      background-color: white;
      transition: .4s;
      border-radius: 50%;
    }

    input:checked + .slider {
      background-color: #84a98c;
    }

    input:checked + .slider:before {
      transform: translateX(26px);
    }

    .switch-label {
      margin-left: 10px;
      vertical-align: super;
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
        endTime: $('#taskDueTime').val(),
        rotationPeriod: 7
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

    function updateTaskStatus(houseworkIdx, newStatus) {
      var memberId = ${sMid};

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

   /*  function showMyTasks() {
      location.href = '${ctp}/housework/workMain?flag=mine';
    } */

    function getFilteredTasks() {
      let category = $("#categoryFilter").val();
      let status = $("#statusFilter").val();
      let memberFilter = $("#memberFilter").val();
      let sortBy = $("#sortBy").val();
      
      location.href = "${ctp}/housework/workMain?category="+category+"&status="+status+"&memberFilter="+memberFilter+"&sortBy="+sortBy;
    }
    
    function viewTaskDetails(idx) {
  	  $.ajax({
  	    url: '${ctp}/housework/getTaskDetails',
  	    type: 'GET',
  	    data: { houseworkIdx: idx },   
  	    success: function(response) {
  	      // 모달 내용 업데이트
  	      $('#taskTitle').text(response.task);
  	      $('#taskCategory').text(response.category);
  	      $('#taskDescription').text(response.description || '설명 없음');
  	      $('#taskMemberName').text(response.memberName);
  	      $('#taskStatus').text(response.status);
  	      $('#taskStartDate').text(response.startDate);
  	      $('#taskEndDate').text(response.endDate);
  	      $('#taskDaysLeft').text(response.daysLeft);
  	      $('#taskRotationPeriod').text(response.rotationPeriod);

  	      // 버튼 업데이트
  	      var buttonsHtml = '';
  	      if (response.currentUserId === response.memberIdx) {
  	        buttonsHtml += `
  	          <button type="button" class="btn btn-primary" onclick="editTask(${response.idx})">수정</button>
  	          <button type="button" class="btn btn-danger" onclick="deleteTask(${response.idx})">삭제</button>
  	          <button type="button" class="btn btn-success" onclick="completeTask(${response.idx})">완료</button>
  	        `;
  	      }
  	      $('#taskButtons').html(buttonsHtml);

  	      // 모달 표시
  	      $('#taskDetailModal').modal('show');
  	    },
  	    error: function(xhr, status, error) {
  	      console.error("Error fetching task details:", error);
  	      alert('할 일 세부 정보를 불러오는데 실패했습니다.');
  	    }
  	  });
  	}

  	function editTask(idx) {
  	  // 수정 기능 구현
  	  window.location.href = '${pageContext.request.contextPath}/housework/edit?idx=' + idx;
  	}

  	function deleteTask(idx) {
  	  if (confirm('정말로 이 할 일을 삭제하시겠습니까?')) {
  	    $.ajax({
  	      url: '${pageContext.request.contextPath}/housework/delete',
  	      type: 'POST',
  	      data: { houseworkIdx: idx },
  	      success: function(response) {
  	        alert('할 일이 삭제되었습니다.');
  	        $('#taskDetailModal').modal('hide');
  	        // 필요한 경우 페이지 새로고침 또는 목록 갱신
  	        location.reload();
  	      },
  	      error: function(xhr, status, error) {
  	        console.error("Error deleting task:", error);
  	        alert('할 일 삭제에 실패했습니다.');
  	      }
  	    });
  	  }
  	}

  	function completeTask(idx) {
  	  $.ajax({
  	    url: '${pageContext.request.contextPath}/housework/complete',
  	    type: 'POST',
  	    data: { houseworkIdx: idx },
  	    success: function(response) {
  	      alert('할 일이 완료되었습니다.');
  	      $('#taskDetailModal').modal('hide');
  	      // 필요한 경우 페이지 새로고침 또는 목록 갱신
  	      location.reload();
  	    },
  	    error: function(xhr, status, error) {
  	      console.error("Error completing task:", error);
  	      alert('할 일 완료 처리에 실패했습니다.');
  	    }
  	  });
  	}

    function selectTemplate() {
      var template = $('#taskTemplate').val();
      if (template) {
        var [category, name, description] = template.split('|');
        $('#taskCategory').val(category);
        $('#taskName').val(name);
        $('#taskDescription').val(description);
      }
    }

    function toggleMyTasks() {
      var isChecked = $('#myTasksToggle').is(':checked');
      location.href = '${ctp}/housework/workMain?flag=' + (isChecked ? 'mine' : '');
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

		<!-- 내가 하는 일만 보기/전체보기 토글 스위치 -->
    <div class="mb-4">
      <label class="switch">
        <input type="checkbox" id="myTasksToggle" onchange="toggleMyTasks()" ${param.flag == 'mine' ? 'checked' : ''}>
        <span class="slider"></span>
      </label>
      <span class="switch-label">내가 하는 일만 보기</span>
    </div>

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
          <select class="form-control" name="categoryFilter" id="categoryFilter" onchange="getFilteredTasks()">
				    <option value="">모든 카테고리</option>
				    <c:forEach var="cat" items="${categories}">
		        	<option value="${cat}" ${category == cat ? 'selected' : ''}>${cat}</option>
				    </c:forEach>
					</select>
        </div>
        <div class="col-md-3">
          <select class="form-control" id="statusFilter" name="statusFilter" onchange="getFilteredTasks()">
            <option value="">모든 상태</option>
            <option value="진행중" ${status == '진행중' ? 'selected' : ''}>진행 중</option>
            <option value="완료" ${status == '완료' ? 'selected' : ''}>완료</option>
          </select>
        </div>
        <div class="col-md-3">
          <select class="form-control" id="memberFilter" name="memberFilter" onchange="getFilteredTasks()">
            <option value="">모든 구성원</option>
            <c:forEach var="member" items="${familyMembers}">
              <option value="${member.memberIdx}"  ${memberFilter == member.memberIdx ? 'selected' : ''}>${member.memberName}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-md-3">
          <select class="form-control" id="sortBy" name="sortBy" onchange="getFilteredTasks()">
            <option value="dueDate" ${sortBy == 'dueDate' ? 'selected' : ''}>마감일순</option>
            <%-- <option value="priority" ${sortBy == 'priority' ? 'selected' : ''}>우선순위순</option> --%>
            <option value="category" ${sortBy == 'category' ? 'selected' : ''}>카테고리순</option>
          </select>
        </div>
      </div>
    </div>

    <!-- 할 일 목록 -->
    <div class="row" id="taskList">
      <c:forEach var="task" items="${vos}" varStatus="status">
        <div class="col-md-4 mb-4 task-item">
          <div class="card task-card">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <i class="fas fa-tasks task-icon"></i>
                <span class="task-status ${task.status == '진행중' ? 'task-status-ongoing' : 'task-status-completed'}">
                  ${task.status} 
                </span>
              </div>
              <h5 class="card-title">${task.category} - ${task.taskName}</h5>
              <p class="card-text">${fn:substring(task.description, 0, 50)}${fn:length(task.description) > 50 ? '...' : ''}</p>
              <p class="card-text"><small class="text-muted">담당: ${task.memberName}</small></p>
              <p class="card-text"><small class="text-muted">마감일: ${fn:substring(task.endDate, 0, 10)}</small></p>
              <p class="card-text"><small class="text-muted">남은 일수: ${task.daysLeft}일</small></p>
              <button class="btn btn-sm btn-outline-primary" onclick="viewTaskDetails(${task.idx})">자세히 보기</button>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 블록페이지 시작 -->
  <%-- 
  <div class="d-flex justify-content-center my-4">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="workMain?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
		  <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="workMain?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="workMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="workMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="workMain?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
		  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="workMain?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div> --%>
  
  
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
					    <label for="taskTemplate">템플릿 선택</label>
					    <select class="form-control" id="taskTemplate" onchange="selectTemplate()">
					      <option value="">직접 입력</option>
					      <option value="청소|거실 청소|거실 바닥 청소 및 정리정돈">거실 청소</option>
					      <option value="청소|방 청소|방 바닥 청소 및 정리정돈">방 청소</option>
					      <option value="빨래|빨래 세탁|세탁기에 빨래 넣고 돌리기, 건조기 사용">빨래 세탁</option>
					      <option value="빨래|빨래 건조|세탁기에 있는 빨래 건조기에 넣거나 널기">빨래 건조</option>
					      <option value="설거지|식후 설거지|식사 후 그릇 씻기 및 정리">식후 설거지</option>
					      <option value="청소|욕실 청소|욕실 바닥 및 변기 청소">욕실 청소</option>
					      <option value="청소|침실 청소|침대 정리 및 방 청소">침실 청소</option>
					      <option value="청소|주방 청소|주방 싱크대 및 조리대 청소">주방 청소</option>
					      <option value="요리|식사 준비|아침, 점심, 저녁 식사 준비">식사 준비</option>
					      <option value="정리정돈|옷장 정리|계절 옷 정리 및 정돈">옷장 정리</option>
					      <option value="정리정돈|서랍 정리|서랍 내부 정리 및 불필요한 물건 버리기">서랍 정리</option>
					      <option value="정리정돈|장난감 정리|장난감 정리 및 정돈">장난감 정리</option>
					      <option value="정리정돈|책 정리|책장 정리 및 먼지 제거">책 정리</option>
					      <option value="쓰레기 처리|쓰레기 버리기|쓰레기 분리수거 및 버리기">쓰레기 버리기</option>
					      <option value="쓰레기 처리|재활용 정리|재활용품 분리수거 및 정리">재활용 정리</option>
					      <option value="기타|애완동물 돌보기|애완동물 먹이 주기 및 산책">애완동물 돌보기</option>
					    </select>
					  </div>
					  <div class="form-group">
					    <label for="taskCategory">카테고리</label>
					    <select class="form-control" id="taskCategory" required>
					      <option value="청소">청소</option>
					      <option value="설거지">설거지</option>
					      <option value="빨래">빨래</option>
					      <option value="요리">요리</option>
					      <option value="정리정돈">정리정돈</option>
					      <option value="쓰레기 처리">쓰레기 처리</option>
					      <option value="기타">기타</option>
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
	          <div class="form-group">
	            <label for="taskDueTime">마감 시간</label>
	            <input type="time" class="form-control" id="taskDueTime" required>
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
  
  <!-- 세부 정보 모달 -->
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
        <h4 id="taskTitle"></h4>
        <p><strong>카테고리:</strong> <span id="taskCategory"></span></p>
        <p><strong>설명:</strong> <span id="taskDescription"></span></p>
        <p><strong>담당자:</strong> <span id="taskMemberName"></span></p>
        <p><strong>상태:</strong> <span id="taskStatus"></span></p>
        <p><strong>시작일:</strong> <span id="taskStartDate"></span></p>
        <p><strong>마감일:</strong> <span id="taskEndDate"></span></p>
        <p><strong>남은 일수:</strong> <span id="taskDaysLeft"></span>일</p>
        <p><strong>로테이션 주기:</strong> <span id="taskRotationPeriod"></span>일</p>
      </div>
      <div class="modal-footer">
        <span id="taskButtons"></span>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
  
</div>  
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 