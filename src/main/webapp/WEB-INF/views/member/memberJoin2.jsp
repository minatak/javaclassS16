<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
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
      font-weight: bold;
    }

   	.form-group .fa {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(30%);
      cursor: pointer;
    }
		

    .mid input[type="text"] {
   	 	width: 70% !important;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-sizing: border-box;
      transition: border-color 0.3s;
      outline-width: 0.7px;
    }
    
    .form-group input[type="text"],
    .form-group input[type="password"],
    .form-group input[type="date"],
    .form-group input[type="file"] {
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
      background-color: #84a98c;
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
    
    .input_container {
      position: relative;
      display: inline-block;
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

    .error-msg {
      color: red;
      margin-top: 5px;
      font-size: 12px;
    }
    
    .checkBtn {
      background-color: #e6e6e6;
      padding: 10px 13px;
      text-decoration: none;
      font-weight: normal;
      border: none;
      border-radius: 10px;
      position: absolute;
      right: 0;
      top: 30px;
    }

    .checkBtn:hover {
      transition: background-color 0.3s;
      background-color: #d4d4d4;
    }
    
    .form-group select {
		  width: 100%;
		  padding: 10px;
		  border: 1px solid #ccc;
		  border-radius: 10px;
		  box-sizing: border-box;
		  transition: border-color 0.3s;
		  outline-width: 0.7px;
		  appearance: none;
		  -webkit-appearance: none;
		  -moz-appearance: none;
		  background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="6"><path d="M0 0l6 6 6-6z" fill="%23333"/></svg>') no-repeat right 10px center;
		  background-size: 12px;
		  background-color: white;
		}
		
		.form-group select:focus {
		  border-color: #84a98c;
		}
		
  </style>
  <script>
    'use strict';
    
    let idCheckSw = 0;
  
    function innerReset() { // 오류 메세지 초기화
      document.getElementById('midError').innerHTML = "";
      document.getElementById('pwdError').innerHTML = "";
    }

    window.onload = function() {
      let midInput = document.myform.mid;
      let pwdInput = document.myform.pwd;
      
      midInput.oninput = function() {
        innerReset();
        let regMid = /^[a-zA-Z0-9_]{4,20}$/; // 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
          
        if (!regMid.test(midInput.value)) {
          document.getElementById('midError').innerHTML = "아이디는 4~20자리의 영문 대소문자와 숫자, 언더바만 사용이 가능해요";
        }
      }
      
      pwdInput.oninput = function() {
        innerReset();
        let regPwd = /^[a-zA-Z0-9!@#$%^*+=-_]{8,16}$/   // 비밀번호는 8~16의 영문 대/소문자와 특수문자 숫자와 밑줄 가능
          
        if (!regPwd.test(pwdInput.value)) {
        	showErrorMsg("pwdError", "비밀번호는 8~16자리의 영문 대소문자와 특수문자, 숫자, 밑줄만 사용이 가능해요");
        }
      }
      
    };
      
    function fCheck() {
      let mid = myform.mid.value.trim();
      let pwd = myform.pwd.value.trim();
      let birthday = myform.birthday.value.trim();
      
      let regMid = /^[a-zA-Z0-9_]{4,20}$/; // 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
      let regPwd = /^[a-zA-Z0-9!@#$%^*+=-_]{8,16}$/;   // 비밀번호는 8~16의 영문 대/소문자와 특수문자 숫자와 밑줄 가능
      
  	  let submitFlag = 0;		// 체크 완료를 체크하기위한 변수. 체크가 완료되면 submitFlag=1 이 된다.
    
  	  if(mid == "") {
  		  showAlert("아이디를 입력하세요.", function() {
  		    document.myform.mid.focus();  // name을 mid로 수정했습니다.
  		  });
  		  return false;
  		}
  		else if (!regMid.test(mid)) {
  		  showAlert("아이디는 4~20자리의 영문 대소문자와 숫자, 언더바만 사용이 가능해요", function() {
  		    document.myform.mid.focus();
  		  });
  		  return false;
  		}
  		else if(pwd == "") {
  		  showAlert("비밀번호를 입력하세요.", function() {
  		    document.myform.pwd.focus();
  		  });
  		  return false;
  		}
  		else if (!regPwd.test(pwd)) {
  		  showAlert("비밀번호는 8~16자리의 영문 대소문자와 특수문자, 숫자, 밑줄만 사용이 가능해요", function() {
  		    document.myform.pwd.focus();
  		  });
  		  return false;
  		}
  		else if(idCheckSw == 0) {
  		  showAlert("아이디 중복체크버튼을 눌러주세요", function() {
  		    document.getElementById("midBtn").focus();
  		  });
  		  return false;  // return false를 추가했습니다.
  		}
  		else if(birthday == "") {
		    showAlert("생일을 입력하세요.", function() {
		      document.myform.birthday.focus();
		    });
		    return false;
		  }
		  else if(!isValidAge(birthday)) {
		    showAlert("유효하지 않은 생년월일입니다.<br/>다시 확인해주세요.", function() {
		      document.myform.birthday.focus();
		    });
		    return false;
		  }
  		else {
  		  submitFlag = 1;
  		}
       
	    // 전송전에 파일에 관련된 사항들을 체크해준다.
			let fName = document.getElementById("file").value;
			if(fName.trim() != "") {
				let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				let maxSize = 1024 * 1024 * 2;
				let fileSize = document.getElementById("file").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
					showAlert("그림파일만 업로드 가능합니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					showAlert("업로드할 파일의 최대용량은 2MByte입니다.");
					return false;
				}
				submitFlag == 1;
			}
			
			// 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리한다.
			if(submitFlag == 1) {
    		myform.submit();
    	}
			else {
				showAlert("회원가입에 실패했어요.<br/>폼의 내용을 확인하세요.");
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
    // 아이디 중복체크
    function idCheck() {
      let mid = myform.mid.value;
      
      if(mid.trim() == "") {
        showAlert("아이디를 입력하세요!");
        myform.mid.focus();
      }
      else {
        idCheckSw = 1;
        
        $.ajax({
          url  : "${ctp}/member/memberIdCheck",
          type : "get",
          data : {mid : mid},
          success:function(res) {
	      	  if(res != '0') {
	      		  showAlert("이미 사용중인 아이디입니다.", function() {
	      		    myform.mid.focus();
	      		  });
	      		}
	      		else {
	      		  showAlert("사용 가능한 아이디입니다.");
	      		}
          },
          error : function() {
            showAlert("전송 오류!");
          }
        });
      }
    }

    $(function(){
      $("#mid").on("blur", () => {
        idCheckSw = 0;
      });
    });
    
    
    $(function() {
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

    function isValidAge(birthday) {
  	  let today = new Date();
  	  let birthDate = new Date(birthday);
  	  let age = today.getFullYear() - birthDate.getFullYear();
  	  let monthDiff = today.getMonth() - birthDate.getMonth();
  	  
  	  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
  	    age--;
  	  }

  	  // 나이가 1살 미만이거나 120살 초과인 경우 유효하지 않은 것으로 간주
  	  return age >= 1 && age <= 120;
  	}
    
    
  </script>
</head>
<body>
  <div class="container">
  <a href="/javaclassS16/"><img src="${ctp}/resources/images/logo.png" width="130" alt="Logo"></a>  
      <h3 class="mt-3">회원가입</h3>
    <div class="login-container">
      <form name="myform" method="post" action="${ctp}/member/memberJoin2" class="was-validated" enctype="multipart/form-data">
        <div class="form-group mid">
          <label for="mid">아이디 *</label>
          <input type="text" id="mid" name="mid" placeholder="아이디를 입력해주세요." required>
          <input type="button" value="아이디 중복체크" id="midBtn" class="checkBtn" onclick="idCheck()"/>
          <div id="midError" class="error-msg"></div>
        </div>
        <div class="form-group">
          <label for="pwd">비밀번호 *</label>
          <input type="password" name="pwd" required placeholder="비밀번호를 입력해주세요.">
          <i class="fa fa-eye-slash" aria-hidden="true"></i>
          <div id="pwdError" class="error-msg"></div>
        </div>
        <div class="form-group">
          <label for="birthday">생일 *</label>
          <input type="date" name="birthday" required/>
        </div>
        <div class="form-group">
          <label for="file">프로필 사진</label>
          <input type="file" name="fName" id="file"/>
        </div>
        
        <div class="form-group">
				  <label for="relationship">가족관계</label>
				  <select name="relationship" id="relationship">
				    <option value="">선택하기</option>
				    <option>엄마</option>
				    <option>아빠</option>
				    <option>딸</option>
				    <option>아들</option>
				    <option>할머니</option>
				    <option>할아버지</option>
				  </select>
				</div>
        
        <input type="hidden" name="email" value="${email}"/>
        <input type="hidden" name="name" value="${name}"/>
        <div class="form-actions">
          <button type="button" class="back" onclick="window.history.back()">뒤로</button>
          <button type="button" class="next" onclick="fCheck()">다음</button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
