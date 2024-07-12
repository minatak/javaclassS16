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
      box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    }
    .header {
      padding: 16px;
      display: flex;
      align-items: center;
      border-bottom: 1px solid #efefef;
    }
    .user-avatar {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      margin-right: 12px;
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
      background-color: rgba(0, 0, 0, 0.5);
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #fff;
      font-size: 18px;
      text-decoration: none;
      transition: 0.3s ease;
      z-index: 1;
    }
    .prev { left: 10px; }
    .next { right: 10px; }
    .prev:hover, .next:hover {
      background-color: rgba(0, 0, 0, 0.8);
    }
    .dot {
      height: 6px;
      width: 6px;
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
    .post-likes {
      padding: 0 16px;
      margin-bottom: 8px;
      font-weight: 600;
      cursor: pointer;
    }
    .description, .comments-section {
      padding: 0 16px;
    }
    .add-comment {
      display: flex;
      border-top: 1px solid #efefef;
      padding: 16px;
    }
    .comment-input {
      flex-grow: 1;
      border: none;
      outline: none;
      font-size: 14px;
      padding: 8px;
      background-color: #fafafa;
      border-radius: 3px;
    }
    .post-comment-btn {
      border: none;
      background: none;
      color: #0095f6;
      font-weight: 600;
      font-size: 14px;
      cursor: pointer;
      padding-left: 16px;
    }
    .post-comment-btn:disabled {
      opacity: 0.3;
      cursor: default;
    }
    .view-all-comments {
      padding-left: 18px;
      color: #8e8e8e;
      font-size: 14px;
      margin-bottom: 8px;
      cursor: pointer;
    }
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
    .fa-heart.fas {
      color: #ed4956;
    }
    .delete-btn {
      color: #ed4956;
      cursor: pointer;
      margin-left: auto;
    }
    .reply-comment {
      margin-left: 20px;
      border-left: 2px solid #efefef;
      padding-left: 10px;
    }
    .latest-comment {
      padding: 1px 16px;
    }
    .comment-username {
      font-weight: 600;
      margin-right: 4px;
    }
    .comment-content {
      word-break: break-word;
    }
    .comment-time {
      color: #8e8e8e;
      font-size: 12px;
      margin-top: 4px;
    }
    .navigation-btn {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background-color: rgba(0, 0, 0, 0.3);
      color: white;
      padding: 10px;
      text-decoration: none;
      font-size: 18px;
    }
    .prev-btn {
      left: 10px;
    }
    .next-btn {
      right: 10px;
    }
    .post-title {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 20px;
      text-align: center;
      color: #262626;
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
    
    let slideIndex = 1;

    document.addEventListener("DOMContentLoaded", function() {
    	  showSlides(slideIndex);
    	  
    	  const prevButton = document.querySelector('.prev');
    	  const nextButton = document.querySelector('.next');
    	  
    	  if (${vo.photoCount} <= 1) {
    	    if (prevButton) prevButton.style.display = 'none';
    	    if (nextButton) nextButton.style.display = 'none';
    	  }
    	});
    
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
    
    let replyCnt = ${replyCnt};
    let commentsVisible = false;

    document.addEventListener("DOMContentLoaded", function() {
    	  const viewAllCommentsBtn = document.querySelector('.view-all-comments');
    	  if (viewAllCommentsBtn) {
    	    if (replyCnt > 0) {
    	      viewAllCommentsBtn.textContent = `댓글 ${replyCnt}개 모두 보기`;
    	    } else {
    	      viewAllCommentsBtn.textContent = '댓글 0개';
    	      viewAllCommentsBtn.style.display = 'none';
    	    }
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
  	    showAlert("댓글을 입력하세요");
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
		          showAlert("댓글이 입력되었습니다.", function() {
		            location.reload();
		          });
		        }
		        else showAlert("댓글 입력에 실패했어요");
		      },
	        error : function() {
	          showAlert("전송 오류!");
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
            showAlert("댓글이 삭제되었습니다.", function() {
	            location.reload();
	          });
          }
          else showAlert("댓글 삭제에 실패했어요");
        },
        error : function() {
          showAlert("전송 오류!");
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
            location.reload();
          } else if(res === "unliked") {
            $("#likeButton").removeClass("fas").addClass("far");
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
    document.addEventListener('DOMContentLoaded', function() {
        // 페이지 로드 시 모든 닫기 버튼을 숨깁니다.
        const closeBtns = document.querySelectorAll('.replyCloseBtn');
        closeBtns.forEach(btn => btn.style.display = 'none');

        const commentsModal = document.getElementById('commentsModal');

        if (commentsModal) {
            commentsModal.addEventListener('show.bs.modal', function () {
                console.log('Modal is about to be shown');
                setupReplyButtons();
            });
        } else {
            console.error('Comments modal not found');
        }
    });

    function setupReplyButtons() {
        const modalBody = document.querySelector('#commentsModal .modal-body');
        if (!modalBody) {
            console.error('Modal body not found');
            return;
        }

        modalBody.addEventListener('click', function(e) {
            if (e.target.id.startsWith('replyShowBtn') || e.target.id.startsWith('replyCloseBtn')) {
                const idx = e.target.id.replace('replyShowBtn', '').replace('replyCloseBtn', '');
                toggleReplyForm(idx);
            }
        });
    }

    function toggleReplyForm(idx) {
        console.log('toggleReplyForm called with idx:', idx);

        const replyForm = document.getElementById(`replyDemo${idx}`);
        const showBtn = document.getElementById(`replyShowBtn${idx}`);
        const closeBtn = document.getElementById(`replyCloseBtn${idx}`);

        console.log('Elements:', {replyForm, showBtn, closeBtn});

        if (replyForm && showBtn && closeBtn) {
            if (window.getComputedStyle(replyForm).display === "none") {
                showBtn.style.display = "none";
                closeBtn.style.display = "inline";
                replyForm.style.display = "block";
            } else {
                showBtn.style.display = "inline";
                closeBtn.style.display = "none";
                replyForm.style.display = "none";
            }
        } else {
            console.error(`Elements not found 	for idx: ${idx}`, {
                replyForm: !!replyForm,
                showBtn: !!showBtn,
                closeBtn: !!closeBtn
            });	
        }
    }

    
    function submitReply(parentIdx, photoIdx, re_step, re_order) {
        const content = $(`#contentRe${parentIdx}`).val();
        if (content.trim() === '') {
            alert('댓글 내용을 입력해주세요.');
            $(`#contentRe${parentIdx}`).focus();
            return;
        }

        const data = {
            photoIdx: photoIdx,
            re_step: re_step + 1,
            re_order: re_order,
            mid: '${sMid}',
            name: '${sName}',
            content: content
        };

        $.ajax({
            url: "${ctp}/photo/photoReplyInputRe",
            type: "POST",
            data: data,
            success: function(res) {
                if (res !== "0") {
                    showAlert("댓글이 입력되었습니다.", function() {
                        location.reload();
                    });
                } else {
                    alert("답변글 입력 실패~~");
                }
            },
            error: function() {
                alert("전송오류!");
            }
        });
    }

    function replyDelete(replyIdx) {
        if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
            $.ajax({
                url: `${ctp}/photo/photoReplyDelete/${replyIdx}`,
                type: "POST",
                success: function(res) {
                    if (res === "1") {
                        showAlert("댓글이 삭제되었습니다.", function() {
                            location.reload();
                        });
                    } else {
                        alert("댓글 삭제에 실패했습니다.");
                    }
                },
                error: function() {
                    alert("전송오류!");
                }
            });
        }
    }

	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  
  <a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
  <%-- <h2 class="post-title">${vo.title}</h2> --%>
  <div class="contentContainer">
  
    <div class="header">
      <img src="${ctp}/member/${photo}" alt="User Avatar" class="user-avatar">
      <span class="user-name">${vo.name}</span>
      <span class="post-time">${fn:substring(vo.PDate,0,16)}</span>
      <c:if test="${sMid == vo.mid}">
        <span class="delete-btn" onclick="deletePhoto()"><i class="fas fa-trash"></i></span>
      </c:if>
    </div>
    
    <input type="hidden" name="idx" id="idx" value="${vo.idx}"/>
    
    <div class="slideshow-container">
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
      <i class="interaction-icon fa-solid fa-arrow-down" onclick="photoDown()"></i>
    </div>
    
    <div class="post-likes" onclick="showLikesModal()">
      좋아요 ${vo.goodCount}개
    </div>
    
    <div class="description">
      <p><strong>${vo.name}</strong> ${fn:replace(vo.description, newLine, "<br/>")}</p>
    </div>
    
    <div class="comments-container">
		  <!-- 최신 댓글 1개 표시 -->
		  <c:if test="${!empty latestReply}">
		    <div class="latest-comment">
		      <span class="comment-username">${latestReply.name}</span>
		      <span class="comment-content">${fn:replace(latestReply.content, newLine, "<br/>")}</span>
		      <div class="comment-time">
		        ${fn:substring(latestReply.prDate, 0, 10)}
		        <c:if test="${sMid == latestReply.mid}">
		          <a href="javascript:replyDelete(${latestReply.idx})" title="댓글삭제">삭제</a>
		        </c:if>
		      </div>
		    </div>
		  </c:if>
		  <c:if test="${replyCnt > 1}">
			  <div class="view-all-comments" data-bs-toggle="modal" data-bs-target="#commentsModal">
			    댓글 ${replyCnt}개 모두 보기
			  </div>
		  </c:if>
		  
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
          <div class="modal-comment ${replyVo.re_step > 0 ? 'reply-comment' : ''}" id="comment${replyVo.idx}">
            <span class="modal-comment-username">${replyVo.name}</span>
            <span class="modal-comment-content">${fn:replace(replyVo.content, newLine, "<br/>")}</span>
            <div class="modal-comment-time">
              ${fn:substring(replyVo.prDate, 0, 10)}
              <c:if test="${sMid == replyVo.mid}">
                <a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제" class="delete-btn">삭제</a>
              </c:if>
              <c:if test="${replyVo.re_step == 0}">
                <a href="javascript:void(0);" id="replyShowBtn${replyVo.idx}" class="reply-btn" onclick="toggleReplyForm(${replyVo.idx})">답글</a>
                <a href="javascript:void(0);" id="replyCloseBtn${replyVo.idx}" class="reply-btn replyCloseBtn" style="display:none;" onclick="toggleReplyForm(${replyVo.idx})">닫기</a>
                <!-- 답글 입력 폼 (부모 댓글에만 표시) -->
                <div id="replyDemo${replyVo.idx}" class="reply-form" style="display:none;">
                  <textarea class="form-control" rows="2" id="contentRe${replyVo.idx}"></textarea>
                  <button onclick="submitReply(${replyVo.idx}, ${replyVo.photoIdx}, ${replyVo.re_step}, ${replyVo.re_order})" class="btn btn-primary btn-sm mt-2">답글 작성</button>
                </div>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>



    
		<!-- 좋아요 모달 -->
		<div class="modal fade" id="likesModal" tabindex="-1" aria-labelledby="likesModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="likesModalLabel">좋아요</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <!-- 여기에 좋아요 누른 사람들의 목록을 추가하세요 -->
		        <c:forEach var="liker" items="${likers}">
		          <div class="modal-comment">
		            <span class="modal-comment-username">${liker.name}</span>
		          </div>
		        </c:forEach>
		      </div>
		    </div>
		  </div>
		</div>
    
    <!-- 이전/다음 게시물 버튼 -->
		<c:if test="${!empty preVo.title}">
		  <a href="${ctp}/photo/photoContent?idx=${vo.idx - 1}" class="navigation-btn prev-btn">&lt;</a>
		</c:if>
		<c:if test="${!empty nextVo.title}">
		  <a href="${ctp}/photo/photoContent?idx=${nextVo.idx}" class="navigation-btn next-btn">&gt;</a>
		</c:if>
    
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>