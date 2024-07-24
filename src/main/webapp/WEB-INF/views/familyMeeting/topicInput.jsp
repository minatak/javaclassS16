<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>안건 제안 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function submitTopic() {
      let title = $("#title").val();
      let description = $("#description").val();
      let priority = $("#priority").val();
      
      if(title.trim() == "") {
        alert("제목을 입력하세요");
        return false;
      }
      
      topicForm.submit();
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container mt-4">
  <h2>안건 제안하기</h2>
  <form name="topicForm" method="post">
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" class="form-control" id="title" name="title" required>
    </div>
    <div class="form-group">
      <label for="description">설명</label>
      <textarea class="form-control" id="description" name="description" rows="3"></textarea>
    </div>
    <div class="form-group">
      <label for="priority">우선순위</label>
      <select class="form-control" id="priority" name="priority">
        <option value="1">최고 우선순위</option>
        <option value="2">높음</option>
        <option value="3">중간</option>
        <option value="4">낮음</option>
        <option value="5">매우 낮음</option>
      </select>
    </div>
    <button type="button" class="btn btn-primary" onclick="submitTopic()">안건 제안하기</button>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>