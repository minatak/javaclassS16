<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회의 수정 | HomeLink</title>
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
		  height: 30px;
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
	  .add-topic-btn {
	    background-color: #84a98c;
	    color: white;
	    border: none;
	    padding: 10px 15px;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	    font-weight: 600;
	    margin-bottom: 10px;
	  }
	  .add-topic-btn:hover {
	    background-color: #6b8c72;
	  }
	  .topic-input input, .topic-input select {
	    width: calc(33% - 10px);
	    margin-right: 10px;
	  }
	  .topic-input button {
	    width: auto;
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
    
    .new-topic-header {
		  display: flex;	
		  align-items: center;
		  margin-bottom: 10px;
		}
		
		.new-topic-header label {
		  margin-bottom: 0;
		  margin-right: 10px;
		}
		
		.toggle-topic-btn {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  padding: 2px 10px;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  font-weight: 600;
		  font-size: 12px;
		  border-radius: 12px;
		  display: inline-flex;
		  align-items: center;
		  justify-content: center;
		  height: 24px;
		}
		
		.toggle-topic-btn:hover {
		  background-color: #6b8c72;
		}
		
		
		.proposed-topics-container {
		  max-height: 400px;
		  overflow-y: auto;
		  padding: 15px;
		  background-color: #fff;
		  border-radius: 8px;
		}
		
		.topic-item {
		  margin-bottom: 10px;
		  position: relative;
		}
		
		.topic-item input[type="checkbox"] {
		  display: none;
		}
		
		.topic-item label {
		  display: flex;
		  align-items: center;
		  cursor: pointer;
		  padding: 10px 10px 10px 40px;
		  border: 1px solid #e0e0e0;
		  border-radius: 5px;
		  transition: all 0.3s ease;
		}
		
		.topic-item label::before {
		  content: '';
		  position: absolute;
		  left: 10px;
		  top: 50%;
		  transform: translateY(-50%);
		  width: 20px;
		  height: 20px;
		  border: 2px solid #84a98c;
		  border-radius: 3px;
		  transition: all 0.3s ease;
		}
		
		.topic-item input[type="checkbox"]:checked + label::before {
		  background-color: #84a98c;
		  border-color: #84a98c;
		}
		
		.topic-item input[type="checkbox"]:checked + label::after {
		  content: '\2714';
		  position: absolute;
		  left: 14px;
		  top: 50%;
		  transform: translateY(-50%);
		  color: white;
		  font-size: 14px;
		}
		
		.topic-title {
		  flex-grow: 1;
		  margin-right: 10px;
		}
		
		.topic-priority {
		  font-size: 0.8em;
		  color: #666;
		}
		
		.topic-item input[type="checkbox"]:checked + label {
		  background-color: #e8f5e9;
		}.proposed-topics-container {
		  max-height: 400px;
		  overflow-y: auto;
		  padding: 15px;
		  background-color: #f9f9f9;
		  border-radius: 8px;
		}
		
		.topic-item {
		  margin-bottom: 10px;
		  position: relative;
		}
		
		.topic-item input[type="checkbox"] {
		  display: none;
		}
		
		.topic-item label {
		  display: flex;
		  align-items: center;
		  cursor: pointer;
		  padding: 10px 10px 10px 40px;
		  border: 1px solid #e0e0e0;
		  border-radius: 5px;
		  transition: all 0.3s ease;
		}
		
		.topic-item label::before {
		  content: '';
		  position: absolute;
		  left: 10px;
		  top: 50%;
		  transform: translateY(-50%);
		  width: 20px;
		  height: 20px;
		  border: 2px solid #84a98c;
		  border-radius: 3px;
		  transition: all 0.3s ease;
		}
		
		.topic-item input[type="checkbox"]:checked + label::before {
		  background-color: #84a98c;
		  border-color: #84a98c;
		}
		
		.topic-item input[type="checkbox"]:checked + label::after {
		  content: '\2714';
		  position: absolute;
		  left: 14px;
		  top: 50%;
		  transform: translateY(-50%);
		  color: white;
		  font-size: 14px;
		}
		
		.topic-title {
		  flex-grow: 1;
		  margin-right: 10px;
		}
		
		.topic-priority {
		  font-size: 0.8em;
		  color: #666;
		}
		
		.topic-item input[type="checkbox"]:checked + label {
		  background-color: #e8f5e9;
		}
		
		.proposed-topics-container {
		  max-height: 400px;
		  overflow-y: auto;
		  padding: 0px;
		  background-color: #fff;
		  border-radius: 0px;
		}
		.topics-grid {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 10px;
		}
		.topic-item {
		  flex: 0 0 calc(50% - 5px);
		  position: relative;
		  margin-bottom: 0;
		}
		.topic-item input[type="checkbox"] {
		  display: none;
		}
		.topic-item label {
		  display: flex;
		  align-items: center;
		  cursor: pointer;
		  padding: 10px 10px 10px 40px;
		  border: 1px solid #e0e0e0;
		  border-radius: 5px;
		  transition: all 0.3s ease;
		  height: 100%;
		}
		.topic-content {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  width: 100%;
		}
		.topic-title {
		  text-align: left;
		}
		.topic-priority {
		  font-size: 0.8em;
		  color: #666;
		  text-align: right;
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
    
    let topicCount = 0;
    
    function toggleNewTopics() {
  	  const container = document.getElementById('newTopicsContainer');
  	  const addMoreTopics = document.getElementById('addMoreTopics');
  	  const toggleBtn = document.getElementById('toggleNewTopicsBtn');
  	  
  	  if (container.style.display === 'none') {
  	    container.style.display = 'block';
  	    addMoreTopics.style.display = 'block';
  	    toggleBtn.textContent = '취소하기';
  	    if (topicCount === 0) {
  	      addNewTopic();
  	    }
  	  } else {
  	    container.style.display = 'none';
  	    addMoreTopics.style.display = 'none';
  	    toggleBtn.textContent = '추가하기';
  	  }
  	}

    function addNewTopic() {
      const container = document.getElementById('newTopicsContainer');
      topicCount++;
      const newTopic = document.createElement('div');
      newTopic.className = 'topic-container';
      newTopic.innerHTML = `
        <div class="topic-input">
          <span class="topic-number">${topicCount}</span>
          <input type="text" name="newTopics[title][]" placeholder="새로운 안건 제목" required>
          <input type="text" name="newTopics[description][]" placeholder="안건 설명" required>
          <select name="newTopics[priority][]" required>
            <option value="">우선순위 선택</option>
            <option value="1">최고 우선순위</option>
            <option value="2">높음</option>
            <option value="3">중간</option>
            <option value="4">낮음</option>
            <option value="5">매우 낮음</option>
          </select>
          <button type="button" onclick="removeNewTopic(this)"><i class="fa-solid fa-minus"></i></button>
        </div>
      `;
      container.appendChild(newTopic);
      updateTopicNumbers();
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
	    let duration = myform.duration.value;
	    
	 		// 새로운 안건에 대한 유효성 검사  
	    let newTopicTitles = document.querySelectorAll('input[name="newTopics[title][]"]');
	    let newTopicDescriptions = document.querySelectorAll('input[name="newTopics[description][]"]');
	    let newTopicPriorities = document.querySelectorAll('select[name="newTopics[priority][]"]');
	    
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
    	else if(duration.trim() == "" || duration <= 0) {
  	    showAlert("유효한 회의 예상 시간을 입력해주세요.", function() {
  	      myform.duration.focus();
  	    });
  	    return false;
  	  }
	    
	 		// 선택된 기존 안건이나 새로운 안건이 있는지 확인
	    if(selectedTopics.length == 0 && newTopicTitles.length == 0) {
	      showAlert("최소 한 개 이상의 안건을 선택하거나 작성해주세요.");
	      return false;
	    }

	    // 새로운 안건에 대한 유효성 검사
	    for (let i = 0; i < newTopicTitles.length; i++) {
	      if (newTopicTitles[i].value.trim() === "") {
	    	  showAlert("새로운 안건의 제목을 입력해주세요.", function() {
		        newTopicTitles[i].focus();
	    	  });
	        return false;
	      }
	      else if (newTopicTitles[i].value.trim().length > 100) {
	  	    showAlert("새로운 안건의 제목은 100자 이내로 입력해주세요.", function() {
	  	      newTopicTitles[i].focus();
	  	    });
	  	    return false;
	  	  }
	  	  else if (newTopicDescriptions[i].value.trim() === "") {
	  	    showAlert("새로운 안건의 설명을 입력해주세요.", function() {
	  	      newTopicDescriptions[i].focus();
	  	    });
	  	    return false;
	  	  }
	  	  else if (newTopicPriorities[i].value === "") {
	  	    showAlert("새로운 안건의 우선순위를 선택해주세요.", function() {
	  	      newTopicPriorities[i].focus();
	  	    });
	  	    return false;
	  	  }
	    }
	
	    document.myform.submit();
	  }
	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="inputContainer">
  <div class="header">
    <a href="${ctp}/familyMeeting/meetingContent?idx=${meeting.idx}" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
    <font size="5" class="mb-4 h2">회의 수정</font>
  </div>
  <form name="myform" method="post">
    <div class="form-group">
      <label for="title">회의 제목</label>
      <input type="text" name="title" id="title" value="${meeting.title}" placeholder="회의 제목을 작성해 주세요." autofocus required class="form-control" />
    </div>
    <div class="form-group">
      <label for="description">회의 설명</label>
      <textarea name="description" id="description" rows="4" placeholder="회의 설명을 입력해 주세요." class="form-control" required>${meeting.description}</textarea>
    </div>
    <div class="form-group">
      <label for="meetingDate">회의 일시</label>
      <input type="datetime-local" name="meetingDate" id="meetingDate" value="${meeting.meetingDate}" class="form-control" required />
    </div>
    <div class="form-group">
		  <label>제안된 안건 선택</label>
		  <div class="proposed-topics-container">
		    <div class="topics-grid">
		      <c:forEach var="topic" items="${proposedTopics}" varStatus="status">
		        <div class="topic-item mb-2">
		          <input type="checkbox" id="topic${topic.idx}" name="selectedTopics" value="${topic.idx}" 
		                 <c:if test="${selectedTopics.contains(topic.idx)}">checked</c:if>>
		          <label for="topic${topic.idx}">
		            <div class="topic-content"> 
		              <span class="topic-title">${topic.title}</span>
		              <span class="topic-priority">우선순위: ${topic.priority}</span>
		            </div>
		          </label>
		        </div>
		        <c:if test="${status.count % 2 == 0 || status.last}">
		          </div><div class="topics-grid">
		        </c:if>
		      </c:forEach>
		    </div>
		  </div>
		</div>
    <div class="form-group">
      <div class="new-topic-header">
        <label>새로운 안건 작성</label>
        <button type="button" id="toggleNewTopicsBtn" class="toggle-topic-btn" onclick="toggleNewTopics()">추가하기</button>
      </div>
      <div id="newTopicsContainer" style="display: none;">
        <!-- JavaScript로 동적으로 추가됨 -->
      </div>
      <button type="button" id="addMoreTopics" onclick="addNewTopic()" class="add-topic" style="display: none;">+ 안건 추가하기</button>
    </div>
    <div class="form-group">
      <label for="facilitatorIdx">회의 진행자</label>
      <select name="facilitatorIdx" id="facilitatorIdx" class="form-control" required>
        <option value="">회의 진행자 선택</option>
        <c:forEach var="member" items="${familyMembers}">
          <option value="${member.idx}" <c:if test="${member.idx == meeting.facilitatorIdx}">selected</c:if>>${member.name}</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-group">
      <label for="recorderIdx">회의 기록자</label>
      <select name="recorderIdx" id="recorderIdx" class="form-control" required>
        <option value="">회의 기록자 선택</option>
        <c:forEach var="member" items="${familyMembers}">
          <option value="${member.idx}" <c:if test="${member.idx == meeting.recorderIdx}">selected</c:if>>${member.name}</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-group">
      <label for="duration">회의 예상 시간 (분)</label>
      <input type="number" name="duration" id="duration" value="${meeting.duration}" class="form-control" required min="1" />
    </div>
    <input type="hidden" name="idx" value="${meeting.idx}">
    <input type="hidden" name="familyCode" value="${sFamCode}">
    <input type="hidden" name="createdBy" value="${sIdx}">
    <div class="form-group" style="margin-bottom:15px;">
      <input type="button" value="수정하기" onclick="fCheck()" class="btn"/>
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