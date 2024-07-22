<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>가사 분담 목록 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: 'Pretendard' !important;
      background-color: #ffffff;
    }
    .workContainer {
      max-width: 1000px;
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
    h3 {
      font-family: 'Pretendard' !important;
      color: #333;
      margin-bottom: 30px;
      font-weight: 700;
    }
    .work-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
      width: 230px;
      height: 300px;
      display: flex;
      flex-direction: column;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      box-sizing: border-box;
      background-color: #fff; 
    }
    .work-card:hover {
      transform: scale(1.02);
      box-shadow: 0 3px 6px rgba(0,0,0,0.07); 
    }
    .work-icon-container {
      height: 35%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 5px 0;
      background-color: #f0f5f1;
    }
    .work-icon {
      font-size: 36px;
      color: #b8c9bc;
    }
    .days-left {
      margin-top: 5px;
      font-size: 14px;
      color: #84a98c;
      font-weight: bold;
    }
    .work-content {
      height: 55%;
      background-color:#fff;
      padding: 5px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .work-status {
      font-size: 12px;
      padding: 2px 5px;
      border-radius: 3px;
      color: white;
      display: inline-block;
      margin-bottom: 5px;
    }
    .work-status-ongoing {
      background-color: #84a98c;
    }
    .work-status-completed {
      background-color: #6c757d;
    }
    .work-card h5 {
      margin: 5px 0;
      font-size: 16px;
      font-weight: bold;
      color: #333;
      overflow: hidden;
    }
    .work-card p {
      font-size: 14px;
      color: #555;
      margin-bottom: 5px;
      line-height: 1.4;
      overflow: hidden;
    }
    .work-card small {
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
    .work-list-item {
      border: 1px solid #ddd;
      padding: 15px;
      margin-bottom: 15px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      overflow: hidden;
      cursor: pointer;
      border-radius: 8px;
    }
    .work-list-item:hover {
      background-color: #f8f9fa; 
      transform: scale(1.01);
      box-shadow: 0 2px 4px rgba(0,0,0,0.05); 
    }
    .hidden {
      display: none;
    }
     .progress-section {
      margin-bottom: 30px;
    }
    .progress {
      height: 25px;
    }
    .progress-bar {
      line-height: 25px;
    }
    .member-progress {
      margin-bottom: 15px;
    }
     .btn-primary {
      background-color: #84a98c;
      border: none;
    }
    .btn-primary:hover {
      background-color: #6b8e76;
    }
    .progress {
      height: 10px;
      border-radius: 5px;
    }
    .progress-bar {
      background-color: #84a98c;
    }
    .task-card {
      height: 100%;
    }
    .task-icon {
      font-size: 2rem;
      color: #84a98c;
    }
    .task-status {
      font-size: 0.8rem;
      padding: 3px 8px;
      border-radius: 20px;
    }
    .task-status-ongoing {
      background-color: #ffd166;
      color: #333;
    }
    .task-status-completed {
      background-color: #06d6a0;
      color: white;
    }
    .filters {
      background-color: white;
      padding: 15px;
      border-radius: 10px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <div class="workContainer">
    <div style="display: flex; align-items: center; gap: 20px;" class="mb-5"> 
      <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>
      <h2>가사 분담</h2>
    </div>

    <!-- 가족 구성원별 진행률 섹션 -->
		<div class="progress-section">
		  <h3>가족 구성원별 진행률</h3>
		  <c:forEach var="member" items="${familyMembers}">
		    <div class="member-progress">
		      <p>${member.memberName}</p>
		      <div class="progress">
		        <div class="progress-bar" role="progressbar" style="width: ${member.progressPercentage}%;" 
		             aria-valuenow="${member.progressPercentage}" aria-valuemin="0" aria-valuemax="100">
		          ${member.progressPercentage}%
		        </div>
		      </div>
		    </div>
		  </c:forEach>
		</div>
		
		<!-- 카드 뷰 -->
		<div id="cardView">
		  <div class="row">
		    <c:forEach var="workInfo" items="${vos}" varStatus="st">
		      <div class="col-md-3 mb-4">
		        <div class="work-card ${workInfo.status != 'COMPLETED' ? 'active-work' : ''}" onclick="location.href='workContent?idx=${workInfo.work.idx}'">
		          <div>
		            <span class="work-status ${workInfo.status != 'COMPLETED' ? 'work-status-ongoing' : 'work-status-completed'}">
		              ${workInfo.status != 'COMPLETED' ? '진행중' : '완료'}
		            </span>        
		          </div>
		          <div class="work-icon-container">
		            <i class="fas fa-broom work-icon"></i>
		            <c:if test="${workInfo.status != 'COMPLETED' && workInfo.daysLeft != 0}">
		              <span class="days-left">${workInfo.daysLeft}일 전</span>
		            </c:if>
		          </div>
		          <div class="work-content">
		            <h5>${workInfo.work.category} - ${workInfo.work.task}</h5>
		            <p>${fn:substring(workInfo.work.description, 0, 30)}${fn:length(workInfo.work.description) > 30 ? '...' : ''}</p>
		            <small>${workInfo.memberName} | ${workInfo.work.endDate != null ? fn:substring(workInfo.work.endDate,0,10) : '마감일 없음'}</small>
		          </div>
		        </div>
		      </div>
		    </c:forEach>
		  </div>
		</div>
		
		<!-- 리스트 뷰 -->
		<div id="listView" class="hidden">
		  <c:forEach var="workInfo" items="${vos}" varStatus="st">
		    <div class="work-list-item" onclick="location.href='workContent?idx=${workInfo.work.idx}'">
		      <div class="d-flex justify-content-between align-items-center">
		        <h5 class="mb-1">${workInfo.work.category} - ${workInfo.work.task}</h5>
		        <span class="work-status ${workInfo.status != 'COMPLETED' ? 'work-status-ongoing' : 'work-status-completed'}">
		          ${workInfo.status != 'COMPLETED' ? '진행중' : '완료'}
		        </span>
		      </div>
		      <p class="mb-1">${fn:substring(workInfo.work.description, 0, 100)}${fn:length(workInfo.work.description) > 100 ? '...' : ''}</p>
		      <small>${workInfo.memberName} | ${workInfo.work.endDate != null ? fn:substring(workInfo.work.endDate,0,10) : '마감일 없음'}</small>
		    </div>
		  </c:forEach>
		</div>
    
    
    <!-- 블록페이지 시작 -->
    <div class="d-flex justify-content-center my-4">
      <ul class="pagination justify-content-center">
        <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="workList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
        <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="workList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
        <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
          <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="workList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
          <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="workList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        </c:forEach>
        <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="workList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
        <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="workList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
      </ul>
    </div>
    <!-- 블록페이지 끝 -->
    
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
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