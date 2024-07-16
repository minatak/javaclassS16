<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위치 공유 | HomeLink</title>
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
        
    </style>
    <script>
    'use strict';

    var map;
    var markers = {};

    function initMap() {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };
        map = new kakao.maps.Map(container, options);
    }

    function updateMyLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude;
                var lng = position.coords.longitude;
                
                $.ajax({
                    url: "${ctp}/location/locationUpdate",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({ latitude: lat, longitude: lng }),
                    success: function(res) {
                        if(res == "1") {
                            showAlert("위치가 업데이트되었습니다.", loadFamilyLocations);
                        } else {
                            showAlert("위치 업데이트에 실패했습니다.");
                        }
                    },
                    error: function() {
                        showAlert("위치 업데이트에 실패했습니다.");
                    }
                });
            });
        } else {
            showAlert("이 브라우저에서는 위치 정보를 지원하지 않습니다.");
        }
    }

    function loadFamilyLocations() {
        $.ajax({
            url: "${ctp}/location/familyLocation",
            type: "POST",
            success: function(response) {
                updateMap(response);
                updateFamilyList(response);
            },
            error: function() {
                showAlert("가족 위치 정보를 불러오는데 실패했습니다.");
            }
        });
    }

    function updateMap(locations) {
        for (var i = 0; i < locations.length; i++) {
            var location = locations[i];
            var position = new kakao.maps.LatLng(location.latitude, location.longitude);
            
            if (markers[location.memberIdx]) {
                markers[location.memberIdx].setPosition(position);
            } else {
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: position,
                    title: location.memberName
                });
                markers[location.memberIdx] = marker;
            }
        }
        
        if (locations.length > 0) {
            map.setCenter(new kakao.maps.LatLng(locations[0].latitude, locations[0].longitude));
        }
    }

    function updateFamilyList(locations) {
        var list = $("#familyLocationList");
        list.empty();
        for (var i = 0; i < locations.length; i++) {
            var location = locations[i];
            list.append('<li>' + 
                        location.memberName + ': ' + location.address + 
                        ' <a href="${ctp}/location/memberDetail?memberIdx=' + location.memberIdx + '">상세보기</a></li>');
        }
    }

    function showAlert(message, callback) {
        Swal.fire({
            html: message,
            confirmButtonText: '확인',
            customClass: {
                confirmButton: 'swal2-confirm',
                popup: 'custom-swal-popup',
                htmlContainer: 'custom-swal-text'
            },
            scrollbarPadding: false,
            allowOutsideClick: false,
            heightAuto: false,
            didOpen: () => {
                document.body.style.paddingRight = '0px';
            }
        }).then((result) => {
            if (result.isConfirmed && callback) {
                callback();
            }
        });
    }

    $(document).ready(function() {
        initMap();
        loadFamilyLocations();
    });
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<div class="locationContainer">
    <h2>가족 위치 공유</h2>
    
    <div id="map"></div>
    
    <button class="btn-update" onclick="updateMyLocation()">내 위치 업데이트</button>
    
    <div class="family-list">
        <h4>가족 구성원 위치</h4>
        <ul id="familyLocationList">
            <!-- 가족 구성원 위치 정보가 여기에 동적으로 추가됩니다 -->
        </ul>
    </div>
		<div class="nav-buttons">
        <a href="${ctp}/location/locationSave" class="nav-button">저장된 장소</a>
        <a href="${ctp}/location/locationDetail" class="nav-button">가족 위치정보</a>
    </div>
</div>


<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>