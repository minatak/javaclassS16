<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>사진 업로드 | HomeLink</title>
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
	</style>
  <script>
    'use strict';
    
    function fCheck() {
        let title = document.getElementById("title").value;
        let content = CKEDITOR.instances.content.getData();
        
        if(title.trim() == "") {
            alert("제목을 입력해주세요");
            return false;
        }
        if(content.trim() == "") {
            alert("사진을 업로드해주세요");
            return false;
        }
        
        let textContent = content.replace(/<p>\s*<img [^>]+>\s*<\/p>/g, "").replace(/<[^>]+>/g, "").trim();
        if (textContent.length > 0) {
            alert("사진 업로드 칸에는 텍스트를 입력할 수 없습니다. 이미지만 업로드해주세요.");
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
            alert("지원되지 않는 파일 형식이 포함되어있어요. JPG, PNG, GIF 파일만 업로드 가능해요!");
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
      <label for="part">카테고리</label>
      <select name="part" id="part" class="form-control">
        <option value="풍경" selected>풍경</option>
        <option value="인물">인물</option>
        <option value="음식">음식</option>
        <option value="여행">여행</option>
        <option value="학습">학습</option>
        <option value="사물">사물</option>
        <option value="기타">기타</option>
      </select>
    </div>
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" name="title" id="title" class="form-control" placeholder="당신의 순간에 제목을 붙여주세요"/>
    </div>
    <div class="form-group">
      <label for="description">설명 <span class="explain">선택사항</span></label>
      <textarea name="description" id="description" rows="3" class="form-control" placeholder="이 순간에 대해 더 자세히 알려주세요"></textarea>
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
					      <button type="button" onclick="fCheck()" class="btn btn-upload">공유하기</button>
					    </div>
					    <div class="form-group">
					      <button type="button" onclick="location.href='${ctp}/photo/photoList';" class="btn btn-back">돌아가기</button>
					    </div>
					    <input type="hidden" name="mid" value="${sMid}" />
					  </form>
				</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>