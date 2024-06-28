<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Family Note</title>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<style>
    body, a {
        font-family: 'SCoreDream', sans-serif;
        font-weight: 300;
    }
    h1, h2, h3, h4, h5 {
        font-family: 'SCoreDream', sans-serif;
        font-weight: 500;
    }
    .profile-img {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: #ddd;
    }
    .profile-dropdown img {
        border-radius: 50%;
        width: 40px;
        height: 40px;
        object-fit: cover;
    }
    /* Main Content */
		main {
		    margin-left: 250px;
		    padding: 20px;
		}
		
		.family-schedule h4 {
		    font-weight: bold;
		}
		
		.family-schedule p {
		    color: #666;
		}
		
		.serviceCard {
		    border: 1px solid #dee2e6;
		    border-radius: 5px;
		    padding: 20px;
		    transition: transform 0.2s;
		    cursor: pointer;
		}
		
		.serviceCard:hover {
		    transform: translateY(-5px);
		}
		
		.serviceCard .card-title {
		    font-size: 1.25rem;
		    color: #007bff;
		}
		
		.serviceCard .card-text {
		    color: #666;
		}
		
		.serviceCard .icon-container {
		    font-size: 2rem;
		    color: #35ae5f;
		}

</style>
<script>
    'use strict';
    (function(){
       $(function(){
         var calendarEl = $('#calendar')[0];
         var calendar = new FullCalendar.Calendar(calendarEl, {
           height: '700px',
           expandRows: true,
           slotMinTime: '05:00',
           slotMaxTime: '24:00',
           headerToolbar: {
             left: 'prev,next today',
             center: 'title',
             right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
           },
           initialView: 'dayGridMonth',
           navLinks: true,
           editable: true,
           selectable: true,
           nowIndicator: true,
           dayMaxEvents: true,
           locale: 'ko',
           eventAdd: function(obj) {
               console.log(obj);
           },
           eventChange: function(info) {
                   var idx = info.event.extendedProps.idx; 
                   var title = info.event.title;
                   var start = info.event.start;
                   var end = info.event.end;
                   var allDay = info.event.allDay;
                   $.ajax({
                      type: "POST",
                      url: "${ctp}/calendar/calendarUpdate",
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
           },
           eventRemove: function(obj){
             console.log(obj);
           },
           select: function(arg) {
             var title = prompt('일정을 입력하세요:');
             if (title) {
               calendar.addEvent({
                 title: title,
                 start: arg.start,
                 end: arg.end,
                 allDay: arg.allDay
               });
               $.ajax({
                   type: "POST",
                   url: "${ctp}/calendar/calendarInput",
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
           events: function(fetchInfo, successCallback, failureCallback) {
                $.ajax({
                    url: "${ctp}/calendar/calendarListAll",
                    type: "POST",
                    dataType: "json",
                    success: function(data) {
                        data.forEach(function(vo) {
                            calendar.addEvent({
                                idx: vo.idx,
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
             if (confirm('정말로 이 일정을 삭제하시겠습니까?')) {
               info.event.remove();
               var title = info.event.title;
               var options = { timeZone: 'Asia/Seoul', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
               var start = new Date(info.event.start).toLocaleString('ko-KR', options).replace(/\. /g, '-').replace('.', '');
               var end = info.event.end ? new Date(info.event.end).toLocaleString('ko-KR', options).replace(/\. /g, '-').replace('.', '') : start;
               var allDay = info.event.allDay;
               $.ajax({
                   type: "POST",
                   url: "${ctp}/calendar/calendarDelete",
                   data: {
                       title: title,
                       start: start,
                       end: end,
                       allDay: allDay
                   },
                   success: function(res) {
                       if (res != "0") {
                           alert("일정이 삭제되었습니다.");
                           location.reload();
                       } else {
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

<!-- !PAGE CONTENT! -->
<main class="w3-main" style="margin-left:300px">

<!-- Main Content -->
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 content">
    <div class="family-schedule">
    <h2>가족 일정 한눈에 보기</h2>
    <p>가족들의 중요한 일정을 한눈에 확인할 수 있습니다.</p>
    <!-- 가족 일정 내용 추가 -->
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

<!-- Cards Section -->
<div class="row gx-5">
    <div class="col-lg-4 mb-5">
        <div class="serviceCard" onclick="location.href='#'">
            <div class="card-body p-4 text-center">
                <h4><a class="card-title mb-3" href="MemberList.mem">공지사항</a></h4>
                <p class="card-text mb-0 mt-3">공지 확인부터 투표 참여까지 한 번에</p>
            </div>
            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                <div class="d-flex justify-content-center">
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-4 mb-5">
        <div class="serviceCard" onclick="location.href='#'">
            <div class="card-body p-4 text-center">
                <h4><a class="card-title mb-3" href="ChatMain.chat">앨범</a></h4>
                <p class="card-text mb-0 mt-3">가족들의 사진 모아보기</p>
            </div>
            <div class="card-footer p-3 pt-0 bg-transparent border-top-0">
                <div class="d-flex justify-content-center">
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-4 mb-5">
        <div class="serviceCard" onclick="location.href='#'">
            <div class="card-body p-3 text-center">
                <h4><a class="card-title mb-3" href="VocaMain.st">일정관리</a></h4>
                <p class="card-text mb-3 mt-3">생일, 기념일 등 가족 이벤트를 계획하고 관리할 수 있음</p>
            </div>
            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                <div class="d-flex justify-content-center">
                    <div class="icon-container">
                        <i class="fa-solid fa-arrow-right" style="color:#35ae5f"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card col-md-9 ml-sm-auto col-lg-10 px-md-4 content text-center"></div>
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="serviceCard">
                <i class="fa fa-calendar fa-2x"></i>
                <h4 class="mt-2">일정 관리</h4>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="serviceCard">
                <i class="fa fa-tasks fa-2x"></i>
                <h4 class="mt-2">가사 분담</h4>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="serviceCard">
                <i class="fa fa-bullhorn fa-2x"></i>
                <h4 class="mt-2">공지사항</h4>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="serviceCard">
                <i class="fa fa-shopping-cart fa-2x"></i>
                <h4 class="mt-2">쇼핑 리스트</h4>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="serviceCard">
                <i class="fa fa-poll fa-2x"></i>
                <h4 class="mt-2">가족 투표</h4>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="serviceCard">
                <i class="fa fa-photo fa-2x"></i>
                <h4 class="mt-2">앨범</h4>
            </div>
        </div>
    </div>
</div>
</main>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
