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
  <title>가족 소식 검색 | HomeLink</title>
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
    
    .pinned-icon, .important-icon {
      color: #84a98c;
      margin-right: 5px;
    }
    
    .search-and-write {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 40px;
    }
    
    .select-options {
      display: flex;
      align-items: center;
    }
    
    .select-options select {
      padding: 8px;
      border: 1px solid #ced4da;
      border-radius: 4px; 
    }
    
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
    
    .search-result {
      margin-bottom: 20px;
      font-size: 16px;
      color: #333;
    }
    
    .search-result span {
      font-weight: bold;
      color: #84a98c;
    }
  </style>
  
  <script>
    'use strict';
    
    function noticeChoice() {
  	  let pageSize = $("#pageSize").val();
  	  let choice = $("#choice").val();
  	  location.href = "noticeSearch?search=${search}&searchString=${searchString}&choice=" + choice;
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="noticeContainer">
    <div class="header">
      <a href="${ctp}/notice/noticeList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
      <font size="5" class="mb-4 h2">가족 소식 검색 결과</font>
    </div>
    
    <div class="search-result">
      <span>${searchTitle}</span>(으)로 <span>${searchString}</span>(을)를 검색한 결과 <span>${searchCount}</span>건의 게시글이 검색되었습니다.
    </div>
    <%-- 
    <div class="search-and-write">
      <div class="select-options">
        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
          <option ${pageSize==5  ? "selected" : ""}>5</option>
          <option ${pageSize==10 ? "selected" : ""}>10</option>
          <option ${pageSize==15 ? "selected" : ""}>15</option>
          <option ${pageSize==20 ? "selected" : ""}>20</option>
          <option ${pageSize==30 ? "selected" : ""}>30</option>
        </select>
      </div>
      <a href="noticeInput" class="btn write-btn">글쓰기</a>
    </div>
     --%>
    <div class="search-and-write">
		  <div class="select-options">
		   <%--  <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
		      <option ${pageSize==5  ? "selected" : ""}>5</option>
		      <option ${pageSize==10 ? "selected" : ""}>10</option>
		      <option ${pageSize==15 ? "selected" : ""}>15</option>
		      <option ${pageSize==20 ? "selected" : ""}>20</option>
		      <option ${pageSize==30 ? "selected" : ""}>30</option>
		    </select> --%>
		    <select name="choice" id="choice" onchange="noticeChoice()">
		      <option value="최신순" ${choice == '최신순' ? 'selected' : ''}>최신순</option>
		      <option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
		      <option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
		      <option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
		      <option value="오래된순" ${choice == '오래된순' ? 'selected' : ''}>오래된순</option>
		    </select>
		  </div>
		  <!-- <a href="noticeInput" class="btn write-btn">글쓰기</a> -->
		</div>
     
     
    <div class="notice-list">
    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <div class="notice-item">
          <div class="notice-number">${curScrStartNo}</div>
          <div class="notice-title">
            <a href="noticeContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&flag=search&search=${search}&searchString=${searchString}" class="text-dark">
              ${vo.title}
              <c:if test="${vo.hour_diff <= 24}"><span class="badge badge-new ml-1">N</span></c:if>
            </a>
          </div>
          <div class="notice-author">${vo.memberName}</div>
          <div class="notice-views text-muted">${vo.viewCount}(${vo.goodCount})</div>
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
        <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
        <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
        <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
          <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
          <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        </c:forEach>
        <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
        <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
      </ul>
    </div>
    <!-- 블록페이지 끝 -->
    
    <div class="text-center mt-4">
      <%-- <input type="button" value="돌아가기" onclick="location.href='noticeList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}';" class="btn"/> --%>
    	<a href="${ctp}/notice/noticeList" class="btn">돌아가기</a> 
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>