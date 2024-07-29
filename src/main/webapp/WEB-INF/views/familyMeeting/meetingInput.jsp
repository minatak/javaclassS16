<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회의 등록 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: 'pretendard' !important;
      background-color: #fff;
      color: #333;
    }
    .inputContainer {
      max-width: 800px;
      margin: 0 auto;
      padding: 40px 20px;
    }
    .header {
      margin-bottom: 30px;
    }
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .home-icon:hover {color: #c6c6c6;}
    .h2 {
      font-family: 'pretendard' !important;
      font-weight: 600;
      font-size: 24px;
      color: #333;
      text-align: center;
    }
    .form-group {
      margin-bottom: 30px;
    }
    label {
      font-weight: 500;
      margin-bottom: 5px;
      display: block;
    }
    select, input[type="text"], input[type="datetime-local"], textarea, .btn {
      width: 100%;
      padding: 10px;
      border: 1px solid #e0e0e0;
      border-radius: 0px;
      font-size: 14px;
    }
    .btn {
      background-color: #84a98c;
      color: white;
      border: none;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-weight: 600;
    }
    .btn:hover {
      background-color: #6b8c72;
    }
    .btn-back {
      background-color: #fff;
      color: #84a98c;
      border: 1px solid #84a98c;
    }
    .btn-back:hover {
      color: #84a98c;
      background-color: #f0f0f0;
    }
    .topic-container {
		  margin-bottom: 10px;
		}
		.topic-input {
		  display: flex;
		  align-items: center;
		}
		.topic-input input {
		  flex-grow: 1;
		  margin-right: 10px;
		}
		.topic-input button {
		  background: none;
		  border: none;
		  color: #cecece;
		  cursor: pointer;
		}
		.add-topic {
		  color: #84a98c;
		  background: none;
		  border: none;
		  cursor: pointer;
		  padding: 5px 0;
		}
		.topic-number {
		  display: inline-flex;
		  justify-content: center;
		  align-items: center;
		  width: 30px;
		  height: 27px;
		  background-color: #e0e0e0;
		  color: #333;
		  border-radius: 50%;
		  margin-right: 10px;
		  font-size: 14px;
		  font-weight: bold;
		}
		
	  .topic-checkbox {
	    display: none;
	  }
	  .topic-label {
	    display: block;
	    padding: 10px;
	    margin-bottom: 10px;
	    border: 1px solid #e0e0e0;
	    border-radius: 5px;
	    cursor: pointer;
	    transition: all 0.3s ease;
	  }
	  .topic-checkbox:checked + .topic-label {
	    background-color: #84a98c;
	    color: white;
	  }
	  .topic-priority {
	    float: right;
	    font-size: 0.9em;
	    color: #666;
	  }
	  .topic-checkbox:checked + .topic-label .topic-priority {
	    color: #e0e0e0;
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
    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
    }
    .swal2-confirm:hover {
      background-color: none !important;
    }
  </style>
   <script>
    'use strict';
  
    function showAlert(message) {
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
      });
    }
    
    let topicCount = 1;

    function addNewTopic() {
      const container = document.getElementById('newTopicsContainer');
      topicCount++;
      const newTopic = document.createElement('div');
      newTopic.className = 'topic-container';
      newTopic.innerHTML = `
        <div class="topic-input">
          <span class="topic-number">${topicCount}</span>
          <input type="text" name="newTopics[]" placeholder="새로운 안건 입력" required>
          <button type="button" onclick="removeNewTopic(this)"><i class="fa-solid fa-minus"></i></button>
        </div>
      `;
      container.appendChild(newTopic);
    }

    function removeNewTopic(button) {
      const container = document.getElementById('newTopicsContainer');
     
      button.closest('.topic-container').remove();
      topicCount--;
      updateTopicNumbers();
    }

    function updateTopicNumbers() {
      const topics = document.querySelectorAll('.topic-container');
      topics.forEach((topic, index) => {
        topic.querySelector('.topic-number').textContent = index + 1;
      });
    }
  
    function fCheck() {
	    let title = myform.title.value;
	    let description = myform.description.value;
	    let meetingDate = myform.meetingDate.value;
	    let selectedTopics = document.querySelectorAll('input[name="selectedTopics"]:checked');
	    let newTopics = document.querySelectorAll('input[name="newTopics[]"]');
	    let facilitatorIdx = myform.facilitatorIdx.value;
	    let recorderIdx = myform.recorderIdx.value;
	    
	    if(title.trim() == "") {
    	  showAlert("회의 제목을 입력해주세요.", function() {
    	    myform.title.focus();
    	  });
    	  return false;
    	}
    	else if (title.trim().length > 100) {
    	  showAlert("제목은 100자 이내로 입력해주세요.", function() {
    	    myform.title.focus();
    	  });
    	  return false;
    	}
    	else if(description.trim() == "") {
    	  showAlert("회의 설명을 입력해주세요.", function() {
    	    myform.description.focus();
    	  });
    	  return false;
    	}
    	else if(meetingDate.trim() == "") {
    	  showAlert("회의 일시를 입력해주세요.", function() {
    	    myform.meetingDate.focus();
    	  });
    	  return false;
    	}
    	else if(selectedTopics.length == 0 && newTopics.length == 0) {
    	  showAlert("최소 한 개 이상의 안건을 선택하거나 작성해주세요.");
    	  return false;
    	}
    	else if(facilitatorIdx == "") {
    	  showAlert("회의 진행자를 선택해주세요.", function() {
    	    myform.facilitatorIdx.focus();
    	  });
    	  return false;
    	}
    	else if(recorderIdx == "") {
    	  showAlert("회의 기록자를 선택해주세요.", function() {
    	    myform.recorderIdx.focus();
    	  });
    	  return false;
    	}
	
	    // 새로운 안건이 있는지 확인
	    let hasNewTopic = false;
	    newTopics.forEach(topic => {
	      if(topic.value.trim() !== "") {
	        hasNewTopic = true;
	      }
	    });
	
	    if(selectedTopics.length == 0 && !hasNewTopic) {
    	  showAlert("최소 한 개 이상의 안건을 선택하거나 작성해주세요.");
    	  return false;
    	}
	
	    document.myform.submit();
	  }
	
	  function addNewTopic() {
	    const container = document.getElementById('newTopicsContainer');
	    topicCount++;
	    const newTopic = document.createElement('div');
	    newTopic.className = 'topic-container';
	    newTopic.innerHTML = `
	      <div class="topic-input">
	        <span class="topic-number">${topicCount}</span>
	        <input type="text" name="newTopics[]" placeholder="새로운 안건 입력">
	        <button type="button" onclick="removeNewTopic(this)"><i class="fa-solid fa-minus"></i></button>
	      </div>
	    `;
	    container.appendChild(newTopic);
	    updateTopicNumbers();
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="inputContainer">
  <div class="header">
    <a href="${ctp}/familyMeeting/meetingList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
    <font size="5" class="mb-4 h2">회의 등록</font>
  </div>
  <form name="myform" method="post">
    <div class="form-group">
      <label for="title">회의 제목</label>
      <input type="text" name="title" id="title" placeholder="회의 제목을 작성해 주세요." autofocus required class="form-control" />
    </div>
    <div class="form-group">
      <label for="description">회의 설명</label>
      <textarea name="description" id="description" rows="4" placeholder="회의 설명을 입력해 주세요." class="form-control" required></textarea>
    </div>
    <div class="form-group">
      <label for="meetingDate">회의 일시</label>
      <input type="datetime-local" name="meetingDate" id="meetingDate" class="form-control" required />
    </div>
    <div class="form-group">
		  <label>제안된 안건 선택</label>
		  <div class="row">
		    <c:forEach var="topic" items="${proposedTopics}">
		      <div class="col-md-6">
		        <input class="topic-checkbox" type="checkbox" name="selectedTopics" value="${topic.idx}" id="topic${topic.idx}">
		        <label class="topic-label" for="topic${topic.idx}">
		          ${topic.title}
		          <span class="topic-priority">우선순위: ${topic.priority}</span>
		        </label>
		      </div>
		    </c:forEach>
		  </div>
		</div>
    <div class="form-group">
		  <label>새로운 안건 작성</label>
		  <div id="newTopicsContainer">
		    <div class="topic-container">
		      <div class="topic-input">
		        <span class="topic-number">1</span>
		        <input type="text" name="newTopics[]" placeholder="새로운 안건 입력" required>
		        <button type="button" onclick="removeNewTopic(this)"><i class="fa-solid fa-minus"></i></button>
		      </div>
		    </div>
		  </div>
		  <button type="button" class="add-topic" onclick="addNewTopic()">+ 안건 추가하기</button>
		</div>
    <div class="form-group">
      <label for="facilitatorIdx">회의 진행자</label>
      <select name="facilitatorIdx" id="facilitatorIdx" class="form-control" required>
        <option value="">회의 진행자 선택</option>
        <c:forEach var="member" items="${familyMembers}">
          <option value="${member.idx}">${member.name}</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-group">
      <label for="recorderIdx">회의 기록자</label>
      <select name="recorderIdx" id="recorderIdx" class="form-control" required>
        <option value="">회의 기록자 선택</option>
        <c:forEach var="member" items="${familyMembers}">
          <option value="${member.idx}">${member.name}</option>
        </c:forEach>
      </select>
    </div>
    <input type="hidden" name="familyCode" value="${sFamCode}">
    <input type="hidden" name="createdBy" value="${sIdx}">
    <div class="form-group" style="margin-bottom:15px;">
      <input type="button" value="등록하기" onclick="fCheck()" class="btn"/>
    </div>
    <div class="form-group">
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/familyMeeting/meetingList';" class="btn btn-back"/>
    </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>