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
  <title>${vo.title} | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
   <style>
     body {
      font-family: 'Pretendard' !important;
      background-color: #ffffff;
      color: #333333;
    }
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .home-icon:hover {color: #c6c6c6;}
    .noticeContainer {
      max-width: 900px;
      margin: 40px auto;
      background-color: #fff;
      padding: 40px;
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
    
    h2 {
      font-family: 'Pretendard' !important; 
      color: #333;
      font-size: 24px;
      font-weight: 700 !important;
      text-align: center;
      margin-bottom: 40px;
    }
    
    .notice-info {
      margin-bottom: 20px;
      /* border-top: 2px solid #333; */
      border-bottom: 1px solid #e4e6eb;
      padding: 20px 0;
    }
    
    .notice-info h3 {
      font-size: 18px;
      font-weight: 700;
      margin-bottom: 10px;
    }
    
    .notice-meta {
      font-size: 14px;
      color: #666;
    }
    
    .notice-content {
		  padding: 20px 0;
		  line-height: 1.6;
		  min-height: 200px;
		  max-width: 100%; /* 컨텐츠의 최대 너비를 컨테이너에 맞춤 */
		}
		
		.notice-content img {
		  max-width: 100%;
		  height: auto;
		  display: block;
		  margin: 10px 0;
		}
    
    .interaction-bar {
      padding: 20px 0;
      display: flex;
      justify-content: flex-end;
      color: #666;
      border-top: 1px solid #e4e6eb;
      font-size: 18px;
    }
    
    .interaction-icon {
      color: #84a98c;
      cursor: pointer;
      margin-right: 5px;
      margin-top: 5px;
    }
    
    /* .comment-section {
      margin-top: 40px;
    }
    
    .comment {
      padding: 15px 0;
      border-top: 1px solid #e4e6eb;
    }
    
    .comment-author {
      font-weight: 600;
      margin-right: 8px;
    } */
    
    .navigation-links {
      margin-top: 40px;
      font-size: 14px;
    }
    
    .navigation-links a {
      color: #333;
      text-decoration: none;
      display: block;
      padding: 10px 0;
      border-top: 1px solid #e4e6eb;
    }
    
    .navigation-links a:last-child {
      border-bottom: 1px solid #e4e6eb;
    }
    
    .navigation-icon {
      color: #84a98c;
      margin-right: 8px;
    }

    .btn-list {
      display: block;
      width: 100px;
      margin: 40px auto 0;
      padding: 10px;
      text-align: center;
      background-color: #fff;
      color: #333;
      border: 1px solid #ccc;
      text-decoration: none;
    }

    .btn-list:hover {
      background-color: #f8f8f8;
    }
    .btn-edit {
      width: 60px;
      /* margin: 40px auto 0; */
      padding: 10px;
      background-color: #fff;
      color: #333; 
      border: 1px solid #ccc;
      text-decoration: none;
    }
 
    .btn-edit:hover {
      background-color: #f8f8f8;
    }
    .action-buttons .btn {
		  margin-left: 10px;
		}
		
		.notice-meta {
		  font-size: 14px;
		  color: #666;
		  margin-bottom: 10px;
		}
		
		.notice-meta span {
		  margin-right: 10px;
		}
		
		.notice-meta i {
		  margin-right: 3px;
		}
		/* 
		.comment-input-container {
		  position: relative;
		  margin-bottom: 40px;
		}
		
	  
	  
	  .comment-section {
		  margin-top: 40px;
		  /* border-top: 1px solid #e0e0e0; */
		  padding-top: 30px;
		}
		
		.comment-section h4 {
		  font-size: 18px;
		  color: #333;
		  margin-bottom: 20px;
		}
		
		.comment-input-container {
		  margin-bottom: 30px;
		}
		
		.comment-input {
		  width: 100%;
		  padding: 15px;
		  border: 1px solid #e0e0e0;
		  border-radius: 4px;
		  font-size: 14px; 
		  resize: vertical;
		  min-height: 100px;
		}
		
		.comment-input:focus {
		  outline: none;
		  border-color: #84a98c;
		}
		
		.btn-comment {
		  background-color: #84a98c;
		  color: #fff;
		  border: none;
		  padding: 8px 16px;
		  border-radius: 4px;
		  font-size: 14px;
		  font-weight: 500;
		  margin-top: 10px;
		  transition: background-color 0.2s ease;
		}
		
		.btn-comment:hover {
		  background-color: #6b8e72;
		}
		
		.comment {
		  padding: 20px 0;
		}
		
		.comment:not(.reply) {
		  border-bottom: 1px solid #e0e0e0;
		}
		
		.comment-author {
		  font-weight: 600;
		  color: #333;
		  margin-right: 10px;
		}
		
		.comment-content {
		  display: inline; /* 이름과 내용을 한 줄에 표시 */
		  color: #333;
		}
		
		.comment-meta {
		  font-size: 12px;
		  color: #999;
		  margin-top: 5px;
		}
		
		.comment-time {
		  margin-right: 10px;
		}
		
		.reply-btn, .delete-btn {
		  cursor: pointer;
		  color: #84a98c;
		  margin-left: 10px;
		  font-size: 12px;
		  transition: color 0.2s ease;
		}
		
		.reply-btn:hover, .delete-btn:hover {
		  color: #6b8e72;
		}
		
		.comment.reply {
		  margin-left: 30px;
		  position: relative;
		  padding-left: 20px;
		  border-bottom: none;
		}
		
		.comment.reply::before {
		  content: '└';
		  position: absolute;
		  left: 0;
		  top: 20px;
		  color: #84a98c;
		}
		
		.reply-form {
		  margin-top: 15px;
		  margin-left: 30px;
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
    
    function noticeDelete() {
      showConfirm("현재 공지사항을 삭제하시겠습니까?", function() {
        location.href = "noticeDelete?idx=${vo.idx}";
      });
    }
    
    function toggleReplyForm(idx) {
      let replyForm = document.getElementById('replyForm' + idx);
      let replyBtn = document.getElementById('replyBtn' + idx);
      
      if (replyForm.style.display === 'none' || replyForm.style.display === '') {
        replyForm.style.display = 'block';
        replyBtn.innerText = '닫기';
        $(replyForm).slideDown(300);
      } else {
        replyBtn.innerText = '답글 달기';
        $(replyForm).slideUp(300);
      }
    }

    function submitComment(parentIdx) {
  	  let contentElement;
  	  if (parentIdx == 0) {
  	    contentElement = document.getElementById("commentContent");
  	  } else {
  	    contentElement = document.getElementById("replyContent" + parentIdx);
  	  }
  	  
  	  if (!contentElement) {
  	    showAlert("댓글 입력 필드를 찾을 수 없습니다.");
  	    return false;
  	  }
  	  
  	  let content = contentElement.value.trim();
  	  
  	  if(content == "") {
  	    showAlert("댓글을 입력하세요");
  	    return false;
  	  }
  	  
  	  let query = {
  	    noticeIdx: ${vo.idx},
  	    memberIdx: ${sIdx},
  	    content: content,
  	    parentIdx: parentIdx == 0 ? null : parentIdx
  	  }
  	  
  	  $.ajax({
  	    url: "${ctp}/notice/noticeReplyInput",
  	    type: "post",
  	    data: query,
  	    success: function(res) {
  	      if(res != "0") {
  	        showAlert("댓글이 입력되었습니다.", function() {
  	          location.reload();
  	        });
  	      }
  	      else showAlert("댓글 입력에 실패했습니다.");
  	    },
  	    error: function() {
  	      showAlert("전송 오류!");
  	    }
  	  });
  	}


  	function toggleLike() {
  	  $.ajax({
  	    url: "${ctp}/notice/noticeToggleLike",
  	    type: "post",
  	    data: {idx: ${vo.idx}},
  	    success: function(res) {
  	      if(res === "liked") {
  	        $("#likeButton").removeClass('far').addClass('fas active');
  	      } else if(res === "unliked") {
  	        $("#likeButton").removeClass('fas active').addClass('far');
  	      }
          location.reload();
  	    },
  	    error: function() {
  	      showAlert("좋아요 처리 중 오류가 발생했습니다.");
  	    }
  	  });
  	}

  	function deleteComment(idx) {
  	  showConfirm("정말로 이 댓글을 삭제하시겠습니까?", function() {
  	    $.ajax({
  	      url: "${ctp}/notice/noticeReplyDelete",
  	      type: "post",
  	      data: {idx: idx},
  	      success: function(res) {
  	        if(res == "1") {
  	          showAlert("댓글이 삭제되었습니다.", function() {
  	            location.reload();
  	          });
  	        }
  	        else {
  	          showAlert("댓글 삭제에 실패했습니다.");
  	        }
  	      },
  	      error: function() {
  	        showAlert("서버 오류가 발생했습니다.");
  	      }
  	    });
  	  });
  	}
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

	<div class="noticeContainer">
	  
	  <a href="${ctp}/notice/noticeList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
	  <!-- <h2>가족 소식</h2> -->
	 <%--  <div class="header">
		    <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
		    <font size="5" class="mb-4 h2">공지사항</font>
			</div>
	   --%>
	  <div class="notice-info">
		  <h3>${vo.title}</h3>
		  <div style="display: flex; justify-content: space-between; align-items: flex-end;">
		    <div class="notice-meta">
		      <span>${vo.memberName}</span> | 
		      <span>&nbsp;
		        <fmt:parseDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both" />
		        <c:choose>
		          <c:when test="${vo.hour_diff < 24}">
		            <fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd HH:mm"/>
		          </c:when>
		          <c:otherwise>
		            <fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd"/>
		          </c:otherwise>
		        </c:choose>
		      </span> | 
		      <span>&nbsp;&nbsp;<i class="far fa-thumbs-up"></i> ${vo.goodCount}</span> | 
		      <span>&nbsp;&nbsp;<i class="far fa-eye"></i> ${vo.viewCount}</span> | 
		      <span>&nbsp;&nbsp;<i class="far fa-comment"></i> ${fn:length(replyVos)}</span>
		      <c:if test="${vo.createdAt != vo.updatedAt}">
		        <span class="edited-mark">| 수정됨</span>
		      </c:if>
		    </div>
		    <div class="action-buttons">
		      <a href="noticeUpdate?idx=${vo.idx}" class="btn btn-sm btn-edit">수정</a>
		      <a href="javascript:noticeDelete()" class="btn btn-sm btn-edit">삭제</a>
		    </div>
		  </div>
		</div>
	  
	  <div class="notice-content">
		  ${fn:replace(vo.content, 'width:', 'max-width:')}
	  </div>
	  
	  <div class="interaction-bar">  
	    <i id="likeButton" class="interaction-icon fa-thumbs-up ${isLiked ? 'fa-solid' : 'fa-regular'}" onclick="toggleLike()"></i>
	    <span>${vo.goodCount}</span>
	  </div>
	  
	  <div class="comment-section">
		  <h4>댓글 ${fn:length(replyVos)}개</h4>
		  <div class="comment-input-container">
		    <textarea id="commentContent" name="content" class="comment-input" placeholder="댓글을 입력하세요..." rows="3"></textarea>
		    <div class="text-right">
		      <button class="btn-comment" onclick="submitComment(0)">등록</button>    
		    </div>
		  </div>
		    
		  <!-- 댓글 리스트 -->
		  <c:forEach var="replyVo" items="${replyVos}">
		    <c:if test="${replyVo.parentIdx == null}">
		      <div class="comment">
		        <span class="comment-author">${replyVo.name}</span>
		        <div class="comment-content">${fn:replace(replyVo.content, newLine, "<br/>")}</div>
		        <div class="comment-meta">
		          <span class="comment-time">${fn:substring(replyVo.createdAt, 0, 16)}</span>
		          <span id="replyBtn${replyVo.idx}" class="reply-btn" onclick="toggleReplyForm(${replyVo.idx})">
		            답글
		          </span>
		          <c:if test="${replyVo.memberIdx == sIdx}">
		            <span class="delete-btn" onclick="deleteComment(${replyVo.idx})">
		              삭제
		            </span>
		          </c:if>
		        </div>
		        <div id="replyForm${replyVo.idx}" class="reply-form" style="display: none;">
		          <textarea id="replyContent${replyVo.idx}" name="replyContent${replyVo.idx}" class="comment-input" placeholder="답글을 입력하세요..." >@${replyVo.name} </textarea>
		          <div class="text-right">
		            <button class="btn-comment" onclick="submitComment(${replyVo.idx})">답글 등록</button>    
		          </div>
		        </div>
		        
		        <!-- 대댓글 표시 -->
		        <c:forEach var="childReply" items="${replyVos}">
		          <c:if test="${childReply.parentIdx == replyVo.idx}">
		            <div class="comment reply">
		              <span class="comment-author">${childReply.name}</span>
		              <div class="comment-content">${fn:replace(childReply.content, newLine, "<br/>")}</div>
		              <div class="comment-meta">
		                <span class="comment-time">${fn:substring(childReply.createdAt, 0, 16)}</span>
		                <c:if test="${childReply.memberIdx == sIdx}">
		                  <span class="delete-btn" onclick="deleteComment(${childReply.idx})">
		                    삭제
		                  </span>
		                </c:if>
		              </div>
		            </div>
		          </c:if>
		        </c:forEach>
		      </div>
		    </c:if>
		  </c:forEach>
		</div>
	  
	  <!-- 이전글/다음글 섹션 -->
	  <div class="navigation-links">
	    <c:if test="${!empty nextVo.title}">
	      <a href="noticeContent?idx=${nextVo.idx}">
	        <span class="navigation-icon">&#9650;</span> 다음글: ${nextVo.title}
	      </a>
	    </c:if>
	    <c:if test="${!empty preVo.title}">
	      <a href="noticeContent?idx=${preVo.idx}">
	        <span class="navigation-icon">&#9660;</span> 이전글: ${preVo.title}
	      </a>
	    </c:if>
	  </div>

	  <a href="noticeList" class="btn-list mt-3">목록</a>
	</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>