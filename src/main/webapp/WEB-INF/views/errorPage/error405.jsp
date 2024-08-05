<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>405 Method Not Allowed | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/css/error-styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-ban"></i>
    </div>
    <div class="error-code">405</div>
    <h1>허용되지 않은 메소드</h1>
    <p>죄송합니다. 요청하신 방법은 이 페이지에서 허용되지 않습니다.<br/>올바른 접근 방법을 사용해 주세요.</p>
    <a href="${ctp}/home" class="btn">홈으로 돌아가기</a>
  </div>
</body>
</html>