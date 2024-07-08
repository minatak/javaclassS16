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
	    flex-direction: column;
	    min-height: 100vh;
	    margin: 0;
	    background-color: #fff;
	  }
	  .page-container {
	    display: flex;
	    flex-direction: column;
	    min-height: 100vh;
	  }
	  .content-wrap {
	    flex: 1;
	    display: flex;
	    justify-content: center;
	    text-align: center; 
	    align-items: center;
	    padding: 20px 0;
	  }
	  .famContainer {
	    justify-content: center;
	    max-width: 600px;  
	    width: 100%;
	    background-color: #fff;
	    padding: 40px;
	  }

    .code-container {
		  align-items: center; /* 추가 */
      background: #fff;
      padding: 0px;
      margin-top: 0px;
      width: 100%;
      max-width: 400px;
      border-radius: 15px;
    }

    h3 {
      font-weight: 800;
      margin-bottom: 20px;
      color: #333;
    }

    .welcome-text {
      margin-bottom: 10px;
    }

    .form-group {
      margin-bottom: 25px;
      text-align: left;
      display: flex;
      flex-direction: column;
    }

    .form-group label {
      display: block;
      margin-bottom: 10px;
      font-weight: bold;
      color: #555;
    }

    .code-input-group {
      display: flex;
      flex-direction: row;
      justify-content: space-between !important;
    }

    .code-input-group input {
      width: calc(12.5% - 10px);
      padding: 12px;
      border: 2px solid #ccc;
      border-radius: 8px;
      text-align: center;
      font-size: 18px;
    }

    .form-group button {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      background-color: #f0f4f8;
      border: 1px solid #ccc;
      color: #333;
      border-radius: 10px;
      cursor: pointer;
    }

    .form-group button:hover {
      background-color: #eaeaea;
    }

    .error-msg {
      color: #e63946;
      margin-top: 8px;
      font-size: 14px;
    }

    .swal2-confirm {
      background-color: white !important;
      color: black !important;
      border-radius: 8px !important;
      box-shadow: none !important;
      font-weight: bold !important;
      font-size: 18px !important;
      margin: 0 !important;
      border: 2px solid #ccc !important;
    }

    .swal2-confirm:hover {
      background-color: #e0e0e0 !important;
    }

    .custom-swal-popup {
      width: 350px !important;
      padding-top: 20px !important;
      border-radius: 15px !important;
    }

    #generated-code {
      font-size: 24px;
      font-weight: bold;
      color: #457b9d;
      margin-top: 20px;
      padding: 15px;
      background-color: #f0f4f8;
      border-radius: 10px;
    }

    .modal-content {
      border-radius: 15px;
    }

    .modal-header {
      border-bottom: none;
      padding: 25px 25px 15px;
    }

    .modal-title {
      width: 100%;
      text-align: center;
      font-weight: bold;
      color: #333;
    }

    .modal-body {
      padding: 25px;
    }

    .modal-footer {
      border-top: none;
      padding: 15px 25px 25px;
    }

    .modal-footer button {
      width: 100%;
      padding: 14px;
      background-color: #333;
      color: white;
      border: none;
      border-radius: 8px;
      /* font-weight: bold; */
    }

    .modal-footer button:hover {
      background-color: #555;
    }

    .close {
      font-size: 28px;
      font-weight: normal;
      opacity: 0.7;
    }

    .close:hover {
      opacity: 1;
    }

    .my-code {
	    font-size: 24px;
	    font-weight: bold;
	    margin: 0px 0;
	    margin-top : 15px;
	    padding: 15px;
	  	background-color: #dfdfdf;   /* 연한 초록색 배경 */
	    border-radius: 10px;
	    text-align: center;  /* 가운데 정렬 */
	  }
	
	  .my-code-label {
	    color: #000000;  /* 검정색 */
	  }
	
	  .my-code-value {
	    color: #5d9469;  /* 초록색 */
	  }

    .register-code-button {
      font-size: 14px;
      padding: 10px;
      margin-top: 10px;
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
        },
        scrollbarPadding: false,
        allowOutsideClick: false,
        heightAuto: false,
        didOpen: () => {
          document.body.style.paddingRight = '0px';
        }
      });
    }

    function newFamilyCode() {
      const inputs = document.querySelectorAll('.code-input-group input');
      inputs.forEach(input => input.value = '');
      inputs[0].focus();

      $.ajax({
        type: 'POST',
        url: '${ctp}/member/createCode',
        success: function(response) {
          showAlert('나의 가족 코드가 생성되었습니다! 가족들에게 코드를 공유해 연결해보세요!');
          location.reload();
        },
        error: function() {
          showAlert('가족 코드 생성 중 오류가 발생했습니다.<br/>다시 시도해주세요.');
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

      $.ajax({
        type: 'POST',
        url: '${ctp}/member/connectCode',
        data: { familyCode: familyCode },
        success: function(response) {
          if (response === 'success') {
            $('#myModal').modal('hide');
            location.href = "${ctp}/message/successFamCode";
          } else {
            showErrorMsg('error-msg', '유효하지 않은 가족 코드입니다. 다시 확인해주세요.');
          }
        },
        error: function() {
          showAlert('가족 코드 등록 중 오류가 발생했습니다.<br/>다시 시도해주세요.');
        }
      });
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
            inputs[index - 1].value = '';
          }
        });
      });
    });
  </script>
</head>
<body>
	<%@ include file = "/WEB-INF/views/include/nav.jsp" %>
  	<div class="page-container">
    	<div class="content-wrap">
			  <div class="famContainer">
			    <%-- <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a> --%>
			    <h3 class="m-2 mb-3">가족 코드 등록</h3>
			    <c:if test="${empty sFamCode}">
			    	<p class="welcome-text">${sName}님 환영합니다 :)<br>가족 코드를 연결 후 모든 기능을 누려보세요!</p>
			    </c:if>
			    <div class="code-container" id="code-container" style="width:600px;margin:0 auto;">
			    	<c:if test="${!empty sFamCode}">
						  <div class="form-group">
						    <div class="my-code">
						      <span class="my-code-label">내 코드 : </span>
						      <span class="my-code-value">${sFamCode}</span>
						    </div>
						  </div>
						  <div class="form-group">
					    	<button type="button" class="button register-code-button" data-toggle="modal" data-target="#myModal">코드 등록하기</button>
					  	</div>
						</c:if>
			      
			      <c:if test="${empty sFamCode}">
			      	<div class="mt-5">
				        <div class="form-group">
				          <label>먼저 가입한 가족이 있나요?</label>
				          <button type="button" class="button" data-toggle="modal" data-target="#myModal">코드 등록하기</button>
				        </div>
				        <div class="form-group">
				          <label>가족중에 첫번째로 가입했어요!</label>
				          <button type="button" id="generateButton" onclick="newFamilyCode()">코드 만들기</button>
				        </div>
			        </div>
			      </c:if>
			    </div>
			    
			    <div id="code-result" style="display: none;">
			      <div id="generated-code"></div>
			    </div>
			
			    <!-- The Modal -->
			    <div class="modal fade" id="myModal">
			      <div class="modal-dialog modal-dialog-centered">
			        <div class="modal-content">
			          <!-- Modal Header -->
			          <div class="modal-header">
			            <h4 class="modal-title">가족 코드 입력</h4>
			            <button type="button" class="close" data-dismiss="modal">&times;</button>
			          </div>
			
			          <!-- Modal body -->
			          <div class="modal-body">
			            <div class="form-group code-input-group" id="familyCodeDiv">
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
			          <div class="modal-footer">
			            <button type="button" onclick="validateAndSubmit()">등록하기</button>
			          </div>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</div>	

</body>
</html>