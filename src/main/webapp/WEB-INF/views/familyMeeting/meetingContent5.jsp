<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${meeting.title} | HomeLink</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
	  body {
	    font-family: 'Pretendard' !important;
	    background-color: #ffffff;
	  }
	  .header {
	    margin-bottom: 30px;
	  }
	  h1, h2, h3, h4, h5 {font-family: 'Pretendard' !important;}
	  .header .h2 {
	    font-family: 'pretendard' !important;
	    font-weight: 600;
	    font-size: 24px;
	    color: #333c47;
	    text-align: center;
	    margin-bottom: 30px;
	  }
	  .meetingContainer {
	    max-width: 900px;
	    background-color: white;
	    padding: 40px; 
	    margin: 30px auto;
	    border-radius: 8px;
	  }
	  .home-icon { 
	    font-size: 24px; 
	    color: #cecece; 
	  }
	  .home-icon:hover {color: #c6c6c6;}
	
	  .card {
	    border: 1px solid #e0e0e0;
	    border-radius: 8px;
	    margin-bottom: 20px;
	  }
	  .card-body {
	    padding: 20px;
	  }
	  .card-title {
	    color: #333c47;
	    font-weight: 600;
	    margin-bottom: 15px;
	  }
	  .meeting-status {
	    font-size: 14px;
	    padding: 6px 12px;
	    border-radius: 20px;
	    color: white;
	    display: inline-block;
	    margin-bottom: 15px;
	    font-weight: 500;
	  }
	  .meeting-status-upcoming { background-color: #84a98c; }
	  .meeting-status-ongoing { background-color: #f4a261; }
	  .meeting-status-completed { background-color: #6c757d; }
	  
	  .topics-container {
	    max-height: 400px;
	    overflow-y: auto;
	    border: 1px solid #e0e0e0;
	    border-radius: 8px;
	    padding: 20px;
	  }
	  .topic-card {
	    background-color: #fff;
	    border-left: 5px solid #84a98c;
	    margin-bottom: 15px;
	    padding: 15px;
	    border-radius: 0 8px 8px 0;
	  }
	  .topic-card:last-child {
	    margin-bottom: 0;
	  }
	  .topic-card h5 {
	    color: #333c47;
	    font-weight: 600;
	    margin-bottom: 10px;
	  }
	  .btn {
	    background-color: #84a98c;
	    color: white;
	    border: none;
	    border-radius: 0;
	    padding: 10px 20px;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	    font-weight: 600;
	    font-size: 14px;
	    text-transform: uppercase;
	    letter-spacing: 1px;
	    margin-right: 10px;
	  }
	  .btn:hover {
	    background-color: #6b8e76;
	  }
	  /* .button-group {
	    display: flex;
	    justify-content: flex-start;
	    margin-top: 20px;
	  } */
	  .form-group {
	    margin-bottom: 25px;
	  }
	  .form-control {
	    border: 1px solid #e0e0e0;
	    border-radius: 8px;
	    padding: 12px;
	    transition: border-color 0.3s ease;
	  }
	  .form-control:focus {
	    border-color: #84a98c;
	    box-shadow: 0 0 0 0.2rem rgba(132, 169, 140, 0.25);
	  }
	  label {
	    font-weight: 500;
	    color: #333c47;
	    margin-bottom: 8px;
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

    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
    }

    .swal2-confirm:hover {
      background-color: none !important;
    }
    
    
    .section {
		  margin-bottom: 40px;
		  padding: 20px;
		  background-color: #fff;
		  border-radius: 8px;
		}
		
		.section-title {
		  color: #333c47;
		  font-weight: 600;
		  margin-bottom: 20px;
		  padding-bottom: 10px;
		  text-align:center;
		}
		
    
		.button-group {
		  display: flex;
		  justify-content: center;
		  margin-top: 30px;
		}
		
		.card-header-buttons {
			text-align:right;
			margin-top:0;
			margin-bottom: 5px;
		}
		
		.btn-sm {
		  padding: 8px 15px;
		  font-size: 12px;
		  border-radius: 20px;
		}
		
		.btn-outline-primary, .btn-outline-danger {
		  background-color: transparent;
		  transition: all 0.3s ease;
		}
		
		.btn-outline-primary {
		  color: #84a98c;
		  border: 2px solid #84a98c;
		}
		
		.btn-outline-primary:hover {
		  color: #fff;
		  border: 2px solid #84a98c;
		  background-color: #84a98c;
		}
		
		.btn-outline-danger {
		  color: #e63946;
		  border: 2px solid #e63946;
		}
		
		.btn-outline-danger:hover {
		  color: #fff;
		  background-color: #e63946;
		}
		
	  .section-header {
		  position: relative;
		  text-align: center;
		  margin-bottom: 20px;
		}
		
		.section-title-withBtn {
		  display: inline-block;
		  margin: 0;
		  position: relative;
		  z-index: 1;
		  color: #333c47;
		  font-weight: 600;
		  margin-bottom: 20px;
		  padding-bottom: 10px;
		}
		
		.card-header-buttons {
		  position: absolute;
		  right: 0;
		  top: 50%;
		  transform: translateY(-50%);
		}
	  
	  .button-group {
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  margin-top: 30px;
		  gap: 20px; /* 버튼 사이의 간격 */
		}
		
		.btn-save, .btn-list {
		  display: inline-block;
		  width: 200px;
		  padding: 10px;
		  text-align: center;
		  text-decoration: none;
		}
		
		.btn-save {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		}
		
		.btn-save:hover {
		  background-color: #6b8e76;
		  color: white;
		}
		
		.btn-list {
		  background-color: #fff;
		  color: #333;
		  border: 1px solid #ccc;
		}
		
		.btn-list:hover {
		  color: #333;
		  background-color: #f8f8f8;
		  text-decoration: none;
		}
		
		.btn-save, .btn-list, .btn-edit {
		  display: inline-block;
		  width: 200px;
		  padding: 10px;
		  text-align: center;
		  text-decoration: none;
		}
		
		.btn-edit {
		  background-color: #6c757d;
		  color: white;
		  border: none;
		}
		
		.btn-edit:hover {
		  background-color: #5a6268;
		  color: white;
		}
		
		.meeting-minutes {
		  background-color: #ffffff;
		  border-radius: 8px;
		  padding: 30px;
		}
		
		.minutes-item {
		  background-color: #ffffff;
		  border-radius: 8px;
		  padding: 20px;
		  margin-bottom: 20px;
		}
		
		.minutes-item:last-child {
		  margin-bottom: 0;
		}
		
		.minutes-item h5 {
		  color: #333c47;
		  font-weight: 600;
		  margin-bottom: 15px;
		  padding-bottom: 10px;
		}
		
		.minutes-content {
		  color: #495057;
		  line-height: 1.6;
		  background-color: #f8f9fa;
		  padding: 15px;
		  border-radius: 6px;
		}
		
		
		.minutes-detail-container {
		  padding: 20px;
		}
		
		.minutes-header {
		  margin-bottom: 20px;
		}
		
		.minutes-detail-content {
		  max-height: 400px;
		  overflow-y: auto;
		}
		
		.modalBtn {
		  padding: 10px 20px;
		  border: none;
		  border-radius: 5px;
		  cursor: pointer;
		}
		
		.btn-close {
		  background-color: #6c757d;
		  color: white;
		}
		
		.btn-close:hover {
		  background-color: #5a6268;
		}
	</style>
  <script>
  
  	'use strict';

		//커스텀 알럿
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
		
		function meetingDelete(idx) {
		 showConfirm("정말로 이 회의를 삭제하시겠습니까?", function() {
		   location.href = "meetingDelete?idx="+idx;
		 });
		}
		
		//회의록 저장 함수 (완료 처리)
		function saveMeeting() {
		 showConfirm("회의 완료처리 및 회의록을 저장하시겠습니까?", function() {
		   if (typeof CKEDITOR !== 'undefined') {
		     let decisions = CKEDITOR.instances.decisions.getData();
		     let actionItems = CKEDITOR.instances.actionItems.getData();
		     let notes = CKEDITOR.instances.notes.getData();
		   
		     if(decisions.trim() == "") {
		       showAlert("결정 사항을 입력해주세요.");
		       CKEDITOR.instances.decisions.focus();
		       return false;
		     }
		     else if(actionItems.trim() == "") {
		       showAlert("실행 항목을 입력해주세요.");
		       CKEDITOR.instances.actionItems.focus();
		       return false;
		     }
		     else if(notes.trim() == "") {
		       showAlert("기타 메모를 입력해주세요.");
		       CKEDITOR.instances.notes.focus();
		       return false;
		     }
		
		     $.ajax({
		       type: "POST",
		       url: "${ctp}/familyMeeting/saveMeeting",
		       data: {
		         idx: ${meeting.idx},
		         decisions: decisions,
		         actionItems: actionItems,
		         notes: notes
		       },
		       success: function(res) {
		         if(res == 1) {
		           showAlert("회의록이 성공적으로 저장되었습니다.", function() {
		             location.reload();
		           });
		         }
		         else {
		           showAlert("회의록 저장에 실패했습니다. 다시 시도해주세요.");
		         }
		       },
		       error: function(xhr, status, error) {
		         console.error("Error details:", xhr.responseText);
		         showAlert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
		       }
		     });
		   } else {
		     console.error('CKEDITOR is not defined. Make sure the CKEditor script is loaded correctly.');
		     showAlert("에디터 초기화에 실패했습니다. 페이지를 새로고침한 후 다시 시도해주세요.");
		   }
		 });  
		}
		
		//페이지 로드 시 초기 설정
		document.addEventListener('DOMContentLoaded', function() {
		 if ('${meeting.status}' === '완료') {
		   displaySavedMinutes(
		     decodeURIComponent("${fn:replace(fn:replace(meeting.decisions, newLine, '\\n'), '"', '\\"')}"),
		     decodeURIComponent("${fn:replace(fn:replace(meeting.actionItems, newLine, '\\n'), '"', '\\"')}"),
		     decodeURIComponent("${fn:replace(fn:replace(meeting.notes, newLine, '\\n'), '"', '\\"')}")
		   );
		 } else {
		   initializeCKEditor();
		   document.querySelector('.btn-edit').style.display = 'none';
		 }
		});
		
		//저장된 회의록 표시
		function displaySavedMinutes(decisions, actionItems, notes) {
		 document.getElementById('decisions').innerHTML = decisions;
		 document.getElementById('actionItems').innerHTML = actionItems;
		 document.getElementById('notes').innerHTML = notes;
		
		 document.querySelector('.btn-save').style.display = 'none';
		 document.querySelector('.btn-edit').style.display = 'inline-block';
		}
		
		//CKEditor 초기화
		function initializeCKEditor() {
		 if (typeof CKEDITOR !== 'undefined') {
		   CKEDITOR.replace("decisions", {
		     height: 200,
		     toolbar: [
		       ['Bold', 'Italic', 'Underline', 'Strike'],
		       ['NumberedList', 'BulletedList'],
		       ['Undo', 'Redo'],
		       ['Source']
		     ],
		     removePlugins: 'elementspath',
		     resize_enabled: false
		   });
		
		   CKEDITOR.replace("actionItems", {
		     height: 200,
		     toolbar: [
		       ['Bold', 'Italic', 'Underline', 'Strike'],
		       ['NumberedList', 'BulletedList'],
		       ['Undo', 'Redo'],
		       ['Source']
		     ],
		     removePlugins: 'elementspath',
		     resize_enabled: false
		   });
		
		   CKEDITOR.replace("notes", {
		     height: 200,
		     toolbar: [
		       ['Bold', 'Italic', 'Underline', 'Strike'],
		       ['NumberedList', 'BulletedList'],
		       ['Undo', 'Redo'],
		       ['Source']
		     ],
		     removePlugins: 'elementspath',
		     resize_enabled: false
		   });
		 } else {
		   console.error('CKEDITOR is not defined. Make sure the CKEditor script is loaded correctly.');
		 }
		}
		
		//수정 모드 활성화
		function enableEditing() {
		 initializeCKEditor();
		 document.getElementById('editButton').style.display = 'none';
		 document.getElementById('saveButton').style.display = 'inline-block';
		}
		
		//수정된 회의록 저장
		function saveChanges() {
		 let decisions = CKEDITOR.instances.decisions.getData();
		 let actionItems = CKEDITOR.instances.actionItems.getData();
		 let notes = CKEDITOR.instances.notes.getData();
		
		 if(decisions.trim() == "") {
		   showAlert("결정 사항을 입력해주세요.");
		   CKEDITOR.instances.decisions.focus();
		   return false;
		 }
		 else if(actionItems.trim() == "") {
		   showAlert("실행 항목을 입력해주세요.");
		   CKEDITOR.instances.actionItems.focus();
		   return false;
		 }
		 else if(notes.trim() == "") {
		   showAlert("기타 메모를 입력해주세요.");
		   CKEDITOR.instances.notes.focus();
		   return false;
		 }
		 
		 $.ajax({
		   type: "POST",
		   url: "${ctp}/familyMeeting/saveMeeting",
		   data: {
		     idx: ${meeting.idx},
		     decisions: decisions,
		     actionItems: actionItems,
		     notes: notes
		   },
		   success: function(res) {
		     if(res == 1) {
		       showAlert("회의록이 수정되었습니다.", function() {
		         location.reload();
		       });
		     } 
		     else {
		       showAlert("회의록 수정에 실패했습니다. 다시 시도해주세요.");
		     }
		   },
		   error: function(xhr, status, error) {
		     console.error("Error details:", xhr.responseText);
		     showAlert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
		   }
		 });
		}
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
	<div class="meetingContainer">
	  <div class="header">
	    <a href="${ctp}/familyMeeting/meetingList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	    <font size="5" class="mb-4 h2">회의 상세보기</font>
	  </div>
	  
	  
	  <div class="section meeting-info">
		  <div class="section-header">
		    <h4 class="section-title-withBtn">회의 정보</h4>
		    <div class="card-header-buttons">
		      <c:if test="${meeting.status != '완료'}">
		        <a class="btn btn-sm btn-outline-primary" href="${ctp}/familyMeeting/meetingUpdate?idx=${meeting.idx}">수정</a>
		      </c:if>
		      <button type="button" class="btn btn-sm btn-outline-danger" onclick="meetingDelete()">삭제</button>
		    </div>
		  </div>
		  <div class="card mb-4">
		    <div class="card-body">
		      <h3 class="card-title">${meeting.title}</h3>
	        <span class="meeting-status meeting-status-${meeting.status == '예정' ? 'upcoming' : meeting.status == '진행 중' ? 'ongoing' : 'completed'}">
	          ${meeting.status}
	        </span>
	        <p class="card-text">${fn:replace(meeting.description, newLine, "<br/>")}</p>
	        <p><strong>일시:</strong> ${fn:substring(meeting.meetingDate, 0, 16)}</p>
	        <p><strong>진행자:</strong> ${meeting.facilitatorName}</p>
	        <p><strong>기록자:</strong> ${meeting.recorderName}</p>
	        <p><strong>소요 시간:</strong> ${meeting.duration}분</p>
	      </div>
	    </div>
	    
	   <span class="mb-3"><font size="3" class="note"><b>안건 목록</b></font></span>
	    <div class="topics-container mt-2">
	      <c:forEach var="topic" items="${topics}" varStatus="status">
	        <div class="topic-card">
	          <h5>${topic.title}</h5>
	          <p>${topic.description}</p>
	          <p><strong>우선순위:</strong> ${topic.priority} | <strong>상태:</strong> ${topic.status}</p>
	          <p><strong>제안자:</strong> ${topic.memberName} | <strong>논의 순서:</strong> ${status.index + 1}</p>
	        </div>
	      </c:forEach>
	    </div>
	  </div>
	  
	  <div class="section meeting-minutes">
		  <h4 class="section-title">회의록</h4>
		  <form name="minutesForm">
		    <div class="minutes-item">
		      <h5>결정 사항</h5>
		      <div id="decisions" class="minutes-content">${meeting.decisions}</div>
		    </div>
		    <div class="minutes-item">
		      <h5>실행 항목</h5>
		      <div id="actionItems" class="minutes-content">${meeting.actionItems}</div>
		    </div>
		    <div class="minutes-item">
		      <h5>기타 메모</h5>
		      <div id="notes" class="minutes-content">${meeting.notes}</div>
		    </div>
		  </form>
		</div>
		
		<div class="button-group">
		  <c:if test="${meeting.status != '완료'}">
		    <button type="button" class="btn-save" onclick="saveMeeting()">회의록 저장</button>
		  </c:if>
		  <c:if test="${meeting.status == '완료'}">
		    <button type="button" id="editButton" class="btn-edit" onclick="enableEditing()">회의록 수정</button>
		    <button type="button" id="saveButton" class="btn-save" onclick="saveChanges()" style="display: none;">수정하기</button>
		  </c:if>
		  <a href="meetingList" class="btn-list">목록</a>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>