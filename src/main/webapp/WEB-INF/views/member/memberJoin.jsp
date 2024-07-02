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
      font-size: 14px;
    }

    .form-group input[type="text"],
    .form-group input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-sizing: border-box;
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
    
    .input_container{
      position: relative;
      display: inline-block;
    }

    .timer{
      position: absolute;
      right: 16px;
      top:16px;
    }
    
  </style>
  <script>
    let ResponseCode;
    let timer;

    function innerReset() {
      document.getElementById('emailError').innerHTML = "";
    }

    window.onload = function() {
      let emailInput = document.myform.email;

      emailInput.oninput = function() {
        innerReset();
        let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
        if (!regEmail.test(emailInput.value)) {
          document.getElementById('emailError').innerHTML = "올바른 이메일 형식이 아닙니다.";
        }
      };
    };
      
    function fCheck() {
      let email = document.myform.email.value;
        
      if(email.trim() == "") {
        showAlert("이메일을 입력해주세요.");
        document.myform.email.focus();
      }
    }
      
    function showAlert(message) {
      Swal.fire({
        html: message,
        confirmButtonText: '확인',
        customClass: {
          confirmButton: 'swal2-confirm',
          popup: 'custom-swal-popup',
          htmlContainer: 'custom-swal-text'
        }
      });
    }
   
    function timer_start() {
      let timeLeft = 300; // 5분
      timer = setInterval(function() {
        if (timeLeft <= 0) {
          clearInterval(timer);
          document.getElementById('timer').textContent = "시간 초과!";
        } else {
          document.getElementById('timer').textContent = Math.floor(timeLeft / 60) + ":" + ('0' + (timeLeft % 60)).slice(-2);
        }
        timeLeft -= 1;
      }, 1000);
    }

    function sendVerificationCode() {
      let emailInput = document.myform.email;
      let email = emailInput.value.trim();

      if (email === "") {
        showAlert("이메일을 입력하세요");
        return;
      }

      if (!validateEmail(email)) {
        showAlert("올바른 이메일 형식을 입력하세요.");
        return;
      }

      $.ajax({
        type: 'POST',
        url: "${ctp}/member/joinEmailCheck",
        data: { email: email },
        success: function(response) {
          ResponseCode = response;  // 서버에서 실제로 받아온 코드
          emailInput.readOnly = true;
          emailInput.style.backgroundColor = "#e9ecef";
          document.getElementById('sendCodeBtn').disabled = true;
          timer_start();
          document.getElementById('auth_container').style.display = "block";
          document.getElementById('code_msg').textContent = "인증코드 발송 성공";
          document.getElementById('code_msg').style.color = "green";
          document.getElementById('code_msg').style.display = "block";
        },
        error: function() {
          showAlert('인증코드 발송에 실패했습니다. 다시 시도해주세요.');
        }
      });
    }

    function validateEmail(email) {
      var re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
      return re.test(String(email).toLowerCase());
    }

    function verifyCode() {
      let enteredCode = document.myform.verificationCode.value.trim();
      if (enteredCode === ResponseCode) {
        clearInterval(timer);
        alert("인증 성공!");
      } else {
        alert("인증에 실패했습니다. 인증코드를 다시 확인해주세요.");
      }
    }

    document.addEventListener('DOMContentLoaded', function() {
      document.getElementById('sendCodeBtn').addEventListener('click', sendVerificationCode);
      document.getElementById('verifyCodeBtn').addEventListener('click', verifyCode);
      document.querySelector('.next').addEventListener('click', fCheck);
    });
  </script>
</head>
<body>
  <div class="container">
    <h3>회 원 가 입</h3>
    <div class="login-container">
      <form name="myform" method="post">
        <div class="form-group">
          <label for="name">이름</label>
          <input type="text" name="name" placeholder="이름" required>
        </div>
        <div class="form-group">
          <label for="email">이메일</label>
          <input type="text" name="email" placeholder="이메일" required>
          <span id="emailError" style="color: red;"></span>
        </div>
        <div class="form-group">
          <button type="button" id="sendCodeBtn">인증번호 전송</button>
        </div>
        <div class="form-group" id="auth_container" style="display:none;">
          <input type="text" name="verificationCode" placeholder="인증번호 입력" required>
          <button type="button" id="verifyCodeBtn">인증코드 확인</button>
          <span id="timer" class="timer"></span>
          <span id="code_msg" style="display:none;"></span>
        </div>
        <div class="form-actions">
          <button type="button" class="back" onclick="history.back()">이전</button>
          <button type="button" class="next">다음</button>
        </div>
      </form>
      <div class="login-links">
        이미 계정이 있나요?<a href="${ctp}/member/memberLogin"><b>로그인하기</b></a>
      </div>
    </div>
  </div>
</body>
</html>
