<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>자세히 보기 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
   <style>
    body {
      font-family: 'pretendard' !important;
      background-color: #fafafa;
      margin: 0;
      padding: 0;
    }
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .contentContainer {
      max-width: 600px;
      margin: 20px auto;
      background-color: #fff;
      border: 1px solid #dbdbdb;
      border-radius: 3px;
    }
    .header {
      padding: 14px 16px;
      display: flex;
      align-items: center;
      border-bottom: 1px solid #efefef;
    }
    .user-avatar {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      margin-right: 10px;
    }
    .user-name {
      font-weight: 600;
      color: #262626;
    }
    .post-time {
      color: #8e8e8e;
      font-size: 12px;
      margin-left: auto;
    }
    .slideshow-container {
      position: relative;
      width: 100%;
      padding-bottom: 100%;
      overflow: hidden;
    }
    .mySlides {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
    .mySlides img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .prev, .next {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      width: 30px;
      height: 30px;
      background-color: rgba(255, 255, 255, 0.7);
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #000;
      font-size: 18px;
      text-decoration: none;
      transition: 0.3s ease;
      z-index: 1;
    }
    .prev { left: 10px; }
    .next { right: 10px; }
    .prev:hover, .next:hover {
      background-color: rgba(255, 255, 255, 0.9);
    }
    .dot {
      height: 8px;
      width: 8px;
      margin: 0 4px;
      background-color: #bbb;
      border-radius: 50%;
      display: inline-block;
      transition: background-color 0.6s ease;
    }
    .active {
      background-color: #717171;
    }
    .interaction-bar {
      padding: 8px 16px;
      display: flex;
      align-items: center;
    }
    .interaction-icon {
      font-size: 24px;
      margin-right: 16px;
      color: #262626;
      cursor: pointer;
    }
    .description, .comments-section {
      padding: 0 16px;
    }
    .add-comment {
      display: flex;
      border-top: 1px solid #efefef;
      padding-top: 16px;
    }
    .comment-input {
      flex-grow: 1;
      border: none;
      outline: none;
      font-size: 14px;
    }
    .post-comment-btn {
      border: none;
      background: none;
      color: #0095f6;
      font-weight: 600;
      font-size: 14px;
      cursor: pointer;
    }
    .post-comment-btn:disabled {
      opacity: 0.3;
      cursor: default;
    }
    .view-all-comments {
      color: #8e8e8e;
      font-size: 14px;
      margin-bottom: 8px;
      cursor: pointer;
    }
    /* 모달 스타일 */
    .modal-content {
      border-radius: 12px;
      border: none;
    }
    .modal-header {
      border-bottom: 1px solid #efefef;
      text-align: center;
      padding: 10px;
    }
    .modal-title {
      font-weight: 600;
      font-size: 16px;
    }
    .modal-body {
      padding: 0;
      max-height: 400px;
      overflow-y: auto;
    }
    .modal-comment {
      padding: 12px 16px;
      border-bottom: 1px solid #efefef;
    }
    .modal-comment:last-child {
      border-bottom: none;
    }
    .modal-comment-username {
      font-weight: 600;
      margin-right: 4px;
    }
    .modal-comment-content {
      word-break: break-word;
    }
    .modal-comment-time {
      color: #8e8e8e;
      font-size: 12px;
      margin-top: 4px;
    }
    /* 좋아요 버튼 스타일 */
    .fa-heart.fas {
      color: #ed4956;
    }
  </style>
  <script>
    'use strict';
    
    let slideIndex = 1;

    document.addEventListener("DOMContentLoaded", function() {
      showSlides(slideIndex);
    });
    
    
    let replyCnt = ${replyCnt};
    let commentsVisible = false;

    document.addEventListener("DOMContentLoaded", function() {
      const commentsList = document.getElementById('comments-list');
      const viewAllCommentsBtn = document.querySelector('.view-all-comments');
      
      if (replyCnt > 0) {
        viewAllCommentsBtn.textContent = `댓글 ${replyCnt}개 모두 보기`;
        commentsList.style.display = 'none';
      } else {
        viewAllCommentsBtn.textContent = '댓글 0개';
        viewAllCommentsBtn.style.display = 'none';
      }
    });
    
    function replyHide() {
      $("#replyHideBtn").hide();
      $("#replyShowBtn").show();
      $(".comments-section").hide();
    }
    
    function replyShow() {
      $("#replyHideBtn").show();
      $("#replyShowBtn").hide();
      $(".comments-section").show();
    }
    
    function replyInputShow() {
      $(".add-comment").toggle();
    }
    
    function replyCheck() {
  	  let content = $("#content").val();
  	  if(content.trim() == "") {
  	    alert("댓글을 입력하세요");
  	    return false;
  	  }
  	  let query = {
  			mid				: '${sMid}',
				photoIdx	: '${vo.idx}',
  	    content   : content
  	  }
  	  
  	  $.ajax({
  	    url  : "${ctp}/photo/photoReplyInput",
  	    type : "post",
  	    data : query,
  	    success:function(res) {
	    	 if(res != "0") {
	            alert("댓글이 입력되었습니다.");
	            location.reload();
	          }
	          else alert("댓글 입력 실패~~");
	        },
	        error : function() {
	          alert("전송 오류!");
	        }
	      });
  	}
    
    function replyDelete(idx) {
      let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        url  : "${ctp}/photo/photoReplyDelete",
        type : "post",
        data : {idx : idx},
        success:function(res) {
          if(res != "0") {
            alert("댓글이 삭제되었습니다.");
            location.reload();
          }
          else alert("삭제 실패~~");
        },
        error : function() {
          alert("전송 오류!");
        }
      });
    }
    
    function toggleLike() {
      $.ajax({
        url: "${ctp}/photo/photoToggleLike",
        type: "post",
        data: {idx: ${vo.idx}},
        success: function(res) {
          if(res === "liked") {
            $("#likeButton").removeClass("far").addClass("fas");
          } else if(res === "unliked") {
            $("#likeButton").removeClass("fas").addClass("far");
          } else {
            alert("좋아요 처리 중 오류가 발생했습니다.");
          }
        },
        error: function() {
          alert("서버 통신 오류");
        }
      });
    }
    
    function plusSlides(n) {
      showSlides(slideIndex += n);
    }
    
    function currentSlide(n) {
      showSlides(slideIndex = n);
    }
    
    function showSlides(n) {
      let slides = document.getElementsByClassName("mySlides");
      let dots = document.getElementsByClassName("dot");
      
      if (slides.length === 0) {
        console.log("슬라이드를 찾을 수 없습니다");
        return;
      }
      
      if (n > slides.length) {slideIndex = 1}    
      if (n < 1) {slideIndex = slides.length}
      
      for (let i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";  
      }
      
      for (let i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
      }
      
      slides[slideIndex-1].style.display = "block";  
      if (dots.length > 0) {
        dots[slideIndex-1].className += " active";
      }
    }
  
    function toggleComments() {
    	  const commentsList = document.getElementById('comments-list');
    	  const viewAllCommentsBtn = document.querySelector('.view-all-comments');
    	  
    	  commentsVisible = !commentsVisible;
    	  
    	  if (commentsVisible) {
    	    commentsList.style.display = 'block';
    	    viewAllCommentsBtn.textContent = '댓글 숨기기';
    	  } else {
    	    commentsList.style.display = 'none';
    	    viewAllCommentsBtn.textContent = `댓글 ${replyCnt}개 모두 보기`;
    	  }
    	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
	<a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	<div class="contentContainer">
	  <div class="header">
	    <img src="${ctp}/member/${photo}" alt="User Avatar" class="user-avatar">
	    <span class="user-name">${vo.name}</span>
	    <span class="post-time">${fn:substring(vo.PDate,0,16)}</span>
	  </div>
	  
	  <input type="hidden" name="idx" id="idx" value="${vo.idx}"/>
	  
	  <div class="slideshow-container">
		  <c:if test="${not empty vo.content}">
		    <c:set var="imageCount" value="0" />
		    <c:forEach var="item" items="${fn:split(vo.content, '\"')}">
		      <c:if test="${fn:contains(item, '/javaclassS16/photo/')}">
		        <c:set var="imageCount" value="${imageCount + 1}" />
		        <c:set var="imagePath" value="${fn:substringAfter(item, '/javaclassS16/')}" />
		        <div class="mySlides">
		          <img src="${ctp}/${imagePath}" alt="Photo ${imageCount}">
		        </div>
		      </c:if>
		    </c:forEach>
		  </c:if>
		  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
		  <a class="next" onclick="plusSlides(1)">&#10095;</a>
		</div>
	  
	  <div style="text-align:center">
	    <c:forEach var="i" begin="1" end="${vo.photoCount}" varStatus="st">
	      <span class="dot" onclick="currentSlide(${i})"></span> 
	    </c:forEach>
	  </div>
	  
	  <div class="interaction-bar">
	    <i id="likeButton" class="interaction-icon fa-heart ${isLiked ? 'fas' : 'far'}" onclick="toggleLike()"></i>
	    <i class="interaction-icon fa-regular fa-comment" data-bs-toggle="modal" data-bs-target="#commentsModal"></i>
	    <i class="interaction-icon fa-regular fa-paper-plane"></i>
	  </div>
	  
	  <div class="description">
	    <p><strong>${vo.name}</strong> ${fn:replace(vo.description, newLine, "<br/>")}</p>
	  </div>
	  
	  <div class="comments-container">
    <div class="view-all-comments" data-bs-toggle="modal" data-bs-target="#commentsModal">
      댓글 ${replyCnt}개 모두 보기
    </div>
    
    <div class="add-comment">
      <input type="text" id="content" class="comment-input" placeholder="댓글 달기...">
      <button class="post-comment-btn" onclick="replyCheck()">게시</button>
    </div>
  </div>
  
  <!-- 댓글 모달 -->
  <div class="modal fade" id="commentsModal" tabindex="-1" aria-labelledby="commentsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="commentsModalLabel">댓글</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
            <div class="modal-comment">
              <span class="modal-comment-username">${replyVo.mid}</span>
              <span class="modal-comment-content">${fn:replace(replyVo.content, newLine, "<br/>")}</span>
              <div class="modal-comment-time">
                ${fn:substring(replyVo.prDate, 0, 10)}
                <c:if test="${sMid == replyVo.mid}">
                  <a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제">삭제</a>
                </c:if>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
  
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>