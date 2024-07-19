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
      color: #cecece; 
    }
    .home-icon:hover {color: #c6c6c6;}
    h2 {
    	font-family: 'Pretendard' !important;
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
		.notice-author {
		  flex: 0 0 100px;
		  text-align: center;
		}
		.notice-views {
		  flex: 0 0 60px;
		  text-align: center;
		}
		.notice-date {
		  flex: 0 0 100px;
		  text-align: center;
		}
		.pinned {
		  background-color: #f0f8ff;
		}
		.pinned-icon {
		  color: #e4e6eb;
		  margin-right: 5px;
		}
    /* 
    .notice-item {
		  border-bottom: 1px solid #e5e5e5;
		  padding: 15px 0;
		  display: flex;
		  align-items: center;
		}
		.notice-number {
		  flex: 0 0 120px;
		  display: flex;
		  align-items: center;
		}
		.notice-title {
		  flex: 1;
		  font-weight: 500;
		}
		.notice-info {
		  flex: 0 0 150px;
		  display: flex;
		  flex-direction: column;
		  align-items: flex-end;
		}
		.notice-date {
		  flex: 0 0 100px;
		  text-align: right;
		} */
    
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
	    background-color: #f0f2f5;
	    color: #333;
	  }
	  
	  .badge-important {
	    background-color: #e4e6eb;
	    color: #333;
	    font-weight: bold;
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
    
    
    select {
      background-color: white;
      border: 1px solid #dbdbdb;
      padding: 8px;
      font-size: 14px;
    }
    
    
    
    .pinned {
      background-color: #f0f8ff;
    }
    .pinned-icon, .important-icon {
      color: #e4e6eb;
      margin-right: 5px;
    }
    
    
    .pagination {
		  display: inline-block;
		  padding-left: 0;
		  margin: 20px 0;
		  border-radius: 4px;
		}
		.pagination > li {
		  display: inline;
		}
		.pagination > li > a,
		.pagination > li > span {
		  position: relative;
		  float: left;
		  padding: 6px 12px;
		  margin-left: -1px;
		  line-height: 1.42857143;
		  color: #84a98c;
		  text-decoration: none;
		  background-color: #fff;
		  border: 1px solid #ddd;
		}
		.pagination > li:first-child > a,
		.pagination > li:first-child > span {
		  margin-left: 0;
		  border-top-left-radius: 4px;
		  border-bottom-left-radius: 4px;
		}
		.pagination > li:last-child > a,
		.pagination > li:last-child > span {
		  border-top-right-radius: 4px;
		  border-bottom-right-radius: 4px;
		}
		.pagination > li > a:hover,
		.pagination > li > span:hover,
		.pagination > li > a:focus,
		.pagination > li > span:focus {
		  color: #2a6496;
		  background-color: #eee;
		  border-color: #ddd;
		}
		.pagination > .active > a,
		.pagination > .active > span,
		.pagination > .active > a:hover,
		.pagination > .active > span:hover,
		.pagination > .active > a:focus,
		.pagination > .active > span:focus {
		  z-index: 2;
		  color: #fff;
		  cursor: default;
		  background-color: #84a98c;
		  border-color: #84a98c;
		}
  </style>
  
  <script>
    'use strict';
    
    function pageSizeCheck() {
      let pageSize = $("#pageSize").val();
      location.href = "noticeList?pageSize="+pageSize;
    }

    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="noticeContainer">
    <div style="display: flex; align-items: center; gap: 20px;" class="mb-5"> 
      <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
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
    <div class="search-bar">
	    <select name="choice" id="choice" onchange="noticeSearch()">
	      <option value="최신순" ${choice == '최신순' ? 'selected' : ''}>최신순</option>
	      <option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
	      <option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
	      <option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
	      <option value="오래된순" ${choice == '오래된순' ? 'selected' : ''}>오래된순</option>
	    </select>
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
    
    <c:set var="pinnedCount" value="${fn:length(vos.stream().filter(vo -> vo.pinned).toList())}" />
		<c:set var="counter" value="${(pageVO.pag-1) * pageVO.pageSize - pinnedCount}" />
    <div class="notice-list">
		  <c:forEach var="vo" items="${vos}" varStatus="st">
		    <c:set var="counter" value="${counter + 1}" />
		    <div class="notice-item ${vo.pinned ? 'pinned' : ''}">
		      <div class="notice-number">
		        <c:if test="${vo.pinned}"><i class="fa-solid fa-thumbtack pinned-icon"></i></c:if>
		        <c:if test="${!vo.pinned}">${counter}</c:if>
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
		      <div class="notice-views text-muted">${vo.viewCount}</div>
		      <div class="notice-date text-muted">
		        ${fn:substring(vo.createdAt,0,10)}
		      </div>
		    </div> 
		  </c:forEach>
		</div> 
    
    <!-- 블록페이지 시작  
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
		블록페이지 끝 -->
		
		<!-- 블록페이지 시작 -->
		<div class="d-flex justify-content-center my-4">
		  <ul class="pagination">
		    <c:if test="${pageVO.pag > 1}">
		      <li><a href="noticeList?pag=1&pageSize=${pageVO.pageSize}">처음</a></li>
		    </c:if>
		    <c:if test="${pageVO.curBlock > 0}">
		      <li><a href="noticeList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">&laquo;</a></li>
		    </c:if>
		    <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
		      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
		        <li class="active"><a href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li>
		      </c:if>
		      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		        <li><a href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li>
		      </c:if>
		    </c:forEach>
		    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		      <li><a href="noticeList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">&raquo;</a></li>
		    </c:if>
		    <c:if test="${pageVO.pag < pageVO.totPage}">
		      <li><a href="noticeList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">끝</a></li>
		    </c:if>
		  </ul>
		</div>
		<!-- 블록페이지 끝 -->
     
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>