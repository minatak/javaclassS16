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
  <script>
    'use strict';
    
    function fCheck() {
        let title = document.getElementById("title").value;
        let content = CKEDITOR.instances.content.getData();
        
        if(title.trim() == "") {
            alert("제목을 입력하세요");
            return false;
        }
        if(content.trim() == "") {
            alert("사진을 업로드하세요");
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

    // 파일 업로드 전 확장자 검사
    CKEDITOR.on('fileUploadRequest', function(evt) {
        var fileLoader = evt.data.fileLoader;
        var fileName = fileLoader.fileName;
        var fileExt = fileName.split('.').pop().toLowerCase();
        
        if (!['jpg', 'jpeg', 'png', 'gif'].includes(fileExt)) {
            evt.cancel();
            alert('지원되지 않는 파일 형식입니다. JPG, PNG, GIF 파일만 업로드 가능합니다.');
        }
    });
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<div class="container">
    <h2>앨범 업로드</h2>
    <hr/>
    <div class="alert alert-info" role="alert">
        <strong>주의:</strong> JPG, PNG, GIF 형식의 이미지만 업로드 가능합니다.
    </div>
    <form name="myform" method="post">
        <div class="input-group mb-2">
            <div class="input-group-prepend input-group-text">분 류</div>
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
        <div class="input-group mb-2">
            <div class="input-group-prepend input-group-text">제 목</div>
            <input type="text" name="title" id="title" class="form-control"/>
        </div>
        <div class="input-group mb-2">
            <div class="input-group-prepend input-group-text">설 명 (선택사항)</div>
            <textarea name="description" id="description" rows="3" class="form-control"></textarea>
        </div>
        <div class="mb-2">
				    <label for="content">사진 업로드</label>
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
				
				    CKEDITOR.instances.content.on('change', function() {
				        var content = this.getData();
				        if (content.replace(/<img[^>]*>/g,"").replace(/\s/g, "").length > 0) {
				            alert("텍스트를 입력할 수 없습니다. 이미지만 업로드해 주세요.");
				            this.setData(content.replace(/[^\s<img][^<>]*(?=>|$)/g, ""));
				        }
				    });
				</script>
        <div class="row">
            <div class="col"><input type="button" value="글올리기" onclick="fCheck()" class="btn btn-success"/></div>
            <div class="col text-right"><input type="button" value="돌아가기" onclick="location.href='${ctp}/photo/photoList';" class="btn btn-warning"/></div>
        </div>
        <input type="hidden" name="mid" value="${sMid}" />
    </form>
    <hr/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>