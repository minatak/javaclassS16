<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>앨범 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
   <style>
    body {
      font-family: 'pretendard' !important;
      background-color: #ffffff;
      margin: 0;
      padding: 0;
    }
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .home-icon:hover {color: #c6c6c6;}
    .bodyContainer {
      max-width: 900px;
      margin: 0 auto;
    	position: relative;  /* 이전/다음 버튼의 기준점 */
    }
    
    .contentContainer {
      max-width: 600px;
      margin: 20px auto;
      background-color: #fff;
      border: 1px solid #dbdbdb;
      border-radius: 3px;
    }
    .titleHeader {
      margin-bottom: 50px;
    }
    .titleHeader .h2 {
      font-family: 'Pretendard', sans-serif;
      font-weight: 600;
      font-size: 24px;
      color: #333c47;
      text-align: center;
      margin-bottom: 50px;
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
      object-fit: cover;
    }
    .user-name {
      font-weight: 600;
      color: #262626;
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
    .comment-input-re {
      flex-grow: 1;
      border: none;
      outline: none;
      font-size: 14px;
      padding: 10px 15px;
      background-color: #f1f3f5;
      border-radius: 20px;
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
      padding-left: 10px;
      color: #8e8e8e;
      font-size: 14px;
      margin-bottom: 8px;
      cursor: pointer;
    }
    .fa-heart.fas {
      color: #ed4956;
    } 
    .delete-btn {
      color: #ed4956;
      cursor: pointer;
      margin-left: auto;
    }
    .updateBtn {
      cursor: pointer;
      margin-left: auto;
    }
    .reply-comment {
      margin-left: 20px;
      border-left: 2px solid #efefef;
      padding-left: 10px;
    }
    .latest-comment {
      padding: 1px 10px;
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
    .prev-btn {
      left: 10px;
    }
    .next-btn {
      right: 10px;
    }
    
		.interaction-bar {
      padding: 15px 20px;
      display: flex;
      align-items: center;
      border-top: 1px solid #e9ecef;
    }
    .interaction-icon {
      font-size: 24px;
      margin-right: 20px;
      color: #84a98c;
      cursor: pointer;
    }
    .post-likes {
      padding: 0 20px;
      margin-bottom: 15px;
      font-weight: 600;
      cursor: pointer;
      color: #333c47;
    }
		.navigation-btn:hover {
      text-decoration: none;
      background-color: #dbdbdb;
    }
    .prev-btn {
      left: -30px;
    }
    .next-btn {
      right: -30px;
    }
    
		.navigation-btn{
		  position: absolute;
		  top: 50%;
		  transform: translateY(-50%);
		  background-color: rgba(255, 255, 255, 0.7);
		  color: #333;
		  width: 40px;
		  height: 40px;
		  border-radius: 50%;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  font-size: 18px;
		  transition: all 0.3s ease;
		  border: 1px solid #dbdbdb;
		  z-index: 1;
		}
		
		.prev-btn:hover, .next-btn:hover {
		  background-color: rgba(132, 169, 140, 0.7);
		  color: white;
		}
    
    .post-comment-btn, /* 기존 댓글 게시 버튼 */
		.reply-form button /* 답글 게시 버튼 */ {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  border-radius: 20px;
		  padding: 8px 16px;
		  font-size: 14px;
		  font-weight: 600;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		
		.post-comment-btn:hover,
		.reply-form button:hover {
		  background-color: #52796f;
		}
		
		.post-comment-btn:disabled,
		.reply-form button:disabled {
		  background-color: #ccc;
		  cursor: not-allowed;
		}
    .post-comment-btn, /* 기존 댓글 게시 버튼 */
		.reply-form button /* 답글 게시 버튼 */ {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  border-radius: 20px;
		  padding: 8px 16px;
		  font-size: 14px;
		  font-weight: 600;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		
		.post-comment-btn:hover,
		.reply-form button:hover {
		  background-color: #52796f;
		}
		
		.post-comment-btn:disabled,
		.reply-form button:disabled {
		  background-color: #ccc;
		  cursor: not-allowed;
		}
	
    .modal-comments-container {
		  display: flex;
		  flex-direction: column;
		  height: 80vh;
		  max-height: 600px;
		}
		
		.comments-header {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  padding: 15px 20px;
		  border-bottom: 1px solid #e0e0e0;
		}
		
		.comments-body {
		  flex-grow: 1;
		  overflow-y: auto;
		  padding: 20px;
		}
		
	/* 	.comment-input-area {
		  display: flex;
		  padding: 15px 20px;
		  border-top: 1px solid #e0e0e0;
		  background-color: #fff;
		}
		 */
		#contentModal {
		  flex-grow: 1;
		  border: none;
		  background-color: white;
		  padding: 10px 15px;
		  border-radius: 20px;
		  margin-right: 10px;
		}
		
		.btn-submit {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  border-radius: 50%;
		  width: 40px;
		  height: 40px;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  transition: background-color 0.3s;
		}
		
		.btn-submit:hover {
		  background-color: #52796f;
		  color: white;
		}
		
		.close {
		  font-size: 24px;
		  color: #adb5bd;
		  background: none;
		  border: none;
		  cursor: pointer;
		}
		
		.modal-title {
		  font-size: 20px;
		  font-weight: 600;
		  color: #333c47;
		  margin: 0;
		}
		
		.modal-comment {
		  padding: 15px;
		  margin-bottom: 15px;
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
		.contentContainer {
		  border-radius: 12px;
		  overflow: hidden;
		}
		
		.user-avatar {
		  width: 32px;
		  height: 32px;
		  border-radius: 50%;
		  margin-right: 12px;
		  object-fit: cover;
		}
		
		.user-name {
		  font-weight: 600;
		  color: #262626;
		}
		
		.post-time {
		  margin-left: auto;
		  font-size: 14px;
		  color: #8e8e8e;
		}
		
		.post-time-left { 
			margin-left: 5px;
			font-size: 14px;
		  color: #8e8e8e;
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
		  background-color: rgba(255, 255, 255, 0.7);
		  color: #333;
		  width: 40px;
		  height: 40px;
		  border-radius: 50%;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  font-size: 16px;
		  transition: all 0.3s ease;
		  z-index: 1;
		}
		
		.prev { left: 10px; }
		.next { right: 10px; }
		
		.prev:hover, .next:hover {
		  background-color: rgba(180, 180, 180, 0.7);
		  color: white;
		  text-decoration: none;
		}
		
		.interaction-bar {
		  padding: 12px 16px;
		  display: flex;
		  align-items: center;
		  border-top: 1px solid #efefef;
		}
		
		.interaction-icon {
		  font-size: 24px;
		  margin-right: 16px;
		  color: #84a98c;
		  cursor: pointer;
		  transition: color 0.3s ease;
		}
		
		.interaction-icon:hover {
		  color: #52796f;
		}
		
	 .post-likes {
      padding: 0 16px;
      margin-bottom: 8px;
      font-weight: 600;
      cursor: pointer;
    }
	
		.description {
		  padding: 0px 16px;
		  font-size: 14px;
		  line-height: 1.5;
		}
		
		.comments-container {
		  padding: 12px 16px;
		}
		.post-comment-btn {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  border-radius: 20px;
		  padding: 8px 16px;
		  font-size: 14px;
		  font-weight: 600;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		
		.post-comment-btn:hover {
		  background-color: #52796f;
		}
		
		.modal-content {
		  border-radius: 12px;
		  overflow: hidden;
		}
		
		.modal-header {
		  border-bottom: 1px solid #efefef;
		  padding: 12px 16px;
		}
		
		.modal-title {
		  font-weight: 600;
		  font-size: 16px;
		}
		
		.modal-body {
		  padding: 16px;
		}
		
		.modal-comment {
		  margin-bottom: 12px;
		}
		
		.modal-comment-username {
		  font-weight: 600;
		  margin-right: 8px;
		}
		
		.modal-comment-content {
		  font-size: 14px;
		}
		
		.modal-comment-time {
		  font-size: 12px;
		  color: #8e8e8e;
		  margin-top: 4px;
		}
		
		.reply-btn, .delete-btn {
		  color: #84a98c;
		  font-size: 12px;
		  font-weight: 600;
		  cursor: pointer;
		  margin-left: 8px;
		}
		
		.reply-form {
		  margin-top: 8px;
		}
		
		.comment-input-re {
		  width: 80%;
		  border: 1px solid #84a98c;
		  border-radius: 20px;
		  padding: 8px 12px;
		  font-size: 14px;
		  resize: none;
		}
		

		.comments-body {
		  flex-grow: 1;
		  overflow-y: auto;
		  padding: 20px;
		}
		
		.comment-input-area {
		  display: flex;
		  padding: 15px 20px;
		  border-top: 1px solid #e0e0e0;
		  background-color: #fff;
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

    
    function showLikesModal() {
    	  $('#likesModal').modal('show');
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
  			photoIdx: ${vo.idx},
		    mid: '${sMid}',
		    name: '${sName}',
		    content: content
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
    
    function modalReplyCheck() {
  	  let content = $("#contentModal").val();
  	  if(content.trim() == "") {
  	    showAlert("댓글을 입력하세요");
  	    return false;
  	  }
  	  let query = {
  			photoIdx: ${vo.idx},
		    mid: '${sMid}',
		    name: '${sName}',
		    content: content
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
    
    function submitReply(idx, photoIdx) {
  	  let content = $("#contentRe"+idx).val();
  	  if(content.trim() == "") {
  	    showAlert("답변글을 입력하세요");
  	    $("#contentRe"+idx).focus();
  	    return false;
  	  }
  	  let query = {
  	    photoIdx: photoIdx,
  	    parentIdx: idx,  // 부모 댓글의 idx
  	    mid: '${sMid}',
  	    name: '${sName}',
  	    content: content
  	  };
  	  $.ajax({
  	    url: "${ctp}/photo/photoReplyInputRe",
  	    type: "POST",
  	    data: query,
  	    success: function(res) {
  	      if (res !== "0") {
  	        showAlert("댓글이 입력되었습니다.", function() {
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
 

  	function replyDelete(idx) {
		  showConfirm('정말로 이 댓글을 삭제하시겠습니까?', function() {
		    $.ajax({
		      url: `${ctp}/photo/photoReplyDelete`,
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
      const replyForm = document.getElementById('replyForm' + idx);
      const showBtn = document.getElementById('showReplyBtn' + idx);
      const closeBtn = document.getElementById('closeReplyBtn' + idx);

      if (replyForm.style.display === 'none' || replyForm.style.display === '') {
        replyForm.style.display = 'block';
        showBtn.style.display = 'none';
        closeBtn.style.display = 'inline';
      } else {
        replyForm.style.display = 'none';
        showBtn.style.display = 'inline';
        closeBtn.style.display = 'none';
      }
    }

    	 
    function deletePhoto() {
    	showConfirm('현재 사진을 삭제하시겠습니까?', function() {
    		location.href = "photoDelete?idx=${vo.idx}";
    	});
    }
    
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <%-- <div class="bodyContainer">
	  <a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
	  <div class="contentContainer">
	   --%>
	  <div class="bodyContainer">
	    <div class="titleHeader">
	      <a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	      <font size="5" class="mb-4 h2">${vo.title}</font>
	    </div>
	  	<div class="contentContainer">
	  
	  
	    <div class="header">
	      <img src="${ctp}/member/${photo}" alt="User Avatar" class="user-avatar">
	      <span class="user-name">${vo.name}</span>
	      <c:if test="${sMid == vo.mid}"> 
	      	<span class="post-time-left">${fn:substring(vo.PDate,0,11)}</span>  
	      </c:if>
	      <c:if test="${sMid != vo.mid}"> 
	      	<span class="post-time">${fn:substring(vo.PDate,0,11)}</span>  
	      </c:if>
	      <c:if test="${sMid == vo.mid}"> 
	      	<%-- <div class="updateBtn">
		        <span class="updateBtn mr-1" onclick="location.href='photoUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';"><i class="fa-solid fa-pen-to-square"></i></span>
		        <span class="updateBtn" onclick="deletePhoto()"><i class="fa-solid fa-xmark"></i></span>	      	
	      	</div> --%>
	      	<div class="card-header-buttons updateBtn">
		        <a class="btn btn-sm btn-outline-primary" href="photoUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">수정</a>
		      <button type="button" class="btn btn-sm btn-outline-danger" onclick="deletePhoto()">삭제</button>
		    </div>
	      	
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
	      <a href="photoTotalDown?idx=${vo.idx}"><i class="interaction-icon fa-solid fa-arrow-down"></i></a>
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
				  <div class="view-all-comments mb-2" data-bs-toggle="modal" data-bs-target="#commentsModal">
				    댓글 ${replyCnt}개 모두 보기
				  </div>
			  </c:if>
			  
			  <div class="add-comment">
			    <input type="text" id="content" class="comment-input" placeholder="댓글 달기...">
			    <button class="post-comment-btn" onclick="replyCheck()">게시</button>
			  </div>
			</div>
			
			
	  </div>
			<c:if test="${!empty nextVo.idx}">
	      <a href="${ctp}/photo/photoContent?idx=${nextVo.idx}" class="navigation-btn prev-btn">&lt;</a>
	    </c:if>
	    <c:if test="${!empty preVo.idx}">
	      <a href="${ctp}/photo/photoContent?idx=${preVo.idx}" class="navigation-btn next-btn">&gt;</a>
	    </c:if>
	</div>
</div>

<!-- 댓글 모달 -->
<div class="modal" id="commentsModal" tabindex="-1" aria-labelledby="commentsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-comments-container">
        <div class="comments-header">
          <h4 class="modal-title" id="commentsModalLabel">댓글</h4>
          <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="comments-body" id="modalComments">
          <c:if test="${!empty replyVos}">      
            <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
              <div class="modal-comment ${replyVo.parentIdx != null ? 'reply-comment' : ''}" id="comment${replyVo.idx}">
                <span class="modal-comment-username">${replyVo.name}</span>
                <span class="modal-comment-content">${fn:replace(replyVo.content, newLine, "<br/>")}</span>
                <div class="modal-comment-time">
                  ${fn:substring(replyVo.prDate, 0, 10)}
                  <c:if test="${sMid == replyVo.mid}">
                    <a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제" class="delete-btn">삭제</a>
                  </c:if>
                  <c:if test="${replyVo.parentIdx == null}">
                    <span id="showReplyBtn${replyVo.idx}" class="reply-btn" onclick="replyShow(${replyVo.idx})">답글 달기</span>
                    <span id="closeReplyBtn${replyVo.idx}" class="reply-btn" onclick="replyShow(${replyVo.idx})" style="display:none;">닫기</span>
                  </c:if>
                </div>
                <div class="reply-form" id="replyForm${replyVo.idx}" style="display:none;">
                  <input type="text" id="contentRe${replyVo.idx}" placeholder="답글을 입력하세요..." class="comment-input-re" value="@${replyVo.name} ">
                  <button onclick="submitReply(${replyVo.idx}, ${vo.idx})"><i class="fas fa-paper-plane"></i></button>
                </div>
              </div>
            </c:forEach>
          </c:if>
          <c:if test="${empty replyVos}">
            <div class="m-3">
              <!-- <span class="modal-comment-username">아직 작성된 댓글이 없어요</span> -->
              <p>아직 댓글이 없습니다.</p>
            </div>
          </c:if>
        </div>
        <div class="comment-input-area">
          <input type="text" id="contentModal" placeholder="새 댓글을 입력하세요...">
          <button type="button" class="btn btn-submit" onclick="modalReplyCheck()">
            <i class="fas fa-paper-plane"></i>
          </button>
      	</div>
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
        <!-- 좋아요 누른 사람들의 목록 -->
        <c:if test="${!empty likers}">
	        <c:forEach var="liker" items="${likers}">
	          <div class="modal-comment">
	            <span class="modal-comment-username">${liker.name}</span>
	          </div>
	        </c:forEach>
        </c:if>
        <c:if test="${empty likers}">
          <div class="modal-comment">
            <span class="modal-comment-username">아직 좋아요를 누른 가족이 없어요</span>
          </div> 
        </c:if>
      </div>
    </div>
  </div>
</div>
    
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>