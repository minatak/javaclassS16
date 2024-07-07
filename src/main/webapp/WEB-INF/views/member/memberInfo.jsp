<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내 정보 | HomeLink</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      background-color: #f4f4f4;
    }
    .container {
      max-width: 600px;
      background-color: #fff;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
    h1 {
      color: #333;
      margin-bottom: 20px;
      font-size: 24px;
      font-weight: bold;
    }
    .form-group {
      margin-bottom: 20px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-group input[type="text"],
    .form-group input[type="email"],
    .form-group input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    .form-group button {
      background-color: #f0f0f0;
      border: none;
      padding: 5px 10px;
      border-radius: 5px;
      cursor: pointer;
      color: #333;
    }
    .error-message {
      color: red;
      font-size: 12px;
      margin-top: 5px;
    }
    #loading-container {
      display: none;
    }
    #loading-container.show {
      display: block;
    }
    .edit-button {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 5px 10px;
      border-radius: 5px;
      cursor: pointer;
    }
  </style>
  <script>
    'use strict';
    
    let emailCheckSw = 0;
    let timer;

    function innerReset() {
      document.getElementById('nameError').innerHTML = "";
      document.getElementById('emailError').innerHTML = "";
    }

    window.onload = function() {
        let nameInput = document.myform.name;
        let emailInput = document.myform.email;

        nameInput.oninput = function() {
            innerReset();
            let regName = /^[가-힣a-zA-Z]+$/;

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

        let regName = /^[가-힣a-zA-Z]+$/;
        let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

        if(name == "") {
            showAlert("이름을 입력하세요");
            document.myform.name.focus();
            return false;
        }
        else if(email == "") {
            showAlert("이메일을 입력하세요");
            document.myform.email.focus();
            return false;
        }
        else if (!regName.test(name)) {
            showErrorMsg("nameError", "이름은 한글과 영문대소문자만 사용가능합니다");
            document.myform.name.focus();
            return false;
        }
        else if (!regEmail.test(email)) {
            showErrorMsg("emailError", "올바른 이메일 형식이 아닙니다");
            document.myform.email.focus();
            return false;
        }
        else if(emailCheckSw != 1) {
            showAlert("이메일을 인증해주세요");
            return false;
        }
        else {
            myform.submit();
        }
    }

    function timer_start() {
        let timeLeft = 300; // 5분
        timer = setInterval(function() {
            if (timeLeft <= 0) {
                clearInterval(timer);
                document.getElementById('timer').textContent = "0:00";
                showAlert("시간이 초과되었습니다<br/>인증번호를 다시 발급해주세요");
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

    function editField(field) {
        const fieldElement = document.getElementById(field);
        const fieldValue = fieldElement.innerText;
        const inputElement = document.createElement('input');
        inputElement.type = field === 'password' ? 'password' : 'text';
        inputElement.value = fieldValue;
        inputElement.className = 'form-control';
        
        const saveButton = document.createElement('button');
        saveButton.innerText = '저장';
        saveButton.className = 'btn btn-primary mt-2';
        saveButton.onclick = function() {
          fieldElement.innerText = inputElement.value;
          fieldElement.parentNode.replaceChild(fieldElement, inputElement);
          this.remove();
        };
        
        fieldElement.parentNode.replaceChild(inputElement, fieldElement);
        inputElement.parentNode.appendChild(saveButton);
      }

      function imgCheck(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function(e) {
            document.getElementById('photoDemo').src = e.target.result;
          };
          reader.readAsDataURL(input.files[0]);
        }
      }
    </script>
  </head>
  <body>
    <%@ include file="/WEB-INF/views/include/nav.jsp" %>

    <div class="container">
      <h1>내 정보 설정</h1>
      <p>본인확인이 필요한 경우 사용할 정보이므로, 정확하게 입력해주세요</p>
      
      <form name="myform" method="post" action="${ctp}/member/memberUpdateOk" enctype="multipart/form-data">
        <div class="form-group">
          <label>회원 사진</label>
          <img src="${ctp}/member/${vo.photo}" width="100px" id="photoDemo"/>
          <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
        </div>
        
        <div class="form-group">
          <label>아이디</label>
          <span id="mid">${vo.mid}</span>
        </div>
        
        <div class="form-group">
          <label>이름</label>
          <span id="name">${vo.name}</span>
          <button type="button" class="edit-button" onclick="editField('name')">변경</button>
          <div id="nameError" class="error-message"></div>
        </div>
        
        <div class="form-group">
          <label>이메일</label>
          <span id="email">${vo.email}</span>
          <button type="button" class="edit-button" onclick="editField('email')">변경</button>
          <div id="emailError" class="error-message"></div>
          <button type="button" id="sendCodeBtn" onclick="sendVerificationCode()" class="btn btn-secondary mt-2" style="display:none;">인증번호 받기</button>
          <div id="loading-container">인증번호 전송중...</div>
          <div id="auth_container" style="display:none;">
            <input type="text" name="verificationCode" placeholder="인증번호 입력" class="form-control mt-2">
            <button type="button" onclick="verifyCode()" class="btn btn-secondary mt-2">인증하기</button>
            <span id="timer"></span>
            <div id="codeError" class="error-message"></div>
          </div>
        </div>
        
        <div class="form-group">
          <label>비밀번호</label>
          <span id="password">********</span>
          <button type="button" class="edit-button" onclick="editField('password')">변경</button>
        </div>

        <div class="form-group">
          <input type="button" value="정보수정" onclick="fCheck()" class="btn btn-primary"/>
        </div>

        <input type="hidden" name="mid" value="${sMid}" />
        <input type="hidden" name="photo" id="photo" value="${vo.photo}" />
      </form>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
  </html>