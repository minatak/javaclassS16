<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항 작성 | HomeLink</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: 'pretendard' !important;
      background-color: #f8f8f8;
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
    .h2 {
      font-family: 'pretendard' !important;
      font-weight: 600;
      font-size: 24px;
      color: #333;
      text-align: center;
    }
    .form-group {
      margin-bottom: 20px;
    }
    label {
      font-weight: 500;
      margin-bottom: 5px;
      display: block;
    }
    select, input[type="text"], textarea, .btn {
      width: 100%;
      padding: 10px;
      border: 1px solid #e0e0e0;
      border-radius: 4px;
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
    .alert-info {
      background-color: #e8f4ea;
      border-color: #84a98c;
      color: #5a7d61;
      border-radius: 4px;
      padding: 10px;
      margin-bottom: 20px;
    }
    .explain {
      color: #aeaeae;
    }
    .radio-inline {
		  display: flex;
		  align-items: center;
		}
		
		.radio-inline input[type="radio"] {
		  margin-right: 5px;
		}
		
		.radio-inline label {
		  margin-right: 15px;
		  display: inline;
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
	  
	  function fCheck() {
	    let title = myform.title.value;
	    let content = CKEDITOR.instances.content.getData();
	    
	    if(title.trim() == "") {
	      showAlert("제목을 입력해주세요.");
	      myform.title.focus();
	      return false;
	    }
	    else if(content.trim() == "") {
	      showAlert("내용을 입력해주세요.");
	      CKEDITOR.instances.content.focus();
	      return false;
	    }
	    
	    myform.submit();
	  }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="inputContainer">
  <div class="header">
    <a href="${ctp}/notice/noticeList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
    <font size="5" class="mb-4 h2">공지사항 작성</font>
  </div>
 <!--  <div class="alert alert-info" role="alert">
    <strong>Tip:</strong> 중요한 정보를 공유해주세요.
  </div> -->
  <form name="myform" method="post">
    <div class="form-group">
      <label for="nickName">글쓴이</label>
      <input type="text" name="nickName" id="nickName" value="${sName}" readonly class="form-control"/>
    </div>
    <div class="form-group">
      <label for="title">글제목</label>
      <input type="text" name="title" id="title" placeholder="글제목을 입력하세요" autofocus required class="form-control" />
    </div>
    <div class="form-group">
      <label for="content">글내용</label>
      <textarea name="content" id="content" rows="6" class="form-control" required></textarea>
    </div>
    <script>
      CKEDITOR.replace("content",{
        height:480,
        filebrowserUploadUrl:"${ctp}/imageUpload",
        uploadUrl : "${ctp}/imageUpload"
      });
    </script>
    <div class="form-group">
		  <label>고정여부</label>
		  <div class="radio-inline">
		    <input type="radio" name="isPinned" id="isPinnedTrue" value="true" />
		    <label for="isPinnedTrue">고정</label>
		    <input type="radio" name="isPinned" id="isPinnedFalse" value="false" checked />
		    <label for="isPinnedFalse">고정 안 함</label>
		  </div>
		</div>
		<div class="form-group">
		  <label>중요도</label>
		  <div class="radio-inline">
		    <input type="radio" name="openSw" id="openSwTrue" value="true" />
		    <label for="openSwTrue">중요</label>
		    <input type="radio" name="openSw" id="openSwFalse" value="false" checked />
		    <label for="openSwFalse">일반</label>
		  </div>
		</div>
    <div class="form-group">
      <input type="button" value="글올리기" onclick="fCheck()" class="btn"/>
    </div>
    <div class="form-group">
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeList';" class="btn btn-back"/>
    </div>
    <input type="hidden" name="familyCode" value="${sFamCode}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>