<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>우리 가족 | HomeLink</title>
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
    
    .familyContainer {
      max-width: 900px;
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
    
    .family-member {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
      padding: 20px;
      border-radius: 10px;
      background-color: #fff;
    }
    
    .profile-photo {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      object-fit: cover;
      margin-right: 20px;
    }
    
    .member-info {
      flex: 1;
    }
    
    .member-name {
      font-weight: 600;
      font-size: 18px;
      margin-bottom: 5px;
    }
    
    .member-relationship {
      color: #6c757d;
      margin-bottom: 5px;
    }
    
    .member-email {
      color: #84a98c;
    }
    
    .btn-invite {
      background-color: #84a98c;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    
    .btn-invite:hover {
      background-color: #6b8e73;
    }
   .member-birthday {
      color: #6c757d;
      font-size: 14px;
    }
    
    .connect-box {
		  background-color: #fff;
		  /* border: 1px solid #e9ecef; */ 
		  border-radius: 10px;
		  padding: 25px;
		  margin-top: 30px;
		}
		
		.connect-box h5 {
		  color: #333c47;
		  font-weight: 600;
		  margin-bottom: 15px;
		}
		
		.family-code-display {
		  background-color: #fff;
		  border: 1px solid #ced4da;
		  border-radius: 5px;
		  padding: 8px 15px;
		  display: inline-block;
		}
		
		.family-code-display strong {
		  color: #84a98c;
		  font-size: 1.2em;  
		  letter-spacing: 1px;
		}
		 
		.connect-info {
		  margin-top: 15px;
		  font-size: 0.9em;
		  color: #6c757d;
		}
		.btn-copy {
		  background-color: #84a98c;
		  color: white;
		  border: none;
		  padding: 10px 15px;
		  border-radius: 5px;
		  font-weight: 600;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		 
		.btn-copy:hover {
		  background-color: #6b8e73;
		  color: white;
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
  
		function copyFamilyCode() {
		  const familyCode = document.querySelector('.family-code-display strong').textContent;
		  navigator.clipboard.writeText(familyCode).then(() => {
		    showAlert('가족 코드가 클립보드에 복사되었습니다.');
		  }).catch(err => {
		    console.error('복사 중 오류가 발생했습니다:', err);
		  });
		}
	</script>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/nav.jsp" %>
  <div class="page-container">
    <div class="content-wrap">
      <div class="familyContainer">
        <div class="header">
          <h2>우리 가족</h2>
          <p>연결된 가족 구성원을 확인하세요</p>
        </div>
        
        <c:forEach var="member" items="${familyMembers}">
          <div class="family-member">
            <img src="${ctp}/member/${member.photo}" alt="${member.name}" class="profile-photo">
            <div class="member-info">
              <div class="member-name">${member.name}</div>
              <div class="member-relationship">${member.relationship}</div>
              <div class="member-birthday">생일 : 
                <fmt:parseDate value="${member.birthday}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedBirthday"/>
								<fmt:formatDate value="${parsedBirthday}" pattern="yyyy년 MM월 dd일" />
              </div>
              <div class="member-email">${member.email}</div>
            </div>
          </div>
        </c:forEach>
        
        <div class="connect-box mt-5 text-center">
				  <h5>가족과 연결하기</h5> 
				  <p class="mb-3">아래 코드를 공유하여 가족을 초대하세요</p>
				  <div>
					  <div class="family-code-display">
					    <strong>${sFamCode}</strong>
					  </div>
					  <button class="btn-copy" onclick="copyFamilyCode()">복사</button>
					</div>
				  <p class="connect-info mt-3 mb-0">
				    가족 코드는 상단 오른쪽 메뉴의 '가족 코드' 에서 생성 또는 등록할 수 있습니다.
				  </p>
				</div>
        
				
      </div>
    </div>
    
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  </div>
</body>
</html>