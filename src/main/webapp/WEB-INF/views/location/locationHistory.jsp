<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위치 기록 | HomeLink</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
        .location-history { margin-top: 20px; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<div class="container mt-5">
    <h2>위치 기록</h2>
    
    <div class="form-group">
        <label for="memberSelect">가족 구성원:</label>
        <select class="form-control" id="memberSelect">
            <option value="all">전체</option>
            <!-- 가족 구성원 옵션이 여기에 동적으로 추가됩니다 -->
        </select>
    </div>
    
    <div class="form-group">
        <label for="dateSelect">날짜:</label>
        <input type="date" class="form-control" id="dateSelect">
    </div>
    
    <button class="btn btn-primary" onclick="searchLocationHistory()">검색</button>
    
    <div class="location-history">
        <h4>위치 기록</h4>
        <ul id="locationHistory" class="list-group">
            <!-- 위치 기록이 여기에 동적으로 추가됩니다 -->
        </ul>
    </div>
</div>

<script>
function loadFamilyMembers() {
    $.ajax({
        url: "${ctp}/family/members",
        type: "GET",
        success: function(response) {
            var select = $("#memberSelect");
            for (var i = 0; i < response.length; i++) {
                var member = response[i];
                select.append('<option value="' + member.idx + '">' + member.name + '</option>');
            }
        },
        error: function() {
            alert("가족 구성원 정보를 불러오는데 실패했습니다.");
        }
    });
}

function searchLocationHistory() {
    var memberIdx = $("#memberSelect").val();
    var date = $("#dateSelect").val();
    
    $.ajax({
        url: "${ctp}/location/history",
        type: "GET",
        data: { memberIdx: memberIdx, date: date },
        success: function(response) {
            updateLocationHistory(response);
        },
        error: function() {
            alert("위치 기록을 불러오는데 실패했습니다.");
        }
    });
}

function updateLocationHistory(history) {
    var list = $("#locationHistory");
    list.empty();
    if (history.length === 0) {
        list.append('<li class="list-group-item">해당 날짜의 위치 기록이 없습니다.</li>');
    } else {
        for (var i = 0; i < history.length; i++) {
            var location = history[i];
            list.append('<li class="list-group-item">' + 
                        location.memberName + ' - ' + 
                        location.timestamp + ': ' + 
                        location.address + '</li>');
        }
    }
}

$(document).ready(function() {
    loadFamilyMembers();
    
    // 오늘 날짜를 기본값으로 설정
    var today = new Date().toISOString().split('T')[0];
    $("#dateSelect").val(today);
    
    // 페이지 로드 시 전체 가족의 오늘 위치 기록을 표시
    searchLocationHistory();
});
</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>