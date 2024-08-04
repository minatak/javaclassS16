<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>아이디 찾기 | HomeLink</title>
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
    .search-button, .verification-button {
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
    .search-button:hover, .verification-button:hover {
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
    
    .verification-container {
      display: none;
    }
    
    .timer {
      position: absolute;
      right: 16px;
      top: 14px;
    }
    
    .error-msg {
      color: red;
      margin-top: 5px;
      font-size: 12px;
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
    
    
    .input-group input[readonly] {
      background-color: #f0f0f0;
    }
    
    .verification-button:disabled {
      background-color: #cccccc;
      cursor: not-allowed;
    }
    
    .timer {
      position: absolute;
      right: 16px;
      top: 35px; /* 타이머 위치 조정 */
      font-size: 14px;
      color: #333;
    }
    
    #foundIdInfo {
      background-color: #e8f5e9;
      padding: 15px;
      border-radius: 10px;
      font-size: 18px;
      margin-top: 20px;
    }
    
    #foundIdInfo strong {
      color: #2e7d32;
      font-size: 20px;
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
    
    
    let timer;
    let emailVerified = false;
    
    function sendVerificationCode() {
   	  let name = $("#nameSearch").val().trim();
   	  let email = $("#emailSearch").val().trim();

	   	let regName = /^[가-힣a-zA-Z]+$/;
	    let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

   	  
   	  if(name == "") {
        showAlert("이름을 입력하세요", function() {
          document.myform.nameSearch.focus();
        });
        return false;
      }
      else if(email == "") {
        showAlert("이메일을 입력하세요", function() {
          document.myform.emailSearch.focus();  
        });
        return false;
      }
      else if (!regName.test(name)) {
        showAlert("이름은 한글과 영문대소문자만 사용가능합니다", function() {
          document.myform.name.focus();
        });
        return false;
      }
      else if (!regEmail.test(email)) {
        showAlert("올바른 이메일 형식이 아닙니다", function() {
          document.myform.email.focus();
        });
        return false;
      }
   	  
   		$(".loading-container").addClass("show");
   	  
   	  $.ajax({
   	    url  : "${ctp}/member/sendVerificationForIdSearch",
   	    type : "post",
   	    data : {
   	      email : email,
   	      name : name
   	    },
   	 		success:function(res) {
         	if(res == "success") {
           	showAlert("인증 코드가 전송되었습니다.");
           	$(".verification-container").show();
           	$("#sendVerificationBtn").prop('disabled', true);
           	$("#emailSearch").prop('readonly', true);
           	startTimer();
         	}
         	else if(res == "not_found") {
         		showAlert("일치하는 회원 정보가 없습니다.");
         	}
        	else {
           	showAlert("인증 코드 전송에 실패했습니다.");
         	}
       	},
       	error : function() {
         	showAlert("전송 오류!");
       	},
       	complete : function() {
         // 로딩 스피너 숨김
         $(".loading-container").removeClass("show");
      	}
   		});
   	}

   	function verifyCode() {
   	  let code = $("#verificationCode").val().trim();
   	  let email = $("#emailSearch").val().trim();
   		let name = $("#nameSearch").val().trim();
   	  if(code == "") {
   			showAlert("인증 코드를 입력하세요");
   	    return false;
   	  }
   	  
   		$.ajax({
   	    url  : "${ctp}/member/verifyEmailForIdSearch",
   	    type : "post",
   	    data : {
   	      email : email,
   	      name : name,
   	      verificationCode : code
   	    },
   	 		success:function(res) {
					if(res != "invalid_code" && res != "not_found") {
					  $("#foundIdInfo").html("회원님의 아이디는 <strong>" + res + "</strong> 입니다.").show();
					  emailVerified = true;
					  clearInterval(timer);
					  $("#timer").text("");
					  $(".verification-container").hide();
					}
   	      else if(res == "not_found") {
   	        showAlert("일치하는 회원 정보가 없습니다.");
   	      }
   	      else {
   	        showAlert("인증 코드가 일치하지 않습니다.");
   	      }
   	    },
   	    error : function() {
   	      showAlert("전송 오류!");
   	    }
   	  });
   	}

    
    function startTimer() {
      let timeLeft = 300; // 5 minutes
      timer = setInterval(function() {
        if(timeLeft <= 0) {
          clearInterval(timer);
          $("#timer").text("0:00");
          showAlert("인증 시간이 만료되었습니다. 다시 시도해주세요.");
          $(".verification-container").hide();
        } else {
          let minutes = Math.floor(timeLeft / 60);
          let seconds = timeLeft % 60;
          $("#timer").text(minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
        }
        timeLeft -= 1;
      }, 1000);
    }
  </script>
</head>
<body>
  <div class="loading-container">
    <div class="loading-spinner"></div>
  </div>
  <div class="container">
    <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a>
    <h3 class="mt-4">아이디 찾기</h3>
      <div class="search-container">
		    <div class="input-group">
		      <label for="nameSearch">이름</label>
		      <input type="text" id="nameSearch" name="nameSearch" placeholder="이름을 입력하세요">
		    </div>
		    <div class="input-group">
		      <label for="emailSearch">이메일</label>
		      <input type="email" id="emailSearch" name="emailSearch" placeholder="이메일을 입력하세요">
		    </div>
		    <button onclick="sendVerificationCode()" id="sendVerificationBtn" class="verification-button">인증번호 전송</button>
		    <div class="verification-container"> 
		      <div class="input-group mt-3">
		        <label for="verificationCode">인증번호</label>
		        <input type="text" id="verificationCode" placeholder="인증번호를 입력하세요">
		        <div class="timer" id="timer"></div>
		      </div>
		      <button onclick="verifyCode()" class="verification-button">인증번호 확인</button>
		    </div>
		    <div id="foundIdInfo" style="display: none;"></div>
	    	<div class="login-link">
	      	<a href="${ctp}/member/memberLogin">로그인 페이지로 돌아가기</a>
	    	</div>
	  </div>
  </div>
</body>
</html>