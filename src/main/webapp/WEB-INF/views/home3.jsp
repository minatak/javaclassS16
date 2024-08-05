<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HomeLink</title>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
	<style>
	  @font-face {
		  font-family: 'yg-jalnan';
		  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.2/JalnanOTF00.woff') format('woff');
		  font-weight: normal;
		  font-style: normal;
		}
		
		@font-face {
		  font-family: 'LeeSeoyun';
		  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2202-2@1.0/LeeSeoyun.woff') format('woff');
		  font-weight: normal;
		  font-style: normal;
		}
		
		@font-face {
	    font-family: 'GmarketSansMedium';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
		
		body {
		  font-family: 'Pretendard', sans-serif !important;
		  background-color: #ffffff;
		  color: #333c47;
		}
		
		.content {
		  max-width: 900px;
		  margin: 40px auto;
		  padding: 40px;
		  margin-top:0;
		}
		
		.header {
		  margin-bottom: 50px;
		}
		
		.header .h2 {
		  font-weight: 600;
		  font-size: 24px;
		  color: #333c47;
		  text-align: center;
		  margin-bottom: 50px;
		}
		
		.card {
		  border: 1px solid #ddd;
		  border-radius: 8px;
		  margin-bottom: 30px;
		  overflow: hidden;
		  min-height: 200px;
		}
		
		.card-header { 
		  background-color: #fff;
		  color: #84a98c;
		  font-weight: 600;
		  padding: 15px 20px;
		  border-bottom: 1px solid #ddd;
		}
		
		.card-body {
		  padding: 20px;
		  background-color: #fff;
		  display: flex;
		  flex-direction: column;
		  justify-content: center;
		}
		
		.list-group {
		  margin-bottom: 0;
		}
		
		.list-group-item {
		  border: none;
		  padding: 12px 0;
		  border-bottom: 1px solid #f0f0f0;
		  white-space: nowrap;
		  overflow: hidden;
		  text-overflow: ellipsis;
		}
		
		.list-group-item:last-child {
		  border-bottom: none;
		}
		
		.view-all {
		  font-size: 14px;
		  color: #84a98c;
		  text-decoration: none;
		  float: right;
		  transition: color 0.3s ease;
		}
		
		.view-all:hover {
		  color: #6b8e76;
		  text-decoration: none;
		}
		
		.empty-message {
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  height: 100%;
		  text-align: center;
		  color: #6c757d;
		  font-size: 14px;
		  font-style: italic;
		  padding: 20px;
		}
		
		.weather-banner {
		  background-color: #fff;
		  color: #333c47;
		  padding: 20px;
		  border-radius: 12px;
		  margin-bottom: 30px;
		}
		
		.weather-content {
		  display: flex;
		  align-items: center;
		}
		
		.weather-icon-temp {
		  display: flex;
		  flex-direction: column;
		  align-items: center;
		  margin-right: 20px;
		}
		
		.weather-icon {
		  width: 64px;
		  height: 64px;
		  margin-bottom: 0px;
		}
		
		.temperature {
		  font-family: 'KOTRAHOPE';
		  font-size: 19px;
		  font-weight: bold;
		  color: #84a98c;
		}
		
		.weather-text {
		  flex: 1;
		}
		
		.weather-title {
		  font-size: 18px;
		  font-weight: 600;
		  margin-bottom: 10px;
		  color: #2d3e50;
		}
		@font-face {
	    font-family: 'KOTRAHOPE';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2110@1.0/KOTRAHOPE.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		@font-face {
	    font-family: 'omyu_pretty';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/omyu_pretty.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		.weather-advice {
		  font-family: 'omyu_pretty';
		  font-size: 18px;
		  /* line-height: 1.6; */
		  margin-bottom: 0;
		}
		
		.photo-preview {
		  width: 100%;
		  height: 130px;
		  object-fit: cover;
		  border-radius: 4px;
		  transition: transform 0.3s ease;
		}
		
		a {
		  color: #333c47;
		  transition: color 0.3s ease;
		}
		
		a:hover {
		  color: #84a98c;
		  text-decoration: none;
		}
	   .meeting-info {
	    display: flex;
	    flex-direction: column;
	  }
	  .meeting-title {
	    font-weight: bold;
	    font-size: 1.1em;
	    margin-bottom: 5px;
	  }
	  .meeting-datetime {
	    font-size: 0.9em;
	    color: #666;
	  }
	  .meeting-datetime i {
	    margin-right: 5px;
	    margin-left: 10px;
	  }
	  .meeting-datetime i:first-child {
	    margin-left: 0;
	  }
	  
	  .housework-info, .notice-info, .vote-info {
		  display: flex;
		  flex-direction: column;
		}
		
		.housework-title, .notice-title, .vote-title {
		  font-weight: bold;
		  font-size: 1.1em;
		  margin-bottom: 5px;
		}
		
		.housework-details, .notice-details, .vote-details {
		  font-size: 0.9em;
		  color: #666;
		}
		
		.housework-details i, .notice-details i, .vote-details i {
		  margin-right: 5px;
		  margin-left: 10px;
		}
		
		.housework-details i:first-child, .notice-details i:first-child, .vote-details i:first-child {
		  margin-left: 0;
		}
		
		.housework-info {
		  display: flex;
		  font-weight: bold;
		}
		
		.member-name {
		  color: #999;
		  margin-right: 10px;
		  font-size: 0.9em;
		}
		
		.housework-title {
		  font-weight: bold;
		}
		
		.member-name i {
		  margin-right: 5px;
		}
	  
	  .schedule-info {
		  display: flex;
		  flex-direction: column;
		}
		
		.schedule-title {
		  font-weight: bold;
		  font-size: 1.1em;
		  margin-bottom: 5px;
		}
		
		#weeklyCalendar {
		  font-size: 0.8em;
		  height: 400px !important;
		}
		.fc-header-toolbar {
		  font-size: 0.9em;
		  margin-bottom: 10px !important;
		}
		.fc-timegrid-slot-label {
		  font-size: 0.9em;
		}
		.fc-timegrid-axis {
		  font-size: 0.9em;
		}
		.fc-timegrid-event {
		  border-radius: 3px;
		}
		.fc-timegrid-event .fc-event-main {
		  padding: 2px 4px;
		}
		.fc .fc-button {
		  padding: 0.2em 0.5em;
		  font-size: 0.9em;
		}
		.fc .fc-toolbar-title {
		  font-size: 1.2em;
		}
		
	</style>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
		  const truncateText = (element, maxLength) => {
		    let text = element.innerText;
		    if (text.length > maxLength) {
		      element.innerText = text.substring(0, maxLength) + '...';
		    }
		  }; 
	
		  document.querySelectorAll('.truncate').forEach(el => truncateText(el, 55));
		});
		
		
		document.addEventListener('DOMContentLoaded', function() {
			  var calendarEl = document.getElementById('weeklyCalendar');
			  var calendar = new FullCalendar.Calendar(calendarEl, {
			    initialView: 'timeGridWeek',
			    headerToolbar: {
			      left: 'prev,next today',
			      center: 'title',
			      right: 'timeGridWeek,timeGridDay'
			    },
			    height: 'auto',
			    allDaySlot: true,
			    slotMinTime: '00:00:00',
			    slotMaxTime: '24:00:00',
			    events: function(info, successCallback, failureCallback) {
			      $.ajax({
			        url: '${ctp}/calendar/weeklyEvents',
			        method: 'GET', 
			        data: {
			          startDate: info.startStr,
			          endDate: info.endStr
			        },
			        dataType: 'json',
			        success: function(res) {
			          console.log('Received events:', res);
			          successCallback(res);
			        },
			        error: function(jqXHR, textStatus, errorThrown) {
			          console.error("AJAX error: " + textStatus + ' : ' + errorThrown);
			          failureCallback("Error fetching events.");
			        }
			      });
			    },
			    eventClick: function(info) {
			      console.log('Event clicked:', info.event);
			      window.location.href = '${ctp}/calendar/calendarContent?idx=' + info.event.id;
			    }
			  });
			  calendar.render();
			  console.log('Calendar rendered');
			});
		
	</script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav.jsp" %>
<%@ include file = "/WEB-INF/views/include/side.jsp" %>
<main role="main" class="content">
  <div class="weather-banner">
		  <c:if test="${not empty weatherAdvice}">
		    <div class="weather-content">
		      <div class="weather-icon-temp">
		        <img src="${weatherIconUrl}" alt="오늘의 날씨" class="weather-icon">
		        <%-- <span class="temperature">${temp}°C</span> --%>
		      </div>
		      <div class="weather-text">
		        <p class="weather-advice">${weatherAdvice}</p>
		      </div>
		    </div>
		  </c:if>
		  <c:if test="${empty weatherAdvice}">
		    <p class="weather-advice">날씨 정보를 불러올 수 없습니다. 하지만 우리의 하루는 언제나 밝고 따뜻할 거예요.</p>
		  </c:if>
		</div>
 
  
	<div class="card">
	  <div class="card-header">
	    <i class="fas fa-bell"></i> 우리 가족 소식
	    <a href="${ctp}/notice/noticeList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
	  </div>
	  <div class="card-body">
	    <c:if test="${not empty notices}">
	      <ul class="list-group list-group-flush">
	        <c:forEach items="${notices}" var="notice">
	          <li class="list-group-item">
	            <a href="${ctp}/notice/noticeContent?idx=${notice.idx}">
	              <div class="notice-info">
	                <div class="notice-title truncate">${notice.title}</div>
	                <div class="notice-details">
	                  ${notice.memberName} | ${notice.createdAt.toString().substring(0, 10)}
	                </div>
	              </div>
	            </a>
	          </li>
	        </c:forEach>
	      </ul>
	    </c:if>
	    <c:if test="${empty notices}">
	      <div class="empty-message">새로운 소식이 없어요. 오늘 하루는 어떠셨나요?</div>
	    </c:if>
	  </div>
	</div>
	
	<div class="card">
	  <div class="card-header">
	    <i class="fas fa-calendar"></i> 이번 주 일정
	    <a href="${ctp}/calendar/calendarMain" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
	  </div>
	  <div class="card-body">
	    <div id='weeklyCalendar' style="height: 600px; width: 100%;"></div>
	  </div>
	</div>
	
	
	<div class="card">
	  <div class="card-header">
	    <i class="fas fa-heart"></i> 오늘 우리가 함께할 일
	    <a href="${ctp}/housework/workMain" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
	  </div>
	  <div class="card-body">
	    <c:if test="${not empty houseworks}">
	      <ul class="list-group list-group-flush">
	        <c:forEach items="${houseworks}" var="work" varStatus="status">
	          <li class="list-group-item">
	            <div class="housework-info">
	              <span class="member-name"><i class="fas fa-user"></i> ${work.memberName}</span><span class="housework-info truncate"> ${work.description}</span>
	            </div>
	          </li>
	        </c:forEach>
	      </ul>
	    </c:if>
	    <c:if test="${empty houseworks}">
	      <div class="empty-message">오늘은 특별한 할 일이 없어요. 가족과 함께 즐거운 시간 보내세요!</div>
	    </c:if>
	  </div>
	</div>
	
	<div class="card">
	  <div class="card-header">
	    <i class="fas fa-poll"></i> 우리 가족의 선택
	    <a href="${ctp}/vote/voteList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
	  </div>
	  <div class="card-body">
	    <c:if test="${not empty votes}">
	      <ul class="list-group list-group-flush">
	        <c:forEach items="${votes}" var="vote">
	          <li class="list-group-item">
	          	<a href="${ctp}/vote/voteContent?idx=${vote.idx}">
		            <div class="vote-info"> 
		              <div class="vote-title truncate">${vote.title}</div>
		              <div class="vote-details">
		                <i class="far fa-clock"></i> ${vote.endTime.toString().substring(0, 10)} 마감
		              </div>
		            </div>
	            </a>
	          </li>
	        </c:forEach>
	      </ul>
	    </c:if>
	    <c:if test="${empty votes}">
	      <div class="empty-message">진행 중인 투표가 없어요. 가족과 함께 결정할 일이 있나요?</div>
	    </c:if>
	  </div>
	</div>

	<div class="card">
	  <div class="card-header">
	    <i class="fas fa-users"></i> 다가오는 가족 회의
	    <a href="${ctp}/familyMeeting/meetingList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
	  </div>
	  <div class="card-body">
	    <c:if test="${not empty meetings}">
	      <ul class="list-group list-group-flush">
	        <c:forEach items="${meetings}" var="meeting">
	          <li class="list-group-item">
	          	<a href="${ctp}/familyMeeting/meetingContent?idx=${meeting.idx}">
		            <div class="meeting-info">
		              <div class="meeting-title truncate">${meeting.title}</div>
		              <div class="meeting-datetime">
		                <i class="far fa-calendar-alt"></i> ${meeting.meetingDate.toString().substring(0, 10)}
		                <i class="far fa-clock"></i> ${meeting.meetingDate.toString().substring(11, 16)}
		              </div>
		            </div>
		        	</a>
	          </li>
	        </c:forEach>
	      </ul>
	    </c:if>
	    <c:if test="${empty meetings}">
	      <div class="empty-message">아직 예정된 회의가 없어요. 가족과 함께 이야기 나누며 해결하고 싶은 일들을 찾아보세요.</div>
	    </c:if>
	  </div>
	</div>

	
	<div class="card">
	  <div class="card-header">
	    <i class="fas fa-camera-retro"></i> 추억의 순간들
	    <a href="${ctp}/photo/photoList" class="view-all">모두 보기 <i class="fas fa-arrow-right"></i></a>
	  </div>
	  <div class="card-body">
	    <c:if test="${not empty photos}">
	      <div class="row">
	        <c:forEach items="${photos}" var="photo">
	          <div class="col-md-3">
	            <a href="${ctp}/photo/photoContent?idx=${photo.idx}">
	              <img src="${ctp}/thumbnail/${photo.thumbnail}" class="photo-preview" alt="가족 사진">
	            </a>
	          </div>
	        </c:forEach>
	      </div>
	    </c:if>
	    <c:if test="${empty photos}">
	      <div class="empty-message">아직 추억이 없어요. 함께 웃을 수 있는 순간을 카메라에 담아보세요.</div>
	    </c:if>
	  </div>
	</div>
</main>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>