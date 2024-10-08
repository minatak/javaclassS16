<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>비밀번호 찾기 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      display: flex; 
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      text-align: center;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
    
    .search-container {
      background: #fff;
      padding: 20px 40px;
      margin-top: 20px;
      width: 100%;
      max-width: 500px;
    }
    h3 {
      font-weight: 800;
      margin-bottom: 20px;
    }
    .input-group {
      margin-bottom: 15px;
      text-align: left;
      position: relative;
      display: flex;
      flex-direction: column;
    }
    .input-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .input-group input[type="text"],
    .input-group input[type="email"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-sizing: border-box;
    }
    .search-button {
      width: 100%;
      padding: 10px;
      background-color: #84a98c;
      border: none;
      border-radius: 10px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .search-button:hover {
      background-color: #6b8e73;
    }
    .login-link {
      margin-top: 20px;
    }
    a:hover {
      text-decoration: none;
      font-weight: 600;
      color: #5f7dc5; 
    } 
    
    a {
      text-decoration: none; 
      font-weight: 600;  
    }
    
    .loading-container {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(255, 255, 255, 0.8);
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }
    
    .loading-container.show {
      display: flex;
    }
    
    .loading-spinner {
      width: 40px;
      height: 40px;
      border: 3px solid #f3f3f3;
      border-top: 3px solid #84a98c;
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
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

    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 0px !important;
    }

    .swal2-confirm:hover {
      background-color: none !important;
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
      });
    }
    
    function newPassword() {
      let mid = $("#midSearch").val().trim();
      let email = $("#emailSearch").val().trim();
      
      let regMid = /^[a-z0-9_]{4,20}$/;
      let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

      if(mid == "") {
        showAlert("아이디를 입력하세요", function() {
          document.myform.midSearch.focus();
        });
        return false;
      }
      else if(email == "") {
        showAlert("이메일을 입력하세요", function() { 
          document.myform.emailSearch.focus();  
        });
        return false;
      }
      else if (!regMid.test(mid)) {
        showAlert("아이디는 4~20자의 영문 소문자, 숫자와<br/>특수기호(_)만 사용 가능합니다", function() {
          document.myform.midSearch.focus();
        });
        return false;
      }
      else if (!regEmail.test(email)) {
        showAlert("올바른 이메일 형식이 아닙니다", function() {
          document.myform.emailSearch.focus();
        });
        return false;
      }
      
      $(".loading-container").addClass("show");
      
      $.ajax({
        url  : "${ctp}/member/memberNewPassword",
        type : "post",
        data : {
          mid   : mid,
          email : email
        }, 
        success:function(res) {
          if(res != "0") { 
            showAlert("새로운 비밀번호가<br/>"+email+"으로<br/>발송되었습니다 :)");
          }
          else {
            showAlert("등록하신 정보가 일치하지 않습니다.<br/>확인후 다시 처리하세요.");
          }
        },
        error : function() {
          showAlert("전송 오류!");
        },
        complete : function() {
          $(".loading-container").removeClass("show");
        }
      });
    }
  </script>
</head>
<body>
  <div class="loading-container">
    <div class="loading-spinner"></div>
  </div>
  <div class="container">
    <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a>
    <h3 class="mt-4">비밀번호 찾기</h3>
    <div class="search-container">
      <div class="input-group">
        <label for="midSearch">아이디</label>
        <input type="text" id="midSearch" placeholder="아이디를 입력하세요">
      </div>
      <div class="input-group">
        <label for="emailSearch">이메일</label>
        <input type="email" id="emailSearch" placeholder="이메일을 입력하세요">
      </div>
      <button onclick="newPassword()" class="search-button">새 비밀번호 발급</button>
      <div class="login-link">
        <a href="${ctp}/member/memberLogin">로그인 페이지로 돌아가기</a>
      </div>
    </div>
  </div>
</body>
</html>