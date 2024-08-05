<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Null Pointer Error | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/css/error-styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-exclamation-circle"></i>
    </div>
    <!-- <div class="error-code">NullPointerException</div> -->
    <h1>null 참조 오류</h1>
    <p>죄송합니다. 프로그램 실행 중 예기치 않은 오류가 발생했습니다.<br/>이 문제는 시스템 내부의 데이터 처리 과정에서 발생한 것으로,<br/>관리자에게 보고되었습니다. 잠시 후 다시 시도해 주세요.</p>
    <a href="${ctp}/" class="btn">홈으로 돌아가기</a>
  </div>
</body>
</html>