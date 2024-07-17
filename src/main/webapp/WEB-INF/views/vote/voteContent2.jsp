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
    
    .vote-content {
      padding: 20px 0;
      line-height: 1.6;
      min-height: 200px;
    }
    
    .vote-options {
      margin-top: 20px;
    }
    
    .vote-option {
      margin-bottom: 10px;
    }
    
    .btn-vote {
      background-color: #84a98c;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      font-weight: 600;
      margin-top: 20px;
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
    
    #chart_div {
      width: 100%;
      height: 400px;
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
    
    
    function submitVote() {
      // 투표 제출 로직 구현
      let selectedOptions = document.querySelectorAll('input[name="voteOption"]:checked');
      if (selectedOptions.length === 0) {
        showAlert("투표 옵션을 선택해주세요.");
        return false;
      }
      
      $.ajax({
  	    url: "${ctp}/vote/doVote",
  	    type: "post",
  	    data: selectedOptions,
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
    
    <c:if test="${isEnded}">
	    google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(drawChart);
	
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
    </c:if>
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<div class="voteContainer">
  <h2>투표하기</h2>
  
  <div class="vote-info">
    <h3>${vo.title}</h3>
    <div class="vote-meta">
      <span>${vo.name}</span> | 
      <span>
        <fmt:parseDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" type="both" />
        <fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd HH:mm"/>
      </span> | 
      <span>마감 
			  <fmt:parseDate value="${vo.endTime}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedEndTime" type="both" />
			  <fmt:formatDate value="${parsedEndTime}" pattern="yyyy.MM.dd HH:mm"/>
			</span>
      <c:if test="${vo.daysLeft >= 0}">
        <span> (${vo.daysLeft}일 남음)</span>
      </c:if>
      <c:if test="${vo.status == 'CLOSED'}">
        <span> (종료됨)</span>
      </c:if>
      
      <c:if test="${vo.memberIdx == sIdx}">
      	<div class="action-buttons">
		      <a href="voteUpdate?idx=${vo.idx}" class="btn btn-sm btn-edit">수정</a>
		      <a href="javascript:voteDelete()" class="btn btn-sm btn-edit">삭제</a>
		      <a href="javascript:voteEnd()" class="btn btn-sm btn-edit">투표 종료</a>
		    </div>
      </c:if>
      
    </div>
  </div>
  
  <div class="vote-content">
    ${fn:replace(vo.description, newLine, "<br/>")}
  </div>
  
  <c:choose>
    <c:when test="${isEnded}">
      <h3>투표 결과</h3>
      <div id="chart_div"></div>
    </c:when>
    <c:otherwise>
      <div class="vote-options">
        <form onsubmit="return submitVote();">
          <c:forEach var="option" items="${voteOptions}">
            <div class="vote-option">
              <input type="${vo.multipleChoice ? 'checkbox' : 'radio'}" name="voteOption" id="option${option.idx}" value="${option.idx}">
              <label for="option${option.idx}">${option.optionText}</label>
            </div>
          </c:forEach>
          <button type="submit" class="btn-vote" ${hasVoted ? 'disabled' : ''}>
            ${hasVoted ? '이미 투표하셨습니다' : '투표하기'}
          </button>
        </form>
      </div>
    </c:otherwise>
  </c:choose>
  
  <a href="${ctp}/vote/voteList" class="btn-list">목록</a>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>