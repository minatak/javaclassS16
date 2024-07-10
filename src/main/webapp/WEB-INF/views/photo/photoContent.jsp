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
		* {box-sizing: border-box}
		body {font-family: 'pretendard' !important; margin:0}
		.home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
		.mySlides {display: none}
		img {vertical-align: middle;}
		
		/* Slideshow container */
		.slideshow-container {
		  max-width: 1000px;
		  position: relative;
		  margin: auto;
		}
		
		/* Next & previous buttons */
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
		}
		
		/* Position the "next button" to the right */
		.next {
		  right: 0;
		  border-radius: 3px 0 0 3px;
		}
		
		/* On hover, add a black background color with a little bit see-through */
		.prev:hover, .next:hover {
		  background-color: rgba(0,0,0,0.8);
		}
		
		/* Caption text */
		.text {
		  color: #f2f2f2;
		  font-size: 15px;
		  padding: 8px 12px;
		  position: absolute;
		  bottom: 8px;
		  width: 100%;
		  text-align: center;
		}
		
		/* Number text (1/3 etc) */
		.numbertext {
		  color: #f2f2f2;
		  font-size: 12px;
		  padding: 8px 12px;
		  position: absolute;
		  top: 0;
		}
		
		/* The dots/bullets/indicators */
		.dot {
		  cursor: pointer;
		  height: 15px;
		  width: 15px;
		  margin: 0 2px;
		  background-color: #bbb;
		  border-radius: 50%;
		  display: inline-block;
		  transition: background-color 0.6s ease;
		}
		
		.active, .dot:hover {
		  background-color: #717171;
		}
		
		/* On smaller screens, decrease text size */
		@media only screen and (max-width: 300px) {
		  .prev, .next,.text {font-size: 11px}
		}
	</style>
  <script>
    'use strict';
    
    document.addEventListener("DOMContentLoaded", function() {
    	  showSlides(slideIndex);
    	});
    
    function replyHide() {
    	$("#replyHideBtn").hide();
    	$("#replyShowBtn").show();
    	$("#replyList").hide();
    }
    
    function replyShow() {
    	$("#replyHideBtn").show();
    	$("#replyShowBtn").hide();
    	$("#replyList").show();
    }
    
    function replyInputShow() {
    	$("#replyInput").toggle();
    }
    
    // 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	let query = {
    			mid				: '${sMid}',
    			photoIdx	: '${vo.idx}',
    			content		: content
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
    
    // 댓글 삭제하기
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
    
    // 좋아요 처리(중복불허)
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
	<div>
		<a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
  	<h2>[${vo.part}] ${vo.title}</h2>
  </div>
  <div class="row">
    <div class="col">
      ${vo.name} | ${fn:substring(vo.PDate,0,16)} |  
    </div>
    <div class="col text-right">
      <i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt} &nbsp;
      <i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.goodCount} &nbsp;
      <i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum} &nbsp;
      <i class="fa-solid fa-layer-group" title="사진수"></i> ${vo.photoCount}
    </div>
  </div>
  <hr/>
  <div class="mb-3">
    <h5>설명:</h5>
    <%-- <p>${fn:replace(vo.description, newLine, "<br/>")}</p> --%>
  </div>
   <div class="slideshow-container">
    <c:if test="${not empty vo.content}">
        <c:set var="imageCount" value="0" />
        <c:forEach var="item" items="${fn:split(vo.content, '\"')}">
            <c:if test="${fn:contains(item, '/javaclassS16/photo/')}">
                <c:set var="imageCount" value="${imageCount + 1}" />
                <c:set var="imagePath" value="${fn:substringAfter(item, '/javaclassS16/')}" />
                <div class="mySlides">
                    <div class="numbertext">${imageCount} / ${vo.photoCount}</div>
                    <img src="${ctp}/${imagePath}" width="100%" />
                </div>
                <c:out value="${fn:substringAfter(imagePath, 'photo/')}" /><br>
            </c:if>
        </c:forEach>
    </c:if>
    <a class="prev" onclick="plusSlides(-1)">❮</a>
    <a class="next" onclick="plusSlides(1)">❯</a>
</div>
  <br>
  <div style="text-align:center">
    <c:forEach var="i" begin="1" end="${vo.photoCount}" varStatus="st">
		  <span class="dot" onclick="currentSlide(${i})"></span> 
		</c:forEach>
  </div>

  <br/>
  <div class="row">
    <div class="col">
      <input type="button" value="목록보기" onclick="location.href='${ctp}/photo/photoList';" class="btn btn-secondary"/>
      <input type="button" value="댓글가리기" onclick="replyHide()" id="replyHideBtn" class="btn btn-info"/>
      <input type="button" value="댓글보이기" onclick="replyShow()" id="replyShowBtn" class="btn btn-warning" style="display:none;"/>
    </div>
    <div class="col text-right" style="font-size:22px">
      <a href="javascript:replyInputShow()"><i class="fa-regular fa-pen-to-square" title="댓글쓰기"></i></a> ${vo.replyCnt} &nbsp;
      <a href="javascript:goodCheck()"><i class="fa-regular fa-face-grin-hearts text-danger" title="좋아요 선택"></i></a> ${vo.goodCount}
    </div>
  </div>
  <!-- 댓글 입력창 -->
  <div id="replyInput" style="display:none;">
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
  </div>
  <hr/>
  <div id="replyList">
	  <!-- 댓글 리스트 보여주기 -->
		<table class="table table-hover text-center">
		  <tr class="table-secondary">
		    <th>작성자</th>
		    <th>댓글내용</th>
		    <th>댓글일자</th>
		  </tr>
		  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
		    <tr>
		      <td>${replyVo.mid}
		        <c:if test="${sMid == replyVo.mid || sLevel == 0}">
		          (<a href="javascript:replyDelete(${replyVo.replyIdx})" title="댓글삭제">x</a>)
		        </c:if>
		      </td>
		      <td class="text-left">${fn:replace(replyVo.content,newLine,"<br/>")}</td>
		      <td>${fn:substring(replyVo.prDate, 0, 10)}</td>
		    </tr>
		  </c:forEach>
		  <tr><td colspan="3" class='m-0 p-0'></td></tr>
		</table>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	let slideIndex = 1;
	showSlides(slideIndex);
	
	function plusSlides(n) {
	  showSlides(slideIndex += n);
	}
	
	function currentSlide(n) {
	  showSlides(slideIndex = n);
	}
	
	function showSlides(n) {
	  let i;
	  let slides = document.getElementsByClassName("mySlides");
	  let dots = document.getElementsByClassName("dot");
	  if (n > slides.length) {slideIndex = 1}    
	  if (n < 1) {slideIndex = slides.length}
	  for (i = 0; i < slides.length; i++) {
	    slides[i].style.display = "none";  
	  }
	  for (i = 0; i < dots.length; i++) {
	    dots[i].className = dots[i].className.replace(" active", "");
	  }
	  slides[slideIndex-1].style.display = "block";  
	  dots[slideIndex-1].className += " active";
	}
</script>
</body>
</html>