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
		  font-family: 'Pretendard', sans-serif !important;
		  background-color: #ffffff;
		  margin: 0;
		  padding: 0;
		}
		.home-icon { 
		  font-size: 24px; 
		  color: #cecece; 
		  transition: color 0.3s ease;
		}
		.home-icon:hover {
		  color: #84a98c;
		}
		.bodyContainer {
		  max-width: 900px;
		  margin: 0 auto;
		  padding: 20px;
		}
		.contentContainer {
		  max-width: 600px;
		  margin: 20px auto;
		  background-color: #fff;
		  border: 1px solid #dbdbdb;
		  border-radius: 10px;
		  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
		  overflow: hidden;
		}
		.titleHeader {
		  margin-bottom: 30px;
		  display: flex;
		  align-items: center;
		}
		.titleHeader .h2 {
		  font-family: 'Pretendard', sans-serif;
		  font-weight: 600;
		  font-size: 24px;
		  color: #333c47;
		  margin-left: 20px;
		}
		.header {
		  padding: 16px;
		  display: flex;
		  align-items: center;
		  border-bottom: 1px solid #efefef;
		}
		.user-avatar {
		  width: 40px;
		  height: 40px;
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
		  transition: color 0.3s ease;
		}
		.interaction-icon:hover {
		  color: #52796f;
		}
		.post-likes {
		  padding: 0 20px;
		  margin-bottom: 15px;
		  font-weight: 600;
		  cursor: pointer;
		  color: #333c47;
		}
		.description {
		  padding: 0 20px 20px;
		  color: #262626;
		  line-height: 1.5;
		}
		.comments-section {
		  border-top: 1px solid #efefef;
		  padding: 20px;
		}
		.comment-input {
		  width: 100%;
		  border: none;
		  outline: none;
		  font-size: 14px;
		  padding: 10px 15px;
		  background-color: #f1f3f5;
		  border-radius: 20px;
		  margin-bottom: 10px;
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
		.comment {
		  margin-bottom: 15px;
		}
		.comment-username {
		  font-weight: 600;
		  margin-right: 10px;
		}
		.comment-content {
		  color: #262626;
		}
		.comment-time {
		  font-size: 12px;
		  color: #8e8e8e;
		  margin-top: 4px;
		}
		
		 #topBtn {
      position: fixed;
      bottom: 20px;
      right: 20px;
      display: none;
      background-color: #84a98c;
      color: #fff;
      border: none;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      text-align: center;
      line-height: 50px;
      cursor: pointer;
      transition: opacity 0.3s;
    }
    #topBtn.show {
      display: block;
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
    
	 	// 스크롤에 따른 Top 버튼 표시
    $(window).scroll(function() {
      if ($(this).scrollTop() > 100) {
        $('#topBtn').addClass('show');
      } else {
        $('#topBtn').removeClass('show');
      }
    });

    // Top 버튼 클릭 시 부드럽게 상단으로 이동
    $('#topBtn').click(function() {
      $('html, body').animate({scrollTop : 0}, 800);
      return false;
    });
    
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <div class="bodyContainer">
    <div class="titleHeader">
      <a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
      <span class="h2">${vo.title}</span>
    </div>
    <div class="contentContainer">
      <div class="header">
        <img src="${ctp}/member/${photo}" alt="User Avatar" class="user-avatar">
        <span class="user-name">${vo.name}</span>
        <span class="post-time">${fn:substring(vo.PDate,0,11)}</span>
      </div>
      
      <div class="slideshow-container">
        <c:forEach var="item" items="${fn:split(vo.content, '\"')}" varStatus="status">
          <c:if test="${fn:contains(item, '/javaclassS16/photo/')}">
            <c:set var="imagePath" value="${fn:substringAfter(item, '/javaclassS16/')}" />
            <div class="mySlides">
              <img src="${ctp}/${imagePath}" alt="Photo ${status.index + 1}">
            </div>
          </c:if>
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
      
      <div class="comments-section">
        <c:if test="${!empty latestReply}">
          <div class="comment">
            <span class="comment-username">${latestReply.name}</span>
            <span class="comment-content">${fn:replace(latestReply.content, newLine, "<br/>")}</span>
            <div class="comment-time">
              ${fn:substring(latestReply.prDate, 0, 10)}
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
    </div>
  </div>
</div>
    
<button id="topBtn" title="Go to top"><i class="fas fa-chevron-up"></i></button>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>