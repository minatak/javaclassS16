<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>앨범 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
   <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'pretendard' !important;
      background-color: #fff;
      color: #333;
    }
    .header {
	    margin-bottom: 30px; 
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
      padding: 40px 20px;
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
/* 
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      padding-bottom: 20px;
    } */
    .btn {
      background-color: #84a98c;
      color: white;
      border: none;
      border-radius:0px;
      padding: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-weight: 600;
      font-size: 14px;
      width: auto; /* 내용에 맞게 너비 조절 */
		  min-width: 100px; /* 최소 너비 설정 */
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
      width: auto; /* 내용에 맞게 너비 조절 */
		  min-width: 120px; /* 최소 너비 설정 */
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

    // 무한 스크롤 구현(aJax처리)
    let lastScroll = 0;
    let curPage = 1;
    
    $(document).scroll(function(){
    	let currentScroll = $(this).scrollTop();			// 스크롤바 위쪽시작 위치, 처음은 0이다.
    	let documentHeight = $(document).height();		// 화면에 표시되는 전체 문서의 높이
    	let nowHeight = $(this).scrollTop() + $(window).height();	// 현재 화면상단 + 현재 화면높이
    	
    	// 스크롤이 아래로 내려갔을때 이벤트 처리..
    	if(currentScroll > lastScroll) {
    		if(documentHeight < (nowHeight + (documentHeight*0.1))) {
    			console.log("다음페이지 가져오기");
    			curPage++;
    			//getList(curPage);
    			$.ajax({
  	    		url  : "photoPaging",
  	    		type : "post",
  	    		data : {
  	    			pag : curPage,
  	    			choice: $("#choice").val()
  	    		},
  	    		success:function(res) {
  	    			$("#list-wrap").append(res);
  	    		}
  	    	});
    		}
    	}
    	lastScroll = currentScroll;
    });
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
	<div class="photoContainer">
    <div class="header">
	    <a href="${ctp}/home" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	    <font size="5" class="mb-4 h2">가족 앨범</font>
		</div>
		<div class="searchItems">
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
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>