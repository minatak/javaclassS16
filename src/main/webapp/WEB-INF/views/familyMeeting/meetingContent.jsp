<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회의 상세 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function saveMeetingMinutes() {
      let decisions = $("#decisions").val();
      let actionItems = $("#actionItems").val();
      let notes = $("#notes").val();
      
      $.ajax({
        type: "POST",
        url: "${ctp}/meeting/saveMeetingMinutes",
        data: {
          meetingIdx: ${meeting.idx},
          decisions: decisions,
          actionItems: actionItems,
          notes: notes
        },
        success: function(res) {
          if(res == "1") {
            alert("회의록이 성공적으로 저장되었습니다.");
            location.reload();
          }
          else {
            alert("회의록 저장에 실패했습니다. 다시 시도해주세요.");
          }
        },
        error: function() {
          alert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
        }
      });
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="container">
  <div class="workContainer">
    <div class="header">
      <a href="${ctp}/meeting/meetingList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
      <font size="5" class="mb-4 h2">회의 상세</font>
    </div>
    
    <div class="card mb-4">
      <div class="card-body">
        <h3 class="card-title">${meeting.title}</h3>
        <p class="card-text">${meeting.description}</p>
        <p><strong>일시:</strong> ${meeting.meetingDate}</p>
        <p><strong>장소:</strong> ${meeting.location}</p>
        <p><strong>상태:</strong> ${meeting.status}</p>
        <p><strong>진행자:</strong> ${meeting.facilitatorName}</p>
        <p><strong>기록자:</strong> ${meeting.recorderName}</p>
      </div>
    </div>
    
    <h4>안건 목록</h4>
    <ul class="list-group mb-4">
      <c:forEach var="topic" items="${meetingTopics}">
        <li class="list-group-item">
          <h5>${topic.title}</h5>
          <p>${topic.description}</p>
          <small>우선순위: ${topic.priority}</small>
        </li>
      </c:forEach>
    </ul>
    
    <h4>회의록 작성</h4>
    <form name="minutesForm">
      <div class="form-group">
        <label for="decisions">결정 사항</label>
        <textarea class="form-control" id="decisions" name="decisions" rows="3">${meeting.decisions}</textarea>
      </div>
      <div class="form-group">
        <label for="actionItems">실행 항목</label>
        <textarea class="form-control" id="actionItems" name="actionItems" rows="3">${meeting.actionItems}</textarea>
      </div>
      <div class="form-group">
        <label for="notes">기타 메모</label>
        <textarea class="form-control" id="notes" name="notes" rows="3">${meeting.notes}</textarea>
      </div>
      <button type="button" class="btn" onclick="saveMeetingMinutes()">회의록 저장</button>
    </form>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>