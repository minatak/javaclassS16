<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>400 Bad Request | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/css/error-styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-exclamation-triangle"></i>
    </div>
    <div class="error-code">400</div>
    <h1>잘못된 요청입니다</h1>
    <p>죄송합니다. 서버가 요청을 이해할 수 없습니다.<br/>입력 정보를 확인하시고 다시 시도해 주세요.</p>
    <a href="${ctp}/home" class="btn">홈으로 돌아가기</a>
  </div>
</body>
</html>