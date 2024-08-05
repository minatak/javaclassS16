<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/favicon.png">
  <title>사진 업로드 | HomeLink</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
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
	  .btn-upload:hover {
	    background-color: #6b8c72;
	    color: white;
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
  	  let title = myform.title.value.trim();
  	  let description = myform.description.value.trim();
  	  let content = CKEDITOR.instances.content.getData();
  	  let textContent = content.replace(/<p>\s*<img [^>]+>\s*<\/p>/g, "").replace(/<[^>]+>/g, "").trim();
  	  
  	  if(title == "") {
  	    showAlert("제목을 입력해주세요", function() {
  	      myform.title.focus();
  	    });
  	    return false;
  	  }
  	  
  	  if(title.length > 50) {
  	    showAlert("제목은 50자 이내로 작성해주세요", function() {
  	      myform.title.focus();
  	    });
  	    return false;
  	  }
  	  
  	  if(description.length > 99) {
  	    showAlert("설명은 100자 이내로 작성해주세요", function() {
  	      myform.description.focus();
  	    });
  	    return false;
  	  }
  	  
  	  if(content.trim() == "") {
  	    showAlert("사진을 업로드해주세요");
  	    return false;
  	  }
  	  
  	  if (textContent.length > 0) {
  	    showAlert("사진 업로드 칸에는 텍스트를 입력할 수 없습니다.");
  	    return false;
  	  }
  	  
  	  // 이미지 확장자 검사
  	  let imgRegex = /<img[^>]+src="([^">]+)"/g;
  	  let match;
  	  let invalidFiles = [];
  	  
  	  while (match = imgRegex.exec(content)) {
  	    let imgSrc = match[1];
  	    let fileExt = imgSrc.split('.').pop().toLowerCase();
  	    
  	    if (!['jpg', 'jpeg', 'png', 'gif'].includes(fileExt)) {
  	      invalidFiles.push(imgSrc.split('/').pop());
  	    }
  	  }
  	  
  	  if (invalidFiles.length > 0) {
  	    showAlert("지원되지 않는 파일 형식이 포함되어있어요. JPG, PNG, GIF 파일만 업로드 가능해요!");
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
  <a href="${ctp}/photo/photoList" class="home-icon"><i class="fa-solid fa-circle-arrow-left"></i></a>&nbsp; &nbsp;
    <font size="5" class="mb-4 h2">새로운 순간 공유하기</font>
  </div>
  <div class="alert alert-info" role="alert">
    <strong>Tip:</strong> JPG, PNG, GIF 형식의 이미지를 공유해보세요.
  </div>
  <form name="myform" method="post">
  	<div class="form-group">
		  <label for="title">제목 <span class="explain">필수사항</span></label>
		  <input type="text" name="title" id="title" class="form-control" required>
		</div>
    <div class="form-group">
      <label for="content">사진 업로드 <span class="explain">파일의 사진을 끌어와주세요! 여러장의 사진 업로드도 가능합니다. </span></label>
      <textarea name="content" id="content" rows="10" class="form-control" required></textarea>
    </div>
    <script>
			CKEDITOR.replace("content", {
		    height: 400,
		    filebrowserUploadUrl: "${ctp}/photo/imageUpload",
		    uploadUrl: "${ctp}/photo/imageUpload",
		    removePlugins: 'elementspath',
		    resize_enabled: false,
		    extraPlugins: 'uploadimage',
		    toolbar: [
		        { name: 'insert', items: [ 'Image' ] },
		        { name: 'tools', items: [ 'Maximize' ] }
		    ],
		    removeButtons: 'PasteFromWord'
			});
		</script>
		<div class="form-group">
      <label for="description">설명 <span class="explain">선택사항</span></label>
      <textarea name="description" id="description" rows="3" class="form-control" placeholder="이 순간에 대해 더 자세히 알려주세요"></textarea>
    </div>
    <div class="form-group">
      <button type="button" onclick="fCheck()" class="btn btn-upload">공유하기</button>
    </div>
    <div class="form-group">
      <button type="button" onclick="location.href='${ctp}/photo/photoList';" class="btn btn-back">돌아가기</button>
    </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>