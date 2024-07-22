<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>가사 등록 | HomeLink</title>
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
    select, input[type="text"], input[type="date"], textarea, .btn {
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
    
    function fCheck() {
      let category = myform.category.value;
      let task = myform.task.value;
      let description = myform.description.value;
      let startDate = myform.startDate.value;
      let endDate = myform.endDate.value;
      let rotationPeriod = myform.rotationPeriod.value;
      
      if(category.trim() == "") {
        showAlert("대항목을 선택해주세요.");
        myform.category.focus();
        return false;
      }
      else if(task.trim() == "") {
        showAlert("소항목을 입력해주세요.");
        myform.task.focus();
        return false;
      }
      else if(description.trim() == "") {
        showAlert("설명을 입력해주세요.");
        myform.description.focus();
        return false;
      }
      else if(startDate.trim() == "") {
        showAlert("시작일을 입력해주세요.");
        myform.startDate.focus();
        return false;
      }
      else if(endDate.trim() == "") {
        showAlert("마감일을 입력해주세요.");
        myform.endDate.focus();
        return false;
      }
      else if(rotationPeriod.trim() == "") {
        showAlert("역할 로테이션 주기를 입력해주세요.");
        myform.rotationPeriod.focus();
        return false;
      }

      myform.submit();
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="inputContainer">
  <div class="header">
    <a href="${ctp}/work/workList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
    <font size="5" class="mb-4 h2">가사 분담 등록</font>
  </div>
  <form name="myform" method="post">
    <div class="form-group">
      <label for="category">대항목</label>
      <select name="category" id="category" class="form-control">
        <option value="">선택하세요</option>
        <option value="청소">청소</option>
        <option value="식사">식사</option>
        <option value="쓰레기버리기">쓰레기버리기</option>
        <option value="빨래">빨래</option>
      </select>
    </div>
    <div class="form-group">
      <label for="task">소항목</label>
      <input type="text" name="task" id="task" placeholder="소항목을 입력해 주세요." class="form-control" />
    </div>
    <div class="form-group">
      <label for="description">설명</label>
      <textarea name="description" id="description" rows="4" placeholder="가사 분담에 대한 설명을 입력해 주세요." class="form-control"></textarea>
    </div>
    <div class="form-group">
      <label for="startDate">시작일</label>
      <input type="date" name="startDate" id="startDate" class="form-control" />
    </div>
    <div class="form-group">
      <label for="endDate">마감일</label>
      <input type="date" name="endDate" id="endDate" class="form-control" />
    </div>
    <div class="form-group">
      <label for="rotationPeriod">역할 로테이션 주기(일)</label>
      <input type="number" name="rotationPeriod" id="rotationPeriod" placeholder="역할 로테이션 주기를 일 단위로 입력해 주세요." class="form-control" />
    </div>
    <input type="hidden" name="memberIdx" value="${sIdx}">
    <input type="hidden" name="familyCode" value="${sFamCode}">
    <div class="form-group" style="margin-bottom:15px;">
      <input type="button" value="등록하기" onclick="fCheck()" class="btn"/>
    </div>
    <div class="form-group">
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/work/workList';" class="btn btn-back"/>
    </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>