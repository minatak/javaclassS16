<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Calendar</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
  <style>
    body, .modal { font-family: 'pretendard' !important; }
  /*   #calendar { max-width: 900px; margin: 0 auto; } */
    #eventModal .modal-body > div { margin-bottom: 10px; }
    .home-icon { 
      font-size: 24px; 
      color: #adb5bd; 
      /* top: 20px; */
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
	    /* padding-top: 60px; */
	  /*   text-align: center; */
	    max-width: 800px;
	    margin: 0 auto;
    }
    h2, h3, h4, h5 {
    	font-weight:600 !important;
    }
    .header {
    	font-weight:600 !important;
    }
  </style>
  <script>
	  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      initialView: 'dayGridMonth',
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridWeek,timeGridDay'
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
	
	      function openEventModal(event, start, end, allDay) {
	    	  $('#eventModal').modal('show');
	    	  $('#modalTitle').text(event ? '일정 수정' : '일정 등록');
	    	  $('#eventId').val(event ? event.id : '');
	    	  $('#eventTitle').val(event ? event.title : '');
	    	  $('#eventAllDay').prop('checked', event ? event.allDay : allDay);
	    	  $('#eventStart').val(event ? moment(event.start).format('YYYY-MM-DD') : moment(start).format('YYYY-MM-DD'));
	    	  $('#eventEnd').val(event ? moment(event.end).format('YYYY-MM-DD') : moment(end).format('YYYY-MM-DD'));
	    	  $('#eventStartTime').val(event ? moment(event.start).format('HH:mm') : '09:00');
	    	  $('#eventEndTime').val(event ? moment(event.end).format('HH:mm') : '18:00');
	    	  $('#eventDescription').val(event ? event.extendedProps.description : '');
	    	  $('#eventSharing').prop('checked', event ? event.extendedProps.sharing : false);
	    	  $('#eventAuthor').text(event ? '작성자: ' + event.extendedProps.memberId : '');
	    	  
	    	  toggleAllDay();  

	    	  if (event) {
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
	            var isAllDay = $('#eventAllDay').prop('checked');
	            $('#eventStartTime, #eventEndTime').prop('disabled', isAllDay);
	            if (isAllDay) {
	              $('#eventStartTime, #eventEndTime').val('');
	            } else {
	              $('#eventStartTime').val('09:00');
	              $('#eventEndTime').val('18:00');
	            }
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
	
	    function createRepeatingEvents(event) {
	      var startDate = moment(event.startTime);
	      var endDate = moment(event.endTime);
	      var repeatEvents = [];
	
	      switch(event.repeatType) {
	        case 'daily':
	          for (var i = 0; i < 365; i++) {
	            repeatEvents.push({
	              title: event.title,
	              start: startDate.clone().add(i, 'days'),
	              end: endDate.clone().add(i, 'days'),
	              allDay: event.allDay,
	              extendedProps: {
	                description: event.description,
	                sharing: event.sharing,
	                repeatType: event.repeatType
	              }
	            });
	          }
	          break;
	        case 'weekly':
	          for (var i = 0; i < 52; i++) {
	            repeatEvents.push({
	              title: event.title,
	              start: startDate.clone().add(i, 'weeks'),
	              end: endDate.clone().add(i, 'weeks'),
	              allDay: event.allDay,
	              extendedProps: {
	                description: event.description,
	                sharing: event.sharing,
	                repeatType: event.repeatType
	              }
	            });
	          }
	          break;
	        case 'monthly':
	          for (var i = 0; i < 12; i++) {
	            repeatEvents.push({
	              title: event.title,
	              start: startDate.clone().add(i, 'months'),
	              end: endDate.clone().add(i, 'months'),
	              allDay: event.allDay,
	              extendedProps: {
	                description: event.description,
	                sharing: event.sharing,
	                repeatType: event.repeatType
	              }
	            });
	          }
	          break;
	      }
	
	      repeatEvents.forEach(function(event) {
	        calendar.addEvent(event);
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
			    <label for="eventAllDay">종일:</label>
			    <input type="checkbox" id="eventAllDay">
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
			    <label for="eventRepeat">반복:</label>
			    <select class="form-control" id="eventRepeat">
			      <option value="none">반복안함</option>
			      <option value="daily">매일</option>
			      <option value="weekly">매주</option>
			      <option value="monthly">매달</option>
			      <option value="yearly">매년</option>
			    </select>
			  </div>
			  <div id="repeatEndDateDiv" style="display:none;">
			    <label for="eventRepeatEndDate">반복 종료일:</label>
			    <input type="date" class="form-control" id="eventRepeatEndDate">
			  </div>
			  <div>
			    <label for="eventDescription">설명:</label>
			    <textarea class="form-control" id="eventDescription" rows="3"></textarea>
			  </div>
			  <div>
			    <label for="eventSharing">공개:</label>
			    <input type="checkbox" id="eventSharing">
			  </div>
			  <div id="eventAuthor" class="mt-2"></div>
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-primary" id="saveEvent">저장</button>
			  <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
			  <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>