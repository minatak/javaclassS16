<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  
  <style>
    body {
      font-family: 'Pretendard' !important;
      background-color: #ffffff;
    }
    .noticeContainer {
      max-width: 900px;
      background-color: white;
      padding: 40px;
      margin: 30px auto;
    }
    .home-icon { 
      font-size: 24px; 
      color: #e4e6eb; 
    }
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
    .notice-item:hover {
      background-color: #f8f9fa;
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
    .notice-date {
      flex: 0 0 100px;
      text-align: center;
      color: #666;
    }
    .btn-write {
      background-color: #e4e6eb;
      border-color: #e4e6eb;
      color: black;
    }
    .btn-write:hover {
      background-color: #d0d3d9;
      border-color: #d0d3d9;
      color: black;
    }
    .pagination .page-link {
      color: #e4e6eb;
    }
    .pagination .page-item.active .page-link {
      background-color: #e4e6eb;
      border-color: #e4e6eb;
      color: black;
    }
    .form-control:focus {
      border-color: #e4e6eb;
      box-shadow: 0 0 0 0.2rem rgba(228, 230, 235, 0.25);
    }
    .badge-new {
      background-color: #ff5722;
      color: white;
    }
    .badge-unread {
      background-color: #007bff;
      color: white;
    }
    .searchContainer {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 20px;
    }
    .search-bar {
      display: flex;
      width: 50%;
    }
    .action-buttons {
      display: flex;
      gap: 10px;
    }
    #searchString {
      margin-right: 10px;
      padding: 8px;
      border: 1px solid #dbdbdb;
      border-radius: 4px;
    }
    .btn-search {
      background-color: #e4e6eb;
      color: black;
    }
    .pinned {
      background-color: #f0f8ff;
    }
    .pinned-icon, .important-icon {
      color: #e4e6eb;
      margin-right: 5px;
    }
  </style>
  
  <script>
    'use strict';
    
    function pageSizeCheck() {
      let pageSize = $("#pageSize").val();
      location.href = "noticeList?pageSize="+pageSize;
    }
    
    function modalCheck(idx, memberIdx, title) {
      $("#myModal #modalMemberIdx").text(memberIdx);
      $("#myModal #modalTitle").text(title);
      $("#myModal #modalIdx").text(idx);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="noticeContainer">
    <div style="display: flex; align-items: center; gap: 20px;" class="mb-5">
      <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-house"></i></a>
      <h2>공지사항</h2>
    </div>
    
    <div class="searchContainer">
      <div class="search-bar">
        <form name="searchForm" method="post" action="noticeSearch" class="form-inline">
          <select name="search" id="search" class="form-control">
            <option value="title">글제목</option>
            <option value="content">글내용</option>
          </select>
          <input type="text" name="searchString" id="searchString" required class="form-control" placeholder="검색어를 입력하세요" />
          <input type="submit" value="검색" class="btn btn-search"/>
          <input type="hidden" name="pag" value="${pageVO.pag}"/>
          <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
        </form>
      </div>
    </div>
    
    <div class="d-flex justify-content-between mb-3">
      <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-control" style="width: auto;">
        <option ${pageVO.pageSize==5  ? "selected" : ""}>5</option>
        <option ${pageVO.pageSize==10 ? "selected" : ""}>10</option>
        <option ${pageVO.pageSize==15 ? "selected" : ""}>15</option>
        <option ${pageVO.pageSize==20 ? "selected" : ""}>20</option>
        <option ${pageVO.pageSize==30 ? "selected" : ""}>30</option>
      </select>
      <a href="noticeInput" class="btn btn-write">글쓰기</a> 
    </div>
    
    <div class="notice-list">
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <div class="notice-item ${vo.pinned ? 'pinned' : ''}">
          <div class="notice-number">
            <c:if test="${vo.pinned}"><i class="fa-solid fa-thumbtack pinned-icon"></i></c:if>
            <c:if test="${vo.important}"><i class="fa-solid fa-exclamation important-icon"></i></c:if>
            <c:if test="${!vo.pinned && !vo.important}">${st.count}</c:if>
          </div>
          <div class="notice-title">
            <a href="noticeContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="text-dark">
              ${vo.title}
              <c:if test="${vo.hour_diff <= 24}"><span class="badge badge-new ml-1">N</span></c:if>
              <c:if test="${!vo.read}"><span class="badge badge-unread ml-1">읽지 않음</span></c:if>
            </a>
          </div>
          <div class="notice-date">
            ${fn:substring(vo.createdAt,0,10)}
          </div>
        </div>
      </c:forEach>
    </div>
    
    <!-- 페이지네이션 -->
    <div class="d-flex justify-content-center my-4">
      <ul class="pagination">
        <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="noticeList?pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
        <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="noticeList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
        <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
          <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
          <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        </c:forEach>
        <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="noticeList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
        <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="noticeList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
      </ul>
    </div>
    
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>