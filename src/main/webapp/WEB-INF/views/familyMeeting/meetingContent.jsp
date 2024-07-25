<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회의 상세 | HomeLink</title>
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
	    background-color: #f8f9fa;
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
	  .btn-danger {
	    background-color: #e63946;
	  }
	  .btn-danger:hover {
	    background-color: #c1121f;
	  }
	  .button-group {
	    display: flex;
	    justify-content: flex-start;
	    margin-top: 20px;
	  }
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
    
    
    function saveMeetingMinutes() {
    	showConfirm("회의 완료처리 및 회의록을 저장하시겠습니까?", function() {
    	
	      let decisions = $("#decisions").val();
	      let actionItems = $("#actionItems").val();
	      let notes = $("#notes").val();
	      
	      $.ajax({
	        type: "POST",
	        url: "${ctp}/familyMeeting/saveMeetingMinutes",
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
	            showAlert("회의록 저장에 실패했습니다. 다시 시도해주세요.", function() {
	            	location.reload();
        	    });
	          }
	        },
	        error: function() {
	        	showAlert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.", function() {
            	location.reload();
      	    });
	        }
	      });
    	});  
    }
    
    function meetingDelete(idx) {
		  showConfirm("정말로 이 회의를 삭제하시겠습니까?", function() {
		    location.href = "meetingDelete?idx="+idx;
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
      <a href="${ctp}/familyMeeting/meetingList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
      <h2 class="mb-4">회의 상세</h2>
    </div>
    
    <div class="card mb-4">
      <div class="card-body">
        <h3 class="card-title">${meeting.title}</h3>
        <span class="meeting-status meeting-status-${meeting.status == '예정' ? 'upcoming' : meeting.status == '진행 중' ? 'ongoing' : 'completed'}">
          ${meeting.status}
        </span>
        <p class="card-text">${meeting.description}</p>
        <p><strong>일시:</strong> ${fn:substring(meeting.meetingDate, 0, 16)}</p>
        <p><strong>진행자:</strong> ${meeting.facilitatorName}</p>
        <p><strong>기록자:</strong> ${meeting.recorderName}</p>
        <p><strong>참석자:</strong> ${meeting.attendees}</p>
        <p><strong>소요 시간:</strong> ${meeting.duration}분</p>
      </div>
    </div>
    
    <h4 class="mb-3">안건 목록</h4>
		<div class="topics-container">
		  <c:forEach var="topic" items="${topics}" varStatus="status">
		    <div class="topic-card">
		      <h5>${topic.title}</h5>
		      <p>${topic.description}</p>
		      <p><strong>우선순위:</strong> ${topic.priority} | <strong>상태:</strong> ${topic.status}</p>
		      <p><strong>제안자:</strong> ${topic.memberName} | <strong>논의 순서:</strong> ${status.index + 1}</p>
		    </div>
		  </c:forEach>
		</div>
    
    <h4 class="mb-3">회의록</h4>
    <form name="minutesForm">
      <div class="form-group">
        <label for="decisions">결정 사항</label>
        <textarea class="form-control" id="decisions" name="decisions" rows="3">${meeting.decisions}</textarea>
      </div>
      <div class="form-group">
        <label for="actionItems">실행 항목</label>
        <textarea class="form-control" id="actionItems" name="actionItems" rows="3">${meeting.actionItems}</textarea>
      </div>
      <div class="form-group">
        <label for="notes">기타 메모</label>
        <textarea class="form-control" id="notes" name="notes" rows="3">${meeting.notes}</textarea>
      </div>
      <div class="button-group">
		    <button type="button" class="btn" onclick="saveMeetingMinutes()">회의록 저장</button>
		    <a class="btn" href="${ctp}/meetingUpdate">회의 정보 수정</a>
		    <button type="button" class="btn btn-danger" onclick="meetingDelete()">회의 삭제</button>
		  </div>
    </form>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>