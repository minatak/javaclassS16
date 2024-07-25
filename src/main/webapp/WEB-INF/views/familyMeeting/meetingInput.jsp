<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회의록 작성 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: 'pretendard' !important;
      background-color: #f8f8f8;
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
    
    function addNewTopic() {
      const container = document.getElementById('newTopicsContainer');
      const newTopic = document.createElement('div');
      newTopic.className = 'new-topic-input mt-2';
      newTopic.innerHTML = `
        <input type="text" name="newTopics[]" placeholder="새로운 안건 입력">
        <button type="button" onclick="removeNewTopic(this)"><i class="fa-solid fa-minus"></i></button>
      `;
      container.appendChild(newTopic);
    }

    function removeNewTopic(button) {
      button.closest('.new-topic-input').remove();
    }
  
    function fCheck() {
      let title = myform.title.value;
      let description = myform.description.value;
      let meetingDate = myform.meetingDate.value;
      let selectedTopics = document.querySelectorAll('input[name="selectedTopics"]:checked');
      let newTopics = document.querySelectorAll('input[name="newTopics[]"]');
      
      if(title.trim() == "") {
        showAlert("회의 제목을 입력해주세요.");
        myform.title.focus();
        return false;
      }
      else if (title.trim().length > 100) {
        showAlert("제목은 100자 이내로 입력해주세요.");
        myform.title.focus();
        return false;
      } 
      else if(description.trim() == "") {
        showAlert("회의 설명을 입력해주세요.");
        myform.description.focus();
        return false;
      }
      else if(meetingDate.trim() == "") {
        showAlert("회의 일시를 입력해주세요.");
        myform.meetingDate.focus();
        return false;
      }
      else if(selectedTopics.length + newTopics.length < 1) {
        showAlert("최소 한 개 이상의 안건을 선택하거나 작성해주세요.");
        return false;
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
    <a href="${ctp}/familyMeeting/meetingList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
    <font size="5" class="mb-4 h2">회의록 작성</font>
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
            <div class="form-check">
              <input class="form-check-input" type="checkbox" name="selectedTopics" value="${topic.idx}" id="topic${topic.idx}">
              <label class="form-check-label" for="topic${topic.idx}">
                ${topic.title} (우선순위: ${topic.priority})
              </label>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
    <div class="form-group">
      <label>새로운 안건 작성</label>
      <div id="newTopicsContainer">
        <div class="new-topic-input">
          <input type="text" name="newTopics[]" placeholder="새로운 안건 입력">
          <button type="button" onclick="removeNewTopic(this)"><i class="fa-solid fa-minus"></i></button>
        </div>
      </div>
      <button type="button" onclick="addNewTopic()" class="btn btn-secondary mt-2">새 안건 추가</button>
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