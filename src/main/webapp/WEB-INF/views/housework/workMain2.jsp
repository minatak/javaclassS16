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
  <style>
    * {font-family: 'Pretendard';}
    
    body {
    	font-family: 'Pretendard' !important;
      background-color: #ffffff;
    }
    .header {
    	/* font-weight:600 !important; */
    	margin-bottom: 50px;
    }
    .header .h2 {
    	font-family: 'pretendard' !important;
      font-weight: 600;
      font-size: 24px;
      color: #33c47;
      text-align: center;
      margin-bottom: 50px;
    }
    .card-title-header {
      font-weight: 500;
      font-size: 22px;
      color: #33c47;
      text-align: center;
    }
    .workContainer {
      max-width: 900px;
      background-color: white;
      padding: 40px;
      /* margin: 30px auto; */
      margin: 0px auto;
    }
    
    .home-icon {
      font-size: 24px;
      color: #cecece;
    }
    
    .home-icon:hover {
      color: #c6c6c6;
    }
    
    h2, h3, h4 {
    	font-family: 'Pretendard' !important;
      color: #33c47;
      margin-bottom: 30px;
      font-weight: 700;
    }
    h5 {
    	font-family: 'Pretendard' !important;
      color: #33c47;
      margin-bottom: 30px;
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
    
    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
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
      background-color: #afb0af;
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
    
    .filters {
      background-color: white;
     /*  padding: 15px; */
      /* border-radius: 10px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1); */
    }
    
    .modal-content {
		  border-radius: 10px;
		  overflow: hidden;
		}
    
    .modal-header {
      background-color: #84a98c;
      color: white !important;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
    }
    
    .modal-body {
      padding: 20px;
    }
    
    .modal-footer {
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;
    }
    
    .form-control:focus {
      border-color: #84a98c; 
      box-shadow: 0 0 0 0.2rem rgba(132, 169, 140, 0.25);
    }
    
    .switch {
      position: relative;
      display: inline-block;
      width: 50px;
      height: 24px;
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
      border-radius: 24px;
    }
    
    .slider:before {
      position: absolute;
      content: "";
      height: 16px;
      width: 16px;
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
      font-size: 14px;
    }
    
    .top-controls {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    
    .task-detail-container {
      padding: 20px;
    }
    
    .task-detail-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    
    .task-detail-info p {
      margin-bottom: 10px;
    }
    
    .task-detail-info i {
      width: 20px;
      color: #84a98c;
      margin-right: 10px;
    }
    
    .task-detail-description {
      background-color: #f8f9fa;
      padding: 15px;
      border-radius: 5px;
    }
    
    .task-status {
      font-size: 13px;
      padding: 5px 10px;
      border-radius: 20px;
      font-weight: 600;
      /* font-weight: bold; */
      background-color: #84a98c;	
      color: white;
    }
    
    .task-status-ongoing {
      background-color: #84a98c;	
      color: white;
    }
    
    .task-status-completed {
      background-color: #afb0af;
      color: white;
    }
    
    .task-status-ongoing-modal {
      background-color: #84a98c;	
      color: white;
    }
    
    .task-status-completed-modal {
      background-color: #afb0af;
      color: white;
    }
    
    .task-completed .task-icon,
    .task-completed .btn-outline-primary {
      color: #afb0af;
    }
    
    /* 모달 창 디자인 부분 */
		.task-status-ongoing-modal,
		.task-status-completed-modal {
		  font-size: 14px;
		  padding: 5px 15px;
		  border-radius: 20px;
		  font-weight: 500;
		  text-align: center;
		  margin: 10px 0;
		  display: inline-block;
		}
		
		.task-status-ongoing-modal {
		  background-color: #84a98c;
		  color: white;
		}
		
		.task-status-completed-modal {
		  background-color: #afb0af;
		  color: white;
		}
		
		.task-status-ongoing-modal:before,
		.task-status-completed-modal:before {
		  content: "상태: ";
		  font-weight: 400;
		  margin-right: 5px;
		}
		
    #taskTitle {
		  margin: 0;
		  font-size: 18px;
		  font-weight: 700;
		  color: #33c47;
		}
		
		
		.task-detail-info p {
		  margin-bottom: 8px;
		  color: #555;
		}
		
		.task-detail-info i {
		  width: 20px;
		  color: #84a98c;
		  margin-right: 10px;
		}
		
		.task-detail-description h5 {
		  font-size: 16px;
		  font-weight: 500;
		  color: #33c47;
		  margin-bottom: 10px;
		}
		
		.task-detail-description p {
		  color: #555;
		}
    
    .btn-edit,
		.btn-delete,
		.btn-complete,
		.btn-close {
		  border-radius: 20px;
		  padding: 5px 15px;
		  font-size: 14px;
		  margin-right: 10px;
		  background-color: #84a98c;
		}
    .btn-edit:hover,
		.btn-delete:hover,
		.btn-complete:hover {
		  background-color: #5d9469;
		}
		.btn-close {
		  background-color: #5d625e;
		  color: white;
		}
		.btn-close:hover {
		  background-color: #595b59;
		}
		
		/* .modal-header {
		  background-color: #84a98c;
		  color: white;
		  border-top-left-radius: 15px;
		  border-top-right-radius: 15px;
		}
		
		.modal-header .modal-title {
		  color: white;
		} */

		
		
		
		
		.pagination {
		  display: inline-block;
		  padding-left: 0;
		  margin: 20px 0;
		  border-radius: 4px;
		}
		
		.pagination > li {
		  display: inline;
		}
		
		.pagination > li > a,
		.pagination > li > span {
		  position: relative;
		  float: left;
		  padding: 6px 12px;
		  margin-left: -1px;
		  line-height: 1.42857143;
		  color: #84a98c;
		  text-decoration: none;
		  background-color: #fff;
		  border: 1px solid #ddd;
		}
		
		.pagination > li:first-child > a,
		.pagination > li:first-child > span {
		  margin-left: 0;
		  border-top-left-radius: 4px;
		  border-bottom-left-radius: 4px;
		}
		
		.pagination > li:last-child > a,
		.pagination > li:last-child > span {
		  border-top-right-radius: 4px;
		  border-bottom-right-radius: 4px;
		}
		
		.pagination > li > a:hover,
		.pagination > li > span:hover,
		.pagination > li > a:focus,
		.pagination > li > span:focus {
		  color: #2a6496;
		  background-color: #eee;
		  border-color: #ddd;
		}
		
		.pagination > .active > a,
		.pagination > .active > span,
		.pagination > .active > a:hover,
		.pagination > .active > span:hover,
		.pagination > .active > a:focus,
		.pagination > .active > span:focus {
		  z-index: 2;
		  color: #fff;
		  cursor: default;
		  background-color: #84a98c;
		  border-color: #84a98c;
		}
    .task-completed .card {
      background-color: #f8f9fa;
    }
    .task-completed .btn {
      background-color: #afb0af;
    }
    
    .swal2-confirm {
      background-color: white !important;
      color: black !important;
      border-radius: 0px !important;
      box-shadow: none !important;
      font-weight: bold !important;
      font-size: 18px !important;
      margin: 0 !important;
      
    }
    .swal2-cancel {
      background-color: white !important;
      color: black !important;
      border-radius: 0px !important;
      box-shadow: none !important;
      /* font-weight: bold !important; */
      font-size: 18px !important;
      margin: 0 !important;
    }
    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
    }
    .swal2-confirm:hover {
      background-color: none !important;
    }
		
		.form-group label {
		  font-weight: 500;
		  color: #33c47;
		  margin-bottom: 5px;
		}
		.form-control:focus {
		  border-color: #84a98c; 
		  box-shadow: 0 0 0 0.2rem rgba(132, 169, 140, 0.25);
		}
		.modalBtn {
		  border-radius: 20px;
		  padding: 5px 15px;
		  font-size: 14px;
		  margin-right: 10px;
		}
		
  </style>
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
  	    cancelButtonText: '취소',
  	    confirmButtonText: '확인',
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
      if(memberIdx === "") {
        showAlert("담당자를 선택해주세요.", function() {
          addTaskForm.memberIdx.focus();
        });
        return false;
      }
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
      if(!noRepeat && (rotationPeriod.trim() === "" || isNaN(rotationPeriod) || parseInt(rotationPeriod) < 0)) {
        showAlert("올바른 반복 주기를 입력해주세요.", function() {
          addTaskForm.rotationPeriod.focus();
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
  	      $('#taskTitle').text(vo.task);
  	      $('#taskCategory').text(vo.category);
  	      $('#taskDescription').text(vo.description || '설명 없음');
  	      $('#taskMemberName').text(vo.memberName);
  	      $('#taskStatus').text(vo.status);
  	      $('#taskStartDate').text(vo.startDate);
  	      $('#taskEndDate').text(vo.endDate);
  	      
  	 			// status에 따라 클래스 추가
  	      if (vo.status === '진행중') {
  	        $('#taskStatus').removeClass('task-status-completed-modal').addClass('task-status task-status-ongoing-modal');
  	      } else {
  	        $('#taskStatus').removeClass('task-status-ongoing-modal').addClass('task-status task-status-completed-modal');
  	      }
  	      
  	 			// 날짜와 시간 분리
  	      let startDate = vo.startDate.substring(0, 10);
  	      let startTime = vo.startDate.substring(11, 16);
  	      let endDate = vo.endDate.substring(0, 10);
  	      let endTime = vo.endDate.substring(11, 16);

  	      $('#taskStartDate').text(startDate + ' ' + startTime);
  	      $('#taskEndDate').text(endDate + ' ' + endTime);

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
  	      } else {
  	        $('#taskTimeLeft').text('마감 시간 초과');
  	      }
  	      
	  	 		// 로테이션 주기 표시
	  	    $('#taskRotationPeriod').text(vo.rotationPeriod == 0 ? '반복 없음' : vo.rotationPeriod + '일');
	
	  	    var buttonsHtml = '';
			  	if (vo.memberIdx == ${sIdx}) {
			  	  buttonsHtml += '<button type="button" class="btn btn-edit" onclick="editTask(' + vo.idx + ')">수정</button>';
			  	  buttonsHtml += '<button type="button" class="btn btn-delete" onclick="workDelete(' + vo.idx + ')">삭제</button>';
				  	
			  	  if (vo.status == '진행중') {
				  	  buttonsHtml += '<button type="button" class="btn btn-complete" onclick="completeTask(' + vo.idx + ')">완료</button>';
				  	}
			  	}
		  	  $('#taskButtons').html(buttonsHtml);
	
	  	    $('#taskDetailModal').modal('show');
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

  	  $('#taskDetailModal').modal('hide');

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
  	      let endDate = vo.endDate.substring(0, 10);
  	      let endTime = vo.endDate.substring(11, 16);

  	      $('#editTaskDueDate').val(endDate);
  	      $('#editTaskDueTime').val(endTime);

  	      $('#editTaskRotationPeriod').val(vo.rotationPeriod);

  	 			// status에 따라 라디오 버튼 선택
	  	    if (vo.status === '완료') {
	  	      document.getElementById('editTaskStatusComplete').checked = true;
	  	    } else {
	  	      document.getElementById('editTaskStatusIncomplete').checked = true;
	  	    }
  	      
  	      $('#taskDetailModal').on('hidden.bs.modal', function (e) {
  	        $('#editTaskModal').modal('show');
  	        $(this).off('hidden.bs.modal');
  	      });
  	    },
  	    error: function(xhr, status, error) {
  	      console.error("Error fetching task details for edit:", xhr.responseText);
  	      showAlert('할 일 정보를 불러오는데 실패했습니다.');
  	    }
  	  });
  	}
  	
    function updateTask() {
  	  let category = $('#editTaskCategory').val();
  	  let task = $('#editTaskName').val();
  	  let description = $('#editTaskDescription').val();
  	  let memberIdx = $('#editTaskAssignee').val();
  	  let date = $('#editTaskDueDate').val();
  	  let time = $('#editTaskDueTime').val();
  	  let rotationPeriod = $('#editTaskRotationPeriod').val();
  	  
  		let status = document.querySelector('input[name="editTaskStatus"]:checked').value;
  	  
  	  // 유효성 검사
  	  if(category.trim() === "") {
  	    showAlert("카테고리를 선택해주세요.", function() {
  	      $('#editTaskCategory').focus();
  	    });
  	    return false;
  	  }
  	  if(task.trim() === "") {
  	    showAlert("할 일의 내용을 입력해주세요.", function() {
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
  	  if(rotationPeriod.trim() === "" || isNaN(rotationPeriod) || parseInt(rotationPeriod) < 0) {
  	    showAlert("올바른 반복 주기를 입력해주세요.", function() {
  	      $('#editTaskRotationPeriod').focus();
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
  	  
  	  // form에 값 설정
  	  $('#editTaskIdxHidden').val($('#editTaskIdx').val());
		  $('#editTaskCategoryHidden').val(category);
		  $('#editTaskNameHidden').val(task);
		  $('#editTaskDescriptionHidden').val(description);
		  $('#editTaskAssigneeHidden').val(memberIdx);
		  $('#editTaskEndDateHidden').val(date + ' ' + time);
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
<p><br/></p> 
<div class="container">
  <div class="workContainer">
    <%-- <div class="mb-5"> 
      <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
      <font size="5" class="mb-4 header">우리 집 가사 관리</font>
    </div> --%>
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
		      <div class="card task-card ${task.status == '완료' ? 'task-completed' : ''}">
				    <div class="card-body">
				      <div class="d-flex justify-content-between align-items-center mb-3">
				        <i class="fas ${task.category == '청소' ? 'fa-broom' : 
							                 task.category == '설거지' ? 'fa-sink' : 
							                 task.category == '빨래' ? 'fa-tshirt' : 
							                 task.category == '요리' ? 'fa-utensils' : 
							                 task.category == '정리정돈' ? 'fa-box' : 
							                 task.category == '쓰레기' ? 'fa-trash' : 
							                 'fa-tasks'} task-icon"></i>
				        <span class="task-status ${task.status == '진행중' ? 'task-status-ongoing' : 'task-status-completed'}">
				          ${task.status} 
				        </span>
				      </div>
              <h5 class="card-title">${task.category} - ${task.task}</h5>
              <p class="card-text">${fn:substring(task.description, 0, 50)}${fn:length(task.description) > 50 ? '...' : ''}</p>
              <p class="card-text"><p class="card-text"><small class="text-muted">담당: ${task.memberName}</small></p>
              <p class="card-text"><small class="text-muted">마감일: ${fn:substring(task.endDate, 0, 10)}</small></p>
              <p class="card-text"><small class="text-muted">남은 일수: ${task.daysLeft}일</small></p>
              <button class="btn btn-sm btn-view-details" onclick="viewTaskDetails(${task.idx})">자세히 보기</button>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 블록페이지 시작 -->
	<%-- <div class="d-flex justify-content-center my-4">
	  <ul class="pagination">
	    <c:if test="${pageVO.pag > 1}">
	      <li><a href="workMain?pag=1&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}">처음</a></li>
	    </c:if>
	    <c:if test="${pageVO.curBlock > 0}">
	      <li><a href="workMain?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}">&laquo;</a></li>
	    </c:if>
	    <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	        <li class="active"><a href="workMain?pag=${i}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}">${i}</a></li>
	      </c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	        <li><a href="workMain?pag=${i}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}">${i}</a></li>
	      </c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	      <li><a href="workMain?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}">&raquo;</a></li>
	    </c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}">
	      <li><a href="workMain?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&category=${param.category}&status=${param.status}&memberFilter=${param.memberFilter}&sortBy=${param.sortBy}">끝</a></li>
	    </c:if>
	  </ul>
	</div> --%>
	<!-- 블록페이지 끝 -->
	
	
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

  <!-- 할 일 등록 모달 -->
  <div class="modal" id="addTaskModal" tabindex="-1" role="dialog" aria-labelledby="addTaskModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="addTaskModalLabel">새로운 할 일 등록</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
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
              <label for="taskCategory">카테고리</label>
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
              <label for="taskName">할 일 이름</label>
              <input type="text" class="form-control" id="task" name="task" required>
            </div>
            <div class="form-group">
              <label for="taskDescription">설명</label>
              <textarea class="form-control" id="description" name="description" rows="3"></textarea>
            </div>
            <div class="form-group">
					    <label for="memberIdx">담당자</label>
					    <select class="form-control" id="memberIdx" name="memberIdx" required>
					      <c:forEach var="member" items="${familyMembers}">
					        <option value="${member.memberIdx}">${member.memberName}</option>
					      </c:forEach>
					    </select>
					  </div>
            <div class="form-group">
					    <label for="endDate">마감일</label>
					    <input type="date" class="form-control" id="date" name="date" required>
					  </div>
					  <div class="form-group">
					    <label for="endTime">마감 시간</label>
					    <input type="time" class="form-control" id="time" name="time" required>
					  </div>
					  <div class="form-group">
					    <label>
					      <input type="checkbox" id="noRepeat" name="noRepeat"> 반복 없음
					    </label>
					  </div>
					  <div class="form-group" id="rotationPeriodGroup">
					    <label for="taskRotationPeriod">반복 주기 (일)</label>
					    <input type="number" class="form-control" id="rotationPeriod" name="rotationPeriod" required>
					  </div>
  					<input type="hidden" name="endDate" id="endDate" >
  					<input type="hidden" name="familyCode" value="${sFamCode}">
		      </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn modalBtn" onclick="addNewTask()">등록</button>
        </div>
      </div>
    </div>
  </div>
  
	<!-- 세부 정보 모달 -->
	<div class="modal" id="taskDetailModal" tabindex="-1" role="dialog" aria-labelledby="taskDetailModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="taskDetailModalLabel">할 일 세부 정보</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="task-detail-container">
	          <div class="task-detail-header">
	            <h4 id="taskTitle" class="mb-3"></h4>
	            <span id="taskStatus" class="task-status"></span>
	          </div>
	          <div class="task-detail-info">
	            <p><i class="fas fa-tag"></i> <span id="taskCategory"></span></p>
	            <p><i class="fas fa-user"></i> <span id="taskMemberName"></span></p>
	            <p><i class="fas fa-calendar-alt"></i> <span id="taskStartDate"></span> ~ <span id="taskEndDate"></span></p>
	            <p><i class="fas fa-hourglass-half"></i> 남은 시간: <span id="taskTimeLeft"></span></p>
	            <p><i class="fas fa-redo"></i> 반복 주기: <span id="taskRotationPeriod"></span></p>
	          </div>
	          <div class="task-detail-description mt-4">
	            <h5>설명</h5>
	            <p id="taskDescription"></p>
	          </div>
	        </div>
	      </div>
	      <div class="modal-footer">
				  <span id="taskButtons"></span>
				  <button type="button" class="btn btn-close" data-dismiss="modal">닫기</button>
				</div>
	    </div>
	  </div>
	</div>

  <!-- 할 일 수정 모달 -->
  <div class="modal" id="editTaskModal" tabindex="-1" role="dialog" aria-labelledby="editTaskModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editTaskModalLabel">할 일 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
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
            <label for="editTaskDueDate">마감일</label>
            <input type="date" class="form-control" id="editTaskDueDate" required>
          </div>
          <div class="form-group">
            <label for="editTaskDueTime">마감 시간</label>
            <input type="time" class="form-control" id="editTaskDueTime" required>
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
                <label class="form-check-label" for="editTaskStatusIncomplete">진행중</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="editTaskStatus" id="editTaskStatusComplete" value="완료" required>
                <label class="form-check-label" for="editTaskStatusComplete">완료</label>
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
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn modalBtn" onclick="updateTask()">수정</button>
      </div>
    </div>
  </div>
</div>
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>	