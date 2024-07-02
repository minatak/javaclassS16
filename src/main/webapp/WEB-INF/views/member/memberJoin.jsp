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
    'use strict';

    function innerReset() {
      document.getElementById('emailError').innerHTML = "";
    }

    window.onload = function() {
      let email = document.forms[0].email;

      email.oninput = function() {
        innerReset();
        let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
        if (!regEmail.test(email.value)) {
          document.getElementById('emailError').innerHTML = "올바른 이메일 형식이 아닙니다.";
        }
      };
    };

    let code_valid = false;
    let current_time = 0;
    let minutes, seconds;
    let timer_thread;
    let responseCode;

    function timer_start() {
      code_valid = true;
      current_time = 0;
      let count = 20;

      document.getElementById('timer').innerHTML = "00:20";
      timer_thread = setInterval(function () {
        minutes = parseInt(count / 60, 10);
        seconds = parseInt(count % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        document.getElementById('timer').innerHTML = minutes + ":" + seconds;

        if (--count < 0) {
          timer_stop();
          document.getElementById('timer').textContent = "시간초과";
          document.getElementById('code_msg').style.display = "block";
          document.getElementById('code_msg').textContent = "인증코드가 만료되었습니다.";
          document.getElementById('code_msg').style.color = "red";
        }

        current_time++;
      }, 1000);
    }

    function timer_stop() {
      clearInterval(timer_thread);
      code_valid = false;
    }

    function sendVerificationCode() {
      const email = document.forms[0].email.value;
      const regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      if (!regEmail.test(email)) {
        document.getElementById('emailError').innerHTML = "올바른 이메일 형식이 아닙니다.";
        return;
      }

      const xhr = new XMLHttpRequest();
      xhr.open('POST', '${ctp}/sendVerificationCode', true);
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
          responseCode = xhr.responseText.trim();
          document.forms[0].email.readOnly = true;
          document.getElementById('emailError').innerHTML = "";
          timer_start();
          document.getElementById('auth_container').style.display = "block";
        }
      };
      xhr.send(`email=${email}`);
    }

    function verifyCode() {
      const code = document.forms[0].verificationCode.value;
      if (code_valid) {
        if (responseCode === code) {
          document.getElementById('code_msg').textContent = "이메일 인증 성공!";
          document.getElementById('code_msg').style.display = "block";
          document.getElementById('code_msg').style.color = "green";
        } else {
          document.getElementById('code_msg').textContent = "인증코드가 일치하지 않습니다.";
          document.getElementById('code_msg').style.display = "block";
          document.getElementById('code_msg').style.color = "red";
        }
      } else {
        document.getElementById('code_msg').textContent = "인증코드가 만료되었습니다.";
        document.getElementById('code_msg').style.display = "block";
        document.getElementById('code_msg').style.color = "red";
      }
    }
  </script>
</head>
<body>
  <div class="container">
    <h3>회 원 가 입</h3>
    <div class="login-container">
      <form action="register" method="post">
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
          <button type="button" onclick="sendVerificationCode()">인증번호 전송</button>
        </div>
        <div class="form-group" id="auth_container" style="display:none;">
          <input type="text" name="verificationCode" placeholder="인증번호 입력" required>
          <button type="button" onclick="verifyCode()">인증코드 확인</button>
          <span id="timer" class="timer"></span>
          <span id="code_msg" style="display:none;"></span>
        </div>
        <div class="form-actions">
          <button type="button" class="back" onclick="history.back()">이전</button>
          <button type="submit" class="next">다음</button>
        </div>
      </form>
      <div class="login-links">
        이미 계정이 있나요?<a href="${ctp}/member/memberLogin"><b>로그인하기</b></a>
      </div>
    </div>
  </div>
</body>
</html>
