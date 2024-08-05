<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>404 Not Found | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/css/error-styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-question-circle"></i>
    </div>
    <div class="error-code">404</div>
    <h1>페이지를 찾을 수 없습니다</h1>
    <p>죄송합니다. 요청하신 페이지를 찾을 수 없습니다.<br/>URL을 확인하시거나 홈 화면으로 이동해주세요.</p>
    <a href="${ctp}/home" class="btn">홈으로 돌아가기</a>
  </div>
</body>
</html>