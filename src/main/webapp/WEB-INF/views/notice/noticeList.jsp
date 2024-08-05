<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>가족소식 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  
  <style>
    body {
		  font-family: 'Pretendard' !important;
		  background-color: #ffffff;
		}
		.header {
		  margin-bottom: 50px;
		}
		.header .h2 {
		  font-family: 'pretendard' !important;
		  font-weight: 600;
		  font-size: 24px;
		  color: #333c47;
		  text-align: center;
		  margin-bottom: 50px;
		}
		.noticeContainer {
		  max-width: 900px;
		  background-color: white;
		  padding: 40px;
		  margin: 30px auto;
		} 
		.home-icon { 
		  font-size: 24px; 
		  color: #cecece; 
		}
		.home-icon:hover {color: #c6c6c6;}
		
		h2 {
		  color: #333;
		  margin-bottom: 30px;
		  font-weight: 700;
		}
		
		.notice-item {
		  border-bottom: 1px solid #e5e5e5;
		  padding: 15px 0;
		  display: flex;
		  align-items: center;
		}
		
		.notice-number {
		  flex: 0 0 60px;
		  font-weight: bold;
		  color: #666;
		}
		
		.notice-title {
		  flex: 1;
		  font-weight: 500;
		}
		
		.notice-author, .notice-date {
		  flex: 0 0 100px;
		  text-align: center;
		}
		
		.notice-views {
		  flex: 0 0 60px;
		  text-align: center;
		}
		
		/* .pinned {
		  background-color: #f0f8ff;
		}
		 */
		
	/* 	.pinned-icon, .important-icon {
		  color: #e4e6eb;
		  margin-right: 5px;
		} */
		.pinned-icon, .important-icon {
		  color: #84a98c;
		  margin-right: 5px;
		}
		
		.search-and-write {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  margin-bottom: 40px;
		  /* padding: 20px; */
		  /* background-color: #fff;
		  border-radius: 8px; */
		}
		
		.select-options {
		  display: flex;
		  align-items: center;
		}
		
		.select-options select {
		 /*  margin-right: 10px; */
		 	/* margin-right: 5px; */
		  padding: 8px;
		  border: 1px solid #ced4da;
		  border-radius: 4px; 
		}
		
	/* 	.search-form {
		  display: flex;
		  align-items: center;
		  flex-grow: 1;
		  justify-content: center;
		  margin: 0 20px;
		}
		
		.search-form select,
		.search-form input[type="text"] {
		  padding: 8px;
		  border: 1px solid #ced4da;
		}
		
		.search-form input[type="text"] {
		  width: 200px;
		  hight: 100%;
		  border-radius: 0px;
		}
		 */
		.btn {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  border-radius: 4px;
		  padding: 8px 16px;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  font-weight: 600;
		  font-size: 14px;
		}
		
		.btn:hover {
		  background-color: #6b8e76;
		  color: white;
		}
		
		.write-btn {
		  white-space: nowrap;
		}
		
		.pagination {
		  margin-top: 30px;
		}
		
		.pagination .page-link {
		  color: #84a98c;
		}
		
		.pagination .page-item.active .page-link {
		  background-color: #84a98c;
		  border-color: #84a98c;
		  color: white;
		}
		
		.badge-new {
		  background-color: #ff5722;
		  color: white;
		}
		
		.badge-unread {
		  background-color: #f0f2f5;
		  color: #333;
		}
		
		.badge-important {
		  background-color: #e4e6eb;
		  color: #333;
		  font-weight: bold;
		}
		
		
		.search-form select,
		.search-form input[type="text"],
		.search-form .btn {
		  height: 40px; /* 모든 요소의 높이를 동일하게 설정 */
		  padding: 6px 12px; /* 내부 여백 조정 */
		  font-size: 14px; /* 글자 크기 통일 */
		  line-height: 1.5; /* 줄 높이 조정 */
		  vertical-align: middle; /* 수직 정렬 */
		  border-radius: 0px; 
		}
		
		.search-form select {
		  border-top-left-radius: 4px;
		  border-bottom-left-radius: 4px;
		  border: 1px solid #ced4da;
		}
		
		.search-form input[type="text"] {
		  width: 200px;
		  border-radius: 0;
		  border-left: none;
		  border-right: none;
		}
		
		.search-form .btn {
		  border-top-right-radius: 4px;
		  border-bottom-right-radius: 4px;
		  
		}
		
		/* 기존 스타일 수정 */
		.search-form {
		  display: flex;
		  align-items: stretch; /* 변경: center에서 stretch로 */
		  flex-grow: 1;
		  justify-content: center;
		  margin: 0 20px;
		}
  </style>
  
  <script>
    'use strict';
    
    function pageSizeCheck() {
      let pageSize = $("#pageSize").val();
      let choice = $("#choice").val();
      location.href = "noticeList?pageSize=" + pageSize + "&choice=" + choice;
    }

    function noticeChoice() {
      let pageSize = $("#pageSize").val();
      let choice = $("#choice").val();
      location.href = "noticeList?pageSize=" + pageSize + "&choice=" + choice;
    }

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="noticeContainer">
    <div class="header">
	    <a href="${ctp}/home" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	    <font size="5" class="mb-4 h2">가족 소식</font>
		</div>
    
  	<div class="search-and-write">
  		<div class="select-options">
		    <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
		      <option ${pageVO.pageSize==5  ? "selected" : ""}>5</option>
		      <option ${pageVO.pageSize==10 ? "selected" : ""}>10</option>
		      <option ${pageVO.pageSize==15 ? "selected" : ""}>15</option>
		      <option ${pageVO.pageSize==20 ? "selected" : ""}>20</option>
		      <option ${pageVO.pageSize==30 ? "selected" : ""}>30</option>
		    </select>
		    <select name="choice" id="choice" onchange="noticeChoice()">
		      <option value="최신순" ${choice == '최신순' ? 'selected' : ''}>최신순</option>
		      <option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
		      <option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
		      <option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
		      <option value="오래된순" ${choice == '오래된순' ? 'selected' : ''}>오래된순</option>
		    </select>
		  </div>
		  <form name="searchForm" method="post" action="noticeSearch" class="search-form">
		    <select name="search" id="search">
		      <option value="title">글제목</option>
		      <option value="content">글내용</option>
		      <option value="memberName">글쓴이</option>
		    </select>
		    <input type="text" name="searchString" id="searchString" required class="form-control" placeholder="검색어를 입력하세요..." />
		    <button type="submit" class="btn">
	        <i class="fa-solid fa-magnifying-glass"></i>
		    </button>
		    <input type="hidden" name="pag" value="${pageVO.pag}"/>
		    <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
		  </form>
		  <a href="noticeInput" class="btn write-btn">글쓰기</a>
		</div>
    
    
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
    <div class="notice-list">
		  <c:forEach var="vo" items="${vos}" varStatus="st">
		    <div class="notice-item ${vo.pinned ? 'pinned' : ''}">
		      <div class="notice-number">
		        <c:if test="${vo.pinned}"><i class="fa-solid fa-thumbtack pinned-icon"></i></c:if>
		        <c:if test="${!vo.pinned}">${curScrStartNo}</c:if>
		      </div>
		      <div class="notice-title">
		        <a href="noticeContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="text-dark">
		          ${vo.title}
		          <c:if test="${vo.hour_diff <= 24}"><span class="badge badge-new ml-1">N</span></c:if>
		          <c:if test="${vo.important}"><span class="badge badge-important ml-1">중요</span></c:if>
		          <c:if test="${!vo.read}"><span class="badge badge-unread ml-1">안읽음</span></c:if>
		        </a>
		      </div>
		      <div class="notice-author">${vo.memberName}</div>
		     <%--  <div class="notice-views text-muted">${vo.viewCount}</div> --%>
		      <div class="notice-views text-muted">${vo.viewCount}(${vo.goodCount})</div>
		     <%--  <div class="notice-date text-muted">
		        ${fn:substring(vo.createdAt,0,10)}
		      </div> --%>
		      <div class="notice-date text-muted">
            ${vo.date_diff == 0 ? fn:substring(vo.createdAt,11,16) : fn:substring(vo.createdAt,0,10)}
          </div>
		    </div> 
		    <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
		  </c:forEach>
		</div> 
    
    <!-- 블록페이지 시작 -->
		<div class="d-flex justify-content-center my-4">
		  <ul class="pagination justify-content-center">
			  <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
			  <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
			  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
			    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
			    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
			  </c:forEach>
			  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
			  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
		  </ul>
		</div>
		<!-- 블록페이지 끝 -->
		
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>