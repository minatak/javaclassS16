<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<c:forEach var="vo" items="${vos}" varStatus="st">
  <div class="card">
    <a href="${ctp}/photo/photoContent?idx=${vo.idx}">
      <img src="${ctp}/thumbnail/${vo.thumbnail}" />
      <c:if test="${vo.photoCount > 1}">
        <div class="multiple-photos">
          <i class="fas fa-clone"></i>
        </div>
      </c:if>
      <div class="card-overlay">
        <div class="card-stats">
          <div class="card-stat"><i class="fas fa-comment"></i> ${vo.replyCnt}</div>
          <div class="card-stat"><i class="fas fa-heart"></i> ${vo.goodCount}</div>
        </div>
      </div>
    </a>
  </div>
</c:forEach>
<input type="hidden" id="hasMore" value="${hasMore}"/>