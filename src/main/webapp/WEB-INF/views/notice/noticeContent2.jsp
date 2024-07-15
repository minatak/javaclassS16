<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 상세보기 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      background-color: #ffffff;
      color: #333333;
    }
    
    .noticeContainer {
      max-width: 800px;
      margin: 40px auto;
      background-color: #fff;
      padding: 40px;
      border: 1px solid #e0e0e0;
    }
    
    h2 {
      color: #000000;
      font-weight: 700;
      margin-bottom: 30px;
      text-align: center;
    }
    
    .notice-info {
      background-color: #f8f8f8;
      border: 1px solid #e0e0e0;
      padding: 20px;
      margin-bottom: 30px;
    }
    
    .notice-info h3 {
      font-weight: 700;
      margin-bottom: 10px;
    }
    
    .notice-meta {
      display: flex;
      justify-content: space-between;
      font-size: 0.9em;
      color: #666;
    }
    
    .notice-content {
      line-height: 1.6;
      margin-bottom: 40px;
      padding: 20px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
    }
    
    .interaction-bar {
      border-top: 1px solid #e0e0e0;
      border-bottom: 1px solid #e0e0e0;
      padding: 15px 0;
      margin-bottom: 30px;
      display: flex;
      justify-content: space-between;
    }
    
    .interaction-icon {
      font-size: 20px;
      color: #333333;
      cursor: pointer;
    }
    
    .fa-heart.active {
      color: #ff0000;
    }
    
    .comment-input {
      width: 100%;
      padding: 15px;
      border: 1px solid #e0e0e0;
      margin-bottom: 15px;
      font-size: 14px;
    }
    
    .btn-comment {
      background-color: #000000;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      font-weight: 500;
      transition: background-color 0.3s;
    }
    
    .btn-comment:hover {
      background-color: #333333;
    }
    
    .comment {
      border-bottom: 1px solid #e0e0e0;
      padding: 20px 0;
    }
    
    .comment-author {
      font-weight: 700;
      margin-right: 10px;
    }
    
    .comment-date {
      font-size: 0.9em;
      color: #888888;
    }
    
    .reply-btn {
      font-size: 0.9em;
      color: #555555;
      margin-left: 10px;
      cursor: pointer;
    }
    
    .btn {
      border-radius: 0;
      padding: 10px 20px;
      font-weight: 500;
      transition: all 0.3s;
    }
    
    .btn-primary {
      background-color: #000000;
      border-color: #000000;
    }
    
    .btn-primary:hover {
      background-color: #333333;
      border-color: #333333;
    }
    
    .btn-danger {
      background-color: #ffffff;
      border-color: #000000;
      color: #000000;
    }
    
    .btn-danger:hover {
      background-color: #000000;
      color: #ffffff;
    }
    
    .btn-secondary {
      background-color: #e0e0e0;
      border-color: #e0e0e0;
      color: #333333;
    }
    
    .btn-secondary:hover {
      background-color: #c0c0c0;
      border-color: #c0c0c0;
    }
    
    .edited-mark {
      font-size: 0.8em;
      color: #888;
      margin-left: 10px;
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
    <div class="notice-meta">
      <span>작성자: ${vo.memberName}</span>
      <span>
        작성일: ${fn:substring(vo.createdAt,0,16)}
        <c:if test="${vo.createdAt != vo.updatedAt}">
          <span class="edited-mark">(수정됨)</span>
        </c:if>
      </span>
      <span>조회수: ${vo.viewCount}</span>
    </div>
  </div>
  
  <div class="notice-content">
    ${fn:replace(vo.content, newLine, "<br/>")}
  </div>
  
  <div class="interaction-bar">
    <div>
      <i id="likeButton" class="interaction-icon fa-heart ${isLiked ? 'fas active' : 'far'}" onclick="toggleLike()"></i>
      <span>좋아요 ${vo.likeCount}개</span>
    </div>
    <div>
      <span>댓글 ${fn:length(replyVos)}개</span>
    </div>
  </div>
  
  <div class="comment-section">
    <textarea id="commentContent" class="comment-input" placeholder="댓글을 입력하세요..."></textarea>
    <button class="btn-comment" onclick="submitComment()">댓글 작성</button>
      <!-- 이전글/ 다음글 출력하기 -->
  <table class="table table-borderless">
    <tr>
      <td>
        <c:if test="${!empty nextVo.title}">
          ☝ <a href="noticeContent?idx=${nextVo.idx}">다음글 : ${nextVo.title}</a><br/>
        </c:if>
        <c:if test="${!empty preVo.title}">
        	👇 <a href="noticeContent?idx=${preVo.idx}">이전글 : ${preVo.title}</a><br/>
        </c:if>
      </td>
    </tr>
  </table>
</div>
<p><br/></p>

<!-- 댓글 처리(리스트/입력) -->
<div class="container">
	<!-- 댓글 리스트 보여주기 -->
	<table class="table table-hover text-center">
	  <tr>
	    <th>작성자</th>
	    <th>댓글내용</th>
	    <th>댓글일자</th>
	    <th>답글</th>
	  </tr>
	  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
	    <tr>
	      <td class="text-left">
	        <c:if test="${replyVo.re_step >= 1}">
	          <c:forEach var="i" begin="1" end="${replyVo.re_step}"> &nbsp;&nbsp;</c:forEach> └▶
	        </c:if>
	        ${replyVo.name}
	        <c:if test="${sIdx == replyVo.memberIdx}">
	          (<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제">x</a>)
	        </c:if>
	      </td>
	      <td class="text-left">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
	      <td>${fn:substring(replyVo.WDate, 0, 10)}</td>
	      <td>
	        <a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge badge-success">답글</a>
	        <a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge badge-warning replyCloseBtn">닫기</a>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="5" class="m-0 p-0">
	        <div id="replyDemo${replyVo.idx}" style="display:none">
	          <table class="table table-center">
	            <tr>
	              <td style="85%" class="text-left">답글내용 :
	                <textarea rows="4" name="contentRe" id="contentRe${replyVo.idx}" class="form-control">@${replyVo.name} </textarea>
	              </td>
	              <td style="15%">
	                <br/>
	                <p>작성자 : ${sName}</p>
	                <input type="button" value="답글달기" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-secondary btn-sm"/>
	              </td>
	            </tr>
	          </table>
	        </div>
	      </td>
	    </tr>
	  </c:forEach>
	  <tr><td colspan="4" class='m-0 p-0'></td></tr>
	</table>
	
	<!-- 댓글 입력창 -->
	<form name="replyForm">
	  <table class="table table-center">
	    <tr>
	      <td style="width:85%" class="text-left">
	        글내용 :
	        <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	      </td>
	      <td style="width:15%">
	        <br/>
	        <p>작성자 : ${sName}</p>
	        <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
	      </td>
	    </tr>
	  </table>
	</form>
	<br/>
</div>
<!-- 댓글 처리 -->

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>