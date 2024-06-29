<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
/*
	// 로그인창에 아이디 체크 유무에 대한 처리
	// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력창에 뿌릴수 있게 한다.
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				pageContext.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
	}
*/
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberLogin.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
  	body {
    font-family: 'Arial', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #f7f7f7;
	}
	
	.login-container {
	    text-align: center;
	    background: #fff;
	    padding: 20px 40px;
	    border-radius: 8px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	    width: 100%;
	    max-width: 400px;
	}
	
	.logo {
	    font-size: 36px;
	    color: #35ae5f;
	    margin-bottom: 20px;
	}
	
	h2 {
	    margin-bottom: 20px;
	}
	
	.input-group {
	    margin-bottom: 15px;
	    text-align: left;
	}
	
	.input-group label {
	    display: block;
	    margin-bottom: 5px;
	    font-weight: bold;
	}
	
	.input-group input[type="text"],
	.input-group input[type="password"] {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-sizing: border-box;
	}
	
	.input-group input[type="checkbox"] {
	    margin-right: 10px;
	}
	
	.input-group .fa {
	    position: absolute;
	    right: 20px;
	    top: 65%;
	    transform: translateY(-50%);
	    cursor: pointer;
	}
	
	.login-button {
	    width: 100%;
	    padding: 10px;
	    background-color: #35ae5f;
	    border: none;
	    border-radius: 4px;
	    color: white;
	    font-size: 16px;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	.login-button:hover {
	    background-color: #2a9a4b;
	}
	
	.login-links {
	    margin: 20px 0;
	}
	
	.login-links a {
	    color: #333;
	    text-decoration: none;
	    margin: 0 5px;
	}
	
	.login-links a:hover {
	    text-decoration: underline;
	}
	
	.footer {
	    font-size: 12px;
	    color: #777;
	    margin-top: 20px;
	}
	
	.footer a {
	    color: #777;
	    text-decoration: none;
	    margin: 0 5px;
	}
	
	.footer a:hover {
	    text-decoration: underline;
	}
	  	
  
  </style>
  <script>
    'use strict';
    
    $(function(){
    	$("#searchPassword").hide();
    });
    
    // 비밀번호 찾기
    function pwdSearch() {
    	$("#searchPassword").show();
    }
    
    // 임시비밀번호 등록시켜주기
    function newPassword() {
    	let mid = $("#midSearch").val().trim();
    	let email = $("#emailSearch2").val().trim();
    	if(mid == "" || email == "") {
    		alert("가입시 등록한 아이디와 메일주소를 입력하세요");
    		$("#midSearch").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/member/memberNewPassword",
    		type : "post",
    		data : {
    			mid   : mid,
    			email : email
    		},
    		success:function(res) {
    			if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
    			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
  				location.reload();
    		},
    		error : function() {
    			alert("전송오류!!")
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
<p><br/></p>
<body>
    <div class="login-container">
        <h1 class="logo">familyConnection</h1>
        <h2>로그인</h2>
        <form class="login-form">
            <div class="input-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" placeholder="아이디">
            </div>
            <div class="input-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호">
                <i class="fa fa-eye-slash" aria-hidden="true"></i>
            </div>
            <div class="input-group">
                <input type="checkbox" id="remember-me" name="remember-me">
                <label for="remember-me">로그인 상태 유지</label>
            </div>
            <button type="submit" class="login-button">로그인</button>
        </form>
        <div class="login-links">
            <a href="#">회원가입</a> |
            <a href="#">아이디 찾기</a> |
            <a href="#">비밀번호 찾기</a>
        </div>
        <footer class="footer">
            <a href="#">이용약관</a> |
            <a href="#">개인정보처리방침</a>
        </footer>
    </div>
</body>
</html>