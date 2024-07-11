<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title> | HomeLink</title>
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
    }
    .mySlides img {
      width: 100%;
      display: block;
    }
    .prev, .next {
      cursor: pointer;
      position: absolute;
      top: 50%;
      width: auto;
      padding: 16px;
      margin-top: -22px;
      color: white;
      font-weight: bold;
      font-size: 18px;
      transition: 0.6s ease;
      border-radius: 0 3px 3px 0;
      user-select: none;
      background-color: rgba(0,0,0,0.3);
    }
    .next {
      right: 0;
      border-radius: 3px 0 0 3px;
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
    .comment {
      margin-bottom: 8px;
    }
    .comment-username {
      font-weight: 600;
      margin-right: 4px;
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
      padding: 16px;
    }
    .comment-input {
      flex-grow: 1;
      border: none;
      outline: none;
    }
    .post-comment-btn {
      border: none;
      background: none;
      color: #0095f6;
      font-weight: 600;
      cursor: pointer;
    }
  </style>
  <script>
    'use strict';
    
    let slideIndex = 1;
    let curPage = 1;

    function plusSlides(n) {
      showSlides(slideIndex += n);
    }

    function currentSlide(n) {
      showSlides(slideIndex = n);
    }

    function showSlides(n) {
      let slides = document.getElementsByClassName("mySlides");
      if (n > slides.length) {slideIndex = 1}    
      if (n < 1) {slideIndex = slides.length}
      for (let i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";  
      }
      slides[slideIndex-1].style.display = "block";  
    }
    
    $(window).scroll(function() {
      if($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
        curPage++;
        $.ajax({
          url: "${ctp}/photo/photoSinglePaging",
          type: "post",
          data: {pag: curPage},
          success: function(res) {
            $("#photoContainer").append(res);
          }
        });
      }
    });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
  <div id="photoContainer">
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <div class="contentContainer">
        <div class="header">
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
        
        <div class="interaction-bar">
          <i class="interaction-icon fa-regular fa-heart" onclick="goodCheck(${vo.idx})"></i>
          <i class="interaction-icon fa-regular fa-comment" onclick="replyInputShow(${vo.idx})"></i>
          <i class="interaction-icon fa-regular fa-paper-plane"></i>
        </div>
        
        <div class="description">
          <p><strong>${vo.name}</strong> ${fn:replace(vo.description, newLine, "<br/>")}</p>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
<p style="clear:both;"><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>