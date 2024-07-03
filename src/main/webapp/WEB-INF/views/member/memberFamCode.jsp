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

    .error-msg {
      color: red;
      margin-top: 5px;
      font-size: 12px;
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

    #generated-code {
      font-size: 18px;
      font-weight: bold;
      color: #007bff;
      margin-top: 10px;
    }

    .modal-body .code-input-group {
      display: flex;
      justify-content: space-between !important;
      margin-bottom: 10px;
    }

    .modal-body .code-input-group input {
      width: 12%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      text-align: center;
      font-size: 18px;
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

    function newFamilyCode() {
      const inputs = document.querySelectorAll('.code-input-group input');
      inputs.forEach(input => input.value = ''); // Clear all inputs
      inputs[0].focus(); // Focus on the first input

      $.ajax({
        type: 'POST',
        url: '${ctp}/family/createCode',
        success: function(response) {
          showAlert('나의 가족 코드가 생성되었습니다! 가족들에게 코드를 공유해 연결해보세요!');
          document.getElementById('generated-code').innerText = response.code; // Display the generated code
        },
        error: function() {
          showAlert('가족 코드 생성 중 오류가 발생했습니다. 다시 시도해주세요.');
        }
      });
    }

    function validateAndSubmit() {
      const inputs = document.querySelectorAll('.code-input-group input');
      let familyCode = '';
      inputs.forEach(input => {
        familyCode += input.value;
      });

      if (familyCode.length !== 8) {
        showErrorMsg('error-msg', '모든 입력란을 채워주세요.');
        return false;
      }

      // Add actual form submission logic here
      showAlert('가족 코드가 등록되었습니다.');
      return false; // Prevent actual form submission for demo purposes
    }

    document.addEventListener('DOMContentLoaded', () => {
      const inputs = document.querySelectorAll('.code-input-group input');
      inputs.forEach((input, index) => {
        input.addEventListener('input', (e) => {
          if (e.target.value.length === 1 && index < inputs.length - 1) {
            inputs[index + 1].focus();
          }
        });
        
        input.addEventListener('keydown', (e) => {
          if (e.key === 'Backspace' && e.target.value.length === 0 && index > 0) {
            inputs[index - 1].focus();
            inputs[index - 1].value = ''; // Clear the previous input
          }
        });
      });
    });
  </script>
</head>
<body>
  <div class="container">
    <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.jpg" width="130" alt="Logo"></a>
    <div class="code-container">
      <h3>가족 코드 등록</h3>
      <p>가족 코드를 입력해서 가족들과 연결 후 모든 기능을 누려보세요!</p>
      <div class="form-group">
        <button type="button" class="button" data-toggle="modal" data-target="#myModal">먼저 가입한 가족이 있는 경우</button>
      </div>

      <div class="form-group">
        <button type="button" id="generateButton" onclick="newFamilyCode()">코드 생성하기</button>
      </div>

      <div id="generated-code"></div>

      <!-- <div class="form-group">
        <button type="button" onclick="validateAndSubmit()">가족 코드 등록</button>
      </div> -->

      <!-- The Modal -->
      <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header text-center">
              <h4 class="modal-title">가족 코드 입력</h4>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
              <div class="form-group code-input-group" id="familyCodeDiv" colspan="8">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
              </div>
              <div id="error-msg" class="error-msg"></div>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer form-group">
              <button type="button" onclick="validateAndSubmit()">등록하기</button>
              <!-- <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->
            </div>

          </div>
        </div>
      </div>

    </div>
  </div>
</body>
</html>
