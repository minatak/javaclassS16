<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>가사 분담 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="${ctp}/css/housework.css?after" rel="stylesheet" /> 
  <script>
    'use strict';

 		// 커스텀 알럿
    function showAlert(message, callback) {
  	  Swal.fire({
  	    html: message,
  	    confirmButtonText: '확인',
  	    customClass: {
  	      confirmButton: 'swal2-confirm',
  	      popup: 'custom-swal-popup',
  	      htmlContainer: 'custom-swal-text'
  	    },
  	    scrollbarPadding: false,
  	    allowOutsideClick: false,
  	    heightAuto: false,
  	    didOpen: () => {
  	      document.body.style.paddingRight = '0px';
  	    }
  	  }).then((result) => {
  	    if (result.isConfirmed && callback) {
  	      callback();
  	    }
  	  });
  	}
    
    function showConfirm(message, confirmCallback, cancelCallback) {
  	  Swal.fire({
  	    html: message,
  	    showCancelButton: true,
  	    cancelButtonText: '아니요',
  	    confirmButtonText: '네',
  	    customClass: {
  	      cancelButton: 'swal2-cancel',
  	      confirmButton: 'swal2-confirm',
  	      popup: 'custom-swal-popup',
  	      htmlContainer: 'custom-swal-text'
  	    },
  	    scrollbarPadding: false,
  	    allowOutsideClick: false,
  	    heightAuto: false,
  	    didOpen: () => {
  	      document.body.style.paddingRight = '0px';
  	    }
  	  }).then((result) => {
  	    if (result.isConfirmed && confirmCallback) {
  	      confirmCallback();
  	    } else if (result.isDismissed && cancelCallback) {
  	      cancelCallback();
  	    }
  	  });
  	}
    
    
 		// 페이지 로드 시 실행되는 함수
    document.addEventListener('DOMContentLoaded', function() {
      // 오늘 날짜 구하기
      let today = new Date();
      let dd = String(today.getDate()).padStart(2, '0');
      let mm = String(today.getMonth() + 1).padStart(2, '0');
      let yyyy = today.getFullYear();
      today = yyyy + '-' + mm + '-' + dd;

      // 마감일 최소값 설정
      document.getElementById('date').min = today;

      // 마감 시간 현재 시간으로 설정
      let now = new Date();
      document.getElementById('time').value = now.getHours().toString().padStart(2, '0') + ':' + now.getMinutes().toString().padStart(2, '0');

   		
      // 등록 모달의 마감일 없음 체크박스 이벤트 리스너
      document.getElementById('noDueDate').addEventListener('change', function() {
        let dueDateGroup = document.getElementById('dueDateGroup');
        let dueTimeGroup = document.getElementById('dueTimeGroup');
        let dateInput = document.getElementById('date');
        let timeInput = document.getElementById('time');
        
        if(this.checked) {
          dueDateGroup.style.display = 'none';
          dueTimeGroup.style.display = 'none';
          dateInput.required = false;
          timeInput.required = false;
        } else {
          dueDateGroup.style.display = 'block';
          dueTimeGroup.style.display = 'block';
          dateInput.required = true;
          timeInput.required = true;
        }
      });

      // 수정 모달의 마감일 없음 체크박스 이벤트 리스너
      document.getElementById('editNoDueDate').addEventListener('change', function() {
        let editDueDateGroup = document.getElementById('editDueDateGroup');
        let editDueTimeGroup = document.getElementById('editDueTimeGroup');
        let editDateInput = document.getElementById('editTaskDueDate');
        let editTimeInput = document.getElementById('editTaskDueTime');
        
        if(this.checked) {
          editDueDateGroup.style.display = 'none';
          editDueTimeGroup.style.display = 'none';
          editDateInput.required = false;
          editTimeInput.required = false;
        } else {
          editDueDateGroup.style.display = 'block';
          editDueTimeGroup.style.display = 'block';
          editDateInput.required = true;
          editTimeInput.required = true;
        }
      });
      
      
      // 반복 없음 체크박스 이벤트 리스너
      document.getElementById('noRepeat').addEventListener('change', function() {
        let rotationPeriodGroup = document.getElementById('rotationPeriodGroup');
        let rotationPeriodInput = document.getElementById('rotationPeriod');
        
        if(this.checked) {
          rotationPeriodGroup.style.display = 'none';
          rotationPeriodInput.required = false;
          rotationPeriodInput.value = "0";
        } else {
          rotationPeriodGroup.style.display = 'block';
          rotationPeriodInput.required = true;
          rotationPeriodInput.value = "";
        }
      });
      
      
    });

    function addNewTask() {
      let category = addTaskForm.category.value;
      let task = addTaskForm.task.value;
      let description = addTaskForm.description.value;
      let memberIdx = addTaskForm.memberIdx.value;
      let date = addTaskForm.date.value;
      let time = addTaskForm.time.value;
      let rotationPeriod = addTaskForm.rotationPeriod.value;
      let noRepeat = addTaskForm.noRepeat.checked;
      let noDueDate = addTaskForm.noDueDate.checked;
      
      // 유효성 검사
      if(category.trim() === "") {
        showAlert("카테고리를 선택해주세요.", function() {
        	addTaskForm.category.focus();
        });
        return false;
      }
      if(task.trim() === "") {
        showAlert("할 일의 내용을 입력해주세요.", function() {
          addTaskForm.task.focus();
        });
        return false;
      }
      if(task.trim() === "") {
        showAlert("할 일의 이름을 입력해주세요.", function() {
          addTaskForm.task.focus();
        });
        return false;
      }
      if(task.length > 20) {
  	    showAlert("할 일의 이름은 20자 이하로 적어주세요", function() {
          addTaskForm.task.focus();
  	    });
  	    return false;
  	  }
      if(memberIdx === "") {
        showAlert("담당자를 선택해주세요.", function() {
          addTaskForm.memberIdx.focus();
        });
        return false;
      }
      if(!noRepeat && (rotationPeriod.trim() === "" || isNaN(rotationPeriod) || parseInt(rotationPeriod) < 0)) {
        showAlert("올바른 반복 주기를 입력해주세요.", function() {
          addTaskForm.rotationPeriod.focus();
        });
        return false;
      }
      if(!noDueDate) {
  	    if(date === "") {
  	      showAlert("마감일을 선택해주세요.", function() {
  	        addTaskForm.date.focus();
  	      });
  	      return false;
  	    }
  	    if(time === "") {
  	      showAlert("마감 시간을 선택해주세요.", function() {
  	        addTaskForm.time.focus();
  	      });
  	      return false;
  	    }
  	    // 현재 시간과 마감일 비교
  	    let now = new Date();
  	    let endDateTime = new Date(date + 'T' + time);
  	    if (endDateTime < now) {
  	      showAlert("과거의 날짜/시간은 마감일로 설정할 수 없습니다.", function() {
  	        addTaskForm.date.focus();
  	      });
  	      return false;
  	    }
  	    addTaskForm.endDate.value = date + ' ' + time;
  	  } else {
  	    addTaskForm.endDate.value = null;
  	  }
      
      if(noRepeat) {
      	addTaskForm.rotationPeriod.value = "0"; // ""으로 해야할지 0으로 해야할지 고민됨.. null or 0
      }
      
      addTaskForm.endDate.value = date + ' ' + time;
      
      addTaskForm.submit();
    }
    
    
    // 셀렉트한걸로 필터링 및 정렬
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
  	    data: { idx: idx },   
  	    success: function(vo) {
  	    	// 모달 내용 초기화
  	      $('#taskTitle').text('');
  	      $('#taskCategory').text('');
  	      $('#taskDescription').text('');
  	      $('#taskMemberName').text('');
  	      $('#taskStatus').text('');
  	      $('#taskStartDate').text('');
  	      $('#taskEndDate').text('');
  	      $('#taskTimeLeftContainer').hide();
  	      $('#taskTimeLeft').text('');
  	      $('#taskRotationPeriod').text('');

  	      // 새 데이터로 모달 업데이트
  	      $('#taskTitle').text(vo.task);
  	      $('#taskCategory').text(vo.category);
  	      $('#taskDescription').text(vo.description || '설명 없음');
  	      $('#taskMemberName').text(vo.memberName);
  	      $('#taskStatus').text(vo.status);
  	      
  	 			// status에 따라 클래스 추가
  	      if (vo.status === '진행중') {
  	        $('#taskStatus').removeClass('task-status-completed-modal').addClass('task-status task-status-ongoing-modal');
  	      } else {
  	        $('#taskStatus').removeClass('task-status-ongoing-modal').addClass('task-status task-status-completed-modal');
  	      }
  	      
  	 			// 날짜와 시간 분리
  	      let startDate = vo.startDate.substring(0, 10);
  	      let startTime = vo.startDate.substring(11, 16);
	  	    if (vo.endDate) {
	  	      let endDate = vo.endDate.substring(0, 10);
	  	      let endTime = vo.endDate.substring(11, 16);
	  	      $('#taskStartDate').text(startDate + ' ' + startTime);
	  	      $('#taskEndDate').text(endDate + ' ' + endTime);
	  	    } else {
	  	      $('#taskStartDate').text(startDate + ' ' + startTime);
	  	      $('#taskEndDate').text('(마감일 없음)');
	  	    }
	
	  	    // 상태가 '진행중'일 때만 남은 시간 표시
	  	    if (vo.status === '진행중' && vo.endDate) {
	  	      $('#taskTimeLeftContainer').show();
	  	      
	  	      // 남은 시간 계산 및 표시
	  	      let now = new Date();
	  	      let end = new Date(vo.endDate);
	  	      let timeDiff = end - now;
	  	      if (timeDiff > 0) {
	  	        let daysLeft = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
	  	        let hoursLeft = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	  	        let minutesLeft = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
	  	        if (daysLeft > 0) {
	  	          $('#taskTimeLeft').text(daysLeft + '일 ' + hoursLeft + '시간 ' + minutesLeft + '분');
	  	        } else if (hoursLeft > 0) {
	  	          $('#taskTimeLeft').text(hoursLeft + '시간 ' + minutesLeft + '분');
	  	        } else {
	  	          $('#taskTimeLeft').text(minutesLeft + '분');
	  	        }
	  	        $('#taskTimeLeft').css('color', ''); // 기본 색상으로 설정
	  	      } else {
	  	        $('#taskTimeLeft').text('시간 초과');
	  	        $('#taskTimeLeft').css('color', 'red'); // 빨간색으로 설정
	  	      }
	  	    } else {
	  	      $('#taskTimeLeftContainer').hide();
	  	    }
  	      
	  	 		// 로테이션 주기 표시
	  	    $('#taskRotationPeriod').text(vo.rotationPeriod == 0 ? '반복 없음' : vo.rotationPeriod + '일');
	
	  	    var buttonsHtml = '';
			  	if (vo.memberIdx == ${sIdx}) {
			  	  buttonsHtml += '<button type="button" class="modalBtn btn-primary" onclick="editTask(' + vo.idx + ')">수정</button>';
			  	  buttonsHtml += '<button type="button" class="modalBtn btn-primary" onclick="workDelete(' + vo.idx + ')">삭제</button>';
				  	
			  	  if (vo.status == '진행중') {
				  	  buttonsHtml += '<button type="button" class="modalBtn btn-primary" onclick="completeTask(' + vo.idx + ')">완료</button>';
				  	}
			  	}
		  	  $('#taskButtons').html(buttonsHtml);
	
	  	    $('#taskDetailModal').modal('show');
	  	  	
	  	    // 이벤트 리스너 제거 및 재설정
	        $('#taskDetailModal').off('hidden.bs.modal');
	        $('#taskDetailModal').on('hidden.bs.modal', function (e) {
	          if ($(e.target).attr('id') === 'taskDetailModal') {
	            $('#editTaskModal').modal('hide');
	          }
	        });
	      },
	      error: function(xhr, status, error) {
	        console.error("Error fetching task details:", error);
	        showAlert('할 일 세부 정보를 불러오는데 실패했습니다.');
	      }
	    });
  	}

    function workDelete(idx) {
		  showConfirm("현재 할 일을 삭제하시겠습니까?", function() {
		    location.href = "workDelete?idx="+idx;
		  });
		}

    function editTask(idx) {
  	  $.ajax({
  	    url: '${ctp}/housework/getTaskDetails',
  	    type: 'GET',
  	    data: { idx: idx },
  	    success: function(vo) {
  	      $('#editTaskIdx').val(vo.idx);
  	      $('#editTaskCategory').val(vo.category);
  	      $('#editTaskName').val(vo.task);
  	      $('#editTaskDescription').val(vo.description);
  	      $('#editTaskAssignee').val(vo.memberIdx);

  	      // 날짜와 시간 분리
  	      let startDate = vo.startDate.substring(0, 10);
  	      let startTime = vo.startDate.substring(11, 16);
  	      $('#editTaskDueDate').val(startDate);
  	      $('#editTaskDueTime').val(startTime);

  	      if (vo.endDate) {
  	        let endDate = vo.endDate.substring(0, 10);
  	        let endTime = vo.endDate.substring(11, 16);
  	        $('#editTaskDueDate').val(endDate);
  	        $('#editTaskDueTime').val(endTime);
  	      } else {
  	        // endDate가 null인 경우, 시작 날짜와 시간을 사용
  	        $('#editTaskDueDate').val(startDate);
  	        $('#editTaskDueTime').val(startTime);
  	      }
  	      
  	      $('#editTaskRotationPeriod').val(vo.rotationPeriod);

  	      // status에 따라 라디오 버튼 선택
  	      if (vo.status === '완료') {
  	        document.getElementById('editTaskStatusComplete').checked = true;
  	      } else {
  	        document.getElementById('editTaskStatusIncomplete').checked = true;
  	      }
  	      
  	      // 모달 전환
  	      $('#taskDetailModal').modal('hide');
  	      $('#editTaskModal').modal('show');
  	    },
  	    error: function(xhr, status, error) {
  	      console.error("Error fetching task details for edit:", xhr.responseText);
  	      showAlert('할 일 정보를 불러오는데 실패했습니다.');
  	    }
  	  });
  	}

  	$(document).ready(function() {
  	  $('#taskDetailModal').on('hidden.bs.modal', function (e) {
  	    if ($('#editTaskModal').hasClass('show')) {
  	      $('body').addClass('modal-open');
  	    }
  	  });

  	  $('#editTaskModal').on('hidden.bs.modal', function (e) {
  	    if ($('#taskDetailModal').hasClass('show')) {
  	      $('body').addClass('modal-open');
  	    }
  	  });

  	  // 모달 전환 시 페이드 효과 추가
  	  $('.modal').on('show.bs.modal', function (e) {
  	    $(this).fadeIn('fast');
  	  });

  	  $('.modal').on('hide.bs.modal', function (e) {
  	    $(this).fadeOut('fast');
  	  });
  	});
  	
    function updateTask() {
  	  let category = $('#editTaskCategory').val();
  	  let task = $('#editTaskName').val();
  	  let description = $('#editTaskDescription').val();
  	  let memberIdx = $('#editTaskAssignee').val();
  	  let date = $('#editTaskDueDate').val();
  	  let time = $('#editTaskDueTime').val();
  	  let rotationPeriod = $('#editTaskRotationPeriod').val();
  		let noDueDate = document.getElementById('editNoDueDate').checked;
  	  
  		let status = document.querySelector('input[name="editTaskStatus"]:checked').value;
  	  
  	  // 유효성 검사
  	  if(category.trim() === "") {
  	    showAlert("카테고리를 선택해주세요.", function() {
  	      $('#editTaskCategory').focus();
  	    });
  	    return false;
  	  }
  		if(task.trim() === "") {
        showAlert("할 일의 이름을 입력해주세요.", function() {
  	    	$('#editTaskName').focus();
        });
        return false;
      }
      if(task.length >= 20) {
  	    showAlert("할 일의 이름은 20자 이하로 적어주세요", function() {
  	    	$('#editTaskName').focus();
  	    });
  	    return false;
  	  }
  	  if(memberIdx === "") {
  	    showAlert("담당자를 선택해주세요.", function() {
  	      $('#editTaskAssignee').focus();
  	    });
  	    return false;
  	  }
  	  if(rotationPeriod.trim() === "" || isNaN(rotationPeriod) || parseInt(rotationPeriod) < 0) {
  	    showAlert("올바른 반복 주기를 입력해주세요.", function() {
  	      $('#editTaskRotationPeriod').focus();
  	    });
  	    return false;
  	  }
  		if(!noDueDate) {
  	    if(date === "") {
  	      showAlert("마감일을 선택해주세요.", function() {
  	        $('#editTaskDueDate').focus();
  	      });
  	      return false;
  	    }
  	    if(time === "") {
  	      showAlert("마감 시간을 선택해주세요.", function() {
  	        $('#editTaskDueTime').focus();
  	      });
  	      return false;
  	    }
  	    // 현재 시간과 마감일 비교
  	    let now = new Date();
  	    let endDateTime = new Date(date + 'T' + time);
  	    if (endDateTime < now) {
  	      showAlert("과거의 날짜/시간은 마감일로 설정할 수 없습니다.", function() {
  	        $('#editTaskDueDate').focus();
  	      });
  	      return false;
  	    }
  	    $('#editTaskEndDateHidden').val(date + ' ' + time);
  	  } else {
  	    $('#editTaskEndDateHidden').val(null);
  	  }
  	  
  	  // form에 값 설정
  	  $('#editTaskIdxHidden').val($('#editTaskIdx').val());
		  $('#editTaskCategoryHidden').val(category);
		  $('#editTaskNameHidden').val(task);
		  $('#editTaskDescriptionHidden').val(description);
		  $('#editTaskAssigneeHidden').val(memberIdx);
		  /* $('#editTaskEndDateHidden').val(date + ' ' + time); */
		  $('#editTaskRotationPeriodHidden').val(rotationPeriod);
		  $('#editTaskStatusHidden').val(status);
		  
  	  document.editTaskForm.submit();
  	}

    function completeTask(idx) {
    	
      showConfirm("해당 집안일을 완료하셨나요?", function() {
        
        $.ajax({
            url: '${ctp}/housework/complete',
            type: 'POST',
            data: { houseworkIdx: idx },
            success: function(response) {
              showAlert("할 일이 완료되었습니다.", function() {
	              $('#taskDetailModal').modal('hide');
	              // 필요한 경우 페이지 새로고침 또는 목록 갱신
	              location.reload();
              });
            },
            error: function(xhr, status, error) {
              console.error("Error completing task:", error);
              showAlert('할 일 완료 처리에 실패했습니다.');
            }
          });
      });
    }

    function selectTemplate() {
      var template = $('#taskTemplate').val();
      if (template) {
        var [category, name, description] = template.split('|');
        $('#category').val(category);
        $('#task').val(name);
        $('#description').val(description);
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
<div class="container">
  <div class="workContainer">
    <div class="header">
	    <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	    <font size="5" class="mb-4 h2">우리 집 가사 관리</font>
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
     <div class="top-controls">
      <div class="d-flex align-items-center">
        <label class="switch mb-0">
          <input type="checkbox" id="myTasksToggle" onchange="toggleMyTasks()" ${param.flag == 'mine' ? 'checked' : ''}>
          <span class="slider"></span>
        </label>
        <span class="switch-label">내가 하는 일만 보기</span>
      </div>
      <button class="btn" data-toggle="modal" data-target="#addTaskModal">
        <i class="fas fa-plus"></i> 새로운 할 일 등록
      </button>
    </div>

    <!-- 가족 구성원별 진행률 섹션 -->
    <div class="card mb-4">
      <div class="card-body">
        <h3 class="card-title-header mb-1">가족 구성원별 진행률</h3>
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
            <option value="category" ${sortBy == 'category' ? 'selected' : ''}>카테고리순</option>
          </select>
        </div>
      </div>
    </div>

    <!-- 할 일 목록 -->
		<div class="row" id="taskList">
		  <c:forEach var="task" items="${vos}" varStatus="status">
		    <div class="col-md-4 mb-4 task-item">
		      <div class="card task-card ${task.status == '완료' ? 'task-completed' : ''} h-100">
		        <div class="card-body d-flex flex-column">
		          <div class="d-flex justify-content-between align-items-center mb-3">
		            <i class="fas ${task.category == '청소' ? 'fa-broom' : 
		                           task.category == '설거지' ? 'fa-sink' : 
		                           task.category == '빨래' ? 'fa-tshirt' : 
		                           task.category == '요리' ? 'fa-utensils' : 
		                           task.category == '정리정돈' ? 'fa-box' : 
		                           task.category == '쓰레기' ? 'fa-trash' : 
		                           'fa-tasks'} task-icon" ${task.status == '완료' ? '' : 'style="color: #b8c9bc;"'}></i>
		            <span class="task-status ${task.status == '진행중' ? 'task-status-ongoing' : 'task-status-completed'}">
		              ${task.status} 
		            </span>
		          </div>
		          <h5 class="card-title">${task.category} - ${task.task}</h5>
		          <p class="card-text">${fn:substring(task.description, 0, 50)}${fn:length(task.description) > 30 ? '...' : ''}</p>
		          <p class="card-text"><small class="text-muted">담당: ${task.memberName}</small></p>
		          <div class="mt-auto">
		            <c:if test="${!empty task.endDate}">
		              <p class="card-text mb-0"><small class="text-muted">마감일: ${fn:substring(task.endDate, 0, 10)}</small></p>
		              <p class="card-text mb-0"><small class="text-muted">
		                <c:choose>
		                  <c:when test="${task.daysLeft >= 0}">남은 일수: ${task.daysLeft}일</c:when>
		                  <c:otherwise>남은 일수: 0일</c:otherwise>
		                </c:choose>
		              </small></p>
		            </c:if>
		            <c:if test="${empty task.endDate}">
		              <p class="card-text mb-0"><small class="text-muted">마감일 없음</small></p>
		              <p class="card-text mb-0"><small class="text-muted">&nbsp;</small></p>
		            </c:if>
		            <button class="btn btn-sm btn-view-details mt-2" onclick="viewTaskDetails(${task.idx})">자세히 보기</button>
		          </div>
		        </div>
		      </div>
		    </div>
		  </c:forEach>
		</div>
	
	<!-- 블록페이지 시작 -->
	<div class="d-flex justify-content-center my-4">
	  <ul class="pagination">
	    <c:if test="${pageVO.pag > 1}">
	      <li><a href="workMain?pag=1&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}&flag=${param.flag}">처음</a></li>
	    </c:if>
	    <c:if test="${pageVO.curBlock > 0}">
	      <li><a href="workMain?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}&flag=${param.flag}">&laquo;</a></li>
	    </c:if>
	    <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	        <li class="active"><a href="workMain?pag=${i}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}&flag=${param.flag}">${i}</a></li>
	      </c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	        <li><a href="workMain?pag=${i}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}&flag=${param.flag}">${i}</a></li>
	      </c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	      <li><a href="workMain?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}&flag=${param.flag}">&raquo;</a></li>
	    </c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}">
	      <li><a href="workMain?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}&flag=${param.flag}">끝</a></li>
	    </c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->

</div>

  <!-- 할 일 등록 모달 -->
  <!-- <div class="modal" id="addTaskModal" tabindex="-1" role="dialog" aria-labelledby="addTaskModalLabel" aria-hidden="true"> -->
  <div class="modal" id="addTaskModal" tabindex="-1" role="dialog" aria-labelledby="addTaskModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="task-form-container">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	        <h4 class="modal-title mb-4">새로운 할 일 등록</h4>
	        <form id="addTaskForm" method="post" action="${ctp}/housework/workInput">
            <div class="form-group">
              <label for="taskTemplate">템플릿 선택</label>
              <select class="form-control" id="taskTemplate" onchange="selectTemplate()">
                <option value="">직접 입력</option>
                <option value="청소|거실 청소|거실 바닥 청소 및 정리정돈">거실 청소</option>
                <option value="청소|방 청소|방 바닥 청소 및 정리정돈">방 청소</option>
                <option value="빨래|빨래 세탁|세탁기에 빨래 넣고 돌리기">빨래 세탁</option>
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
                <option value="기타|반려동물 돌보기|반려동물 먹이 주기 및 산책">반려동물 돌보기</option>
              </select>
            </div>
            <div class="form-group">
              <label for="taskCategory">카테고리 *</label>
              <select class="form-control" id="category" name="category" required>
                <option value="">선택</option>
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
              <label for="taskName">할 일 이름 *</label>
              <input type="text" class="form-control" id="task" name="task" required>
            </div>
            <div class="form-group">
              <label for="taskDescription">설명</label>
              <textarea class="form-control" id="description" name="description" rows="3"></textarea>
            </div>
            <div class="form-group">
					    <label for="memberIdx">담당자 *</label>
					    <select class="form-control" id="memberIdx" name="memberIdx" required>
					      <c:forEach var="member" items="${familyMembers}">
					        <option value="${member.memberIdx}">${member.memberName}</option>
					      </c:forEach>
					    </select>
					  </div>
            <div class="form-group">
	            <label>
	              <input type="checkbox" id="noDueDate" name="noDueDate"> 마감일 없음
	            </label>
	          </div>
	          <div class="form-group" id="dueDateGroup">
	            <label for="endDate">마감일</label>
	            <input type="date" class="form-control" id="date" name="date">
	          </div>
	          <div class="form-group" id="dueTimeGroup">
	            <label for="endTime">마감 시간</label>
	            <input type="time" class="form-control" id="time" name="time">
	          </div>
					  <div class="form-group" id="rotationPeriodGroup">
					    <label for="taskRotationPeriod">반복 주기 (일)</label>
					    <input type="number" class="form-control" id="rotationPeriod" name="rotationPeriod" required>
					  </div>
					  <div class="form-group" style="margin-top:0px;">
					    <label>
					      <input type="checkbox" id="noRepeat" name="noRepeat"> 반복 없음
					    </label>
					  </div>
  					<input type="hidden" name="endDate" id="endDate" >
  					<input type="hidden" name="familyCode" value="${sFamCode}">
			      <div class="task-actions mt-4">
	            <button type="button" class="modalBtn btn-secondary" data-dismiss="modal">취소</button>
	            <button type="button" class="modalBtn btn-primary" onclick="addNewTask()">등록</button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
  
	<!-- 세부 정보 모달 -->
	<div class="modal" id="taskDetailModal" tabindex="-1" role="dialog" aria-labelledby="taskDetailModalLabel" aria-hidden="true" data-keyboard="false">
	<!-- <div class="modal" id="taskDetailModal" tabindex="-1" role="dialog" aria-labelledby="taskDetailModalLabel" aria-hidden="true"> -->
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="task-detail-container">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	        <div class="task-header">
	          <h4 id="taskTitle" class="mb-3"></h4>
	          <span id="taskStatus" class="task-status mb-3 mr-3"></span>
	        </div>
	        <div class="task-detail-info">
	          <p><i class="fas fa-tag"></i> <span id="taskCategory"></span></p>
	          <p><i class="fas fa-user"></i> <span id="taskMemberName"></span></p>
	          <p><i class="fas fa-calendar-alt"></i> <span id="taskStartDate"></span> ~ <span id="taskEndDate"></span></p>
	          <p id="taskTimeLeftContainer" style="display: none;">
				    	<i class="fas fa-hourglass-half"></i> 남은 시간: <span id="taskTimeLeft"></span>
					  </p>
	          <p><i class="fas fa-redo"></i> 반복 주기: <span id="taskRotationPeriod"></span></p>
	        </div>
	        <div class="task-detail-description mt-4">
	          <h5>설명</h5>
	          <p id="taskDescription"></p>
	        </div>
	        <div class="task-actions mt-4">
	          <span id="taskButtons"></span>
	          <button type="button" class="modalBtn btn-close" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

  <!-- 할 일 수정 모달 -->
  <!-- <div class="modal" id="editTaskModal" tabindex="-1" role="dialog" aria-labelledby="editTaskModalLabel" aria-hidden="true"> -->
  <div class="modal" id="editTaskModal" tabindex="-1" role="dialog" aria-labelledby="editTaskModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="task-form-container">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	        <h4 class="modal-title mb-4">할 일 수정</h4>
	        <form name="editTaskForm" method="post" action="${ctp}/housework/workUpdate">
          <input type="hidden" id="editTaskIdx">
          <div class="form-group">
            <label for="editTaskCategory">카테고리</label>
            <select class="form-control" id="editTaskCategory" required>
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
            <label for="editTaskName">할 일 이름</label>
            <input type="text" class="form-control" id="editTaskName" required>
          </div>
          <div class="form-group">
            <label for="editTaskDescription">설명</label>
            <textarea class="form-control" id="editTaskDescription" rows="3"></textarea>
          </div>
          <div class="form-group">
            <label for="editTaskAssignee">담당자</label>
            <select class="form-control" id="editTaskAssignee" required>
              <c:forEach var="member" items="${familyMembers}">
                <option value="${member.memberIdx}">${member.memberName}</option>
              </c:forEach>
            </select>
          </div>
          <div class="form-group">
            <label>
            	<input type="checkbox" id="editNoDueDate" name="editNoDueDate"> 마감일 없음
            </label>
          </div>
          <div class="form-group" id="editDueDateGroup">
            <label for="editTaskDueDate">마감일</label>
            <input type="date" class="form-control" id="editTaskDueDate">
          </div>
          <div class="form-group" id="editDueTimeGroup">
            <label for="editTaskDueTime">마감 시간</label>
            <input type="time" class="form-control" id="editTaskDueTime">
          </div>
          <div class="form-group">
            <label for="editTaskRotationPeriod">반복 주기 (일)</label>
            <input type="number" class="form-control" id="editTaskRotationPeriod" required>
          </div>
          <div class="form-group">
            <label>완료 여부</label>
            <div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="editTaskStatus" id="editTaskStatusIncomplete" value="진행중" required>
                <label class="form-check-label" for="editTaskStatusIncomplete" style="margin-bottom:0px; font-weight: 400;">진행중</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="editTaskStatus" id="editTaskStatusComplete" value="완료" required>
                <label class="form-check-label" for="editTaskStatusComplete" style="margin-bottom:0px; font-weight: 400;">완료</label>
              </div>
            </div>
          </div>
          <input type="hidden" name="familyCode" value="${sFamCode}">
			    <input type="hidden" id="editTaskIdxHidden" name="idx">
				  <input type="hidden" id="editTaskCategoryHidden" name="category">
				  <input type="hidden" id="editTaskNameHidden" name="task">
				  <input type="hidden" id="editTaskDescriptionHidden" name="description">
				  <input type="hidden" id="editTaskAssigneeHidden" name="memberIdx">
				  <input type="hidden" id="editTaskEndDateHidden" name="endDate">
				  <input type="hidden" id="editTaskRotationPeriodHidden" name="rotationPeriod">
				  <input type="hidden" id="editTaskStatusHidden" name="status">
	        <div class="task-actions mt-4">
	            <button type="button" class="modalBtn btn-secondary" data-dismiss="modal">취소</button>
	            <button type="button" class="modalBtn btn-primary" onclick="updateTask()">수정</button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>	