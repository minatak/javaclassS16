<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입 | HomeLink</title>
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

    .code-container {
      background: #fff;
      padding: 20px 40px;
      margin-top: 0px;
      width: 100%;
      max-width: 500px;
      border-radius: 10px;
    }

    h3 {
      font-weight: 800;
      margin-bottom: 20px;
    }

    .form-group {
      margin-bottom: 15px;
      text-align: left;
      /* position: relative; */
      display: flex;
      flex-direction: column;
    }

    .form-group label {
      display: block;
      margin-top: 5px; 
      font-weight: bold;
    }

    .code-input-group {
      display: flex;
      flex-direction: row;
      justify-content: space-between !important;
    }

    .button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
    /*   background-color: transparent; */
      border: 1px solid #ccc;
      color: black;
      border-radius: 10px;
      cursor: pointer;
      text-align: center; 
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

    .kakaoLogin {
	    background-color: #ffeb00; 
	    color: black;
	    font-weight: 500;
    }
    
    .kakaoLogin:hover {
      background-color: #ffeb00;
    }
    .form-group a:hover {
      text-decoration: none;
       color: black;
    }

    .login-links a:hover {
      text-decoration: none;
    }
  </style>
  <script>
    'use strict';
    // 페이지 로드 시 카카오 SDK 초기화
    document.addEventListener('DOMContentLoaded', function() {
      Kakao.init("de6e07199c4aa87682edf478ce5966ae"); // 실제 JavaScript 키로 교체
      
      if (!Kakao.isInitialized()) {
        console.error('Kakao SDK failed to initialize');
        return;
      }
    });
    
    function kakaoJoin() {
      if (!Kakao.isInitialized()) {
        console.error('Kakao SDK is not initialized');
        return;
      }
      Kakao.Auth.login({
        success: function(authObj) {
          console.log('Login success', authObj);
          Kakao.API.request({
            url: '/v2/user/me',
            success: function(res) {
              console.log('User info success', res);
              const kakao_account = res.kakao_account;
              const redirectUrl = "${ctp}/member/kakaoJoin?nickName=" + encodeURIComponent(kakao_account.profile.nickname) + "&email=" + encodeURIComponent(kakao_account.email) + "&accessToken=" + encodeURIComponent(Kakao.Auth.getAccessToken());
              console.log('Redirecting to:', redirectUrl);
              window.location.href = redirectUrl;
            },
            fail: function(error) {
              console.error('Failed to get user info', error);
              alert('카카오 정보를 가져오는데 실패했습니다: ' + JSON.stringify(error));
            }
          });
        },
        fail: function(err) {
          console.error('Login failed', err);
          alert('카카오 회원가입에 실패했습니다: ' + JSON.stringify(err));
        }
      });
    }
  </script>
</head>
<body>
  <div class="container">
    <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a>
      <h3 class="m-5">회원가입</h3>
    <div class="code-container">
      <div class="form-group">
        <a href="${ctp}/member/memberJoin" class="button email-join">이메일로 회원가입</a>
      </div>
      <div class="form-group">
			  <a href="javascript:kakaoJoin()" class="login-button button kakaoLogin"><i class="fa-solid fa-comment"></i>&nbsp;카카오 회원가입</a>
			</div>
 			<div class="login-links">
      	이미 계정이 있나요? <a href="${ctp}/member/memberLogin"><b>로그인하기</b></a>
    	</div>
	  </div>
	</div>
</body>
</html>
