<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>저장된 장소 | HomeLink</title>
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
        .locationContainer {
            max-width: 900px;
            margin: 40px auto;
            background-color: #fff;
            padding: 40px;
        }
        #map { 
            height: 400px; 
            width: 100%;
            margin-bottom: 20px;
        }
        .saved-places {
            margin-top: 20px;
        }
        .btn-add {
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
			
			function loadSavedPlaces() {
			    $.ajax({
			        url: "${ctp}/location/savedPlaces",
			        type: "GET",
			        success: function(response) {
			            updateSavedPlacesList(response);
			        },
			        error: function() {
			            alert("저장된 장소를 불러오는데 실패했습니다.");
			        }
			    });
			}
			
			function updateSavedPlacesList(places) {
			    var list = $("#savedPlacesList");
			    list.empty();
			    for (var i = 0; i < places.length; i++) {
			        var place = places[i];
			        list.append('<li class="list-group-item">' + 
			                    place.placeName + ' - ' + place.address + 
			                    ' <button onclick="editPlace(' + place.idx + ')">수정</button>' +
			                    ' <button onclick="deletePlace(' + place.idx + ')">삭제</button></li>');
			    }
			}
			
			function addNewPlace() {
			    var center = map.getCenter();
			    var placeName = prompt("새로운 장소의 이름을 입력하세요:");
			    if (placeName) {
			        $.ajax({
			            url: "${ctp}/location/savePlace",
			            type: "POST",
			            data: { 
			                placeName: placeName,
			                latitude: center.getLat(),
			                longitude: center.getLng()
			            },
			            success: function(response) {
			                alert("새로운 장소가 저장되었습니다.");
			                loadSavedPlaces();
			            },
			            error: function() {
			                alert("장소 저장에 실패했습니다.");
			            }
			        });
			    }
			}
			
			function editPlace(placeIdx) {
			    // 장소 수정 로직 구현
			}
			
			function deletePlace(placeIdx) {
			    if (confirm("정말로 이 장소를 삭제하시겠습니까?")) {
			        $.ajax({
			            url: "${ctp}/location/deletePlace/" + placeIdx,
			            type: "DELETE",
			            success: function(response) {
			                alert("장소가 삭제되었습니다.");
			                loadSavedPlaces();
			            },
			            error: function() {
			                alert("장소 삭제에 실패했습니다.");
			            }
			        });
			    }
			}
			
			$(document).ready(function() {
			    initMap();
			    loadSavedPlaces();
			});
		</script>
			    
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<div class="locationContainer">
    <h2>저장된 장소</h2>
    
    <div id="map"></div>
    
    <button class="btn-add" onclick="addNewPlace()">새로운 장소 추가</button>
    
    <div class="saved-places">
        <h4>저장된 장소 목록</h4>
        <ul id="savedPlacesList" class="list-group">
            <!-- 저장된 장소 목록이 여기에 동적으로 추가됩니다 -->
        </ul>
    </div>
</div>



<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>