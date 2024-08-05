<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>message</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
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
      font-size: 18px !important;
      margin: 0 !important;
    }
    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
    }
    .swal2-confirm:hover {
      background-color: inherit !important;
    }
  </style>
  <script>
    'use strict';
    
    function showAlert(message) {
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
      }).then(() => {
        location.href = '${ctp}/${url}';
      });
    }

    window.onload = function() {
      showAlert('${msg}');
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  
</div>
<p><br/></p>
</body>
</html>