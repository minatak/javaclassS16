<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>500 Internal Server Error | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/css/error-styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-cogs"></i>
    </div>
    <div class="error-code">500</div>
    <h1>서버 내부 오류</h1>
    <p>죄송합니다. 서버에 문제가 발생했습니다. 잠시 후 다시 시도해 주시거나,<br/>문제가 지속될 경우 관리자에게 문의해 주세요.</p>
    <a href="${ctp}/" class="btn">홈으로 돌아가기</a>
  </div>
</body>
</html>