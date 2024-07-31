<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>제안된 안건 목록 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      font-family: 'Pretendard';
      background-color: #ffffff;
    }
    .header {
      margin-bottom: 50px;
    }
    .header .h2 {
      font-family: 'Pretendard', sans-serif;
      font-weight: 600;
      font-size: 24px;
      color: #333c47;
      text-align: center;
      margin-bottom: 50px;
    }
    .topicContainer {
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
    .topic-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
      width: 260px;
      height: 380px;
      display: flex;
      flex-direction: column;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      box-sizing: border-box;
      background-color: #fff;
    }
    .topic-card:hover {
      transform: scale(1.02);
      box-shadow: 0 3px 6px rgba(0,0,0,0.07);
    }
    .topic-icon-container {
      height: 35%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 5px 0;
      background-color: #f0f5f1;
    }
    .topic-icon {
      font-size: 36px;
      color: #b8c9bc;
    }
    .topic-content {
      height: 65%;
      background-color:#fff;
      padding: 10px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .topic-actions {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }
    .topic-status {
      font-size: 12px;
      padding: 4px 8px;
      border-radius: 20px;
      color: white;
      display: inline-block; 
      margin-bottom: 10px;
      font-weight: 600;
    }
    .topic-status-제안됨 { background-color: #84a98c; }
    .topic-status-승인됨 { background-color: #52796f; }
    .topic-status-예정 { background-color: #354f52; }
    .topic-status-논의중 { background-color: #2f3e46; }
    .topic-content {
      height: 65%;
      background-color:#fff;
      padding: 15px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .topic-btn {
      background: none;
      border: none;
      color: #84a98c;
      cursor: pointer;
      font-size: 0.9em;
      padding: 5px 10px;
      text-decoration: none;
      border-radius: 5px;
      transition: background-color 0.3s, color 0.3s;
    }
    .topic-btn:hover {
      background-color: #84a98c;
      color: white;
    }
    .topic-title {
      margin: 10px 0;
      font-size: 18px;
      font-weight: bold;
      color: #333;
      overflow: hidden;
    }
    .topic-description {
      font-size: 14px;
      color: #555;
      margin-bottom: 10px;
      line-height: 1.5;
      overflow: hidden;
    }
    .topic-info {
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
    .filter-buttons {
      margin-bottom: 30px;
    }
    .filter-btn {
      margin: 0 5px;
      padding: 8px 15px;
      border: none;
      border-radius: 20px;
      background-color: #e9ecef;
      color: #495057;
      cursor: pointer;
      transition: all 0.3s ease;
      font-weight: 600;
    }
    .filter-btn.active {
      background-color: #84a98c;
      color: white;
    }
    .filter-btn:hover {
      background-color: #6b8e76;
      color: white;
    }
    .topic-list-item {
      border: none;
      padding: 20px;
      margin-bottom: 20px;
      cursor: pointer;
      overflow: hidden;
      border-radius: 12px;
      background-color: #fff;
    }
    .topic-list-item:hover {
      background-color: #fff; 
    }
    
    /* 모달 스타일 */
    .modal-content {
      border-radius: 15px;
      border: none;
    }
    .comments-container {
      padding: 30px;
      max-height: 80vh;
      overflow-y: auto;
    }
    .close {
      position: absolute;
      right: 20px;
      top: 20px;
      font-size: 24px;
      color: #adb5bd;
      background: none;
      border: none;
      cursor: pointer;
    }
    .modal-title {
      font-weight: 600;
      color: #333c47;
      margin-bottom: 20px;
      font-size: 21px;
    }
    .comments-container {
      padding: 20px;
    }
    .modal-comment {
      padding: 15px;
      margin-bottom: 15px;
    }
    .reply-comment {
      margin-left: 20px;
      border-left: none;
      padding-left: 0;
    }
    .modal-comment-username {
      font-weight: 600;
      color: #333c47;
      margin-right: 10px;
    }
    .modal-comment-content {
      color: #495057;
      margin-top: 5px;
      line-height: 1.5;
    }
    .modal-comment-time {
      font-size: 0.8em;
      color: #6c757d;
      margin-top: 5px;
    }
    .delete-btn {
      color: #84a98c;
      margin-left: 10px;
      font-size: 0.9em;
      text-decoration: none;
    }
    .delete-btn:hover {
      text-decoration: underline;
    }
    .comment-input-area {
      display: flex;
      margin-top: 20px;
      padding: 5px;
    }
    #newCommentInput {
      flex-grow: 1;
      padding: 10px 15px;
      border: none;
      background: transparent;
      font-size: 14px;
    }
    .btn-submit {
      background-color: #84a98c;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .btn-submit:hover {
      background-color: #52796f;
    }
    select {
      background-color: white;
      border: 1px solid #ced4da;
      padding: 8px;
      font-size: 14px;
    }
    
    .modal-content {
		  border-radius: 10px;
		  border: none;
		  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
		}
		
		.task-detail-container, .task-form-container {
		  padding: 30px;
		  position: relative;
		}
		
		.close {
		  position: absolute;
		  top: 20px;
		  right: 20px;
		  font-size: 24px;
		  color: #84a98c;
		  opacity: 0.7;
		  transition: opacity 0.2s;
		}
		
		.close:hover {
		  opacity: 1;
		}
		
		.task-header {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  margin-bottom: 20px;
		}
		    
		.modalBtn {
		  border-radius: 10px;
		  padding: 8px 20px;
		  font-size: 14px;
		  margin-left: 10px;
		  border: none;
		  transition: background-color 0.2s;
		}
		
		.modalBtn.btn-primary {
		  background-color: #84a98c;
		  color: white;
		  padding: 8px 20px;
		  margin-left: 0px;
		}
		
		.modalBtn.btn-primary:hover {
		  background-color: #5d9469;
		}
		
		.modalBtn.btn-secondary {
		  background-color: #6c757d;
		  color: white;
		}
		
		.modalBtn.btn-secondary:hover {
		  background-color: #5a6268;
		}
		
		.modalBtn.btn-close {
		  background-color: #6c757d;
		  color: white;
		}
		
		.modalBtn.btn-close:hover {
		  background-color: #5a6268;
		}
		
		.form-group label {
		  font-weight: 600;
		  color: #333;
		  margin-bottom: 5px;
		}
		.modal-title {
		  font-size: 24px;
		  font-weight: 700;
		  color: #333;
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
    
  	
	  let currentTopicIdx;
	  let topicIdx;
	  
		// 페이지 로드 시 현재 사용자의 idx를 설정
		var sIdx;
		$(document).ready(function() {
		  sIdx = ${sessionScope.sIdx}; // 또는 적절한 방식으로 현재 사용자의 ID를 설정
		});
	
	  function showComments(topicIdx) {
		  $.ajax({
		    url: "${ctp}/familyMeeting/getComments",   
		    type: "GET",
		    data: {topicIdx: topicIdx},
		    success: function(comments) {
		      let commentHtml = '';
		      if (comments && comments.length > 0) {
		        comments.forEach(function(comment) {
		          commentHtml += '<div class="modal-comment ' + (comment.parentIdx !== 0 ? 'reply-comment' : '') + '" id="comment' + comment.idx + '">';
		          commentHtml += '<span class="modal-comment-username">' + comment.memberName + '</span>';
		          commentHtml += '<span class="modal-comment-content">' + comment.content + '</span>';
		          commentHtml += '<div class="modal-comment-time">' + comment.createdAt;
		          
		          if (comment.memberIdx == sIdx) {
		            commentHtml += ' <a href="javascript:replyDelete(' + comment.idx + ')" title="댓글삭제" class="delete-btn">삭제</a>';
		          }
		          
		          commentHtml += '</div>';
		        });
		      } else {
		        commentHtml = '<p>아직 댓글이 없습니다.</p>';
		      }
		      $('#modalComments').html(commentHtml);
		      $('#commentsModal').modal('show');
		    },
		    error: function(xhr, status, error) {
		      console.error("Error fetching comments:", error);
		      alert("댓글을 불러오는 데 실패했습니다.");
		    }
		  });
		}

	
	  function replyCheck(topicIdx) {
	    let content = $(`#content-${topicIdx}`).val();
	    if(content.trim() == "") {
	      showAlert("댓글을 입력하세요");
	      return false;
	    }
	    let query = {
	      topicIdx: topicIdx,
	      mid: '${sMid}',
	      name: '${sName}',
	      content: content
	    }
	    
	    $.ajax({
	      url  : "${ctp}/topic/replyInput",
	      type : "post",
	      data : query,
	      success:function(res) {
	        if(res != "0") {
	          showAlert("댓글이 입력되었습니다.", function() {
	            location.reload();
	          });
	        }
	        else showAlert("댓글 입력에 실패했습니다");
	      },
	      error : function() {
	        showAlert("전송 오류!");
	      }
	    });
	  }
	
	  function replyDelete(idx) {
	    showConfirm('정말로 이 댓글을 삭제하시겠습니까?', function() {
	      $.ajax({
	        url: `${ctp}/topic/replyDelete`,
	        type: "POST",
	        data: {idx: idx},
	        success: function(res) {
	          if (res == "1") {
	            showAlert("댓글이 삭제되었습니다.", function() {
	              location.reload();
	            });
	          } else {
	            showAlert("댓글 삭제에 실패했습니다.");
	          }
	        },
	        error: function() {
	          showAlert("전송오류!");
	        }
	      });
	    });
	  }
	
	  function replyShow(idx) {
	    $(`#replyForm${idx}`).show();
	    $(`#showReplyBtn${idx}`).hide();
	    $(`#closeReplyBtn${idx}`).show();
	  }
	
	  function replyHide(idx) {
	    $(`#replyForm${idx}`).hide();
	    $(`#showReplyBtn${idx}`).show();
	    $(`#closeReplyBtn${idx}`).hide();
	  }
	
	  function submitReply(parentIdx, topicIdx) {
	    let content = $(`#contentRe${parentIdx}`).val();
	    if(content.trim() == "") {
	      showAlert("답변글을 입력하세요");
	      $(`#contentRe${parentIdx}`).focus();
	      return false;
	    }
	    let query = {
	      topicIdx: topicIdx,
	      parentIdx: parentIdx,
	      mid: '${sMid}',
	      name: '${sName}',
	      content: content
	    };
	    $.ajax({
	      url: "${ctp}/topic/replyInputRe",
	      type: "POST",
	      data: query,
	      success: function(res) {
	        if (res !== "0") {
	          showAlert("답글이 입력되었습니다.", function() {
	            location.reload();
	          });
	        } else {
	          showAlert("답변글 입력에 실패했습니다.");
	        }
	      },
	      error: function() {
	        showAlert("전송오류!");
	      }
	    });
	  }
	
	  function showAlert(message, callback) {
	    alert(message);
	    if (callback) callback();
	  }
	
	  function showConfirm(message, callback) {
	    if (confirm(message)) {
	      callback();
	    }
	  }
	  
	  function proposeTopic() {
      location.href = "${ctp}/familyMeeting/topicInput";
    }
	  
	  function viewMeetingList() {
      location.href = "${ctp}/familyMeeting/meetingList";
    }
	  
	  function filterTopics(status) {
	    location.href = '${ctp}/familyMeeting/topicList?status=' + status;
		}
	  
	  function editTopic(topicIdx) {
		  location.href = '${ctp}/familyMeeting/topicUpdate?idx='+topicIdx;
		}

		function deleteTopic(topicIdx) {
		  if (confirm('정말로 이 안건을 삭제하시겠습니까?')) {
		    // AJAX를 사용하여 서버에 삭제 요청
		    $.ajax({
		      url: '${ctp}/familyMeeting/topicDelete',
		      type: 'POST',
		      data: { idx: topicIdx },
		      success: function(res) {
		        if (res != 0) {
		          showAlert("안건이 삭제되었습니다.", function() {
		            location.reload();
		          });
		        } else {
		        	showAlert('안건 삭제에 실패했습니다.');
		        }
		      },
		      error: function() {
		    	  showAlert('서버와의 통신 중 오류가 발생했습니다.');
		      }
		    });
		  }
		}
		
		
		function replyInput(topicIdx) {
		  let content = $('#newCommentInput').val();
		  if(content.trim() == "") {
		    alert("댓글을 입력하세요");
		    return false;
		  }
		  
		  $.ajax({
		    url: "${ctp}/familyMeeting/replyInput",
		    type: "POST",
		    data: {
		      topicIdx: topicIdx,
		      content: content
		    },
		    success: function(res) {
		      if(res != "0") {
		        alert("댓글이 입력되었습니다.");
		        $('#newCommentInput').val('');
		        showComments(topicIdx);
		      }
		      else alert("댓글 입력에 실패했습니다");
		    },
		    error: function() {
		      alert("전송 오류!");
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
	
	    // 안건 제안 모달의 날짜 최소값 설정
	    document.getElementById('date').min = today;
	  });
	
	  function proposeTopic() {
	    $('#addTopicModal').modal('show');
	  }
	
	  function addNewTopic() {
	    let title = addTopicForm.title.value;
	    let description = addTopicForm.description.value;
	    let priority = addTopicForm.priority.value;
	    let date = addTopicForm.date.value;
	    
	    // 유효성 검사
	    if(title.trim() === "") {
	      showAlert("안건 제목을 입력해주세요.", function() {
	        addTopicForm.title.focus();
	      });
	      return false;
	    }
	    if(description.trim() === "") {
	      showAlert("안건 설명을 입력해주세요.", function() {
	        addTopicForm.description.focus();
	      });
	      return false;
	    }
	    if(priority === "") {
	      showAlert("우선순위를 선택해주세요.", function() {
	        addTopicForm.priority.focus();
	      });
	      return false;
	    }
	    if(date === "") {
	      showAlert("날짜를 선택해주세요.", function() {
	        addTopicForm.date.focus();
	      });
	      return false;
	    }
	    
	    addTopicForm.submit();
	  }
	
	  function editTopic(idx) {
	    $.ajax({
	      url: '${ctp}/familyMeeting/getTopicDetails',
	      type: 'GET',
	      data: { idx: idx },
	      success: function(topic) {
	        $('#editTopicIdx').val(topic.idx);
	        $('#editTopicTitle').val(topic.title);
	        $('#editTopicDescription').val(topic.description);
	        $('#editTopicPriority').val(topic.priority);
	        $('#editTopicDate').val(topic.createdAt.substring(0, 10));
	        $('#editTopicStatus').val(topic.status);
	        
	        $('#editTopicModal').modal('show');
	      },
	      error: function(xhr, status, error) {
	        console.error("Error fetching topic details for edit:", xhr.responseText);
	        showAlert('안건 정보를 불러오는데 실패했습니다.');
	      }
	    });
	  }
	
	  function updateTopic() {
	    let idx = $('#editTopicIdx').val();
	    let title = $('#editTopicTitle').val();
	    let description = $('#editTopicDescription').val();
	    let priority = $('#editTopicPriority').val();
	    let date = $('#editTopicDate').val();
	    let status = $('#editTopicStatus').val();
	    
	    // 유효성 검사
	    if(title.trim() === "") {
	      showAlert("안건 제목을 입력해주세요.");
	      return false;
	    }
	    if(description.trim() === "") {
	      showAlert("안건 설명을 입력해주세요.");
	      return false;
	    }
	    if(priority === "") {
	      showAlert("우선순위를 선택해주세요.");
	      return false;
	    }
	    if(date === "") {
	      showAlert("날짜를 선택해주세요.");
	      return false;
	    }
	    
	    $.ajax({
	      url: '${ctp}/familyMeeting/updateTopic',
	      type: 'POST',
	      data: {
	        idx: idx,
	        title: title,
	        description: description,
	        priority: priority,
	        createdAt: date,
	        status: status
	      },
	      success: function(response) {
	        showAlert("안건이 수정되었습니다.", function() {
	          $('#editTopicModal').modal('hide');
	          location.reload();
	        });
	      },
	      error: function(xhr, status, error) {
	        console.error("Error updating topic:", error);
	        showAlert('안건 수정에 실패했습니다.');
	      }
	    });
	  }
	
	  function deleteTopic(idx) {
	    showConfirm("이 안건을 삭제하시겠습니까?", function() {
	      $.ajax({
	        url: '${ctp}/familyMeeting/deleteTopic',
	        type: 'POST',
	        data: { idx: idx },
	        success: function(response) {
	          showAlert("안건이 삭제되었습니다.", function() {
	            location.reload();
	          });
	        },
	        error: function(xhr, status, error) {
	          console.error("Error deleting topic:", error);
	          showAlert('안건 삭제에 실패했습니다.');
	        }
	      });
	    });
	  }
	
	  function filterTopics(status) {
	    location.href = '${ctp}/familyMeeting/topicList?status=' + status;
	  }
	
	  function viewMeetingList() {
	    location.href = '${ctp}/familyMeeting/meetingList';
	  }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="topicContainer">
    <div class="header">
      <a href="${ctp}/familyMeeting/meetingList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
      <font size="5" class="mb-4 h2">제안된 안건 목록</font>
    </div>
    
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <select class="form-select" onchange="filterTopics(this.value)">
          <option value="all" ${currentStatus == 'all' ? 'selected' : ''}>전체</option>
          <option value="제안됨" ${currentStatus == '제안됨' ? 'selected' : ''}>제안됨</option>
          <option value="예정" ${currentStatus == '예정' ? 'selected' : ''}>예정됨</option>
          <option value="결정됨" ${currentStatus == '결정됨' ? 'selected' : ''}>결정됨</option>
        </select>
      </div>
      <div>
        <button type="button" class="btn btn-primary me-2" onclick="proposeTopic()">
          <i class="fas fa-plus"></i> 안건 제안하기
        </button>
        <button type="button" class="btn btn-secondary" onclick="viewMeetingList()">
          <i class="fas fa-lightbulb"></i> 회의 목록 보기
        </button>
      </div>
    </div>
  
    <div id="cardView">
      <div class="row">
        <c:forEach var="topic" items="${proposedTopics}">
          <div class="col-md-4 mb-4">
            <div class="topic-card">
              <div class="topic-icon-container">
                <i class="fas fa-clipboard-list topic-icon"></i>
              </div>
              <div class="topic-content">
                <span class="topic-status topic-status-${topic.status}">${topic.status}</span>
                <h5 class="topic-title">${topic.title}</h5>
                <p class="topic-description">${fn:substring(topic.description, 0, 50)}${fn:length(topic.description) > 50 ? '...' : ''}</p>
                <p class="topic-info">
                  제안자: ${topic.memberName} | 우선순위: ${topic.priority}
                </p>
                <div class="topic-actions">
                  <button class="topic-btn" onclick="showComments(${topic.idx})">댓글 보기</button>
                  <c:if test="${topic.memberIdx == sessionScope.sIdx}">
                    <button class="topic-btn" onclick="editTopic(${topic.idx})">수정</button>
                    <button class="topic-btn" onclick="deleteTopic(${topic.idx})">삭제</button>
                  </c:if>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
    
    <!-- 블록페이지 시작 -->
    <div class="d-flex justify-content-center my-4">
      <ul class="pagination justify-content-center">
        <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="topicList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
        <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="topicList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
        <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
          <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="topicList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
          <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="topicList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        </c:forEach>
        <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="topicList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
        <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="topicList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
      </ul>
    </div>
    <!-- 블록페이지 끝 -->
    
  </div>
</div>

<!-- 안건 등록 모달 -->
<div class="modal" id="addTopicModal" tabindex="-1" role="dialog" aria-labelledby="addTopicModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="task-form-container">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title mb-4">새로운 안건 제안</h4>
        <form id="addTopicForm" method="post" action="${ctp}/familyMeeting/topicInput">
          <div class="form-group">
            <label for="title">안건 제목 *</label>
            <input type="text" class="form-control" id="title" name="title" required>
          </div>
          <div class="form-group">
            <label for="description">안건 설명 *</label>
            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
          </div>
          <div class="form-group">
            <label for="priority">우선순위 *</label>
            <select class="form-control" id="priority" name="priority" required>
              <option value="">선택</option>
              <option value="1">1 (최고 우선순위)</option>
              <option value="2">2 (높음)</option>
              <option value="3">3 (중간)</option>
              <option value="4">4 (낮음)</option>
              <option value="5">5 (매우 낮음)</option>
            </select>
          </div>
          <div class="form-group">
            <label for="date">날짜 *</label>
            <input type="date" class="form-control" id="date" name="date" required>
          </div>
          <input type="hidden" name="familyCode" value="${sFamCode}">
          <div class="task-actions mt-4">
            <button type="button" class="modalBtn btn-secondary" data-dismiss="modal">취소</button>
            <button type="button" class="modalBtn btn-primary" onclick="addNewTopic()">제안</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- 안건 수정 모달 -->
<div class="modal" id="editTopicModal" tabindex="-1" role="dialog" aria-labelledby="editTopicModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="task-form-container">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title mb-4">안건 수정</h4>
        <form name="editTopicForm" method="post">
          <input type="hidden" id="editTopicIdx">
          <div class="form-group">
            <label for="editTopicTitle">안건 제목 *</label>
            <input type="text" class="form-control" id="editTopicTitle" required>
          </div>
          <div class="form-group">
            <label for="editTopicDescription">안건 설명 *</label>
            <textarea class="form-control" id="editTopicDescription" rows="3" required></textarea>
          </div>
          <div class="form-group">
            <label for="editTopicPriority">우선순위 *</label>
            <select class="form-control" id="editTopicPriority" required>
              <option value="1">1 (최고 우선순위)</option>
              <option value="2">2 (높음)</option>
              <option value="3">3 (중간)</option>
              <option value="4">4 (낮음)</option>
              <option value="5">5 (매우 낮음)</option>
            </select>
          </div>
          <div class="form-group">
            <label for="editTopicDate">날짜 *</label>
            <input type="date" class="form-control" id="editTopicDate" required>
          </div>
          <div class="form-group">
            <label for="editTopicStatus">상태 *</label>
            <select class="form-control" id="editTopicStatus" required>
              <option value="제안됨">제안됨</option>
              <option value="예정">예정</option>
              <option value="결정됨">결정됨</option>
            </select>
          </div>
          <div class="task-actions mt-4">
            <button type="button" class="modalBtn btn-secondary" data-dismiss="modal">취소</button>
            <button type="button" class="modalBtn btn-primary" onclick="updateTopic()">수정</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- 댓글 모달 -->
<div class="modal" id="commentsModal" tabindex="-1" aria-labelledby="commentsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="comments-container">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="commentsModalLabel">댓글</h4>
        <div id="modalComments">
          <!-- 댓글 내용이 여기에 동적으로 삽입됩니다 -->
        </div>
        <div class="comment-input-area">
          <input type="text" id="newCommentInput" placeholder="새 댓글을 입력하세요...">
          <button type="button" class="btn btn-submit ml-2" onclick="replyInput(topicIdx)">작성</button>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>