<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내 정보 | HomeLink</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      background-color: #fff;
      color: #333;
    }
    
    .page-container {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    
    .content-wrap {
      flex: 1;
      padding: 50px 0;
    }
    
    .infoContainer {
      max-width: 600px;
      margin: 0 auto;
      background-color: #fff;
      padding: 40px;
      border-radius: 10px;
    }
    
    .header {
      text-align: center;
      margin-bottom: 30px;
    }
    
    .header h2 {
      font-weight: 700;
      color: #333c47;
      margin-bottom: 10px;
    }
    
    .header p {
      color: #6c757d;
    }
    
    .form-group {
      margin-bottom: 25px;
    }
    
    .form-group label {
      font-weight: 600;
      color: #495057;
      margin-bottom: 8px;
      display: block;
    }
    
    .form-control {
      height: 50px;
      border: 1px solid #ced4da;
      border-radius: 5px;
      padding: 10px 15px;
      font-size: 16px;
      transition: border-color 0.3s ease;
      width: 100%;
    }
    
    .form-control:focus {
      border-color: #84a98c;
      box-shadow: none;
    }
    
    .btn {
      padding: 12px 20px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      transition: all 0.3s ease;
    }
    
    .error-message {
      color: #dc3545;
      font-size: 14px;
      margin-top: 5px;
    }
    
    .profile-photo {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 20px;
    }
    
    .edit-form {
      display: none;
    }
    
    .btn-save, .btn-cancel {
      margin-top: 10px;
      padding: 8px 15px;
		  border-radius: 5px;
		  font-size: 14px;
		  font-weight: 600;
    }
    .btn-save:hover, .btn-cancel:hover {
      color: white;	
    }
    
    .btn-save {
      background-color: #84a98c;
      color: white;
    }
    
    .btn-cancel {
      background-color: #6c757d;
      color: white;
    }
    
		.form-group label {
		  font-weight: 600;
		  color: #495057;
		  margin-bottom: 8px;
		  display: block;
		}
		
		.form-group p {
		  font-weight: 400;
		  color: #333;
		  margin-bottom: 0;
		  padding: 10px 0;
		  border-bottom: 1px solid #ced4da;
		}
		
		.edit-button {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  padding: 8px 15px;
		  border-radius: 5px;
		  font-size: 14px;
		  font-weight: 600;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  float: right;
		  margin-top: -40px;
		}
		
		.photo-upload-btn {
		  background-color: #84a98c;
		  color: #fff !important;
		  border: none;
		  padding: 10px 20px;
		  border-radius: 5px;
		  font-weight: 600;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  font-size: 14px;
		}
		
		.photo-upload-btn:hover {
		  background-color: #6b8e76;
		}
		
		.custom-file-input {
		  display: none;
		}   
		
		.deleteBtn {
			color : #f05650;
			text-decoration: none;
			font-weight: 600;
		}
		.deleteBtn:hover {
			color : #f05650;
			text-decoration: none;
			cursor: pointer;
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
		.swal2-cancel {
		  background-color: white !important;
		  color: black !important;
		  border-radius: 0px !important;
		  box-shadow: none !important;
		  /* font-weight: bold !important; */
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
		.custom-swal-input {
		  width: 90% !important;
		  margin: 10px auto !important;
		}  
		
		.loading-container {
		  display: none;
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 100%;
		  background-color: rgba(255, 255, 255, 0.8);
		  justify-content: center;
		  align-items: center;
		  z-index: 1000;
		}
		
		.loading-container.show {
		  display: flex;
		}
		
		.loading-spinner {
		  width: 40px;
		  height: 40px;
		  border: 3px solid #f3f3f3;
		  border-top: 3px solid #3498db;
		  border-radius: 50%;
		  animation: spin 1s linear infinite;
		}
		
		@keyframes spin {
		  0% { transform: rotate(0deg); }
		  100% { transform: rotate(360deg); }
		}
		
  </style>
  <script>
    'use strict';
    
 
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
    
    function showConfirm(message, confirmCallback, cancelCallback) {
		 Swal.fire({
		   html: message,
		   showCancelButton: true,
		   cancelButtonText: '아니요',
		   confirmButtonText: '네',
		   customClass: {
		     cancelButton: 'swal2-cancel',
		     confirmButton: 'swal2-confirm',
		     popup: 'custom-swal-popup',
		     htmlContainer: 'custom-swal-text'
		   },
		   scrollbarPadding: false,
		   allowOutsideClick: false,
		   heightAuto: false
		 }).then((result) => {
		   if (result.isConfirmed && confirmCallback) {
		     confirmCallback();
		   } else if (result.isDismissed && cancelCallback) {
		     cancelCallback();
		   }
		 });
		}
    
    function editField(field) {
      document.getElementById(field + 'Display').style.display = 'none';
      document.getElementById(field + 'Edit').style.display = 'block';
    }

    function cancelEdit(field) {
      document.getElementById(field + 'Display').style.display = 'block';
      document.getElementById(field + 'Edit').style.display = 'none';
    }

    function saveField(field) {
      const newValue = document.getElementById(field + 'Input').value;
      
      if (!validateField(field, newValue)) {
        return;
      }
      
      $.ajax({
        type: 'POST',
        url: '${ctp}/member/updateField',
        data: { 
          field: field,
          value: newValue,
          mid: '${sMid}'
        },
        success: function(response) {
          if(response === 'success') {
            document.getElementById(field + 'Value').textContent = newValue;
            cancelEdit(field);
            showAlert("정보가 변경되었습니다.", function() {
	        		location.reload(); 
	        	});
          } else {
            showAlert('정보 업데이트에 실패했습니다. 다시 시도해주세요.');
          }
        },
        error: function() {
          showAlert('서버와의 통신 중 오류가 발생했습니다.');
        }
      });
    }

    function validateField(field, value) {
      switch(field) {
        case 'name':
          if (!/^[가-힣a-zA-Z]+$/.test(value)) {
            showAlert('이름은 한글과 영문 대소문자만<br/>사용 가능합니다.');
            return false;
          }
          break;
        case 'email':
          if (!/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/.test(value)) {
            showAlert('올바른 이메일 형식이 아닙니다.');
            return false;
          }
          break;
        case 'relationship':
          if (!value) {
            showAlert('가족관계를 선택해주세요.');
            return false;
          }
          break;
      }
      return true;
    }

    function updatePhoto() {
		  const formData = new FormData(document.getElementById('photoForm'));
		  
		  $.ajax({
		    type: 'POST',
		    url: '${ctp}/member/updatePhoto',
		    data: formData,
		    processData: false,
		    contentType: false,
		    success: function(response) {
		      if(response === 'success') {
		        showAlert("프로필 사진이 변경되었습니다.", function() {
		        	location.reload(); 
		        	/* document.getElementById('photoDemo').src = '${ctp}/member/' + response + '?' + new Date().getTime(); */
		        });
		      } else {
		        showAlert('프로필 사진 업데이트에 실패했습니다. 다시 시도해주세요.');
		      }
		    },
		    error: function() {
		      showAlert('서버와의 통신 중 오류가 발생했습니다.');
		    }
		  });
		}
		
		function imgCheck(input) {
		  if (input.files && input.files[0]) {
		    const reader = new FileReader();
		    
		    reader.onload = function(e) {
		      document.getElementById('photoDemo').src = e.target.result;
		    }
		    
		    reader.readAsDataURL(input.files[0]);
		    updatePhoto();
		  }
		}

    function memberDelete() {
   	  Swal.fire({
   	    html: '<div style="font-size: 18px; font-weight: bold; margin-bottom: 10px;">회원 탈퇴</div>' +
               '<input type="password" id="password" class="swal2-input custom-swal-input" placeholder="현재 비밀번호를 입력하세요">',
   	    showCancelButton: true,
   	    confirmButtonText: '확인',
   	    cancelButtonText: '취소',
   	    customClass: {
   	      confirmButton: 'swal2-confirm',
   	      cancelButton: 'swal2-cancel',
   	      popup: 'custom-swal-popup',
   	      htmlContainer: 'custom-swal-text',
   	      input: 'custom-swal-input'
   	    },
   	    scrollbarPadding: false,
   	    allowOutsideClick: false,
   	    heightAuto: false,
   	    preConfirm: () => {
   	      const password = document.getElementById('password').value;
   	      if (!password) {
   	        Swal.showValidationMessage('비밀번호를 입력해주세요');
   	      }
   	      return { password: password };
   	    }
   	  }).then((result) => {
   	    if (result.isConfirmed) {
   	      const password = result.value.password;
   	      
   	      $.ajax({
   	        type: 'POST',
   	        url: '${ctp}/member/checkPassword',
   	        data: { 
   	          pwd: password
   	        },
   	        success: function(response) {
   	          if(response === '1') {
   	            showConfirm('정말 탈퇴하시겠습니까?<br>탈퇴 시 해당 아이디의 모든 콘텐츠가<br>삭제됩니다.', 
   	              function() {
   	                location.href = '${ctp}/member/userDel';
   	              }
   	            );
   	          } else {
   	            showAlert('비밀번호가 일치하지 않습니다.');
   	          }
   	        },
   	        error: function() {
   	          showAlert('서버와의 통신 중 오류가 발생했습니다.');
   	        }
   	      });
   	    }
   	  });
   	}
    
    function showLoading() {
   	  document.getElementById('loading-container').classList.add('show');
   	}

   	function hideLoading() {
   	  document.getElementById('loading-container').classList.remove('show');
   	}

   	function sendVerificationCode() {
   	  let email = document.getElementById('emailInput').value.trim();

   	  if (email === "") {
   	    showAlert("이메일을 입력하세요");
   	    return;
   	  }

   	  showLoading();

   	  $.ajax({
   	    type: 'POST',
   	    url: '${ctp}/member/joinEmailCheck',
   	    data: { email: email },
   	    success: function(response) {
   	      if(response == "alreadyMember") {
   	    	showAlert("이미 가입되어있는 이메일입니다");
   	      }
   	      else {
   	        ResponseCode = response;
   	        sessionStorage.setItem('sEmailKey', ResponseCode);
   	        showAlert("인증 코드가 전송되었습니다");
   	        document.getElementById('verificationSection').style.display = "block";
   	        document.getElementById('sendCodeBtn').style.display = "none";
   	      }
   	    },
   	    error: function() {
   	      showAlert("인증 코드 전송 중 오류가 발생했습니다<br/>다시 시도해주세요");
   	    },
   	    complete: function() {
   	      hideLoading();
   	    }
   	  });
   	}

   	function verifyAndSaveEmail() {
   	  const newEmail = document.getElementById('emailInput').value;
   	  const verificationCode = document.getElementById('verificationCode').value;
   	  
   	  showLoading();

   	  $.ajax({
   	    type: 'POST',
   	    url: '${ctp}/member/verifyAndUpdateEmail',
   	    data: { 
   	      email: newEmail,
   	      verificationCode: verificationCode
   	    },
   	    success: function(response) {
   	      if(response === 'success') {
   	        document.getElementById('emailValue').textContent = newEmail;
   	        cancelEdit('email');
   	        showAlert("이메일이 성공적으로 변경되었습니다.");
   	      } else {
   	        showAlert('이메일 변경에 실패했습니다. 다시 시도해주세요.');
   	      }
   	    },
   	    error: function() {
   	      showAlert('서버와의 통신 중 오류가 발생했습니다.');
   	    },
   	    complete: function() {
   	      hideLoading();
   	    }
   	  });
   	}

   	function cancelEdit(field) {
   	  document.getElementById(field + 'Display').style.display = 'block';
   	  document.getElementById(field + 'Edit').style.display = 'none';
   	  if(field === 'email') {
   	    document.getElementById('verificationSection').style.display = 'none';
   	    document.getElementById('sendCodeBtn').style.display = 'block';
   	  }
   	}
    
  </script>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/nav.jsp" %>
  <div class="page-container">
    <div class="content-wrap">
      <div class="infoContainer">
        <div class="header">
          <h2>내 정보 설정</h2>
          <p>본인확인이 필요한 경우 사용할 정보이므로 정확하게 입력해주세요</p>
        </div>
        
        <form id="photoForm" enctype="multipart/form-data">
          <div class="text-center mb-5">
            <img src="${ctp}/member/${vo.photo}" id="photoDemo" class="profile-photo"/>
            <div class="custom-file">
              <input type="file" class="custom-file-input" name="fName" id="file" onchange="imgCheck(this)">
              <label for="file" class="photo-upload-btn">사진 변경</label>
            </div>
          </div>
        </form>

        <div class="form-group">
          <label for="mid">아이디</label>
          <p id="midValue">${sMid}</p>
        </div>


        <div class="form-group" id="nameDisplay">
          <label for="name">이름</label>
          <p id="nameValue">${vo.name}</p>
          <button type="button" class="edit-button" onclick="editField('name')">변경</button>
        </div>
        <div class="form-group edit-form" id="nameEdit">
          <label for="nameInput">이름</label>
          <input type="text" class="form-control" id="nameInput" value="${vo.name}">
          <button type="button" class="btn btn-save" onclick="saveField('name')">저장</button>
          <button type="button" class="btn btn-cancel" onclick="cancelEdit('name')">취소</button>
        </div>

        <div class="form-group" id="emailDisplay">
				  <label for="email">이메일</label>
				  <p id="emailValue">${vo.email}</p>
				  <button type="button" class="edit-button" onclick="editField('email')">변경</button>
				</div>
				<div class="form-group edit-form" id="emailEdit" style="display: none;">
				  <label for="emailInput">이메일</label>
				  <input type="email" class="form-control" id="emailInput" value="${vo.email}">
				  <button type="button" class="btn btn-cancel mt-2" id="sendCodeBtn" onclick="sendVerificationCode()">인증번호 발송</button>
				  <div id="verificationSection" style="display: none;"> 
				    <input type="text" class="form-control mt-2" id="verificationCode" placeholder="인증번호 입력">
				    <div class="mt-2">
				      <button type="button" class="btn btn-save" onclick="verifyAndSaveEmail()">인증 및 저장</button>
				      <button type="button" class="btn btn-cancel" onclick="cancelEdit('email')">취소</button>
				    </div>
				  </div>
				</div>

        <div class="form-group" id="relationshipDisplay">
          <label for="relationship">가족관계</label>
          <p id="relationshipValue">${vo.relationship}</p>
          <button type="button" class="edit-button" onclick="editField('relationship')">변경</button>
        </div>
        <div class="form-group edit-form" id="relationshipEdit">
          <label for="relationshipInput">가족관계</label>
          <select class="form-control" id="relationshipInput">
            <option value="">선택하기</option>
            <option ${vo.relationship == '엄마' ? 'selected' : ''}>엄마</option>
            <option ${vo.relationship == '아빠' ? 'selected' : ''}>아빠</option>
            <option ${vo.relationship == '딸' ? 'selected' : ''}>딸</option>
            <option ${vo.relationship == '아들' ? 'selected' : ''}>아들</option>
            <option ${vo.relationship == '할머니' ? 'selected' : ''}>할머니</option>
            <option ${vo.relationship == '할아버지' ? 'selected' : ''}>할아버지</option>
          </select>
          <button type="button" class="btn btn-save" onclick="saveField('relationship')">저장</button>
          <button type="button" class="btn btn-cancel" onclick="cancelEdit('relationship')">취소</button>
        </div>

        <div class="form-group" style="border-bottom: 1px solid #ced4da;">
          <label>비밀번호</label> 
          <button type="button" class="edit-button" onclick="location.href = '/pwdChange'">비밀번호 재설정</button>
        </div>
				
        <div class="form-group mt-5">
				  <label>회원 탈퇴</label>
				  <span class="text-muted mb-3">회원 탈퇴 시 모든 데이터가 삭제되며 복구할 수 없습니다.</span> 
				  <a class="deleteBtn" href="javascript:memberDelete()">회원 탈퇴 진행</a>
				</div>
        
      </div>
    </div>
    
    <div id="loading-container" class="loading-container">
		  <div class="loading-spinner"></div>
		</div>
    
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>