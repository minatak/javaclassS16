<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>가족 코드 등록 | HomeLink</title>
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

    .code-container {
      background: #fff;
      padding: 20px 40px;
      margin-top: 20px;
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
      margin-bottom: 5px;
      font-weight: bold;
    }

    .code-input-group {
      display: flex;
      flex-direction: row;
      justify-content: space-between !important;
    }

    .code-input-group input {
      width: calc(12.5% - 10px);
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      text-align: center;
      font-size: 18px;
    }

    .form-group button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
    /*   background-color: transparent; */
      border: 1px solid #ccc;
      color: black;
      border-radius: 10px;
      cursor: pointer;
    }

    .form-group button:hover {
      border-color: #457b9d;
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

  </style>
   <script>
    'use strict';

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
        <button type="button" class="button" data-toggle="modal" data-target="#myModal">이메일로 회원가입</button>
      </div>
			<div class="form-group">
        <button onclick="kakaoLogin()" class="login-button kakaoLogin"><i class="fa-solid fa-comment"></i>&nbsp;카카오 회원가입</button>
      </div>
 			<div class="login-links">
      	이미 계정이 있나요?<a href="${ctp}/member/memberLogin"><b>로그인하기</b></a>
    	</div>
	  </div>
	</div>
</body>
</html>
