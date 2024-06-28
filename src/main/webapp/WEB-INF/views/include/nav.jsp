<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg">
    <div class="container px-5">
        <a class="navbar-brand" href="Main.com">FamilyNote</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                <!-- Profile Dropdown -->
                <c:if test="${!empty sMid}">
                    <li class="nav-item dropdown profile-dropdown ml-3">
                        <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="${ctp}/images/member/${sPhoto}" alt="Profile Picture">
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li><a class="dropdown-item" href="MemberMain.mem">대시보드</a></li>
                            <li><a class="dropdown-item" href="MemberInfo.mem">정보 확인</a></li>
                            <li><a class="dropdown-item" href="MemberUpdate.mem">정보 수정</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <c:if test="${sLevel == 0}">
                                <li><a class="dropdown-item" href="AdminMemberList.ad">회원 리스트</a></li>
                                <li><a class="dropdown-item" href="AdminReports.ad">신고 관리</a></li>
                                <li><hr class="dropdown-divider"></li>
                            </c:if>
                            <li><a class="dropdown-item" href="MemberLogout.mem">Logout</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>


<style>
    body {
        font-family: 'SCoreDream';
        font-weight: 300; 
    }
    a {
        font-family: 'SCoreDream';
        font-weight: 300; 
    }
    h1,h2,h3,h4,h5 {
        font-family: 'SCoreDream';
        font-weight: 500; 
    }
 /*    .profile-dropdown img {
        border-radius: 50%;
        width: 40px;
        height: 40px;
        object-fit: cover;
    } */
    
    /* Navigation Bar */
		.navbar {
		    background-color: #f8f9fa;
		}
		
		.navbar-brand {
		    font-size: 1.5rem;
		    font-weight: bold;
		}
		
		.navbar-toggler {
		    border-color: #6c757d;
		}
		
		.navbar-toggler-icon {
		    color: #6c757d;
		}
		
		.nav-link {
		    color: #343a40;
		}
		
		.nav-link:hover {
		    color: #007bff;
		}
		
		.dropdown-menu {
		    background-color: #fff;
		    border: 1px solid rgba(0,0,0,.15);
		}
		
		.dropdown-item {
		    color: #343a40;
		}
		
		.dropdown-item:hover {
		    background-color: #007bff;
		    color: #fff;
		}
		    
</style>
