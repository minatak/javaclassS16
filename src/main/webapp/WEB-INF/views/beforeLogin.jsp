<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="가족 관리 플랫폼">
    <meta name="author" content="">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

    <title>HomeLink</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <link rel="stylesheet" href="${ctp}/css/templatemo-chain-app-dev.css">
    <link rel="stylesheet" href="${ctp}/css/animated.css">
    <link rel="stylesheet" href="${ctp}/css/owl.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

	  <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Owl Carousel CSS 및 JS 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
		

	<style>
		body {font-family: 'Pretendard' !important;}
		.modal {
		  display: none;
		  position: fixed;
		  z-index: 1000;
		  left: 0;
		  top: 0;
		  width: 100%;
		  height: 100%;
		  overflow: auto;
		  background-color: rgba(0,0,0,0.4);
		}
		
		.modal-content {
		  background-color: #fefefe;
		  margin: 5% auto;
		  padding: 20px;
		  border: 1px solid #888;
		  width: 80%;
		  max-width: 600px;
		  border-radius: 10px;
		  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		}
		
		.close {
		  color: #aaa;
		  float: right;
		  font-size: 28px;
		  font-weight: bold;
		  cursor: pointer;
		}
		
		.close:hover,
		.close:focus {
		  color: #000;
		  text-decoration: none;
		  cursor: pointer;
		}
		
		.modal-body {
		  margin-top: 20px;
		  display: flex;
		  flex-direction: column;
		  align-items: center;
		}
		
		.modal-body img {
		  max-width: 100%;
		  height: auto;
		  margin-bottom: 20px;
		  border-radius: 5px;
		}
		
		.modal-footer {
		  margin-top: 20px;
		  text-align: center;
		}
		
		#modalTitle {
		  color: #ff6b6b;
		  margin-bottom: 10px;
		}
		
		#modalDescription {
		  line-height: 1.6;
		  color: #333;
		}
	</style>
	<script>
	$(document).ready(function(){
		  $(".owl-carousel").owlCarousel({
		    loop: true,
		    margin: 30,
		    nav: true,
		    responsive:{
		      0:{ items: 1 },
		      600:{ items: 2 },
		      1000:{ items: 4 }
		    }
		  });
		});

        // 모달 관련 요소 선택
        var modal = document.getElementById("featureModal");
				var modalTitle = document.getElementById("modalTitle");
				var modalImage = document.getElementById("modalImage");
				var modalDescription = document.getElementById("modalDescription");
				var modalCTA = document.getElementById("modalCTA");
				var span = document.getElementsByClassName("close")[0];
				
				// 서비스 정보 객체
				var serviceInfo = {
				  "일정 관리": {
				    title: "일정 관리",
				    description: "가족 구성원들의 일정을 한눈에 확인하고 관리할 수 있습니다. 개인 및 공유 일정을 구분하여 등록할 수 있으며, 중요한 가족 행사나 기념일도 놓치지 않도록 알림 기능을 제공합니다. 또한, 일정별로 색상 구분이 가능해 직관적인 일정 파악이 가능합니다.",
				    image: "assets/images/calendar.jpg",
				    ctaLink: "#"
				  },
				  "가족 투표": {
				    title: "가족 투표",
				    description: "중요한 가족 결정사항을 민주적으로 결정할 수 있는 투표 시스템을 제공합니다. 주말 여행지 선택, 저녁 메뉴 결정 등 다양한 주제로 투표를 생성할 수 있으며, 익명 투표 옵션도 제공합니다. 실시간으로 투표 결과를 그래프로 확인할 수 있어 가족 간 소통을 더욱 원활하게 합니다.",
				    image: "assets/images/voting.jpg",
				    ctaLink: "#"
				  },
				  "가사 분담": {
				    title: "가사 분담",
				    description: "가사 업무를 효율적으로 분담하고 관리할 수 있는 시스템을 제공합니다. 정기적인 집안일부터 특별한 tasks까지 등록하고 담당자를 지정할 수 있습니다. 완료된 일을 체크하면 포인트가 쌓이는 재미있는 요소도 있어, 가족 구성원 모두가 자발적으로 가사에 참여하도록 동기를 부여합니다.",
				    image: "assets/images/chores.jpg",
				    ctaLink: "#"
				  },
				  "가족 앨범": {
				    title: "가족 앨범",
				    description: "소중한 가족의 추억을 저장하고 공유할 수 있는 디지털 앨범 기능을 제공합니다. 각 가족 구성원이 사진을 업로드하고 앨범을 만들 수 있으며, 댓글 기능을 통해 추억을 나눌 수 있습니다. 연도별, 이벤트별로 앨범을 구분하여 정리할 수 있어 체계적인 추억 관리가 가능합니다.",
				    image: "assets/images/album.jpg",
				    ctaLink: "#"
				  },
				  "가족 회의": {
				    title: "가족 회의",
				    description: "정기적인 가족 회의를 효과적으로 진행할 수 있는 도구를 제공합니다. 회의 안건을 사전에 등록하고, 온라인으로 의견을 나눌 수 있습니다. 회의 결과와 결정사항을 기록하고 공유할 수 있어, 모든 가족 구성원이 중요한 가족 사안에 대해 알고 참여할 수 있습니다.",
				    image: "assets/images/meeting.jpg",
				    ctaLink: "#"
				  },
				  "가족 소식": {
				    title: "가족 소식",
				    description: "가족 내 중요한 소식과 정보를 공유할 수 있는 게시판 기능을 제공합니다. 공지사항, 긴급 연락사항, 축하 메시지 등을 올릴 수 있으며, 댓글 기능을 통해 실시간으로 소통할 수 있습니다. 또한, 중요한 소식에 대해서는 푸시 알림 기능을 제공하여 빠른 정보 전달이 가능합니다.",
				    image: "assets/images/news.jpg",
				    ctaLink: "#"
				  }
				};
				
				// 모달 열기 함수
				function openModal(serviceName) {
				  var service = serviceInfo[serviceName];
				  modalTitle.textContent = service.title;
				  modalImage.src = service.image;
				  modalDescription.textContent = service.description;
				  modalCTA.href = service.ctaLink;
				  modal.style.display = "block";
				}
				
				// 모달 닫기
				span.onclick = function() {
				  modal.style.display = "none";
				}
				
				// 모달 외부 클릭 시 닫기
				window.onclick = function(event) {
				  if (event.target == modal) {
				    modal.style.display = "none";
				  }
				} 
				
				// 서비스 아이템에 클릭 이벤트 리스너 추가
				document.querySelectorAll('.service-item').forEach(item => {
				  item.addEventListener('click', function() {
				    var serviceName = this.querySelector('h4').textContent;
				    openModal(serviceName);
				  });
				});
  </script>
  </head>

<body>

  <!-- ***** Preloader Start ***** -->
  <div id="js-preloader" class="js-preloader">
    <div class="preloader-inner">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div> 
  </div>
  <!-- ***** Preloader End ***** -->

  <!-- ***** Header Area Start ***** -->
  <header class="header-area header-sticky wow slideInDown" data-wow-duration="0.75s" data-wow-delay="0s">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <nav class="main-nav">
            <!-- ***** Logo Start ***** -->
            <a href="index.html" class="logo">
              <img src="assets/images/logo.png" alt="Chain App Dev">
              <%-- <img src="${ctp}/images/logo.png" alt="Chain App Dev"> --%>
            </a>
            <!-- ***** Logo End ***** -->
            <!-- ***** Menu Start ***** -->
            <ul class="nav">
              <li class="scroll-to-section"><a href="#home" class="active">홈</a></li>
              <li class="scroll-to-section"><a href="#features">기능</a></li>
              <li class="scroll-to-section"><a href="#testimonials">후기</a></li>
              <li class="scroll-to-section"><a href="#contact">문의</a></li>
              <li><div class="gradient-button"><a href="${ctp}/member/memberJoin0"><i class="fa fa-sign-in-alt"></i> 시작하기</a></div></li> 
            </ul>        
            <a class='menu-trigger'>
                <span>메뉴</span>
            </a>
            <!-- ***** Menu End ***** -->
          </nav>
        </div>
      </div>
    </div>
  </header>
  <!-- ***** Header Area End ***** -->
  <div class="main-banner wow fadeIn" id="top" data-wow-duration="1s" data-wow-delay="0.5s">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="row">
            <div class="col-lg-6 align-self-center">
              <div class="left-content show-up header-text wow fadeInLeft" data-wow-duration="1s" data-wow-delay="1s">
                <div class="row">
                  <div class="col-lg-12">
                    <h2>HomeLink: 가족과 함께하는 효율적인 일상</h2>
                    <p>HomeLink는 가족 구성원들이 함께 사용할 수 있는 다양한 기능을 제공하여 가정 내 소통과 협업을 효율적으로 돕는 가족 관리 플랫폼입니다.</p>
                  </div>
                  <div class="col-lg-12">
                    <div class="white-button first-button scroll-to-section">
                      <a href="#about">자세히 알아보기 <i class="fab fa-apple"></i></a>
                    </div>
                    <div class="white-button scroll-to-section">
                      <a href="${ctp}/member/memberJoin0">지금 시작하기 <i class="fab fa-google-play"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="right-image wow fadeInRight" data-wow-duration="1s" data-wow-delay="0.5s">
                <img src="assets/images/slider-dec.png" alt="가족 관리 앱 이미지">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

	<div id="services" class="services section">
	  <div class="container">
	    <div class="row">
	      <div class="col-lg-8 offset-lg-2">
	        <div class="section-heading  wow fadeInDown" data-wow-duration="1s" data-wow-delay="0.5s">
	          <h4>가족을 위한 <em>놀라운 기능</em></h4>
	          <img src="assets/images/heading-line-dec.png" alt="">
	          <p>HomeLink는 가족 생활을 더욱 효율적이고 즐겁게 만들어주는 다양한 기능을 제공합니다.</p>
	        </div>
	      </div>
	    </div>
	  </div>
	  <div class="container">
	    <div class="owl-carousel owl-theme">
	      <div class="item">
	        <div class="service-item first-service">
	          <div class="icon"></div>
	          <h4>일정 관리</h4>
	          <p>가족 구성원들의 일정을 한눈에 확인하고 관리할 수 있습니다.</p>
	          <div class="text-button">
						  <a href="#" class="modal-trigger" data-service="일정 관리">자세히 보기 <i class="fa fa-arrow-right"></i></a>
						</div>
	        </div>
	      </div>
	      <div class="item">
	        <div class="service-item second-service">
	          <div class="icon"></div>
	          <h4>가족 투표</h4>
	          <p>중요한 결정을 가족 구성원들과 함께 투표로 결정할 수 있습니다.</p>
	          <div class="text-button">
	            <a href="#" class="modal-trigger">자세히 보기 <i class="fa fa-arrow-right"></i></a>
	          </div>
	        </div>
	      </div>
	      <div class="item">
	        <div class="service-item third-service">
	          <div class="icon"></div>
	          <h4>가사 분담</h4>
	          <p>가사 업무를 효율적으로 분담하고 관리할 수 있습니다.</p>
	          <div class="text-button">
	            <a href="#" class="modal-trigger">자세히 보기 <i class="fa fa-arrow-right"></i></a>
	          </div>
	        </div>
	      </div>
	      <div class="item">
	        <div class="service-item fourth-service">
	          <div class="icon"></div>
	          <h4>가족 앨범</h4>
	          <p>소중한 가족의 추억을 함께 저장하고 공유할 수 있습니다.</p>
	          <div class="text-button">
	            <a href="#" class="modal-trigger">자세히 보기 <i class="fa fa-arrow-right"></i></a>
	          </div>
	        </div>
	      </div>
	      <div class="item">
	        <div class="service-item fifth-service">
	          <div class="icon"></div>
	          <h4>가족 회의</h4>
	          <p>가족 회의를 진행하고 회의록을 작성할 수 있습니다.</p>
	          <div class="text-button">
	            <a href="#" class="modal-trigger">자세히 보기 <i class="fa fa-arrow-right"></i></a>
	          </div>
	        </div>
	      </div>
	      <div class="item">
	        <div class="service-item sixth-service">
	          <div class="icon"></div>
	          <h4>가족 소식</h4>
	          <p>가족 내 중요한 소식과 정보를 공유할 수 있는 게시판입니다.</p>
	          <div class="text-button">
	            <a href="#" class="modal-trigger">자세히 보기 <i class="fa fa-arrow-right"></i></a>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

  <div id="about" class="about-us section">
    <div class="container">
      <div class="row">
        <div class="col-lg-6 align-self-center">
          <div class="section-heading">
            <h4>HomeLink <em>소개</em></h4>
            <img src="assets/images/heading-line-dec.png" alt="">
            <p>HomeLink는 가족 구성원들이 함께 사용할 수 있는 다양한 기능을 제공하여 가정 내 소통과 협업을 효율적으로 돕는 가족 관리 플랫폼입니다.</p>
          </div>
          <div class="row">
            <div class="col-lg-6">
              <div class="box-item">
                <h4><a href="#">일정 공유</a></h4>
                <p>가족 구성원들의 일정을 한눈에</p>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="box-item">
                <h4><a href="#">가족 투표</a></h4>
                <p>중요한 결정을 함께</p>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="box-item">
                <h4><a href="#">가사 분담</a></h4>
                <p>효율적인 가사 업무 관리</p>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="box-item">
                <h4><a href="#">가족 앨범</a></h4>
                <p>추억을 함께 저장하고 공유</p>
              </div>
            </div>
            <div class="col-lg-6">
		          <div class="box-item">
		            <h4><a href="#">가족 회의</a></h4>
		            <p>가족 회의를 진행 및 의견 나누기</p>
		          </div>
		        </div>
		        <div class="col-lg-6">
		          <div class="box-item">
		            <h4><a href="#">가족 소통 게시판</a></h4>
		            <p>가족 간 소통의 중심</p>
		          </div>
		        </div>
            <div class="col-lg-12">
              <p>HomeLink와 함께 더 효율적이고 행복한 가족 생활을 만들어보세요.</p>
            </div>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="right-image">
            <img src="assets/images/about-right-dec.png" alt="가족 관리 앱 사용 이미지">
          </div>
        </div>
      </div>
    </div>
  </div>

  <div id="clients" class="the-clients">
  <div class="container">
    <div class="row">
      <div class="col-lg-8 offset-lg-2">
        <div class="section-heading">
          <h4>HomeLink 사용자들의 <em>생생한 후기</em></h4>
          <img src="assets/images/heading-line-dec.png" alt="">
          <p>실제 HomeLink를 사용하고 있는 가족들의 경험담을 들어보세요.</p>
        </div>
      </div>
    </div>
    <div class="col-lg-12">
      <div class="naccs">
        <div class="grid">
          <div class="row">
            <div class="col-lg-7 align-self-center">
              <div class="menu">
                <div class="first-thumb active">
                  <div class="thumb">
                    <div class="row">
                      <div class="col-lg-4 col-sm-4 col-12">
                        <h4>김지영 가족</h4>
                        <span class="date">2024년 3월 15일</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 d-none d-sm-block">
                        <span class="category">일정 관리</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 col-12">
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <span class="rating">5.0</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div>
                  <div class="thumb">
                    <div class="row">
                      <div class="col-lg-4 col-sm-4 col-12">
                        <h4>박서준 가족</h4>
                        <span class="date">2024년 2월 28일</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 d-none d-sm-block">
                        <span class="category">가족 투표</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 col-12">
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <span class="rating">4.8</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div>
                  <div class="thumb">
                    <div class="row">
                      <div class="col-lg-4 col-sm-4 col-12">
                        <h4>이미나 가족</h4>
                        <span class="date">2024년 1월 10일</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 d-none d-sm-block">
                        <span class="category">가사 분담</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 col-12">
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <span class="rating">4.9</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div>
                  <div class="thumb">
                    <div class="row">
                      <div class="col-lg-4 col-sm-4 col-12">
                        <h4>최우진 가족</h4>
                        <span class="date">2023년 12월 5일</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 d-none d-sm-block">
                        <span class="category">가족 앨범</span>
                      </div>
                      <div class="col-lg-4 col-sm-4 col-12">
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <span class="rating">4.7</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> 
            <div class="col-lg-5">
              <ul class="nacc">
                <li class="active">
                  <div>
                    <div class="thumb">
                      <div class="row">
                        <div class="col-lg-12">
                          <div class="client-content">
                            <img src="assets/images/quote.png" alt="">
                            <p>"HomeLink의 일정 관리 기능 덕분에 우리 가족의 생활이 훨씬 체계적으로 변했어요. 각자의 일정을 한눈에 볼 수 있어서 약속 잡기도 쉽고, 중요한 가족 행사도 놓치지 않게 되었죠. 특히 아이들의 학교 행사나 병원 예약 관리가 정말 편해졌어요."</p>
                          </div>
                          <div class="down-content">
                            <img src="assets/images/client-image.jpg" alt="">
                            <div class="right-content">
                              <h4>김지영</h4>
                              <span>4인 가족 주부</span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
                <li>
                  <div>
                    <div class="thumb">
                      <div class="row">
                        <div class="col-lg-12">
                          <div class="client-content">
                            <img src="assets/images/quote.png" alt="">
                            <p>"가족 투표 기능이 정말 유용해요. 주말 여행지 선택부터 저녁 메뉴 결정까지, 모든 가족의 의견을 쉽게 모을 수 있어 좋아요. 익명 투표 옵션도 있어서 솔직한 의견을 낼 수 있고, 결과를 그래프로 볼 수 있어 재미있어요. 덕분에 가족 간 소통이 더 활발해졌습니다."</p>
                          </div>
                          <div class="down-content">
                            <img src="assets/images/client-image.jpg" alt="">
                            <div class="right-content">
                              <h4>박서준</h4>
                              <span>3인 가족 아빠</span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
                <li>
                  <div>
                    <div class="thumb">
                      <div class="row">
                        <div class="col-lg-12">
                          <div class="client-content">
                            <img src="assets/images/quote.png" alt="">
                            <p>"가사 분담 기능으로 우리 집 가사 일이 훨씬 공평해졌어요. 각자의 역할이 명확해지고, 완료된 일을 체크하는 재미도 있어요. 아이들도 자신의 할 일을 책임감 있게 하더라고요. 덕분에 집안일로 인한 스트레스가 줄고, 가족 모두가 협력하는 분위기가 생겼습니다."</p>
                          </div>
                          <div class="down-content">
                            <img src="assets/images/client-image.jpg" alt="">
                            <div class="right-content">
                              <h4>이미나</h4>
                              <span>5인 가족 워킹맘</span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
                <li>
                  <div>
                    <div class="thumb">
                      <div class="row">
                        <div class="col-lg-12">
                          <div class="client-content">
                            <img src="assets/images/quote.png" alt="">
                            <p>"가족 앨범 기능이 정말 마음에 들어요. 각자 찍은 사진을 한 곳에 모아볼 수 있어 좋고, 특히 멀리 있는 조부모님과 손쉽게 일상을 공유할 수 있어 좋아요. 추억을 정리하는 것도 쉬워져서, 이제는 연말에 가족 앨범을 만드는 것이 우리 가족의 새로운 전통이 되었답니다."</p>
                          </div>
                          <div class="down-content">
                            <img src="assets/images/client-image.jpg" alt="">
                            <div class="right-content">
                              <h4>최우진</h4>
                              <span>3대가족 손자</span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
              </ul>
            </div>          
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

  <footer id="newsletter">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 offset-lg-2">
          <div class="section-heading">
            <h4>HomeLink의 최신 소식과 업데이트를 받아보세요</h4>
          </div>
        </div>
        <div class="col-lg-6 offset-lg-3">
          <form id="search" action="#" method="GET">
            <div class="row">
              <div class="col-lg-6 col-sm-6">
                <fieldset>
                  <input type="address" name="address" class="email" placeholder="이메일 주소..." autocomplete="on" required>
                </fieldset>
              </div>
              <div class="col-lg-6 col-sm-6">
                <fieldset>
                  <button type="submit" class="main-button">구독하기 <i class="fa fa-angle-right"></i></button>
                </fieldset>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-3">
          <div class="footer-widget">
            <h4>Contact Us</h4>
            <p>Rio de Janeiro - RJ, 22795-008, Brazil</p>
            <p><a href="#">010-020-0340</a></p>
            <p><a href="#">info@company.co</a></p>
          </div>
        </div>
        <div class="col-lg-3">
          <div class="footer-widget">
            <h4>About Us</h4>
            <ul>
              <li><a href="#">Home</a></li>
              <li><a href="#">Services</a></li>
              <li><a href="#">About</a></li>
              <li><a href="#">Testimonials</a></li>
              <li><a href="#">Pricing</a></li>
            </ul>
            <ul>
              <li><a href="#">About</a></li>
              <li><a href="#">Testimonials</a></li>
              <li><a href="#">Pricing</a></li>
            </ul>
          </div>
        </div>
        <div class="col-lg-3">
          <div class="footer-widget">
            <h4>About Our Company</h4>
            <div class="logo">
              <img src="assets/images/white-logo.png" alt="">
            </div>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
          </div>
        </div>
        <div class="col-lg-12">
          <div class="copyright-text">
            <p>Copyright © 2024 HomeLink. All Rights Reserved. 
          </div>
        </div>
      </div>
    </div>
  </footer>

	<!-- 모달 구조 -->
	<!-- <div id="serviceModal" class="modal">
	  <div class="modal-content">
	    <span class="close">&times;</span>
	    <h2 id="modalTitle"></h2>
	    <p id="modalDescription"></p>
	  </div>
	</div> -->
	
	<!-- 모달 창 -->
	<div id="featureModal" class="modal">
	  <div class="modal-content">
	    <span class="close">&times;</span>
	    <h2 id="modalTitle"></h2>
	    <div class="modal-body">
	      <img id="modalImage" src="" alt="Feature image">
	      <p id="modalDescription"></p>
	    </div>
	    <div class="modal-footer">
	      <a href="#" class="cta-button" id="modalCTA">자세히 알아보기</a>
	    </div>
	  </div>
	</div>

  <!-- Scripts -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${ctp}/js/owl-carousel.js"></script>
  <script src="${ctp}/js/animation.js"></script>
  <script src="${ctp}/js/imagesloaded.js"></script>
  <script src="${ctp}/js/popup.js"></script>
  <script src="${ctp}/js/custom.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
  
</body>
</html>