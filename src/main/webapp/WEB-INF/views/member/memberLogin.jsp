<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인 | HomeLink</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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

    .logo {
      font-family: 'Cafe24Ssurround';
      font-size: 27px;
      color: #769cf8;
      margin-bottom: 50px;
    }

    h3 {
      /* font-size: 1.5rem; */
      font-weight : 800;
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

    .input-group .forgot-link {
      position: absolute;
      right: 0;
      top: 0;
      font-weight: 500;
    }

    .input-group input[type="text"],
    .input-group input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-sizing: border-box;
    }

    .input-group .fa {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(30%);
      cursor: pointer;
    }

    .login-button {
      width: 100%;
      padding: 10px;
      background-color: #000000;
      border: none;
      border-radius: 10px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .kakaoLogin {
      background-color: #ffeb00; 
      color: black;
      font-weight: 500;
    }
    
    .kakaoLogin:hover {
      background-color: #ffeb00;
    }

    .login-links {
      margin: 20px 0;
    }

    .login-links a {
      margin: 0 10px;
    }

   a:hover {
      /* text-decoration: underline; */
      text-decoration: none;
    } 
    
    a {
     /*  color: #5f7dc5; */
      text-decoration: none;
      font-weight: 500;
    }
    
    .checkbox-container {
      display: flex;
      align-items: center;
      margin-top: 10px;
    }

    .checkbox-container input[type="checkbox"] {
      margin-right: 10px;
    }
  </style>
	<script>
    'use strict';

    $(function() {
        $("#searchPassword").hide();


        // 비밀번호 표시 토글
        $('.fa-eye-slash').on('click', function() {
          var passwordField = $('input[name="pwd"]');
          if (passwordField.attr('type') === "password") {
            passwordField.attr('type', 'text');
            $(this).removeClass('fa-eye-slash').addClass('fa-eye');
          } else {
            passwordField.attr('type', 'password');
            $(this).removeClass('fa-eye').addClass('fa-eye-slash');
          }
        });
      });
    
    // 비밀번호 찾기
    function pwdSearch() {
      $("#searchPassword").show();
    }

    // 임시비밀번호 등록시켜주기
    function newPassword() {
      let mid = $("#midSearch").val().trim();
      let email = $("#emailSearch2").val().trim();
      if(mid == "" || email == "") {
        alert("가입시 등록한 아이디와 메일주소를 입력하세요");
        $("#midSearch").focus();
        return false;
      }

      $.ajax({
        url  : "${ctp}/member/memberNewPassword",
        type : "post",
        data : {
          mid   : mid,
          email : email
        },
        success:function(res) {
          if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
          else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
            location.reload();
        },
        error : function() {
          alert("전송오류!!")
        }
      });
    }

    // 카카오 로그인(자바스크립트 앱키 등록)
    window.Kakao.init("de6e07199c4aa87682edf478ce5966ae");

    function kakaoLogin() {
      window.Kakao.Auth.login({
        scope: 'profile_nickname, account_email',
        success:function(autoObj) {
          window.Kakao.API.request({
            url : '/v2/user/me',
            success:function(res) {
              const kakao_account = res.kakao_account;
              console.log(kakao_account);
              location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
            }
          });
        }
      });
    }
  </script>
</head>
<body>
  <div class="container">
  <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a>
   	<!-- <a href="/" class="logo mb-4" style="font-size:10px;"><h5>Homelink</h5></a> -->
    <h3 class="mt-4">로 그 인</h3>
    <div class="login-container">
      <form method="post" class="login-form">
        <div class="input-group mb-3">
          <label for="username">아이디</label>
          <a href="javascript:midSearch()" class="forgot-link">아이디를 잊어버리셨나요?</a>
          <input type="text" name="mid" value="${mid}" autofocus required placeholder="아이디를 입력해주세요.">
        </div>
        <div class="input-group">
          <label for="password">비밀번호</label>
          <a href="javascript:pwdSearch()" class="forgot-link">비밀번호를 잊어버리셨나요?</a>
          <input type="password" name="pwd" required placeholder="비밀번호를 입력해주세요.">
          <i class="fa fa-eye-slash" aria-hidden="true"></i>
        </div>
        <button type="submit" class="login-button">로그인</button>
        <div class="checkbox-container">
          <input type="checkbox" name="idSave" checked /> 아이디 저장
        </div>
      </form>
      <div class="login-links">
        홈링크가 처음인가요?<a href="${ctp}/member/memberJoin0"><b>회원가입하기</b></a>
      </div>
      <hr/>			
      <div>
        <p class="mb-2">이미 카카오로 회원가입을 완료했다면?</p>
        <button onclick="kakaoLogin()" class="login-button kakaoLogin"><i class="fa-solid fa-comment"></i>&nbsp;카카오 로그인</button>
      </div>
    </div>
  </div>
</body>
</html>
