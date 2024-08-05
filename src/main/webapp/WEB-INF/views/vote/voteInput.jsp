<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>투표 등록 | HomeLink</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
	  body {
	    font-family: 'pretendard' !important;
	    background-color: #fff;
	    color: #333;
	  }
	  .inputContainer {
	    max-width: 800px;
	    margin: 0 auto;
	    padding: 40px 20px;
	  }
	  .header {
	    margin-bottom: 30px;
	  }
	  .home-icon { 
	    font-size: 24px; 
	    color: #cecece; 
	  }
	  .home-icon:hover {color: #c6c6c6;}
	  .h2 {
	    font-family: 'pretendard' !important;
	    font-weight: 600;
	    font-size: 24px;
	    color: #333;
	    text-align: center;
	  }
	  .form-group {
	    margin-bottom: 30px;
	  }
	  label {
	    font-weight: 500;
	    margin-bottom: 5px;
	    display: block;
	  }
	  select, input[type="text"], input[type="datetime-local"], textarea, .btn {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #e0e0e0;
	    border-radius: 0px;
	    font-size: 14px;
	  }
	  .btn {
	    background-color: #84a98c;
	    color: white;
	    border: none;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	    font-weight: 600;
	  }
	  .btn:hover {
	    background-color: #6b8c72;
	  }
	  .btn-back {
	    background-color: #fff;
	    color: #84a98c;
	    border: 1px solid #84a98c;
	  }
	  .btn-back:hover {
	    color: #84a98c;
	    background-color: #f0f0f0;
	  }
	  .option-container {
	    margin-bottom: 10px;
	  }
	  .option-input {
	    display: flex;
	    align-items: center;
	  }
	  .option-input input {
	    flex-grow: 1;
	    margin-right: 10px;
	  }
	  .option-input button {
	    background: none;
	    border: none;
	    color: #cecece;
	    cursor: pointer;
	  }
	  .add-option {
	    color: #84a98c;
	    background: none;
	    border: none;
	    cursor: pointer;
	    padding: 5px 0;
	  }
	  .radio-inline {
	    display: flex;
	    gap: 20px;
	  }
	  .radio-inline label {
	    display: inline-flex;
	    align-items: center;
	    margin-bottom: 0;
	  }
	  .radio-inline input[type="radio"] {
	    margin-right: 5px;
	  }
	  .option-number {
	    display: inline-flex;
	    justify-content: center;
	    align-items: center;
	    width: 30px;
	    height: 27px;
	    background-color: #e0e0e0;
	    color: #333;
	    border-radius: 50%;
	    margin-right: 10px;
	    font-size: 14px;
	    font-weight: bold;
	  }
		.option-input {
		  display: flex;
		  align-items: center;
		}
		
		.option-input input {
		  flex-grow: 1;
		  margin-right: 10px;
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
    
    let optionCount = 2;

    function addOption() {
  	  const container = document.getElementById('optionsContainer');
  	  optionCount++;
  	  const newOption = document.createElement('div');
  	  newOption.className = 'option-container';
  	  newOption.innerHTML = `
  	    <div class="option-input">
  	      <span class="option-number"></span>
  	      <input type="text" name="options[]" placeholder="항목 입력" required>
  	      <button type="button" onclick="removeOption(this)"><i class="fa-solid fa-minus"></i></button>
  	    </div>
  	  `;
  	  container.appendChild(newOption);
  	  
  	  // 번호를 별도로 설정
  	  newOption.querySelector('.option-number').textContent = optionCount;
  	}

    function removeOption(button) {
      const container = document.getElementById('optionsContainer');
      if (container.children.length > 2) {
        button.closest('.option-container').remove();
        optionCount--;
        updateOptionNumbers();
      } else {
        showAlert('최소 2개의 항목이 필요합니다.');
      }
    }

    function updateOptionNumbers() {
      const options = document.querySelectorAll('.option-container');
      options.forEach((option, index) => {
        option.querySelector('.option-number').textContent = index + 1;
      });
    }

    function toggleEndTime() {
      const endTimeGroup = document.getElementById('endTimeGroup');
      const endTimeInput = document.getElementById('endTime');
      if (document.getElementById('noEndTime').checked) {
        endTimeGroup.style.display = 'none';
        endTimeInput.removeAttribute('required');
      } else {
        endTimeGroup.style.display = 'block';
        endTimeInput.setAttribute('required', '');
      }
    }
  
    function isValidEndTime(endTime) {
   	  const now = new Date();
   	  const selectedEndTime = new Date(endTime);
   	  return selectedEndTime > now;
   	}
    
    function fCheck() {
  	  let title = myform.title.value;
  	  let description = myform.description.value;
  	  let options = document.getElementsByName('options[]');
  	  let noEndTime = document.getElementById('noEndTime');
  	  let endTime = document.getElementById('endTime');
  	  
	  	if(title.trim() == "") {
	  	  showAlert("제목을 입력해주세요.", function() {
	  	    myform.title.focus();
	  	  });
	  	  return false;
	  	}
	  	else if (title.trim().length > 100) {
	  	  showAlert("제목은 100자 이내로 입력해주세요.", function() {
	  	    myform.title.focus();
	  	  });
	  	  return false;
	  	} 
	  	else if(description.trim() == "") {
	  	  showAlert("내용을 입력해주세요.", function() {
	  	    myform.description.focus();
	  	  });
	  	  return false;
	  	}
	  	else if(options.length < 2) {
	  	  showAlert("최소 두 개 이상의 항목을 입력해주세요.");
	  	  return false;
	  	}
	  	else if (!noEndTime.checked && endTime.value.trim() == "") {
	  	  showAlert("종료 시간을 입력해주세요.", function() {
	  	    endTime.focus();
	  	  });
	  	  return false;
   		} 
	  	else if (!noEndTime.checked && !isValidEndTime(endTime.value)) {
        showAlert("종료 시간은 현재 시간 이후로 설정해주세요", function() {
          endTime.focus();
        });
        return false;
      }
	  	else {
	  	  for(let i = 0; i < options.length; i++) {
	  	    if(options[i].value.trim() == "") {
	  	      showAlert("투표 항목을 입력해주세요.", function() {
	  	        options[i].focus();
	  	      });
	  	      return false;
	  	    }
	  	  }
	  	}

	  	if (noEndTime.checked) {
  	    document.myform.endTime.value = "";
  	  }
	  	
  	  document.myform.submit();
  	}
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="inputContainer">
  <div class="header">
	  <a href="${ctp}/vote/voteList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
	  <font size="5" class="mb-4 h2">투표 등록</font>
	</div>
  <form name="myform" method="post">
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" name="title" id="title" placeholder="제목을 작성해 주세요." autofocus required class="form-control" />
    </div>
    <div class="form-group">
      <label for="description">설명</label>
      <textarea name="description" id="description" rows="4" placeholder="투표 설명을 입력해 주세요." class="form-control" required></textarea>
    </div>
    <!-- <div class="form-group">
      <label for="part">분류</label>
      <input type="text" name="part" id="part" placeholder="투표 분류를 입력해 주세요. (예: 활동 관련)" class="form-control" required />
    </div> -->
    <div class="form-group">
      <label>투표 항목</label>
      <div id="optionsContainer">
			  <div class="option-container">
			    <div class="option-input">
			      <span class="option-number">1</span>
			      <input type="text" name="options[]" placeholder="항목 입력" required>
			      <button type="button" onclick="removeOption(this)"><i class="fa-solid fa-minus"></i></button>
			    </div>
			  </div>
			  <div class="option-container">
			    <div class="option-input">
			      <span class="option-number">2</span>
			      <input type="text" name="options[]" placeholder="항목 입력" required>
			      <button type="button" onclick="removeOption(this)"><i class="fa-solid fa-minus"></i></button>
			    </div>
			  </div>
			</div>
      <button type="button" class="add-option" onclick="addOption()">+ 항목 추가하기</button>
    </div>
    
		<div class="form-group" style="margin-bottom:15px;" id="endTimeGroup">
		  <label for="endTime">종료 시간</label>
		  <input type="datetime-local" name="endTime" id="endTime" class="form-control" required />
		</div>
		<div class="form-group">
		  <label>
		    <input type="checkbox" id="noEndTime" onchange="toggleEndTime()"> 종료시간 설정 안함
		  </label>
		</div>
    <div class="form-group">
      <label>익명 투표</label>
      <div class="radio-inline">
        <label><input type="radio" name="anonymous" value="true"> 예</label>
        <label><input type="radio" name="anonymous" value="false" checked> 아니오</label>
      </div>
    </div>
    <div class="form-group">
      <label>복수 선택</label>
      <div class="radio-inline">
        <label><input type="radio" name="multipleChoice" value="true"> 허용</label>
        <label><input type="radio" name="multipleChoice" value="false" checked> 허용 안함</label>
      </div>
    </div>
    <input type="hidden" name="memberIdx" value="${sIdx}">
    <input type="hidden" name="name" value="${sName}">
    <input type="hidden" name="familyCode" value="${sFamCode}">
    <div class="form-group" style="margin-bottom:15px;">
      <input type="button" value="등록하기" onclick="fCheck()" class="btn"/>
    </div>
    <div class="form-group">
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/vote/voteList';" class="btn btn-back"/>
    </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>