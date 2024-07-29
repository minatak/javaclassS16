<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>안건 제안 | HomeLink</title>
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
    select, input[type="text"], textarea, .btn {
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
    
    function fCheck() {
      let title = topicForm.title.value;
      let description = topicForm.description.value;
      let priority = topicForm.priority.value;
      
      if(title.trim() == "") {
        showAlert("제목을 입력해주세요.", function() {
          topicForm.title.focus();
        });
        return false;
      }
      else if(title.trim().length > 100) {
        showAlert("제목은 100자 이내로 입력해주세요.", function() {
          topicForm.title.focus();
        });
        return false;
      }
      else if(description.trim() == "") {
        showAlert("설명을 입력해주세요.", function() {
          topicForm.description.focus();
        });
        return false;
      }
      
      topicForm.submit();
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
    <font size="5" class="mb-4 h2">안건 제안</font>
  </div>
  <form name="topicForm" method="post">
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" name="title" id="title" placeholder="안건 제목을 작성해 주세요." autofocus required class="form-control" />
    </div>
    <div class="form-group">
      <label for="description">설명</label>
      <textarea name="description" id="description" rows="4" placeholder="안건 설명을 입력해 주세요." class="form-control" required></textarea>
    </div>
    <div class="form-group">
      <label for="priority">우선순위</label>
      <select name="priority" id="priority" class="form-control" required>
        <option value="1">최고 우선순위</option>
        <option value="2">높음</option>
        <option value="3">중간</option>
        <option value="4">낮음</option>
        <option value="5">매우 낮음</option>
      </select>
    </div>
    <input type="hidden" name="familyCode" value="${sFamCode}">
    <input type="hidden" name="memberIdx" value="${sIdx}">
    <input type="hidden" name="memberName" value="${sName}">
    <div class="form-group" style="margin-bottom:15px;">
      <input type="button" value="제안하기" onclick="fCheck()" class="btn"/>
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