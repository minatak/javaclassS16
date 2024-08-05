<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>Error | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/css/error-styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-exclamation-triangle"></i>
    </div>
    <h1>오류가 발생했습니다</h1>
    <p>죄송합니다. 요청을 처리하는 동안 오류가 발생했습니다.<br/>잠시 후 다시 시도해 주세요.</p>
    <a href="${ctp}/home" class="btn">홈으로 돌아가기</a>
  </div>
</body>
</html>