<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>앨범 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
   <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'pretendard' !important;
      background-color: #fafafa;
      color: #262626;
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
		}
    .photoContainer {
      max-width: 900px;
      margin: 0 auto;
      padding: 20px 0;
    }
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .home-icon:hover {color: #c6c6c6;}
    .grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 3px;
    }
    .card {
      position: relative;
      width: 100%;
      padding-bottom: 90%;
      overflow: hidden;
      border-radius:0px;
    }
    .card img {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .card-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.3);
      opacity: 0;
      transition: opacity 0.2s ease;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
    }
    .card:hover .card-overlay {
      opacity: 1;
    }
    .card-stats {
      display: flex;
      gap: 30px;
    }
    .card-stat {
      display: flex;
      align-items: center;
      font-weight: 600;
    }
    .card-stat i {
      margin-right: 7px;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      padding-bottom: 20px;
    }
    .btn {
      background-color: #84a98c;
      color: white;
      border: none;
      border-radius:0px;
      padding: 8px 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-weight: 600;
      font-size: 14px;
    }
    .btn:hover {
      color: white;
      background-color: #6b8e76;
    }
    select {
      background-color: white;
      border: 1px solid #dbdbdb;
      padding: 8px;
      font-size: 14px;
    }
    h2 {
    	font-family: 'pretendard' !important;
    	font-weight: 700;
      color: #262626;
      font-size: 28px;
      margin: 0;
    }
    .multiple-photos {
      position: absolute;
      top: 10px;
      right: 10px;
      color: white;
      font-size: 20px;
    }
    .search-bar, .title-search {
	    display: flex;
	    align-items: center;
	  }
	  #titleSearch {
	    margin-right: 10px;
	    padding: 8px;
	    border: 1px solid #dbdbdb;
	    border-radius: 0px;
	  }
    .searchContainer {
    	/* max-width: 600px; */
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  margin-bottom: 20px;
		}
		.action-buttons {
		  display: flex;
		  gap: 10px;
		  margin-bottom: 0; /* Remove bottom margin */
		}
    .top-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
  </style>
  <script>
    'use strict';
    
    function photoSearch() {
    	/* let part = $("#part").val(); */
    	let choice = $("#choice").val();
    	
    	location.href = "${ctp}/photo/photoList?choice="+choice;
    }
    
    let curPage = 1;
    let loading = false;
    let hasMore = true;

    $(document).ready(function() {
        curPage = 1;
        loading = false;
        hasMore = true;
    });

    function loadMorePhotos() {
        if (loading || !hasMore) return;
        loading = true;
        $.ajax({
            url: "${ctp}/photo/photoPaging",
            type: "post",
            data: {pag: curPage, choice: $("#choice").val()},
            success: function(res) {
                let $res = $(res);
                if ($res.find('.card').length > 0) {
                    $("#list-wrap").append($res.find('.card'));
                    curPage++;
                    hasMore = $res.find('#hasMore').val() === 'true';
                } else {
                    hasMore = false;
                }
                loading = false;
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:", error);
                loading = false;
            }
        });
    }

    $(window).on('scroll', function() {
        if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
            loadMorePhotos();
        }
    });

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="photoContainer">
	<div class="searchItems">
	  <div class="top-bar">
	    <div class="header">
		    <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
		    <font size="5" class="h2">가족 앨범</font>
			</div>
	  </div>
	  <hr/>
	  <div class="searchContainer">
		  <div class="search-bar">
		    <select name="choice" id="choice" onchange="photoSearch()">
		      <option value="최신순" ${choice == '최신순' ? 'selected' : ''}>최신순</option>
		      <option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
		      <option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
		      <option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
		      <option value="오래된순" ${choice == '오래된순' ? 'selected' : ''}>오래된순</option>
		    </select>
		    <!-- <button onclick="photoSearch()" class="btn ml-2" >적용</button> -->
		  </div>		
		  <!-- <div class="title-search">
	      <input type="text" name="titleSearch" id="titleSearch" placeholder="사진의 해시태그를 검색하세요"/>
		    <button onclick="titleSearch()" class="btn"><i class="fa-solid fa-magnifying-glass"></i></button>
		  </div> -->
		  <div class="action-buttons">
		    <button onclick="location.href='${ctp}/photo/photoInput';" class="btn">업로드</button>
		    <%-- <button onclick="location.href='${ctp}/photo/photoList';" class="btn">내 업로드 보기</button> --%>
		  </div>
		</div>
	</div>

  <div class="grid" id="list-wrap">
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <div class="card">
        <a href="${ctp}/photo/photoContent?idx=${vo.idx}">
          <img src="${ctp}/thumbnail/${vo.thumbnail}" />
          <c:if test="${vo.photoCount > 1}">
            <div class="multiple-photos">
              <i class="fas fa-clone"></i>
            </div>
          </c:if>
          <div class="card-overlay">
            <div class="card-stats">
              <div class="card-stat"><i class="fas fa-comment"></i> ${vo.replyCnt}</div>
              <div class="card-stat"><i class="fas fa-heart"></i> ${vo.goodCount}</div>
            </div>
          </div>
        </a>
      </div>
    </c:forEach>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>