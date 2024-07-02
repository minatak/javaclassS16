<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberJoin.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
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
    
    .form-container {
      background: #fff;
      padding: 20px 40px;
      margin-top: 20px;
      width: 100%;
      max-width: 600px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }
    
    h2 {
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
      font-weight: bold;
    }
    
    .form-group input,
    .form-group select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }
    
    .form-group .input-group {
      display: flex;
      align-items: center;
    }
    
    .form-group .input-group input[type="text"] {
      flex: 1;
    }
    
    .form-group .input-group .input-group-append {
      margin-left: 5px;
    }
    
    .form-group .input-group .input-group-append select {
      flex: 0 0 auto;
    }
    
    .form-group button {
      width: 100%;
      padding: 10px;
      background-color: #000000;
      border: none;
      border-radius: 4px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
      margin-top: 10px;
    }
    
    .form-group button:hover {
      background-color: #000000;
    }
    
    .form-group img {
      margin-top: 10px;
      max-width: 100px;
    }
    
    .form-group .btn-secondary {
      margin-top: 10px;
      width: 100%;
    }
  </style>
  <script>
    'use strict';
    // Existing JavaScript functions and handlers go here
  </script>
</head>
<body>
  <div class="container">
    <div class="form-container">
      <h2>회 원 가 입</h2>
      <form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
        <div class="form-group">
          <label for="mid">아이디 :</label>
          <div class="input-group">
            <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus />
            <div class="input-group-append">
              <button type="button" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()">아이디 중복체크</button>
            </div>
          </div>
        </div>
        <div class="form-group">
          <label for="pwd">비밀번호 :</label>
          <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
        </div>
        <div class="form-group">
          <label for="name">이름 :</label>
          <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
        </div>
        <div class="form-group">
          <label for="email1">이메일 :</label>
          <div class="input-group">
            <input type="text" class="form-control" id="email1" name="email1" placeholder="Email을 입력하세요." required />
            <div class="input-group-append">
              <select name="email2" class="custom-select">
                <option value="naver.com" selected>naver.com</option>
                <option value="hanmail.net">hanmail.net</option>
                <option value="hotmail.com">hotmail.com</option>
                <option value="gmail.com">gmail.com</option>
                <option value="nate.com">nate.com</option>
                <option value="yahoo.com">yahoo.com</option>
              </select>
            </div>
          </div>
        </div>
        <div class="form-group">
          <label for="birthday">생일</label>
          <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control" />
        </div>
        <div class="form-group">
          <label for="file">회원 사진 (파일용량:2MByte이내) :</label>
          <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border" />
          <img id="photoDemo" src="" alt="Selected Image" />
        </div>
        <div class="form-group">
          <button type="button" onclick="fCheck()">회원가입</button>
          <button type="reset" class="btn btn-secondary">다시작성</button>
          <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/member/memberLogin';">돌아가기</button>
        </div>
        <input type="hidden" name="email" />
      </form>
    </div>
  </div>
  <jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
