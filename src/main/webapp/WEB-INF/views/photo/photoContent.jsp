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
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
      background-color: #fafafa;
      margin: 0;
      padding: 0;
    }
    .container {
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
    }
    .mySlides img {
      width: 100%;
      display: block;
    }
    .prev, .next {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      font-size: 20px;
      font-weight: bold;
      padding: 16px;
      color: white;
      background: rgba(0,0,0,0.3);
      border: none;
      cursor: pointer;
    }
    .next {
      right: 0;
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
    .comments-section {
      padding-bottom: 16px;
      font-size: 14px;
    }
    .comment {
      margin-bottom: 8px;
      line-height: 1.4;
    }
    .comment-username {
      font-weight: 600;
      margin-right: 4px;
      color: #262626;
    }
    .comment-content {
      color: #262626;
    }
    .comment-time {
      font-size: 12px;
      color: #8e8e8e;
      margin-top: 4px;
    }
    .view-all-comments {
      color: #8e8e8e;
      font-size: 14px;
      margin-bottom: 8px;
      cursor: pointer;
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
  </style>
  <script>
    'use strict';
    
    let slideIndex = 1;

    document.addEventListener("DOMContentLoaded", function() {
      showSlides(slideIndex);
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
        mid       : '${sMid}',
        photoIdx  : '${vo.idx}',
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
    
    function goodCheck() {
      $.ajax({
        url  : "${ctp}/photo/photoGoodCheck",
        type : "post",
        data : {idx : ${vo.idx}},
        success:function(res) {
          if(res != "0") location.reload();
          else alert("이미 좋아요 버튼을 클릭하셨습니다.");
        },
        error : function() {
          alert("전송오류");
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
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <div class="header">
    <img src="${ctp}/member/${photo}" alt="User Avatar" class="user-avatar">
    <span class="user-name">${vo.name}</span>
    <span class="post-time">${fn:substring(vo.PDate,0,16)}</span>
  </div>
  
  <div class="slideshow-container">
    <c:if test="${not empty vo.content}">
      <c:set var="imageCount" value="0" />
      <c:forEach var="item" items="${fn:split(vo.content, '\"')}">
        <c:if test="${fn:contains(item, '/javaclassS16/photo/')}">
          <c:set var="imageCount" value="${imageCount + 1}" />
          <c:set var="imagePath" value="${fn:substringAfter(item, '/javaclassS16/')}" />
          <div class="mySlides">
            <img src="${ctp}/${imagePath}" width="100%" />
          </div>
        </c:if>
      </c:forEach>
    </c:if>
    <a class="prev" onclick="plusSlides(-1)">❮</a>
    <a class="next" onclick="plusSlides(1)">❯</a>
  </div>
  
  <div style="text-align:center">
    <c:forEach var="i" begin="1" end="${vo.photoCount}" varStatus="st">
      <span class="dot" onclick="currentSlide(${i})"></span> 
    </c:forEach>
  </div>
  
  <div class="interaction-bar">
    <i class="interaction-icon fa-regular fa-heart" onclick="goodCheck()"></i>
    <i class="interaction-icon fa-regular fa-comment" onclick="replyInputShow()"></i>
    <i class="interaction-icon fa-regular fa-paper-plane"></i>
  </div>
  
  <div class="description">
    <p><strong>${vo.name}</strong> ${fn:replace(vo.description, newLine, "<br/>")}</p>
  </div>
  
  <div class="comments-section">
    <div class="view-all-comments" onclick="replyShow()">댓글 ${vo.replyCnt}개 모두 보기</div>
    
    <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
      <div class="comment">
        <span class="comment-username">${replyVo.mid}</span>
        <span class="comment-content">${fn:replace(replyVo.content,newLine," ")}</span>
        <div class="comment-time">
          ${fn:substring(replyVo.prDate, 0, 10)}
          <c:if test="${sMid == replyVo.mid || sLevel == 0}">
            <a href="javascript:replyDelete(${replyVo.replyIdx})" title="댓글삭제">삭제</a>
          </c:if>
        </div>
      </div>
    </c:forEach>

    <div class="add-comment" style="display:none;">
      <input type="text" id="content" class="comment-input" placeholder="댓글 달기...">
      <button class="post-comment-btn" onclick="replyCheck()">게시</button>
    </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>