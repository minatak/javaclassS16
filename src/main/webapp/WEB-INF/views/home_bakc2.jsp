<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Family Note</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://webfontworld.github.io/SCoreDream/SCoreDream.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>
<style>
   .serviceCard {
	    cursor: pointer;
	    text-align: center;
	    border: 1px solid #e7e7e7;
	    border-radius: 8px;
	    padding: 20px;
	    transition: transform 0.2s;
    }
    .serviceCard:hover {
   		transform: scale(1.05);
    }
    .content {
	    margin-left: 300px;
	    padding: 20px;
	    padding-top: 60px;
	    text-align: center;
	    max-width: 900px;
	    margin: 0 auto;
    }
    .family-schedule {
    background: #fff;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    }
</style>
<script>
    'use strict';
 
        /* full calender */
     
    (function(){
       $(function(){
         // calendar element 취득
         var calendarEl = $('#calendar')[0];
         // full-calendar 생성하기
         var calendar = new FullCalendar.Calendar(calendarEl, {
           height: '700px', // calendar 높이 설정
           expandRows: true, // 화면에 맞게 높이 재설정
           slotMinTime: '05:00', // Day 캘린더에서 시작 시간
           slotMaxTime: '24:00', // Day 캘린더에서 종료 시간
           // 해더에 표시할 툴바
           headerToolbar: {
             left: 'prev,next today',
             center: 'title',
             right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
           },
           initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
            // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
           navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
           editable: true, // 수정 가능?
           selectable: true, // 달력 일자 드래그 설정가능
           nowIndicator: true, // 현재 시간 마크
           dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
           locale: 'ko', // 한국어 설정
           eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트  
               console.log(obj);
           },
           eventChange: function(info) { // 이벤트가 수정되면 발생하는 이벤트
                   var idx = info.event.extendedProps.idx; 
                       var title = info.event.title;
                  var start = info.event.start;
                  var end = info.event.end;
                  var allDay = info.event.allDay;
                  // 서버로 수정된 일정 정보를 전송
                  $.ajax({
                      type: "POST",
                      url: "${ctp}/calendar/calendarUpdate", // 서버 측 스크립트의 URL
                      data: {
                              idx : idx,
                              title: title,
                          start: start,
                          end: end,
                          allDay: allDay
                      },
                      success: function(res) {
                          if (res != "0") {
                              alert("일정이 수정되었습니다.");
                              location.reload();
                          } else {
                              alert("일정 수정 실패");
                          }
                      },
                      error: function() {
                          alert("연결오류~");
                      }
                  });
             console.log("수정");
           },
           eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
             console.log(obj);
           },
           select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
             var title = [안내]태그제한으로등록되지않습니다('일정을 입력하세요:');
             if (title) {
               calendar.addEvent({
                 title: title,
                 start: arg.start,
                 end: arg.end,
                 allDay: arg.allDay
               });
               
               $.ajax({
                   type: "POST",
                   url: "${ctp}/calendar/calendarInput", // 서버 측 스크립트의 URL
                   data: {
                           title: title,
                           start: arg.start.toISOString(),  
                       end: arg.end.toISOString(),      
                       allDay: arg.allDay
                       
                   },
                   success: function(res) {
                       if (res != "0" ){
                           alert("일정이 저장되었습니다");
                           location.reload();
                      } else  {
                          alert("일정 저장 실패");
                      }
                   },
                   error: function() {
                       alert("연결오류~");
                   }
               });
             }
             calendar.unselect();
           },
           // 이벤트 
           events: function(fetchInfo, successCallback, failureCallback) {
                $.ajax({
                    url: "${ctp}/calendar/calendarListAll",
                    type: "POST",
                    dataType: "json",
                    success: function(data) {
                        data.forEach(function(vo) {
                            calendar.addEvent({
                                idx: vo.idx, // 이벤트의 고유 ID
                                title: vo.title,
                                start: vo.startTime,
                                end: vo.endTime,
                                allDay: vo.allDay
                            });
                        });
                        successCallback([]);
                    },
                    error: function() {
                        failureCallback("연결 오류~");
                    }
                });
            },
           eventClick: function(info) {
             if (confirm‎('정말로 이 일정을 삭제하시겠습니까?')) {
               info.event.remove(); // 이벤트 삭제
               
            // 이벤트 속성 값 가져오기
               var title = info.event.title;
               // 한국 표준시(KST)로 변환
               var options = { timeZone: 'Asia/Seoul', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
               var start = new Date(info.event.start).toLocaleString('ko-KR', options).replace(/\. /g, '-').replace('.', '');
               var end = info.event.end ? new Date(info.event.end).toLocaleString('ko-KR', options).replace(/\. /g, '-').replace('.', '') : null;
               var allDay = info.event.allDay;
               
               $.ajax({
                   type: "POST",
                   url: "${ctp}/calendar/calendarDelete", // 서버 측 스크립트의 URL
                   data: {
                           title: title,
                       start: start,
                       end: end,
                       allDay: allDay
                   },
                   success: function(res) {
                       if (res != "0" ){
                           alert("일정이 삭제되었습니다.");
                             location.reload();
                      } else  {
                          alert("일정 삭제 실패");
                      }
                   },
                   error: function() {
                       alert("연결오류~");
                   }
               });
               
             }
           }
         });
         // 캘린더 랜더링
         calendar.render();
        
       });
     })();    
</script>

</head>
<body class="w3-light-grey w3-content" style="max-width:1600px">

<!-- Navigation -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- Sidebar/menu -->
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<main class="w3-main content">

    <!-- Main Content -->
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 content">
        <div class="family-schedule">
            <h2>가족 일정 한눈에 보기</h2>
            <p>가족들의 중요한 일정을 한눈에 확인할 수 있습니다.</p>
            <!-- 가족 일정 내용 추가 -->
            <div id='calendar-container'>
					    <div id='calendar'>
					    </div>
					</div>
					 
            </div>  
                <div class="row mb-4">
                    <div class="col-12">
                    <div class="family-schedule">
                        <h4 class="border-bottom pb-2">공지사항 0개</h4>
                        <p>작성된 알림장이 없습니다.</p>
                    </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                    <div class="family-schedule">
                        <h4 class="border-bottom pb-2">추억 앨범 0개</h4>
                        <p>작성된 앨범이 없습니다.</p>
                    </div>
                </div>
            </div>
        </main>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-calendar fa-2x"></i>
                    <h4 class="mt-2">일정 관리</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-tasks fa-2x"></i>
                    <h4 class="mt-2">가사 분담</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-bullhorn fa-2x"></i>
                    <h4 class="mt-2">공지사항</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-shopping-cart fa-2x"></i>
                    <h4 class="mt-2">쇼핑 리스트</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-poll fa-2x"></i>
                    <h4 class="mt-2">가족 투표</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="serviceCard">
                    <i class="fa fa-photo fa-2x"></i>
                    <h4 class="mt-2">앨범</h4>
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </main>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
