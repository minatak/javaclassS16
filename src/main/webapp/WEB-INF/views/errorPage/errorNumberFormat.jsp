<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>Number Format Error | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/css/error-styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-icon">
      <i class="fas fa-hashtag"></i>
    </div>
    <!-- <div class="error-code">NumberFormatException</div> -->
    <h1>숫자 형식 오류</h1>
    <p>죄송합니다. 입력된 데이터를 숫자로 변환하는 과정에서 오류가 발생했습니다.<br/>숫자만 입력해야 하는 필드에 문자나 특수문자가 포함되어 있지 않은지<br/>확인해 주세요.</p>
    <a href="javascript:history.back()" class="btn">이전 페이지로 돌아가기</a>
  </div>
</body>
</html>