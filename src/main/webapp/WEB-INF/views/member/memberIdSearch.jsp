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
    
  </style>
  <script>
    'use strict';
    
    function findId() {
      let name = $("#nameSearch").val().trim();
      let email = $("#emailSearch").val().trim();
      if(name == "" || email == "") {
        alert("이름과 이메일 주소를 입력하세요");
        return false;
      }

      $.ajax({
        url  : "${ctp}/member/findMemberId",
        type : "post",
        data : {
          name  : name,
          email : email
        },
        success:function(res) {
          if(res != "") alert("회원님의 아이디는 " + res + " 입니다.");
          else alert("일치하는 회원 정보가 없습니다.");
        },
        error : function() {
          alert("전송 오류!");
        }
      });
    }
  </script>
</head>
<body>
  <div class="container">
    <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a>
    <h3 class="mt-4">아이디 찾기</h3>
    <div class="search-container">
      <div class="input-group">
        <label for="nameSearch">이름</label>
        <input type="text" id="nameSearch" placeholder="이름을 입력하세요">
      </div>
      <div class="input-group">
        <label for="emailSearch">이메일</label>
        <input type="email" id="emailSearch" placeholder="이메일을 입력하세요">
      </div>
      <button onclick="findId()" class="search-button">아이디 찾기</button>
      <div class="login-link">
        <a href="${ctp}/member/memberLogin">로그인 페이지로 돌아가기</a>
      </div>
    </div>
  </div>
</body>
</html>