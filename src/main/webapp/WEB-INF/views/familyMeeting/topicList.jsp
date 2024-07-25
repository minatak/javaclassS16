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
    .topic-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      background-color: #fff;
    }
    .topic-card:hover {
      transform: scale(1.02);
      box-shadow: 0 3px 6px rgba(0,0,0,0.07);
    }
    .topic-status {
      font-size: 12px;
      padding: 2px 5px;
      border-radius: 3px;
      color: white;
      display: inline-block;
      margin-bottom: 5px;
    }
    .topic-status-proposed {
      background-color: #84a98c;
    }
    .topic-title {
      margin: 5px 0;
      font-size: 16px;
      font-weight: bold;
      color: #333;
      overflow: hidden;
    }
    .topic-description {
      font-size: 14px;
      color: #555;
      margin-bottom: 5px;
      line-height: 1.4;
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
    .view-all-comments {
      cursor: pointer;
      color: #555;
      font-size: 14px;
      margin-top: 10px;
    }
    .add-comment {
      margin-top: 15px;
    }
    .comment-input {
      width: calc(100% - 70px);
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }
    .post-comment-btn {
      width: 60px;
      padding: 8px;
      background-color: #84a98c;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    /* 모달 스타일 */
    .modal-content {
      border-radius: 10px;
      border: none;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .comments-container {
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
    .modal-title {
      font-size: 24px;
      font-weight: 700;
      color: #333;
      margin-bottom: 20px;
    }
    #modalComments {
      max-height: 400px;
      overflow-y: auto;
    }
    .modal-comment {
      margin-bottom: 15px;
      padding-bottom: 15px;
      border-bottom: 1px solid #eee;
    }
    .modal-comment-username {
      font-weight: 600;
      color: #333;
      margin-right: 10px;
    }
    .modal-comment-content {
      color: #555;
      font-size: 16px;
    }
    .modal-comment-time {
      font-size: 12px;
      color: #888;
      margin-top: 5px;
    }
    .reply-btn, .delete-btn {
      cursor: pointer;
      color: #84a98c;
      margin-left: 10px;
      font-size: 14px;
    }
    .reply-form {
      margin-top: 10px;
    }
    .comment-input-re {
      width: calc(100% - 70px);
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }
    .comment-actions {
      display: flex;
      justify-content: flex-end;
      margin-top: 30px;
    }
    .modalBtn {
      border-radius: 10px;
      padding: 8px 20px;
      font-size: 14px;
      margin-left: 10px;
      border: none;
      transition: background-color 0.2s;
    }
    .modalBtn.btn-close {
      background-color: #6c757d;
      color: white;
    }
    .modalBtn.btn-close:hover {
      background-color: #5a6268;
    }
  </style>
  <script>
  	
  	'use strict';
  
	  let currentTopicIdx;
	
	  function showComments(topicIdx) {
		  currentTopicIdx = topicIdx;
		  $.ajax({
		    url: "${ctp}/familyMeeting/getComments",   
		    type: "GET",
		    data: {topicIdx: topicIdx},
		    success: function(comments) {
		      console.log("Received comments:", comments);
		      let commentHtml = '';
		      if (comments && comments.length > 0) {
		        comments.forEach(comment => {
		          commentHtml += `
		            <div class="modal-comment ${comment.parentIdx ? 'reply-comment' : ''}" id="comment${comment.idx}">
		              <span class="modal-comment-username">${comment.memberName}</span>
		              <span class="modal-comment-content">${comment.content}</span>
		              <div class="modal-comment-time">
		                ${comment.createdAt}
		                ${comment.memberIdx == ${sIdx} ? `<a href="javascript:replyDelete(${comment.idx})" title="댓글삭제" class="delete-btn">삭제</a>` : ''}
		                ${!comment.parentIdx ? `
		                  <span id="showReplyBtn${comment.idx}" class="reply-btn" onclick="replyShow(${comment.idx})">답글 달기</span>
		                  <span id="closeReplyBtn${comment.idx}" class="reply-btn" onclick="replyHide(${comment.idx})" style="display:none;">닫기</span>
		                ` : ''}
		              </div>
		              <div class="reply-form" id="replyForm${comment.idx}" style="display:none;">
		                <input type="text" id="contentRe${comment.idx}" placeholder="답글을 입력하세요..." class="comment-input-re" value="@${comment.memberName} ">
		                <button onclick="submitReply(${comment.idx}, ${topicIdx})">게시</button>
		              </div>
		            </div>
		          `;
		        });
		      } else {
		        commentHtml = '<p>아직 댓글이 없습니다.</p>';
		      }
		      $('#modalComments').html(commentHtml);
		      $('#commentsModal').modal('show');
		    },
		    error: function(xhr, status, error) {
		      console.error("Error fetching comments:", error);
		      showAlert("댓글을 불러오는 데 실패했습니다.");
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
	          showAlert("답변글 입력 실패~~");
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
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="topicContainer">
    <div class="header">
      <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
      <font size="5" class="mb-4 h2">제안된 안건 목록</font>
    </div>
    
    <div class="row">
      <c:forEach var="topic" items="${proposedTopics}">
			  <div class="col-md-6 mb-4">
			    <div class="topic-card">
			      <span class="topic-status topic-status-proposed">제안됨</span>
			      <h5 class="topic-title">${topic.title}</h5>
			      <p class="topic-description">${fn:substring(topic.description, 0, 100)}${fn:length(topic.description) > 100 ? '...' : ''}</p>
			      <p class="topic-info">
			        제안자: ${topic.memberName} | 우선순위: ${topic.priority} | 
			        상태: ${topic.status}
			      </p>
			      <button class="btn btn-sm" onclick="approveTopic(${topic.idx})">승인</button>
			      <div class="view-all-comments mb-4" onclick="showComments(${topic.idx})">
			        댓글 ${topic.replyCnt}개 모두 보기
			      </div>
			      <div class="add-comment">
			        <input type="text" id="content-${topic.idx}" class="comment-input" placeholder="댓글 달기...">
			        <button class="post-comment-btn" onclick="replyCheck(${topic.idx})">게시</button>
			      </div>
			    </div>
			  </div>
			</c:forEach>
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
        <div class="comment-actions mt-4">
          <button type="button" class="modalBtn btn-close" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>