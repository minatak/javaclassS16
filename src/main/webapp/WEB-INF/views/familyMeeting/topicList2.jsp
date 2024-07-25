<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>제안된 안건 목록 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    .topic-card {
      margin-bottom: 20px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .topic-title {
      font-weight: bold;
      font-size: 1.2em;
    }
    .topic-description {
      color: #666;
    }
    .topic-info {
      font-size: 0.9em;
      color: #888;
    }
    .comment-section {
      margin-top: 15px;
      border-top: 1px solid #eee;
      padding-top: 15px;
    }
    .comment {
      margin-bottom: 10px;
    }
  </style>
  <script>
    function addComment(topicIdx) {
      let content = document.getElementById('commentContent-' + topicIdx).value;
      // AJAX로 서버에 댓글 추가 요청
      // 성공 시 댓글 목록 새로고침
    }

    function approveTopic(topicIdx) {
      // AJAX로 서버에 안건 승인 요청
      // 성공 시 화면 갱신
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container mt-5">
  <h2 class="mb-4">제안된 안건 목록</h2>
  <div class="row">
    <c:forEach var="topic" items="${proposedTopics}">
      <div class="col-md-6">
        <div class="card topic-card">
          <div class="card-body">
            <h5 class="card-title topic-title">${topic.title}</h5>
            <p class="card-text topic-description">${topic.description}</p>
            <p class="topic-info">
              제안자: ${topic.memberName} | 우선순위: ${topic.priority} | 
              상태: ${topic.status}
            </p>
            <button class="btn btn-sm btn-primary" onclick="approveTopic(${topic.idx})">승인</button>
            <div class="comment-section">
		          <h6>댓글</h6>
		          <c:forEach var="reply" items="${topicReplies[topic.idx]}">
		            <div class="comment">
		              <strong>${reply.memberName}:</strong> ${reply.content}
		              <small class="text-muted">${reply.createdAt}</small>
		            </div>
		          </c:forEach>  
              <div class="mt-2">
                <input type="text" id="commentContent-${topic.idx}" class="form-control form-control-sm" placeholder="댓글을 입력하세요">
                <button class="btn btn-sm btn-secondary mt-1" onclick="addComment(${topic.idx})">댓글 추가</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>