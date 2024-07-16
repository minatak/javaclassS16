<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가족 구성원 위치 상세 | HomeLink</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de6e07199c4aa87682edf478ce5966ae"></script>
    <style>
    body {
            font-family: 'Pretendard' !important;
            background-color: #ffffff;
            color: #333333;
        }
        .swal2-confirm {
		      background-color: white !important;
		      color: black !important;
		      border-radius: 0px !important;
		      box-shadow: none !important;
		      font-weight: bold !important;
		      font-size: 18px !important;
		      margin: 0 !important;
		      
		    }
		    .swal2-cancel {
		      background-color: white !important;
		      color: black !important;
		      border-radius: 0px !important;
		      box-shadow: none !important;
		      /* font-weight: bold !important; */
		      font-size: 18px !important;
		      margin: 0 !important;
		    }
		    .custom-swal-popup {
		      width: 350px !important;
		      padding-top: 20px !important;
		      border-radius: 0px !important;
		    }
		    .swal2-confirm:hover {
		      background-color: none !important;
		    }
        .locationContainer {
            max-width: 900px;
            margin: 40px auto;
            background-color: #fff;
            padding: 40px;
        }
        
        h2 {
            font-family: 'Pretendard' !important; 
            color: #333;
            font-size: 24px;
            font-weight: 700 !important;
            text-align: center;
            margin-bottom: 40px;
        }
        
        #map { 
            height: 400px; 
            width: 100%;
            margin-bottom: 20px;
        }
        
        .btn-update {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: #84a98c;
            color: #ffffff;
            border: none;
            text-decoration: none;
        }
        
        .btn-update:hover {
            background-color: #6b8e78;
        }
        
        .family-list {
            margin-top: 40px;
        }
        
        .family-list h4 {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        #familyLocationList {
            list-style-type: none;
            padding: 0;
        }
        
        #familyLocationList li {
            padding: 15px 0;
            border-top: 1px solid #e4e6eb;
        }
        
        #familyLocationList li:last-child {
            border-bottom: 1px solid #e4e6eb;
        }
        
        #familyLocationList a {
            color: #84a98c;
            text-decoration: none;
            margin-left: 10px;
        }
        
        #familyLocationList a:hover {
            text-decoration: underline;
        }
        
        .nav-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        
        .nav-button {
            padding: 10px 20px;
            background-color: #84a98c;
            color: #ffffff;
            border: none;
            text-decoration: none;
            font-weight: bold;
        }
        
        .nav-button:hover {
            background-color: #6b8e78;
            color: #ffffff;
        }
        .location-history {
            margin-top: 20px;
        }
    </style>
    <script>
			var map;
			
			function initMap() {
			    var container = document.getElementById('map');
			    var options = {
			        center: new kakao.maps.LatLng(33.450701, 126.570667),
			        level: 3
			    };
			    map = new kakao.maps.Map(container, options);
			}
			
			function loadMemberLocation() {
			    $.ajax({
			        url: "${ctp}/location/member/${memberIdx}",
			        type: "GET",
			        success: function(response) {
			            updateMap(response.currentLocation);
			            updateLocationHistory(response.locationHistory);
			        },
			        error: function() {
			            alert("위치 정보를 불러오는데 실패했습니다.");
			        }
			    });
			}
			
			
			
			function updateMap(location) {
			    var position = new kakao.maps.LatLng(location.latitude, location.longitude);
			    map.setCenter(position);
			    
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: position
			    });
			}
			
			function updateLocationHistory(history) {
			    var list = $("#locationHistory");
			    list.empty();
			    for (var i = 0; i < history.length; i++) {
			        var location = history[i];
			        list.append('<li class="list-group-item">' + location.timestamp + ': ' + location.address + '</li>');
			    }
			}
			
			$(document).ready(function() {
			    initMap();
			    loadMemberLocation();
			});
			</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<div class="locationContainer">
    <h2>${memberName}의 위치 정보</h2>
    
    <div id="map"></div>
    
    <div class="location-history">
        <h4>최근 위치 기록</h4>
        <ul id="locationHistory" class="list-group">
            <!-- 위치 기록이 여기에 동적으로 추가됩니다 -->
        </ul>
    </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>