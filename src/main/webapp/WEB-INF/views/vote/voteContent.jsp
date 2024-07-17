<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${vo.title} | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: 'Pretendard' !important;
      background-color: #ffffff;
      color: #333333;
    }
    .header {margin-bottom: 30px;}
	  .home-icon { 
	    font-size: 24px; 
	    color: #cecece; 
	  }
	  .home-icon:hover {color: #c6c6c6;}
    .voteContainer {
      max-width: 900px;
      margin: 40px auto;
      background-color: #fff;
      padding: 40px;
    }
    
    .swal2-confirm {
      background-color: white !important;
      color: black !important;
      border-radius: 0px !important;
      box-shadow: none !important;
      font-weight: bold !important;
      font-size: 18px !important;
      margin: 0 !important;
      
    }
    .swal2-cancel {
      background-color: white !important;
      color: black !important;
      border-radius: 0px !important;
      box-shadow: none !important;
      font-size: 18px !important;
      margin: 0 !important;
    }
    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
    }
    .swal2-confirm:hover {
      background-color: none !important;
    }
    
    
    h2 {
      font-family: 'Pretendard' !important; 
      color: #333;
      font-size: 24px;
      font-weight: 700 !important;
      text-align: center;
      margin-bottom: 40px;
    }
    
    .vote-info {
      margin-bottom: 20px;
      border-bottom: 1px solid #e4e6eb;
      padding: 20px 0;
    }
    
    .vote-info h3 {
      font-size: 18px;
      font-weight: 700;
      margin-bottom: 10px;
    }
    
    .vote-meta {
      font-size: 14px;
      color: #666;
    }
    
    .vote-options {
	    margin-top: 30px;
	  }
	  
	  .vote-option {
	    margin-bottom: 15px;
	  }
	  
	  .vote-option input[type="radio"],
	  .vote-option input[type="checkbox"] {
	    display: none;
	  }
	  
	  .vote-option label {
	    display: block;
	    background-color: #f0f0f0;
	    border: 2px solid #e0e0e0;
	    border-radius: 8px;
	    padding: 15px 20px;
	    cursor: pointer;
	    transition: all 0.3s ease;
	  }
	  
	  .vote-option input[type="radio"]:checked + label,
	  .vote-option input[type="checkbox"]:checked + label {
	    background-color: #a7c4ad;
	    border-color: #84a98c;
	    color: #ffffff;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	  }
	  
	  .vote-option label:hover {
	    background-color: #e8e8e8;
	  }
	  
	  .btn-vote {
	    background-color: #84a98c;
	    color: #ffffff;
	    border: none;
	    padding: 12px 25px;
	    font-weight: 600;
	    margin-top: 25px;
	    border-radius: 8px;
	    transition: background-color 0.3s ease;
	  }
	  
	  .btn-vote:hover {
	    background-color: #6b8e72;
	  }
	  
	  .btn-vote:disabled {
	    background-color: #cccccc;
	    cursor: not-allowed;
	  }
	  
	  .vote-info {
	    background-color: #f9f9f9;
	    border-radius: 8px;
	    padding: 20px;
	    margin-bottom: 30px;
	  }
	  
	  .vote-content {
	    background-color: #ffffff;
	    border: 1px solid #e4e6eb;
	    border-radius: 8px;
	    padding: 25px;
	    margin-bottom: 30px;
	  }
    .btn-list {
      display: block;
      width: 100px;
      margin: 40px auto 0;
      padding: 10px;
      text-align: center;
      background-color: #fff;
      color: #333;
      border: 1px solid #ccc;
      text-decoration: none;
    }

    .btn-list:hover {
      background-color: #f8f8f8;
    }
    .action-buttons {
	    margin-top: 15px;
	    display: flex;
	    gap: 10px;
	  }
	
	  .btn-action {
	    padding: 8px 15px;
	    border-radius: 6px;
	    font-weight: 600;
	    text-decoration: none;
	    transition: all 0.3s ease;
	  }
	
	  .btn-edit {
	    background-color: #e0e0e0;
	    color: #333;
	    border: 1px solid #ccc;
	  }
	
	  .btn-edit:hover {
	    background-color: #d0d0d0;
	  }
	
	  .btn-delete {
	    background-color: #ff6b6b;
	    color: white;
	    border: 1px solid #ff5252;
	  }
	
	  .btn-delete:hover {
	    background-color: #ff5252;
	  }
	
	  .btn-end-vote {
	    background-color: #4a69bd;
	    color: white;
	    border: 1px solid #3c55a5;
	    font-weight: 700;
	    padding: 10px 18px;
	  }
	
	  .btn-end-vote:hover {
	    background-color: #3c55a5;
	  }
    

 		.vote-meta {
      font-size: 14px;
      color: #666;
      margin-bottom: 10px;
    }
    
    .vote-status {
      font-weight: bold;
      color: #ff6b6b;
    }
    
    .vote-option {
      position: relative;
      margin-bottom: 15px;
    }
    
    .vote-bar {
      height: 30px;
      background-color: #e0e0e0;
      border-radius: 15px;
      overflow: hidden;
    }
    
    .vote-progress {
      height: 100%;
      background-color: #84a98c;
    }
    
    .vote-text {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #333;
    }
    
    .vote-percent {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #333;
    }
    
    .voter-info {
      margin-top: 5px;
      font-size: 12px;
    }
    
    .voter-photo {
      width: 20px;
      height: 20px;
      border-radius: 50%;
      margin-right: 5px;
    }
    
    .non-voters {
      margin-top: 20px;
    }
    
    #chart_div {
      width: 100%;
      height: 400px;
      margin-top: 20px;
    }
  </style>
  <script>
    
  	'use strict';
    
    // 커스텀 알럿
    function showAlert(message, callback) {
  	  Swal.fire({
  	    html: message,
  	    confirmButtonText: '확인',
  	    customClass: {
  	      confirmButton: 'swal2-confirm',
  	      popup: 'custom-swal-popup',
  	      htmlContainer: 'custom-swal-text'
  	    },
  	    scrollbarPadding: false,
  	    allowOutsideClick: false,
  	    heightAuto: false,
  	    didOpen: () => {
  	      document.body.style.paddingRight = '0px';
  	    }
  	  }).then((result) => {
  	    if (result.isConfirmed && callback) {
  	      callback();
  	    }
  	  });
  	}
    
    function showConfirm(message, confirmCallback, cancelCallback) {
  	  Swal.fire({
  	    html: message,
  	    showCancelButton: true,
  	    cancelButtonText: '취소',
  	    confirmButtonText: '확인',
  	    customClass: {
  	      cancelButton: 'swal2-cancel',
  	      confirmButton: 'swal2-confirm',
  	      popup: 'custom-swal-popup',
  	      htmlContainer: 'custom-swal-text'
  	    },
  	    scrollbarPadding: false,
  	    allowOutsideClick: false,
  	    heightAuto: false,
  	    didOpen: () => {
  	      document.body.style.paddingRight = '0px';
  	    }
  	  }).then((result) => {
  	    if (result.isConfirmed && confirmCallback) {
  	      confirmCallback();
  	    } else if (result.isDismissed && cancelCallback) {
  	      cancelCallback();
  	    }
  	  });
  	}
    
    
    function fCheck() {
  	  let selectedOptions = document.querySelectorAll('input[name="voteOption"]:checked');
  	  if (selectedOptions.length === 0) {
  	    showAlert("투표 옵션을 선택해주세요.");
  	    return false;
  	  }
  	  
  	  let formData = new FormData();
  	  formData.append('voteIdx', ${vo.idx});
  	  selectedOptions.forEach(option => {
  	    formData.append('optionIdx[]', option.value);
  	  });

  	  $.ajax({
  	    url: "${ctp}/vote/doVote",
  	    type: "post",
  	    data: formData,
  	    processData: false,
  	    contentType: false,
  	    success: function(res) {
  	      if(res != "0") {
  	        showAlert("투표가 완료되었습니다", function() {
  	          location.reload();
  	        });
  	      }
  	      else showAlert("투표에 실패했습니다.");
  	    },
  	    error: function() {
  	      showAlert("전송 오류!");
  	    }
  	  });
  	}
    
 		// JSP에서 JavaScript 변수 설정
    var isEnded = ${isEnded};
    
    // Google Charts 로드
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    
    // 페이지 로드 완료 시 실행할 함수 설정
    google.charts.setOnLoadCallback(function() {
      if (isEnded) {
        drawChart();
      }
    });

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Option', 'Votes'],
        <c:forEach var="option" items="${voteOptions}">
          ['${option.optionText}', ${option.voteCount}],
        </c:forEach>
      ]);

      var options = {
        title: '투표 결과',
        pieHole: 0.4,
      };

      var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<div class="voteContainer">
  <div class="header">
    <a href="${ctp}/vote/voteList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
    <font size="5" class="mb-4 h2">투표하기</font>
  </div>
  
  <div class="vote-info">
	  <h3>${vo.title}</h3>
	  <div class="vote-meta">
	    <span>작성자: ${vo.name}</span> | 
	    <span>작성일: ${vo.createdAt}</span><br>
	    <span>마감일: ${vo.endTime}</span>
	    <c:choose>
	      <c:when test="${vo.status == 'CLOSED'}">
	        <span class="vote-status"> (종료됨)</span>
	      </c:when>
	      <c:when test="${vo.daysLeft > 1}">
	        <span> (${vo.daysLeft}일 남음)</span>
	      </c:when>
	      <c:when test="${vo.daysLeft == 1}">
	        <span> (내일 마감)</span>
	      </c:when>
	      <c:when test="${vo.daysLeft == 0}">
	        <span> (오늘 마감)</span>
	      </c:when>
	      <c:otherwise>
	        <span> (${-vo.daysLeft}시간 ${-vo.minutesLeft}분 남음)</span>
	      </c:otherwise>
	    </c:choose>
	    <c:if test="${vo.multipleChoice}">
	      <span> | 복수 선택 가능</span>
	    </c:if>
	  </div>
	  <c:if test="${vo.memberIdx == sIdx && !hasVoted}">
	    <div class="action-buttons">
	      <a href="javascript:voteUpdate(${vo.idx})" class="btn btn-sm btn-edit">수정</a>
	      <a href="javascript:voteDelete(${vo.idx})" class="btn btn-sm btn-edit">삭제</a>
	    </div>
	  </c:if>
	</div>
  
  <div class="vote-content">
    ${fn:replace(vo.description, newLine, "<br/>")}
  </div>
  
  <c:choose>
    <c:when test="${vo.status == 'CLOSED' || isEnded}">
      <h3>투표 결과</h3>
      <div id="chart_div"></div>
      <c:forEach var="option" items="${voteOptions}">
        <div class="vote-option">
          <div class="vote-bar">
            <div class="vote-progress" style="width: ${option.votePercent}%;"></div>
          </div>
          <span class="vote-text">${option.optionText}</span>
          <span class="vote-percent">${option.votePercent}% (${option.voteCount}표)</span>
        </div>
        <c:if test="${!vo.anonymous}">
          <div class="voter-info">
            <c:forEach var="voter" items="${option.voters}">
              <img src="${voter.photo}" alt="${voter.name}" class="voter-photo">
              <span>${voter.name}</span>
            </c:forEach>
          </div>
        </c:if>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <div class="vote-options">
        <form onsubmit="return submitVote();">
          <c:forEach var="option" items="${voteOptions}">
            <div class="vote-option">
              <input type="${vo.multipleChoice ? 'checkbox' : 'radio'}" name="voteOption" id="option${option.idx}" value="${option.idx}" ${hasVoted || vo.status == 'CLOSED' ? 'disabled' : ''}>
              <label for="option${option.idx}">
                ${option.optionText}
                <c:if test="${!vo.anonymous && option.voteCount > 0}">
                  <span>(${option.voteCount}명)</span>
                </c:if>
              </label>
            </div>
          </c:forEach>
          <div class="text-center">
            <button type="button" onclick="fCheck()" class="btn-vote mr-3" ${hasVoted || vo.status == 'CLOSED' ? 'disabled' : ''}>
              ${hasVoted ? '이미 투표하셨습니다' : '투표하기'}
            </button>
            <c:if test="${vo.memberIdx == sIdx && !hasVoted}">
              <input type="button" value="투표 종료" class="btn-vote" onclick="voteEnd()" />
            </c:if>
          </div>
        </form>
      </div>
    </c:otherwise>
  </c:choose>
  
  <div class="non-voters">
    <h4>미참여 가족</h4>
    <c:forEach var="nonVoter" items="${nonVoters}">
      <img src="${nonVoter.photo}" alt="${nonVoter.name}" class="voter-photo">
      <span>${nonVoter.name}</span>
    </c:forEach>
  </div>
  
  <a href="${ctp}/vote/voteList" class="btn-list">목록으로</a>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>