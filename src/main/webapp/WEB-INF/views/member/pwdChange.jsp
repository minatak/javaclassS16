<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    .input-group input[type="password"] {
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
    
    .error-message {
      color: red;
      font-size: 0.9em;
      margin-top: 5px;
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
		  let regPwd = /^[a-zA-Z0-9!@#$%^*+=-_]{8,16}$/;
		  const currentPwd = document.getElementById('currentPwd').value.trim();
		  const newPwd = document.getElementById('newPwd').value.trim();
		  const confirmPwd = document.getElementById('confirmPwd').value.trim();
		
		  // 현재 비밀번호 확인
		  if (currentPwd === '') {
		    showAlert("현재 비밀번호를 입력해주세요.");
		    return;
		  }
		
		  // 새 비밀번호 유효성 검사
		  if (!regPwd.test(newPwd)) {
  		  showAlert("새 비밀번호는 8~16자리의 영문 대소문자와 특수문자, 숫자, 밑줄만 사용가능합니다", function() {
  		    document.myform.newPwd.focus();
  		  });
  		  return;
  		}
		
		  // 새 비밀번호 확인
		  if (newPwd !== confirmPwd) {
		    showAlert("새 비밀번호와 확인 비밀번호가<br/>일치하지 않습니다.");
		    return;
		  }
		
		  $(".loading-container").addClass("show");
		  
		  $.ajax({
		    url  : "${ctp}/member/updatePassword",
		    type : "post",
		    data : {
		      currentPwd: currentPwd,
		      newPwd: newPwd
		    }, 
		    success: function(res) {
		      if(res == "success") { 
		        showAlert("비밀번호가 성공적으로 변경되었습니다.");
		        setTimeout(() => {
		          window.location.href = "${ctp}/member/memberInfo";
		        }, 2000);
		      }
		      else if (res == "wrong_password") {
		        showAlert("현재 비밀번호가 일치하지 않습니다.");
		      }
		      else {
		        showAlert("비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
		      }
		    },
		    error : function() {
		      showAlert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
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
    <h3 class="mt-4">비밀번호 변경</h3>
    <div class="search-container">
      <div class="input-group">
        <label for="currentPwd">현재 비밀번호</label>
        <input type="password" id="currentPwd" placeholder="현재 비밀번호를 입력하세요">
      </div>
      <div class="input-group">
        <label for="newPwd">새 비밀번호</label>
        <input type="password" id="newPwd" placeholder="새 비밀번호를 입력하세요">
      </div>
      <div class="input-group">
        <label for="confirmPwd">새 비밀번호 확인</label>
        <input type="password" id="confirmPwd" placeholder="새 비밀번호를 다시 입력하세요">
      </div>
      <button onclick="newPassword()" class="search-button">비밀번호 변경</button>
      <div class="login-link">
        <a href="${ctp}/member/memberInfo">회원 정보 화면으로 돌아가기</a>
      </div>
    </div>
  </div>
</body>
</html>