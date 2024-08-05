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
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>${vo.title} | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
    
    .swal2-confirm, .swal2-cancel {
      background-color: white !important;
      color: black !important;
      border-radius: 0px !important;
      box-shadow: none !important;
      font-size: 18px !important;
      margin: 0 !important;
    }
    .swal2-confirm {
      font-weight: bold !important;
    }
    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
    }
    
    h2, h3 {
      font-family: 'Pretendard' !important;
      color: #333;
      font-weight: 700 !important;
    }
    h2 {
      font-size: 24px;
      text-align: center;
      margin-bottom: 40px;
    }
    h4 {
      font-family: 'Pretendard' !important;
      font-weight: 600 !important;    
    }
    .vote-info {
      margin-bottom: 20px;
      border-bottom: 1px solid #e4e6eb;
      padding: 20px 0;
    }
    
    .vote-meta {
      font-size: 14px;
      color: #666;
      margin-bottom: 10px;
    }
    
    .vote-options {
      margin-top: 30px;
    }
    
    .vote-option {
      position: relative;
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
      text-decoration: none;
      color: #333;
    }
    .action-buttons {
      margin-top: 15px;
      display: flex;
      gap: 10px;
      justify-content: flex-end;
    }
  
    .btn-action {
      padding: 8px 15px;
      border-radius: 6px;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.3s ease;
    }
  
    .btn-edit, .btn-delete {
      background-color: #e0e0e0;
      color: #333;
      border: 1px solid #ccc;
    }
  
    .btn-edit:hover, .btn-delete:hover {
      background-color: #d0d0d0;
    }
    .btn-end-vote {
      background-color: #84a98c;
      color: #ffffff;
      border: none;
      padding: 12px 25px;
      font-weight: 600;
      margin-top: 25px;
      border-radius: 8px;
      transition: background-color 0.3s ease;
    }
  
    .btn-end-vote:hover {
      background-color: #3c55a5;
    }
    
    .vote-status {
      font-weight: bold;
      color: #ff6b6b;
    }
    
    .vote-bar {
      height: 30px;
      background-color: #e0e0e0;
      border-radius: 15px;
      overflow: hidden;
    }
    
    .vote-progress {
      height: 100%;
      background-color: #a7c4ad;
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
    
    #chart_div {
      width: 100%;
      height: 400px;
      margin-top: 20px;
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
      object-fit: cover;
    }
    
    .participants-section {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
    }
    
    .non-voters, .participants {
      width: 48%;
    }
    
    .vote-comment-divider {
      border-top: 1px solid #e4e6eb;
      margin: 30px 0;
    }
    
    .vote-info {
      background-color: #fff;
      border-radius: 10px;
      padding: 25px;
      margin-bottom: 30px;
    }
    
    .vote-title {
      font-size: 28px;
      color: #333;
      margin-bottom: 20px;
      border-bottom: 2px solid #84a98c;
      padding-bottom: 10px;
    }
    
    .vote-meta-container {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }
    
    .vote-meta-left, .vote-meta-right {
      flex: 1;
    }
    
    .vote-meta-left p, .vote-meta-right p {
      margin-bottom: 10px;
      color: #555;
    }
    
    .vote-meta-left i, .vote-meta-right i {
      width: 20px;
      color: #84a98c;
      margin-right: 5px;
    }
    
    .vote-status {
      font-weight: bold;
      padding: 5px 10px;
      border-radius: 15px;
    }
    
    .vote-status.active {
      background-color: #d4edda;
      color: #155724;
    }
    
    .vote-status.ended {
      background-color: #f8d7da;
      color: #721c24;
    }
    
    .vote-type {
      background-color: #e2e3e5;
      color: #383d41;
      padding: 5px 10px;
      border-radius: 15px;
      display: inline-block;
      margin-right: 10px;
    }
    
    .vote-type.anonymous {
      background-color: #fff3cd;
      color: #856404;
    }
    
    .vote-actions {
      margin-top: 5px;
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }
    
    .btn {
      padding: 8px 15px;
      border-radius: 5px;
      font-weight: 600;
      transition: all 0.3s ease;
    }
    
    .btn-end-vote, .btn-edit, .btn-delete {
      background-color: #84a98c;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      font-weight: 600;
      margin-top: 25px;
      border-radius: 8px;
    }
    .btn-edit {
      background-color: #ffc107;
      color: #212529;
    }
    .btn-edit:hover {
      background-color: #ffc107;
      color: #212529;
    }
    
    .btn-delete {
      background-color: #dc3545;
      color: white;
    }
    .btn-delete:hover {
      background-color: #dc3545;
      color: white;
    }
    .btn-end-vote:hover {
      background-color: #6b8e72;
      color: white;
    }
    
    #voteResultContainer {
      margin-top: 20px;
    }
    
    .vote-options {
      margin-top: 20px;
    }
    
    .vote-option {
      margin-bottom: 15px;
    }
    
    .vote-bar {
      height: 30px;
      background-color: #e0e0e0;
      border-radius: 15px;
      overflow: hidden;
      position: relative;
    }
    
    .vote-progress {
      height: 100%;
      background-color: #84a98c;
    }
    
    .vote-text, .vote-percent {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      padding: 0 10px;
    }
    
    .vote-text {
      left: 10px;
      color: #333;
    }
    
    .vote-percent {
      right: 10px;
      color: #333;
    }
    
    .voter-info {
      margin-top: 5px;
      margin-left: 10px;
    }
    
    .voter-photo {
      width: 20px;
      height: 20px;
      border-radius: 50%;
      margin-right: 5px;
      object-fit: cover;
    }

    /* 댓글 섹션 스타일 수정 */
    .comment-section {
		  margin-top: 40px;
		  border-top: 1px solid #e0e0e0;
		  padding-top: 30px;
		}
		
		.comment-section h4 {
		  font-size: 18px;
		  color: #333;
		  margin-bottom: 20px;
		}
		
		.comment-input-container {
		  margin-bottom: 30px;
		}
		
		.comment-input {
		  width: 100%;
		  padding: 15px;
		  border: 1px solid #e0e0e0;
		  border-radius: 4px;
		  font-size: 14px; 
		  resize: vertical;
		  min-height: 100px;
		}
		
		.comment-input:focus {
		  outline: none;
		  border-color: #84a98c;
		}
		
		.btn-comment {
		  background-color: #84a98c;
		  color: #fff;
		  border: none;
		  padding: 8px 16px;
		  border-radius: 4px;
		  font-size: 14px;
		  font-weight: 500;
		  margin-top: 10px;
		  transition: background-color 0.2s ease;
		}
		
		.btn-comment:hover {
		  background-color: #6b8e72;
		}
		
		.comment {
		  padding: 20px 0;
		}
		
		.comment:not(.reply) {
		  border-bottom: 1px solid #e0e0e0;
		}
		
		.comment-author {
		  font-weight: 600;
		  color: #333;
		  margin-right: 10px;
		}
		
		.comment-content {
		  margin: 10px 0;
		  line-height: 1.6;
		  color: #333;
		}
		
		.comment-meta {
		  font-size: 12px;
		  color: #999;
		  margin-top: 5px;
		}
		
		.comment-time {
		  margin-right: 10px;
		}
		
		.reply-btn, .delete-btn {
		  cursor: pointer;
		  color: #84a98c;
		  margin-left: 10px;
		  font-size: 12px;
		  transition: color 0.2s ease;
		}
		
		.reply-btn:hover, .delete-btn:hover {
		  color: #6b8e72;
		}
		
		.comment.reply {
		  margin-left: 30px;
		  position: relative;
		  padding-left: 20px;
		  border-bottom: none;
		}
		
		.comment.reply::before {
		  content: '└';
		  position: absolute;
		  left: 0;
		  top: 20px;
		  color: #84a98c;
		}
		
		.reply-form {
		  margin-top: 15px;
		  margin-left: 30px;
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

    function voteEnd() {
      showConfirm("정말로 투표를 종료하시겠습니까?", function() {
        $.ajax({
          url: "${ctp}/vote/endVote",
          type: "post",
          data: {voteIdx: ${vo.idx}},
          success: function(res) {
            if(res != 0) {
              showAlert("투표가 종료되었습니다.", function() {
                location.reload();
              });
            }
            else {
              showAlert("투표 종료에 실패했습니다.");
            }
          },
          error: function() {
            showAlert("서버 오류가 발생했습니다.");
          }
        });
      });
    }
    
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var rawData = [
        <c:forEach var="option" items="${voteOptions}">
          ['${option.optionText}', ${option.voteCount}],
        </c:forEach>
      ];
      
      // 총 투표 수 계산
      // var totalVotes = rawData.reduce((sum, option) => sum + option[1], 0);
      
      // 투표 수가 0인 경우 처리
     /*  if (totalVotes === 0) {
		    chartContainer.innerHTML = '<p class="text-center my-4">투표에 참여한 사람이 없습니다.</p>';
		    return;
		  } */
      
      // 투표 수에 따라 데이터 정렬 (내림차순)
      rawData.sort((a, b) => b[1] - a[1]);
      
      var chartData = [['Option', 'Votes']];
      for (var i = 0; i < rawData.length; i++) {
        chartData.push(rawData[i]);
      }
      var data = google.visualization.arrayToDataTable(chartData);

			/* var colors = ['#84a98c', '#a7c4ad', '#cad2c5', '#52796f', '#354f52']; */
			var colors = ['#84a98c', '#a7c4ad', '#cad2c5', '#52796f', '#354f52', '#6b9080', '#8fb3a5', '#c2d3c9', '#446a5d', '#2f3e46'];
     
			var options = {
        title: '',
        pieHole: 0.4,
        colors: colors.slice(0, rawData.length) // 데이터 개수만큼 색상 사용
      };

      var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    }

    // 페이지 로드 완료 시 실행할 함수 설정
    google.charts.setOnLoadCallback(function() {
      if (isEnded || '${vo.status}' === 'CLOSED') {
        drawChart();
      }
    });
    
    
    function toggleReplyForm(idx) {
        let replyForm = document.getElementById('replyForm' + idx);
        let replyBtn = document.getElementById('replyBtn' + idx);
        
        if (replyForm.style.display === 'none' || replyForm.style.display === '') {
          replyForm.style.display = 'block';
          replyBtn.innerText = '닫기';
          $(replyForm).slideDown(300);
        } else {
          replyBtn.innerText = '답글 달기';
          $(replyForm).slideUp(300);
        }
      }

      function submitComment(parentIdx) {
    	  let contentElement;
    	  if (parentIdx == 0) {
    	    contentElement = document.getElementById("commentContent");
    	  } else {
    	    contentElement = document.getElementById("replyContent" + parentIdx);
    	  }
    	  
    	  if (!contentElement) {
    	    showAlert("댓글 입력 필드를 찾을 수 없습니다.");
    	    return false;
    	  }
    	  
    	  let content = contentElement.value.trim();
    	  
    	  if(content == "") {
    	    showAlert("댓글을 입력하세요");
    	    return false;
    	  }
    	  
    	  let query = {
    	    voteIdx: ${vo.idx},
    	    memberIdx: ${sIdx},
    	    content: content,
    	    parentIdx: parentIdx == 0 ? null : parentIdx
    	  }
    	  
    	  $.ajax({
    	    url: "${ctp}/vote/voteReplyInput",
    	    type: "post",
    	    data: query,
    	    success: function(res) {
    	      if(res != "0") {
    	        showAlert("댓글이 입력되었습니다.", function() {
    	          location.reload();
    	        });
    	      }
    	      else showAlert("댓글 입력에 실패했습니다.");
    	    },
    	    error: function() {
    	      showAlert("전송 오류!");
    	    }
    	  });
    	}
      
      function voteDelete(idx) {
	 			showConfirm("정말로 이 투표를 삭제하시겠습니까?", function() {
	 		  	location.href = "voteDelete?idx="+idx;
	 			});
	 		}
 		
      function reVote() {
    	    $.ajax({
    	        url: "${ctp}/vote/reVote",
    	        type: "post",
    	        data: {voteIdx: ${vo.idx}},
    	        success: function(res) {
    	            if(res == "1") {
    	                showAlert("이전 투표가 취소되었습니다. 다시 투표해주세요.", function() {
    	                    location.reload();
    	                });
    	            } else {
    	                showAlert("다시 투표하기에 실패했습니다.");
    	            }
    	        },
    	        error: function() {
    	            showAlert("서버 오류가 발생했습니다.");
    	        }
    	    });
    	}
      
      function deleteComment(idx) {
			 	showConfirm('정말로 이 댓글을 삭제하시겠습니까?', function() {
					$.ajax({
					  url: '${ctp}/vote/replyDelete',
					  type: "POST",
					  data: {idx: idx},
					  success: function(res) {
					    if (res == "1") {
					      showAlert("댓글이 삭제되었습니다.", function() {
                	location.reload();
                });
					    } else {
					      showAlert("댓글 삭제에 실패했습니다.");
					    }
					  },
					  error: function() {
					    showAlert("전송오류!");
					  }
					});
			 	});
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
	  <h2 class="vote-title">${vo.title}</h2>
	  <div class="vote-meta-container">
	    <div class="vote-meta-left">
	      <p><i class="fas fa-user"></i> 작성자: ${vo.name}</p>
	      <p><i class="far fa-calendar-alt"></i> 작성일: ${fn:substring(vo.createdAt, 0, 11)}</p>
	      <c:if test="${!empty vo.endTime}">
		      <c:if test="${fn:substring(vo.createdAt, 0, 10) == fn:substring(vo.endTime, 0, 10)}">
		        <p><i class="fas fa-hourglass-end"></i> 마감일: ${fn:substring(vo.endTime, 0, 16)}</p>
		      </c:if>	        
		      <c:if test="${fn:substring(vo.createdAt, 0, 10) != fn:substring(vo.endTime, 0, 10)}">
		        <p><i class="fas fa-hourglass-end"></i> 마감일: ${fn:substring(vo.endTime, 0, 11)}</p>
		      </c:if>	        
	      </c:if>
	    </div>
	    <div class="vote-meta-right">
      	<c:if test="${!empty statusStr}">
		      <p class="vote-status ${statusStr == '종료됨' ? 'ended' : 'active'}"><i class="fas fa-circle"></i> ${statusStr}</p>
      	</c:if>
      	<c:if test="${empty statusStr}">
		      <p class="vote-status ${statusStr == '종료됨' ? 'ended' : 'active'}"><i class="fas fa-circle"></i> 진행중</p>
      	</c:if>
	      <c:if test="${vo.multipleChoice}">
	        <p class="vote-type"><i class="fas fa-check-double"></i> 복수 선택 가능 </p>
	      </c:if>
	      <c:if test="${vo.anonymous}">
	        <p class="vote-type anonymous"><i class="fas fa-user-secret"></i> 익명 투표 </p>
	      </c:if>
	    </div>
	  </div>
	  <div class="vote-actions">
	    <c:if test="${vo.memberIdx == sIdx}">
	      <button class="btn btn-end-vote" onclick="voteEnd()">투표 종료</button>
		    <c:if test="${vo.memberIdx == sIdx && empty participants}">
		      <a href="${ctp}/vote/voteUpdate?idx=${vo.idx}" class="btn btn-edit"><i class="fas fa-edit"></i> 수정</a>
		    </c:if>
		    <a href="javascript:voteDelete(${vo.idx})" class="btn btn-delete"><i class="fas fa-trash-alt"></i> 삭제</a>
	    </c:if>
	  </div>
	</div>
  
  <div class="vote-content">
    ${fn:replace(vo.description, newLine, "<br/>")}
  </div>
  
  <c:if test="${vo.status != 'CLOSED' && !isEnded}">
    <div class="vote-options">
      <form>
        <c:forEach var="option" items="${voteOptions}">
          <div class="vote-option">
            <input type="${vo.multipleChoice ? 'checkbox' : 'radio'}" name="voteOption" id="option${option.idx}" value="${option.idx}" ${hasVoted ? 'disabled' : ''}>
            <label for="option${option.idx}">
              ${option.optionText}
              <c:if test="${!vo.anonymous && option.voteCount > 0 && hasVoted}">
                <span>(${option.voteCount}명)</span>
              </c:if>
            </label>
            <c:if test="${!vo.anonymous && option.voteCount > 0 && hasVoted}">
              <div class="voter-info mb-2">
                <c:forEach var="voter" items="${option.voters}">
                  <img src="${ctp}/member/${voter.photo}" alt="${voter.name}" class="voter-photo">
                  <span>${voter.name}</span>
                </c:forEach>
              </div>
            </c:if>
          </div>
        </c:forEach>
        
        <div class="text-center">
          <c:if test="${!hasVoted}"><input type="button" onclick="fCheck()" class="btn-vote mr-3" value="투표하기" /></c:if>
          <c:if test="${hasVoted}"><input type="button" onclick="reVote()" class="btn-vote mr-3" value="다시 투표하기" /></c:if>
        </div>
      </form>
    </div>
  </c:if>

  <c:if test="${vo.status == 'CLOSED' || isEnded}">
	  <h3>투표 결과</h3>
	  <div id="voteResultContainer">
	    <c:choose>
	      <c:when test="${empty participants}">
	        <p class="text-center my-4">투표에 참여한 가족이 없습니다.</p>
	      </c:when>
	      <c:otherwise>
	        <div id="chart_div" style="width: 100%; height: 400px;"></div>
	        <div class="vote-options mt-4">
	          <c:forEach var="option" items="${voteOptions}">
	            <div class="vote-option mt-3">
	              <div class="vote-bar">
	                <div class="vote-progress" style="width: ${option.votePercent}%;"></div>
	              </div>
	              <span class="vote-text">${option.optionText}</span>
	              <span class="vote-percent">${option.votePercent}% (${option.voteCount}표)</span>
	            </div>
	            <c:if test="${!vo.anonymous}">
	              <div class="voter-info">
	                <c:forEach var="voter" items="${option.voters}">
	                  <img src="${ctp}/member/${voter.photo}" alt="${voter.name}" class="voter-photo">
	                  <span>${voter.name}</span>
	                </c:forEach>
	              </div>
	            </c:if>
	          </c:forEach>
	        </div>
	      </c:otherwise>
	    </c:choose>
	  </div>
	</c:if>

  <hr class="mt-5"/>
  
  <div class="participants-section mt-4">
    <c:if test="${!empty nonParticipants}">
      <div class="non-voters">
        <h4>미참여 가족</h4>
        <c:forEach var="vo" items="${nonParticipants}">
          <img src="${ctp}/member/${vo.photo}" alt="${vo.name}" class="voter-photo">
          <span>${vo.name}</span>&nbsp;
        </c:forEach>
      </div>
    </c:if>
    <c:if test="${!empty participants}">
      <div class="participants">
        <h4>참여한 가족</h4>
        <c:forEach var="vo" items="${participants}">
          <img src="${ctp}/member/${vo.photo}" alt="${vo.name}" class="voter-photo">
          <span>${vo.name}</span>&nbsp;
        </c:forEach>
      </div>
    </c:if>
  </div>

  <!-- <div class="vote-comment-divider"></div> -->
  
	<div class="comment-section">
  <h4>댓글 ${fn:length(replyVos)}개</h4>
  <div class="comment-input-container">
    <textarea id="commentContent" name="content" class="comment-input" placeholder="댓글을 입력하세요..." rows="3"></textarea>
    <div class="text-right">
      <button class="btn-comment" onclick="submitComment(0)">등록</button>    
    </div>
  </div>
    
  <!-- 댓글 리스트 -->
  <c:forEach var="replyVo" items="${replyVos}">
    <c:if test="${replyVo.parentIdx == null}">
      <div class="comment">
        <span class="comment-author">${replyVo.name}</span>
        <span>${fn:replace(replyVo.content, newLine, "<br/>")}</span>
        <div class="comment-meta">
          <span class="comment-time">${fn:substring(replyVo.createdAt, 0, 16)}</span>
          <span id="replyBtn${replyVo.idx}" class="reply-btn" onclick="toggleReplyForm(${replyVo.idx})">
            답글
          </span>
          <c:if test="${replyVo.memberIdx == sIdx}">
            <span class="delete-btn" onclick="deleteComment(${replyVo.idx})">
              삭제
            </span>
          </c:if>
        </div>
        <div id="replyForm${replyVo.idx}" class="reply-form" style="display: none;">
          <textarea id="replyContent${replyVo.idx}" name="replyContent${replyVo.idx}" class="comment-input" placeholder="답글을 입력하세요..." >@${replyVo.name} </textarea>
          <div class="text-right">
            <button class="btn-comment" onclick="submitComment(${replyVo.idx})">답글 등록</button>    
          </div>
        </div>
        
        <!-- 대댓글 표시 -->
        <c:forEach var="childReply" items="${replyVos}">
          <c:if test="${childReply.parentIdx == replyVo.idx}">
            <div class="comment reply">
              <span class="comment-author">${childReply.name}</span>
              <span>${fn:replace(childReply.content, newLine, "<br/>")}</span>
              <div class="comment-meta">
                <span class="comment-time">${fn:substring(childReply.createdAt, 0, 16)}</span>
                <c:if test="${childReply.memberIdx == sIdx}">
                  <span class="delete-btn" onclick="deleteComment(${childReply.idx})">
                    삭제
                  </span>
                </c:if>
              </div>
            </div>
          </c:if>
        </c:forEach>
      </div>
    </c:if>
  </c:forEach>
</div>

  <a href="${ctp}/vote/voteList" class="btn-list">목록으로</a>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>