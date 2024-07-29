<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      display: flex; 
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      overflow: hidden; /* Prevent page from scrolling */
    }

    .container {
      text-align: center;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }

    .login-container {
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

    .form-group {
      margin-bottom: 15px;
      text-align: left;
      position: relative;
      display: flex;
      flex-direction: column;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      /* font-size: 14px; */
      font-weight: bold;
    }

    .form-group input[type="text"],
    .form-group input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 10px;
      /* box-sizing: border-box; */
      transition: border-color 0.3s;
      outline-width: 0.7px;
    }

    .form-group button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      background-color: #e6e6e6;
      border: none;
      color: black;
      border-radius: 10px;
      cursor: pointer;
    }

    .form-group button:hover {
      background-color: #d4d4d4;
      transition: background-color 0.3s;
    }

    .login-links {
      margin: 20px 0;
    }

    .login-links a {
      margin: 0 10px;
    }

    a:hover {
      text-decoration: none;
    }

    a {
      text-decoration: none;
      font-weight: 500;
    }

    .form-actions {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
    }

    .form-actions button {
      border: none;
      border-radius: 10px;
    }

    .back {
      width: 19%;
      padding: 15px;
      background-color: #efefef;
    }

    .next {
      width: 78%;
      padding: 15px;
      background-color: #000000;
      border: none;
      border-radius: 4px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .back:hover {
      transition: background-color 0.3s;
      background-color: #e6e6e6;
    }

    .input_container {
      position: relative;
      display: inline-block;
    }

    .timer {
      position: absolute;
      right: 16px;
      top: 14px;
    }

    .loading-container {
      display: none;
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(255, 255, 255, 0.8);
      justify-content: center;
      align-items: center;
      z-index: 10;
    }

    .loading-container.show {
      display: flex;
    }

    .loading-spinner {
      border: 4px solid rgba(0, 0, 0, 0.1);
      border-left-color: #000;
      border-radius: 50%;
      width: 40px;
      height: 40px;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
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

    .error-msg {
      color: red;
      margin-top: 5px;
      font-size: 12px;
    }
  </style>
  <script>
    let ResponseCode;
    let timer;
    let emailCheckSw = 0;

    function innerReset() { // 오류 메세지 초기화
      document.getElementById('nameError').innerHTML = "";
      document.getElementById('emailError').innerHTML = "";
      document.getElementById('codeError').innerHTML = "";
    }

    window.onload = function() {
      let nameInput = document.myform.name;
      let emailInput = document.myform.email;

      nameInput.oninput = function() {
        innerReset();
        let regName = /^[가-힣a-zA-Z]+$/;        // 이름은 한글/영문 가능

        if (!regName.test(nameInput.value)) {
          document.getElementById('nameError').innerHTML = "이름은 한글과 영문 대소문자만 사용가능합니다";
        }
      }

      emailInput.oninput = function() {
        innerReset();
        let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

        if (!regEmail.test(emailInput.value)) {
          document.getElementById('emailError').innerHTML = "올바른 이메일 형식이 아닙니다";
        }
      };
    };

    function fCheck() {
      let name = document.myform.name.value;
      let email = document.myform.email.value;
      let verificationCode = document.myform.verificationCode.value.trim();
      let sessionKey = sessionStorage.getItem('sEmailKey');

      let regName = /^[가-힣a-zA-Z]+$/;        // 이름은 한글/영문 가능
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

      if(name == "") {
    	  showAlert("이름을 입력하세요", function() {
    	    document.myform.name.focus();
    	  });
    	  return false;
    	}
    	else if(email == "") {
    	  showAlert("이메일을 입력하세요", function() {
    	    document.myform.email.focus();  
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
    	else if(emailCheckSw != 1) {
    	  showAlert("이메일을 인증해주세요");
    	  return false;
    	}
    	else {
    	  myform.submit();
    	}

    function showErrorMsg(elementId, message) {
      document.getElementById(elementId).innerHTML = message;
    }

    
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

    function timer_start() {
      let timeLeft = 300; // 5분
      timer = setInterval(function() {
        if (timeLeft <= 0) {
          clearInterval(timer);
          document.getElementById('timer').textContent = "0:00";
          showAlert("시간이 초과되었습니다<br/>인증번호를 다시 발급해주세요");
          // 세션 초기화
          sessionStorage.removeItem('sEmailKey');
          document.getElementById('sendCodeBtn').style.display = "block";
          document.getElementById('auth_container').style.display = "none";
        } else {
          document.getElementById('timer').textContent = Math.floor(timeLeft / 60) + ":" + ('0' + (timeLeft % 60)).slice(-2);
        }
        timeLeft -= 1;
      }, 1000);
    }

    function sendVerificationCode() {
      let email = document.myform.email.value.trim();

      if (email === "") {
        showErrorMsg("emailError", "이메일을 입력하세요");
        return;
      }

      document.getElementById('loading-container').classList.add('show');

      $.ajax({
        type: 'POST',
        url: '${ctp}/member/joinEmailCheck',
        data: { email: email },
        success: function(response) {
        	if(response == "alreadyMember") {
        		window.location.href = '${ctp}/message/alreadyMember';
        	}
        	else {
	          ResponseCode = response;
	          sessionStorage.setItem('sEmailKey', ResponseCode);
	          showAlert("인증 코드가 전송되었습니다");
	          document.getElementById('auth_container').style.display = "block";
	          document.getElementById('sendCodeBtn').style.display = "none";
	          timer_start();        		
        	}
        },
        error: function() {
          showAlert("인증 코드 전송 중 오류가 발생했습니다<br/>다시 시도해주세요");
        },
        complete: function() {
          document.getElementById('loading-container').classList.remove('show');
        }
      });
    }

    function verifyCode() {
      let verificationCode = document.myform.verificationCode.value.trim();
      let sessionKey = sessionStorage.getItem('sEmailKey');

      if (verificationCode === "") {
        showErrorMsg("codeError", "인증 코드를 입력하세요");
        return false;
      }
      if (verificationCode !== sessionKey) {
        showErrorMsg("codeError", "인증코드가 일치하지 않습니다");
        return false;
      }
      else {
        showAlert("인증이 완료되었습니다<p><br/><p>'다음' 버튼을 클릭해 <br/>회원가입을 진행해주세요!");
        emailCheckSw = 1;
        document.myform.verificationCode.readOnly = true;
        document.getElementById('auth_container').readOnly = true;
        innerReset();
        clearInterval(timer);
      }
    }
  </script>
</head>
<body>
  <div class="container">
    <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a>
    <div class="login-container">
      <h3>회원가입</h3>
      <form name="myform" method="post">
        <div class="form-group">
          <label for="name">이름</label>
          <input type="text" id="name" name="name" placeholder="이름을 입력해주세요." required>
          <div id="nameError" class="error-msg"></div>
        </div>
        <div class="form-group">
          <label for="email">이메일</label>
          <div class="input_container">
            <input type="text" id="email" name="email" placeholder="이메일을 입력해주세요." required>
          </div>
          <div id="emailError" class="error-msg"></div>
        </div>
        <div class="form-group">
          <label for="verificationCode">인증번호</label>
          <button type="button" id="sendCodeBtn" onclick="sendVerificationCode()">인증번호 전송</button>
          <div class="form-group" id="auth_container" style="display:none;">
            <input type="text" id="verificationCode" name="verificationCode" placeholder="인증번호를 입력하세요.">
            <div class="timer" id="timer">5:00</div>
            <div id="codeError" class="error-msg"></div>
            <button type="button" onclick="verifyCode()">인증번호 확인</button>
          </div>
        </div>
        <div class="form-actions">
          <button type="button" class="back" onclick="window.history.back()">뒤로</button>
          <button type="button" class="next" onclick="fCheck()">다음</button>
        </div>
      </form>
    </div>
    <%-- <div class="login-links">
      이미 계정이 있나요?<a href="${ctp}/member/memberLogin"><b>로그인하기</b></a>
    </div> --%>
  </div>
  <div id="loading-container" class="loading-container">
    <div class="loading-spinner"></div>
  </div>
</body>
</html>

