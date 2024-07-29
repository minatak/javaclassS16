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
      font-family: 'Pretendard', sans-serif;
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
      border: none;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 30px;
      width: 100%;
      height: 320px;
      display: flex;
      flex-direction: column;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      box-sizing: border-box;
      background-color: #fff;
    }
    .topic-card:hover {
      transform: translateY(-5px);
    }
    .topic-icon-container {
      height: 35%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 10px 0;
      background-color: #e9ecef;
      border-radius: 5px;
    }
    .topic-icon {
      font-size: 40px;
      color: #84a98c;
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
      /* transition: transform 0.3s ease, box-shadow 0.3s ease; */
      cursor: pointer;
      overflow: hidden;
      border-radius: 12px;
      background-color: #fff;
    }
    .topic-list-item:hover {
      background-color: #f8f9fa; 
    /*   transform: translateY(-3px); */
     /*  box-shadow: 0 4px 8px rgba(0,0,0,0.15); */
    }
    
    /* 모달 스타일 */
    .modal-content {
      border-radius: 15px;
      border: none;
      box-shadow: 0 5px 25px rgba(0,0,0,0.1);
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
      font-size: 24px;
    }
    
    /* 댓글 스타일 */
    .modal-content {
    border-radius: 8px;
  }
  
  .comments-container {
    padding: 20px;
  }
  
  .modal-comment {
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 15px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
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
  
  .reply-btn, .delete-btn {
    color: #84a98c;
    margin-left: 10px;
    font-size: 0.9em;
    text-decoration: none;
  }
  
  .reply-btn:hover, .delete-btn:hover {
    text-decoration: underline;
  }
  
  .comment-input-area {
    display: flex;
    margin-top: 20px;
    background-color: #f1f3f5;
    border-radius: 8px;
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
  </style>
  <script>
  	
  	'use strict';
  
	  let currentTopicIdx;
	  
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
		          
		          if (comment.parentIdx === 0) {
		            commentHtml += ' <span id="showReplyBtn' + comment.idx + '" class="reply-btn" onclick="replyShow(' + comment.idx + ')">답글 달기</span>';
		            commentHtml += ' <span id="closeReplyBtn' + comment.idx + '" class="reply-btn" onclick="replyHide(' + comment.idx + ')" style="display:none;">닫기</span>';
		          }
		          
		          commentHtml += '</div>';
		          commentHtml += '<div class="reply-form" id="replyForm' + comment.idx + '" style="display:none;">';
		          commentHtml += '<input type="text" id="contentRe' + comment.idx + '" placeholder="답글을 입력하세요..." class="comment-input-re" value="@' + comment.memberName + ' ">';
		          commentHtml += '<button onclick="submitReply(' + comment.idx + ', ' + topicIdx + ')">게시</button>';
		          commentHtml += '</div></div>';
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
	  
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="topicContainer">
    <div class="header">
      <a href="${ctp}/familyMeeting/meetingList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
      <h2 class="mb-4 h2">제안된 안건 목록</h2>
    </div>
    
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div class="filter-buttons">
        <button class="filter-btn ${currentStatus == 'all' ? 'active' : ''}" onclick="filterTopics('all')">전체</button>
        <button class="filter-btn ${currentStatus == '제안됨' ? 'active' : ''}" onclick="filterTopics('제안됨')">제안됨</button>
        <button class="filter-btn ${currentStatus == '승인됨' ? 'active' : ''}" onclick="filterTopics('승인됨')">승인됨</button>
        <button class="filter-btn ${currentStatus == '예정' ? 'active' : ''}" onclick="filterTopics('예정')">예정</button>
      </div>
      <div>
        <button type="button" class="btn" onclick="proposeTopic()">
          <i class="fas fa-plus"></i> 안건 제안하기
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
					        <button class="btn btn-link" onclick="showComments(${topic.idx})">댓글 보기</button>
					        <c:if test="${topic.memberIdx == sessionScope.sIdx}">
					          <button class="btn btn-link" onclick="editTopic(${topic.idx})">수정</button>
					          <button class="btn btn-link" onclick="deleteTopic(${topic.idx})">삭제</button>
					        </c:if>
					      </div>
					    </div>
					  </div>
					</div>
        </c:forEach>
      </div>
    </div>
    
  </div>
</div>

<!-- 댓글 모달 -->
<div class="modal fade" id="commentsModal" tabindex="-1" aria-labelledby="commentsModalLabel" aria-hidden="true">
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
          <button type="button" class="btn btn-submit" onclick="submitNewComment()">작성</button>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>