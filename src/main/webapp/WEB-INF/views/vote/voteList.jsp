<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>투표 목록 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
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
    .voteContainer {
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
    .vote-card {
		  border: 1px solid #ddd;
		  border-radius: 8px;
		  padding: 25px;
		  margin-bottom: 20px;
		  width: 100%;
		  height: 350px;
		  display: flex;
		  flex-direction: column;
		  transition: transform 0.3s ease, box-shadow 0.3s ease;
		  cursor: pointer;
		  overflow: hidden;
		  box-sizing: border-box;
		  background-color: #fff; 
		}
		
		.vote-card:hover {
		  /* transform: scale(1.03);
		  box-shadow: 0 4px 8px rgba(0,0,0,0.1); */
		  
		  transform: scale(1.01); /* 마우스 올리면 커지는 정도 */
		  /* box-shadow: 0 3px 6px rgba(0,0,0,0.07);  */
		}
		.vote-icon-container {
		 /*  height: 35%; */
		 	height: 100px;
		  display: flex;
		  flex-direction: column;
		  justify-content: center;
		  align-items: center;
		  padding: 5px 0;
		  background-color: #f0f5f1;
		}
		
		.vote-icon {
		  font-size: 36px;
		  color: #b8c9bc;
		}
		
		.days-left {
		  margin-top: 5px;
		  font-size: 14px;
		  color: #84a98c;
		  font-weight: bold;
		}
		
		.vote-content {
		  height: 55%;
		  background-color:#fff;
		  padding: 5px 0;
		  display: flex;
		  flex-direction: column;
		  justify-content: space-between;
		}
		
		.vote-status {
		  font-size: 12px;
		  padding: 2px 5px;
		  border-radius: 3px;
		  color: white;
		  display: inline-block;
		  margin-bottom: 5px;
		}
		
		.vote-status-ongoing {
		  background-color: #84a98c;
		}
		
		.vote-status-completed {
		  background-color: #6c757d;
		}
		
		.vote-card h5 {
		  margin: 5px 0;
		  font-size: 16px;
		  font-weight: bold;
		  color: #333;
		  overflow: hidden;
		}
		.vote-card h5 {
		  margin: 5px 0;
		  font-size: 16px;
		  font-weight: bold;
		  color: #333;
		  overflow: hidden;
		}
		
		.vote-card p {
		  font-size: 14px;
		  color: #555;
		  margin-bottom: 5px;
		  line-height: 1.4;
		  overflow: hidden;
		}
		
		.vote-card small {
		  font-size: 12px;
		  color: #777;
		}
    .btn {
      background-color: #84a98c;
      color: white;
      border: none;
      border-radius: 0px;
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
    
    .cardList {
    	background-color: #fff;
    	color: #333;
    	border: 1px solid #dbdbdb;
    }
    .cardList:hover {
    	background-color: #d7d7d7;
    	color: #333;
    	border: 1px solid #dbdbdb;
    }
    
    .search-bar {
      display: flex;
      align-items: center;
    }
    select {
      background-color: white;
      border: 1px solid #dbdbdb;
      padding: 8px;
      font-size: 14px;
    }
    .vote-list-item {
      border: 1px solid #ddd;
      padding: 15px;
      margin-bottom: 15px;
      /* transition: background-color 0.3s ease; */
		  transition: transform 0.3s ease, box-shadow 0.3s ease;
		  cursor: pointer;
		  overflow: hidden;
      cursor: pointer;
      border-radius: 8px;
    }
    .vote-list-item:hover {
      background-color: #f8f9fa; 
		  transform: scale(1.01); /* 마우스 올리면 커지는 정도 */
		  box-shadow: 0 2px 4px rgba(0,0,0,0.05); 
    }
    
    .hidden {
      display: none;
    }

  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <div class="voteContainer mt-0">
    <div class="header">
	    <a href="${ctp}/home" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	    <font size="5" class="mb-4 h2">가족 투표</font>
	  </div>
    
    <div class="d-flex justify-content-between mb-3">
      <div class="search-bar">
        <select name="choice" id="choice" onchange="photoSearch()">
				  <option value="전체" ${choice == '전체' ? 'selected' : ''}>전체</option>
				  <option value="ACTIVE" ${choice == 'ACTIVE' ? 'selected' : ''}>진행 중</option>
				  <option value="CLOSED" ${choice == 'CLOSED' ? 'selected' : ''}>종료</option>
				  <option value="미참여" ${choice == '미참여' ? 'selected' : ''}>미참여</option>
				</select>
      </div>    
      <div>
        <button class="btn cardList" id="cardViewBtn">카드</button>
        <button class="btn cardList" id="listViewBtn">목록</button>
        <a href="voteInput" class="btn btn-write">투표 올리기</a> 
      </div>
    </div>
    
    <div id="cardView">
		  <div class="row">
		    <c:forEach var="vo" items="${vos}" varStatus="st">
		      <div class="col-md-4 mb-4">
					  <div class="vote-card ${vo.status == 'ACTIVE' ? 'active-vote' : ''}" onclick="location.href='voteContent?idx=${vo.idx}'">
				      <div>
					      <span class="vote-status ${vo.status == 'ACTIVE' ? 'vote-status-ongoing' : 'vote-status-completed'}">
					        ${vo.status == 'ACTIVE' ? '투표중' : '투표종료'}
					      </span>				      
				      </div>
					    <div class="vote-icon-container">
					      <i class="fas fa-vote-yea vote-icon"></i>
					      <c:if test="${vo.status == 'ACTIVE' && vo.daysLeft != 0}">
					        <span class="days-left">${vo.daysLeft}일 전</span>
					      </c:if>
					    </div>
					    <div class="vote-content">
					      <h5>${vo.title}</h5>
					      <p>${fn:substring(vo.description, 0, 30)}${fn:length(vo.description) > 30 ? '...' : ''}</p>
					      <small>${vo.name} | ${vo.endTime != null ? fn:substring(vo.endTime,0,10) : '종료일 없음'}</small>
					    </div>
					  </div>
					</div>
		    </c:forEach>
		  </div>
		</div>
    
    <div id="listView" class="hidden">
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <div class="vote-list-item" onclick="location.href='voteContent?idx=${vo.idx}'">
          <div class="d-flex justify-content-between align-items-center">
            <h5 class="mb-1">${vo.title}</h5>
            <span class="vote-status ${vo.status == 'ACTIVE' ? 'vote-status-ongoing' : 'vote-status-completed'}">
              ${vo.status == 'ACTIVE' ? '투표중' : '투표종료'}
            </span>
          </div>
          <p class="mb-1">${fn:substring(vo.description, 0, 100)}${fn:length(vo.description) > 100 ? '...' : ''}</p>
          <small>${vo.name} | ${vo.endTime != null ? fn:substring(vo.endTime,0,10) : '종료일 미정'}</small>
        </div>
      </c:forEach>
    </div>
    
    <!-- 블록페이지 시작 -->
    <div class="d-flex justify-content-center my-4">
      <ul class="pagination justify-content-center">
        <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="voteList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
        <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="voteList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
        <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
          <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="voteList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
          <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="voteList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        </c:forEach>
        <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="voteList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
        <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="voteList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
      </ul>
    </div>
    <!-- 블록페이지 끝 -->
     
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function photoSearch() {
    let choice = document.getElementById("choice").value;
    location.href = "voteList?choice=" + choice;
  }

  document.getElementById('cardViewBtn').addEventListener('click', function() {
    document.getElementById('cardView').classList.remove('hidden');
    document.getElementById('listView').classList.add('hidden');
  });

  document.getElementById('listViewBtn').addEventListener('click', function() {
    document.getElementById('listView').classList.remove('hidden');
    document.getElementById('cardView').classList.add('hidden');
  });
</script>
</body>
</html>