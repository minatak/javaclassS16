<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>캘린더 | HomeLink</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
  <style>
	  body { 
	    font-family: 'Pretendard', sans-serif; 
	    background-color: #ffffff;
	  }
	  
	  .modal {
	  	font-family: 'Pretendard'; 
	  }
	  
	  .calendarContainer {
	    max-width: 900px;
	    margin: 30px auto;
	    padding: 40px;
	    margin-top:0;
	  }
	 
	 
	 
	  .header {
      margin-bottom: 50px;
    }
	  .header .h2{
	    font-family: 'Pretendard', sans-serif;
      font-weight: 600;
      font-size: 24px;
      color: #333c47;
      text-align: center;
      /* margin-bottom: 50px; */
	  }
	  
	  .home-icon { 
	    font-size: 24px; 
	    color: #cecece; 
	  }
	  
	  .home-icon:hover { color: #c6c6c6; }
	  
	  #showSharedOnly {
	    margin-right: 5px;
	    margin-bottom: 7px;
	    cursor: pointer;
	  }
	  
	  .calendar-legend {
	    font-size: 12px;
	    color: #6c757d;
	    margin-top: 10px;
	    font-family: 'Pretendard' !important;
	  }
	  
	  .legend-item {
	    display: inline-block;
	    margin-right: 15px;
	  }
	  
	  .legend-color {
	    display: inline-block;
	    width: 12px;
	    height: 12px;
	    margin-right: 5px;
	    border-radius: 50%;
	  }
	  
	  /* Calendar Styles */
	  .fc {
	    font-family: 'Pretendard', sans-serif;
	  }
	  
	  .fc .fc-toolbar.fc-header-toolbar {
	    margin-bottom: 1.5em;
	  }
	  
	  .fc .fc-toolbar-title {
	    font-size: 1.5em;
	    font-weight: bold;
	    color: #333c47;
	  }
	  
	  .fc .fc-button {
	    background-color: white;
	    border: 1px solid #cecece;
	    color: #333;
	    font-weight: normal;
	    padding: 0.3em 1.5em;
	    border-radius: 0;
	  }
	  
	  .fc .fc-button:hover {
	    background-color: #fff;
	    border: 1px solid #cecece;
	    color: #333;
	  }
	  
	  .fc .fc-button-primary:not(:disabled).fc-button-active,
	  .fc .fc-button-primary:not(:disabled):active {
	    background-color: #333;
	    color: white;
	    font-weight: bold;
	    box-shadow: none;
	  }
	  
	  .fc .fc-daygrid-day-number {
	    font-size: 1em;
	    padding: 0.4em;
	    color: #333;
	  }
	  
	  .fc .fc-day-today {
	    background-color: white !important;
	  }
	  
	  .fc .fc-day-today .fc-daygrid-day-number {
	    background-color: #333;
	    color: white;
	    border-radius: 50%;
	    width: 30px;
	    height: 30px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    margin: 5px;
	  }
	  
	  .fc .fc-highlight {
	    background-color: #e9ecef;
	    opacity: 0.7;
	  }
	  
	  .fc th, .fc td {
	    border-color: #e9ecef;
	  }
	  
	  .fc .fc-col-header-cell-cushion {
	    color: #495057;
	    font-weight: bold;
	  }
	  
	  .modal-content {
	    border-radius: 15px;
	    border: none;
	    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
	  }
	  
	  .modal-header {
	    justify-content: center; 
	    position: relative;
	    border-bottom: none;
	    padding-bottom: 0;
	  }
	  
	  .modal-title {
	    font-weight: 600;
	    color: #333c47;
	    font-size: 21px;
	  }
	  
	  .modal-body {
	    padding: 30px;
	  }
	  
	  .modal-footer {
	    border-top: none;
	    justify-content: flex-start;
	    padding: 0 30px 30px;
	  }
	  
	  .form-group label {
	    font-weight: 600;
	    color: #333;
	    margin-bottom: 5px;
	  }
	  
	  .form-control {
	    border-radius: 5px;
	    border: 1px solid #ced4da;
	  }
	  
	  .modalBtn {
	    border-radius: 10px;
	    padding: 8px 20px;
	    font-size: 14px;
	    margin-right: 10px;
	    border: none;
	    transition: background-color 0.2s;
	  }
	  
	  .modalBtn.btnPrimary {
	    background-color: #84a98c;
	    color: white;
	  }
	  
	  .modalBtn.btnPrimary:hover {
	    background-color: #5d9469;
	  }
	  
	  .modalBtn.btnDanger {
	    background-color: #6c757d;
	    color: white;
	  }
	  
	  .modalBtn.btnDanger:hover {
	    background-color: #5a6268;
	  }
	  
	  .close {
	    position: absolute;
	    right: 20px;
	    top: 20px;
	    font-size: 24px;
	    color: #adb5bd;
	    background: none;
	    border: none;
	    cursor: pointer;
	  }
	  
	  #eventAuthor {
	    font-size: 14px;
	    color: #6c757d;
	    margin-top: 10px;
	  }
	  
     /* 공유 일정만 보기 체크박스 스타일 */
    .shared-only-container {
      display: flex;
      align-items: center;
      justify-content: flex-end;
     /*  margin-bottom: 15px; */
    }
    
    .shared-only-container input[type="checkbox"] {
      margin-right: 8px;
    }
    
    .shared-only-container label {
      font-size: 14px;
      color: #333;
      cursor: pointer;
      font-family: 'Pretendard' !important;
      font-weight: 600;
    }
    
    /* 상단 버튼 스타일 */
    .fc .fc-button {
      background-color: #84a98c;
      color: white;
      border: none;
      border-radius: 5px;
      padding: 8px 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-weight: 600;
      font-size: 14px;
    }
    
    .fc .fc-button:hover {
      color: white;
      background-color: #6b8e76;
      border: none;
      font-size: 14px;
    }
    
		/* '오늘' 버튼 스타일 */
		/* .fc .fc-today-button {
		  background-color: #e9ecef;
		  color: #333;
		} */
		
		.fc .fc-today-button:hover {
		  background-color: #26292a;  
		  color: #fff;
		}
    
    .fc .fc-button-primary:not(:disabled).fc-button-active,
    .fc .fc-button-primary:not(:disabled):active {
      background-color: #5d7d64;
      color: white;
    }
		.modal-content {
		  background-color: white;
		}
		
		/* 모달 애니메이션 추가 */
		.modal.fade .modal-dialog {
		  transition: transform .3s ease-out;
		  transform: translate(0,-50px);
		} 
		
		.header .h2 {
		  margin-right: auto;
		}
	/* 	 .home-icon { 
	    font-size: 24px; 
	    color: #cecece; 
	  }
	  
	  .home-icon:hover { color: #c6c6c6; } */
	  
		.help-icon {
		  font-size: 24px;
		  color: #808080;
		  cursor: pointer;
		  margin-left: 5px;
		}
		
		.help-icon:hover {
		  color: #666666;
		}
		
		/* 모달 중앙 배치를 위한 스타일 */
		.modal-dialog {
		  display: flex;
		  align-items: center;
		  min-height: calc(100% - 1rem);
		}
		
		@media (min-width: 576px) {
		  .modal-dialog {
		    max-width: 500px;
		    margin: 1.75rem auto;
		  }
		}
		
		
  </style>
  <script>
	  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var showSharedOnly = false;
	    
	 		// 모달 닫기 기능 수정
      $('.close, .modal').on('click', function(e) {
        if (e.target === this) {
          $('#eventModal').modal('hide');
        }
      });
	 		
      // 공유 버튼 체크박스 기능 추가
      $('#showSharedOnly').change(function() {
        showSharedOnly = $(this).is(':checked');
        calendar.refetchEvents();
      });
      
      // 모달 애니메이션 제거
      /* $('#eventModal').on('show.bs.modal', function (e) {
        $(this).removeClass('fade');
      });
	     */
	    
	    var calendar = new FullCalendar.Calendar(calendarEl, {
    	 initialView: 'dayGridMonth',
    	  headerToolbar: {
    	    left: 'prev,next today',
    	    center: 'title',
    	    right: 'dayGridMonth,timeGridWeek,timeGridDay'
    	  },
    	  buttonText: {
    	    today: '오늘',
    	    month: '월',
    	    week: '주',
    	    day: '일'
    	  },
    	  events: function(info, successCallback, failureCallback) {
    		  $.ajax({
    		    url: '${ctp}/calendar/calendarListAll',
    		    type: 'POST',
    		    dataType: 'json',
    		    success: function(res) {
    		      var events = res.map(function(event) {
    		        return {
    		          id: event.idx,
    		          title: event.title,
    		          start: event.startTime,
    		          end: event.endTime,
    		          allDay: event.allDay,
    		          description: event.description,
    		          sharing: event.sharing,
    		          memberId: event.memberId,
    		          color: event.sharing ? '#84a98c' : '#8c9daa'
    		        };
    		      });
    		      
    		      // 체크박스 상태에 따라 이벤트 필터링
    		      if (showSharedOnly) {
    		        events = events.filter(function(event) {
    		          return event.sharing;
    		        });
    		      }
    		      
    		      successCallback(events);
    		    },
    		    error: function(jqXHR, textStatus, errorThrown) {
    		      console.error("AJAX error: " + textStatus + ' : ' + errorThrown);
    		      failureCallback("Error fetching events.");
    		    }
    		  });
    		},
	      editable: true,
	      selectable: true,
	      select: function(info) {
	        openEventModal(null, info.startStr, info.endStr, info.allDay);
	      },
	      eventClick: function(info) {
	          openEventModal(info.event);
	        },
	        eventDrop: function(info) {
        	  var updatedEvent = {
	      	    idx: info.event.id,
	      	    title: info.event.title,
	      	    startTime: info.event.start.toISOString(),
	      	    endTime: info.event.end ? info.event.end.toISOString() : info.event.start.toISOString(),
	      	    allDay: info.event.allDay,
	      	    description: info.event.extendedProps.description,
	      	    sharing: info.event.extendedProps.sharing
        	  };
        	  updateEvent(updatedEvent);
        	},
        	eventResize: function(info) {
        	  var updatedEvent = {
        	    idx: info.event.id,
        	    title: info.event.title,
        	    startTime: info.event.start.toISOString(),
        	    endTime: info.event.end.toISOString(),
        	    allDay: info.event.allDay,
        	    description: info.event.extendedProps.description,
        	    sharing: info.event.extendedProps.sharing
        	  };
        	  updateEvent(updatedEvent);
        	}
	      });
	      calendar.render();
	
	   		// 체크박스 이벤트 리스너 추가
	      $('#showSharedOnly').change(function() {
	        showSharedOnly = $(this).is(':checked');
	        calendar.refetchEvents();
	      });
	      
	      
	      function openEventModal(event, start, end, allDay) {
	    	  $('#eventModal').modal('show');
	    	  $('#modalTitle').text(event ? '일정 상세' : '일정 등록');
	    	  
	    	  const isAuthor = event ? (event.extendedProps.memberId === '${sMid}') : true;
	    	  const isNewEvent = !event;

	    	  $('#eventId').val(event ? event.id : '');
	    	  $('#eventTitle').val(event ? event.title : '').prop('readonly', !isAuthor);
	    	  $('#eventAllDay').prop('checked', event ? event.allDay : allDay).prop('disabled', !isAuthor);
	    	  $('#eventStart').val(event ? moment(event.start).format('YYYY-MM-DD') : moment(start).format('YYYY-MM-DD')).prop('readonly', !isAuthor);
	    	  $('#eventEnd').val(event ? moment(event.end).format('YYYY-MM-DD') : moment(end).format('YYYY-MM-DD')).prop('readonly', !isAuthor);
	    	  $('#eventStartTime').val(event ? moment(event.start).format('HH:mm') : '09:00').prop('readonly', !isAuthor);
	    	  $('#eventEndTime').val(event ? moment(event.end).format('HH:mm') : '18:00').prop('readonly', !isAuthor);
	    	  $('#eventDescription').val(event ? event.extendedProps.description : '').prop('readonly', !isAuthor);
	    	  $('#eventSharing').prop('checked', event ? event.extendedProps.sharing : false).prop('disabled', !isAuthor);
	    	  $('#eventAuthor').text(event ? '작성자: ' + event.extendedProps.memberId : '');

	    	  // 저장/수정 버튼 설정
	    	  if (isAuthor) {
	    	    $('#saveEvent').show();
	    	    $('#saveEvent').text(isNewEvent ? '저장' : '수정');
	    	  } else {
	    	    $('#saveEvent').hide();
	    	  }
	    	  
	    	  // 삭제 버튼 설정 (새 이벤트가 아니고 작성자인 경우에만 표시)
	    	  $('#deleteEvent').toggle(!isNewEvent && isAuthor);

	    	  toggleAllDay();

	    	  if (event && isAuthor) {
	    	    $('#deleteEvent').show().removeClass('btn-secondary').addClass('btnDanger');
	    	    $('#deleteEvent').off('click').on('click', function() {
	    	      if (confirm('이 일정을 삭제하시겠습니까?')) {
	    	        deleteEvent(event.id);
	    	      }
	    	    });
	    	  } else {
	    	    $('#deleteEvent').hide();
	    	  }
	    	}

	        $('#saveEvent').click(function() {
	          if (!validateEventForm()) {
	            return;
	          }

	          var event = {
	            idx: $('#eventId').val(),
	            title: $('#eventTitle').val(),
	            startTime: $('#eventAllDay').prop('checked') ? $('#eventStart').val() : $('#eventStart').val() + 'T' + $('#eventStartTime').val(),
	            endTime: $('#eventAllDay').prop('checked') ? $('#eventEnd').val() : $('#eventEnd').val() + 'T' + $('#eventEndTime').val(),
	            allDay: $('#eventAllDay').prop('checked'),
	            description: $('#eventDescription').val(),
	            sharing: $('#eventSharing').prop('checked')
	          };

	          $.ajax({
	            url: event.idx ? '${ctp}/calendar/calendarUpdate' : '${ctp}/calendar/calendarInput',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(event),
	            success: function(res) {
	              if(res === '1') {
	                $('#eventModal').modal('hide');
	                calendar.refetchEvents();
	              } else {
	                alert('일정 저장에 실패했습니다. 오류: ' + res);
	              }
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	              console.error("AJAX error: " + textStatus + ' : ' + errorThrown);
	              alert('서버와의 통신 중 오류가 발생했습니다. 오류: ' + jqXHR.responseText);
	            }
	          });
	        });
	    
	        function toggleAllDay() {
        	  const isAllDay = $('#eventAllDay').prop('checked');
        	  $('#eventStartTime, #eventEndTime').closest('div').toggle(!isAllDay);
        	}
	        
	        $('#eventAllDay').change(toggleAllDay);
	        
	    function updateEvent(event) {
	      var updatedEvent = {
	        idx: event.id,
	        title: event.title,
	        startTime: event.start.toISOString(),
	        endTime: event.end ? event.end.toISOString() : event.start.toISOString(),
	        allDay: event.allDay,
	        description: event.extendedProps.description,
	        sharing: event.extendedProps.sharing,
	        repeatType: event.extendedProps.repeatType
	      };
	
	      $.ajax({
	        url: '${ctp}/calendar/calendarUpdate',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify(updatedEvent),
	        success: function(res) {
	          if(res === '1') {
	            calendar.refetchEvents();
	          } else {
	            alert('일정 수정에 실패했습니다.');
	          }
	        },
	        error: function() {
	          alert('서버와의 통신 중 오류가 발생했습니다.');
	        }
	      });
	    }
	
	    function deleteEvent(eventId) {
	      $.ajax({
	        url: '${ctp}/calendar/calendarDelete',
	        type: 'POST',
	        data: { idx: eventId },
	        success: function(res) {
	          if(res === '1') {
	            $('#eventModal').modal('hide');
	            calendar.refetchEvents();
	          } else {
	            alert('일정 삭제에 실패했습니다.');
	          }
	        },
	        error: function() {
	          alert('서버와의 통신 중 오류가 발생했습니다.');
	        }
	      });
	    }
	
	    function validateEventForm() {
	      if (!$('#eventTitle').val()) {
	        alert('제목을 입력해주세요.');
	        return false;
	      }
	      if (!$('#eventStart').val()) {
	        alert('시작일을 입력해주세요.');
	        return false;
	      }
	      if (!$('#eventEnd').val()) {
	        alert('종료일을 입력해주세요.');
	        return false;
	      }
	      if (new Date($('#eventEnd').val()) < new Date($('#eventStart').val())) {
	        alert('종료일은 시작일보다 이후여야 합니다.');
	        return false;
	      }
	      return true;
	    }
	    
	 		// 도움말 아이콘 클릭 이벤트
	    $('#helpIcon').click(function() {
	      $('#helpModal').modal('show');
	    });
	    
	    
	  });
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
  <div class="calendarContainer">
  	<div class="mb-3 header">
		  <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
		  <font size="5" class="mb-4 h2">일정관리</font>
		 <!--  <i class="fas fa-info-circle help-icon" id="helpIcon"></i> -->
			<i class="fa-regular fa-circle-question help-icon" id="helpIcon"></i>
		</div>
    <div class="shared-only-container">
      <input type="checkbox" id="showSharedOnly" />
      <label for="showSharedOnly">공유 일정만 보기</label>
    </div>
    <div id='calendar'></div>
    <div class="calendar-legend">
      <div class="legend-item">
        <span class="legend-color" style="background-color: #84a98c;"></span>
        공유된 일정
      </div>
      <div class="legend-item">
        <span class="legend-color" style="background-color: #8c9daa;"></span>
        개인 일정
      </div>
    </div>
  </div>
	
	<!-- Event Modal -->
	<div class="modal fade" id="eventModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modalTitle">일정 등록</h5>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        <input type="hidden" id="eventId">
	        <div class="form-group">
	          <label for="eventTitle">제목:</label>
	          <input type="text" class="form-control" id="eventTitle" required>
	        </div>
	        <div class="form-check mb-3">
	          <input type="checkbox" class="form-check-input" id="eventAllDay" onchange="toggleAllDay()">
	          <label class="form-check-label" for="eventAllDay">하루종일</label>
	        </div>
	        <div class="form-group">
	          <label for="eventStart">시작일:</label>
	          <input type="date" class="form-control" id="eventStart" required>
	        </div>
	        <div class="form-group">
	          <label for="eventStartTime">시작 시간:</label>
	          <input type="time" class="form-control" id="eventStartTime">
	        </div>
	        <div class="form-group">
	          <label for="eventEnd">종료일:</label>
	          <input type="date" class="form-control" id="eventEnd" required>
	        </div>
	        <div class="form-group">
	          <label for="eventEndTime">종료 시간:</label>
	          <input type="time" class="form-control" id="eventEndTime">
	        </div>
	        <div class="form-group">
	          <label for="eventDescription">설명:</label>
	          <textarea class="form-control" id="eventDescription" rows="3"></textarea>
	        </div>
	        <div class="form-check mb-3">
	          <input type="checkbox" class="form-check-input" id="eventSharing">
	          <label class="form-check-label" for="eventSharing">가족 공유</label>
	        </div>
	        <div id="eventAuthor"></div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="modalBtn btnPrimary" id="saveEvent">저장</button>
	        <button type="button" class="modalBtn btnDanger" id="deleteEvent">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 도움말 메시지를 위한 모달 -->
	<div class="modal fade" id="helpModal" tabindex="-1" role="dialog" aria-labelledby="helpModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="helpModalLabel">캘린더 사용 안내</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <ul>
	          <li>빈 칸을 클릭하면 새로운 일정을 등록할 수 있습니다.</li>
	          <li>등록된 일정을 클릭하면 상세 정보를 볼 수 있습니다.</li>
	          <li>자신이 작성한 일정은 상세 보기에서 수정 및 삭제가 가능합니다.</li>
	          <li>일정을 드래그하여 날짜를 변경할 수 있습니다.</li>
	          <li>일정의 끝을 드래그하여 기간을 조정할 수 있습니다.</li>
	          <li>'공유 일정만 보기' 체크박스를 통해 공유된 일정만 필터링할 수 있습니다.</li>
	        </ul>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>