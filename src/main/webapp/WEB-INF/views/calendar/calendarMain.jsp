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
    body, .modal { font-family: 'pretendard' !important; }
    #eventModal .modal-body > div { margin-bottom: 10px; }
    .home-icon { 
      font-size: 24px; 
      color: #cecece; 
    }
    .modal-header { 
      justify-content: center; 
      position: relative;
    }
    .modal-title {
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }
    .calendarContainer {
    	margin-left: 300px;
	    padding: 20px;
	    max-width: 850px;
	    margin: 0 auto;
    }
    h2, h3, h4, h5 {
    	font-weight:600 !important;
    }
    .header {
    	font-weight:600 !important;
    }
    
    /* ---- 캘린더 UI 변경 ---- */
    
		.fc {
		  font-family: 'Pretendard', sans-serif;
		  max-width: 900px;
		  margin: 0 auto;
		  background-color: white;
		}
		
		.fc .fc-day-today {
		  background-color: white !important;
		}
		
		/* 헤더 스타일 */
		.fc .fc-toolbar.fc-header-toolbar {
		  margin-bottom: 1.5em;
		}
		
		.fc .fc-toolbar-title {
		  font-size: 1.5em;
		  font-weight: bold;
		  color: #333;
		}
		
		/* 버튼 스타일 */
		.fc .fc-button {
		  background-color: white;
		  border: 1px solid #cecece;
		  color: #333;
		  /* text-transform: capitalize; */
		  font-weight: normal;
		  padding: 0.3em 1.5em;
		  margin: 0 4px;
		 /*  transition: all 0.3s ease; */
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
		
		.fc .fc-button:focus {
		  box-shadow: none;
		}
		
		/* 날짜 셀 스타일 */
		.fc .fc-daygrid-day-number {
		  font-size: 1em;
		  padding: 0.4em;
		  color: #333;
		}
		
		/* 오늘 날짜 스타일 */
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

		
		/* 날짜 선택시 스타일 */
		.fc .fc-highlight {
		  background-color: #e9ecef;
		  opacity: 0.7;
		}
		
		/* 테두리 색상 */
		.fc th, .fc td {
		  border-color: #e9ecef;
		}
		
		/* 요일 헤더 */
		.fc .fc-col-header-cell-cushion {
		  color: #495057;
		  font-weight: bold;
		}
		
		/* 이벤트 스타일 */
		.fc-event {
		  background-color: #4dabf7;
		  border: none;
		  padding: 2px 4px;
		}
		
		.fc-event-title {
		  font-weight: normal;
		}
		
		.fc .fc-button-primary:focus,
		.fc .fc-button-primary:not(:disabled):active:focus {
		  box-shadow: none;
		}
		
		.fc .fc-button-group > .fc-button {
		  margin: 0;
		}
		
		#eventModal .btn {
		  border-radius: 7px;
		}
		
		/* 모달 버튼 스타일 */
		#eventModal .btn-primary,
		#eventModal .btn-danger {
		  background-color: #333;
		  border-color: #333;
		  color: white;
		}
		
		#eventModal .btn-primary:hover,
		#eventModal .btn-danger:hover {
		  background-color: #555;
		  border-color: #555;
		}
  </style>
  <script>
	  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var showSharedOnly = false;
	    
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
	    	          color: event.sharing ? '#84a98c' : '#829aae'
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
	    	    $('#deleteEvent').show().removeClass('btn-secondary').addClass('btn-danger');
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
	        
	        /* function toggleAllDay() {
	            var isAllDay = $('#eventAllDay').prop('checked');
	            $('#eventStartTime, #eventEndTime').prop('disabled', isAllDay);
	            if (isAllDay) {
	              $('#eventStartTime, #eventEndTime').val('');
	            } else {
	              $('#eventStartTime').val('09:00');
	              $('#eventEndTime').val('18:00');
	            }
	          } */
	        
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
	  });
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
	<div class="calendarContainer">
	  <a href="${ctp}/" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	  <font size="5" class="mb-4 header">일정관리</font>
	  <div class="text-right">
		  <input type="checkbox" id="showSharedOnly"/>공유 일정만 보기
		</div>
	  <hr/>
	  <div id='calendar' class="mt-4"></div>
	</div>
</div>
<!-- 일정 입력/수정 모달 -->
<div class="modal fade" id="eventModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title mb-5" id="modalTitle"><b>일정 등록</b></h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="eventId">
        <div>
          <label for="eventTitle">제목:</label>
          <input type="text" class="form-control" id="eventTitle" required>
        </div>
        <div>
          <input type="checkbox" id="eventAllDay" onchange="toggleAllDay()">
          <label for="eventAllDay">하루종일</label>
        </div>
        <div>
          <label for="eventStart">시작일:</label>
          <input type="date" class="form-control" id="eventStart" required>
        </div>
        <div>
          <label for="eventStartTime">시작 시간:</label>
          <input type="time" class="form-control" id="eventStartTime">
        </div>
        <div>
          <label for="eventEnd">종료일:</label>
          <input type="date" class="form-control" id="eventEnd" required>
        </div>
        <div>
          <label for="eventEndTime">종료 시간:</label>
          <input type="time" class="form-control" id="eventEndTime">
        </div>
        <div>
          <label for="eventDescription">설명:</label>
          <textarea class="form-control" id="eventDescription" rows="3"></textarea>
        </div>
        <div>
          <input type="checkbox" id="eventSharing">
          <label for="eventSharing">가족 공유</label>
        </div>
        <div id="eventAuthor" class="mt-2"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="saveEvent">저장</button>
        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>