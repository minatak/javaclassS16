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
    
    .noticeContainer {
      max-width: 900px;
      margin: 40px auto;
      background-color: #fff;
      padding: 40px;
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
    }
    
    .interaction-bar {
      padding: 20px 0;
      display: flex;
      justify-content: flex-end;
      color: #666;
      border-top: 1px solid #e4e6eb;
    }
    
    .interaction-icon {
      color: #84a98c;
      cursor: pointer;
      margin-right: 5px;
    }
    
    .comment-section {
      margin-top: 40px;
    }
    
    .comment {
      padding: 15px 0;
      border-top: 1px solid #e4e6eb;
    }
    
    .comment-author {
      font-weight: 600;
      margin-right: 8px;
    }
    
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
		
		.comment-input-container {
		  position: relative;
		  margin-bottom: 20px;
		}
		
		.comment-input {
		  width: 100%;
		  padding: 12px;
		  border: 1px solid #ccd0d5;
		  border-radius: 4px;
		  font-size: 14px;
		  resize: vertical;
		  min-height: 100px;
		}
		
		.btn-comment {
		  bottom: 10px;
		  right: 10px;
		  background-color: #84a98c;
		  color: #ffffff;
		  border: none;
		  padding: 8px 16px;
		  font-weight: 600;
		  /* border-radius: 4px; */
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
    
    function noticeDelete() {
      showConfirm("현재 공지사항을 삭제하시겠습니까?", function() {
        location.href = "noticeDelete?idx=${vo.idx}";
      });
    }
    
    function toggleLike() {
      $.ajax({
        url: "${ctp}/notice/noticeToggleLike",
        type: "post",
        data: {idx: ${vo.idx}},
        success: function(res) {
          if(res === "liked") {
            $("#likeButton").addClass("active");
            location.reload();
          } else if(res === "unliked") {
            $("#likeButton").removeClass("active");
            location.reload();
          } else {
            showAlert("좋아요 처리 중 오류가 발생했습니다.");
          }
        },
        error: function() {
          showAlert("서버 통신 오류");
        }
      });
    }
    
    function submitComment() {
      let content = $("#commentContent").val();
      if(content.trim() == "") {
        showAlert("댓글을 입력하세요");
        return false;
      }
      let query = {
        noticeIdx: ${vo.idx},
        content: content
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
    
    function deleteComment(idx) {
      showConfirm("이 댓글을 삭제하시겠습니까?", function() {
        $.ajax({
          url: "${ctp}/notice/noticeReplyDelete",
          type: "POST",
          data: {idx: idx},
          success: function(res) {
            if (res === "1") {
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
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

	<div class="noticeContainer">
	  <h2>공지사항</h2>
	  
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
		      <span>&nbsp;&nbsp;<i class="far fa-thumbs-up"></i> ${vo.likeCount}</span> | 
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
	  
	  <div class="notice-content" style="margin=0;">
	    ${vo.content}
	  </div>
	  
	  <div class="interaction-bar">
	    <i id="likeButton" class="interaction-icon fa-heart ${isLiked ? 'fas active' : 'far'}" onclick="toggleLike()"></i>
	    <span>${vo.likeCount}</span>
	  </div>
	  
	  <div class="comment-section">
		  <h4>댓글 ${fn:length(replyVos)}개</h4>
		  <div>
	    	<textarea id="commentContent" class="comment-input" placeholder="댓글을 입력하세요..." style="padding-bottom: 40px;"></textarea>
		    <div class="text-right">
		    <button class="btn-comment" onclick="submitComment()">등록</button>		  
		    </div>
		  </div>
		    
	    <!-- 댓글 리스트 -->
	    <c:forEach var="replyVo" items="${replyVos}">
	      <div class="comment">
	        <span class="comment-author">${replyVo.name}</span>
	        <span>${fn:replace(replyVo.content, newLine, "<br/>")}</span>
	        <div class="notice-meta">
	          <fmt:parseDate value="${replyVo.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedReplyDate" type="both" />
	          <fmt:formatDate value="${parsedReplyDate}" pattern="yyyy.MM.dd" var="formattedReplyDate" />
	          <span>${formattedReplyDate}</span>
	        </div>
	      </div>
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