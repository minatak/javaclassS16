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
		<link rel="icon" href="${ctp}/images/favicon.png">
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
		 <!-- Pretendard 폰트 추가 -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    
	<style>
    body {
        font-family: 'Pretendard', 'Noto Sans KR', -apple-system, BlinkMacSystemFont, system-ui, Roboto, 'Helvetica Neue', 'Segoe UI', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
    }
    
     .header-text h2 {
		    font-size: 3.5vw; /* 뷰포트 너비에 따라 조정 */
		    line-height: 1.2;
		  }
		  .header-text .sub-title {
		    font-size: 2vw;
		    line-height: 1.4;
		  }
		  @media (max-width: 768px) {
		    .header-text h2 {
		      font-size: 6vw;
		    }
		    .header-text .sub-title {
		      font-size: 4vw;
		    }
		  }
		 /*  .sub-title {
			  font-family: 'Pretendard', sans-serif;
			  font-size: 0.5vw;
			  font-weight: 700;
			  letter-spacing: 1px;
			  text-transform: uppercase;
			 /*  margin-top: 10px; */
			  display: block;
			} */
			
			@media (max-width: 768px) {
			  .sub-title {
			    font-size: 3vw;
			  }
			}
			
			.sub-title {
				font-family: 'Pretendard', sans-serif;
			  font-size: 1.2rem;
			  font-weight: 700;
			  color: white;
			}
			
			.services-carousel .service-item {
			  margin: 15px;
			}
			
			.services-carousel .owl-nav {
			  position: absolute;
			  top: 50%;
			  width: 100%;
			}
			
			.services-carousel .owl-nav button {
			  position: absolute;
			  transform: translateY(-50%);
			  background: rgba(255, 255, 255, 0.7) !important;
			  color: #333 !important;
			  width: 40px;
			  height: 40px;
			  border-radius: 50% !important;
			  font-size: 20px !important;
			}
			
			.services-carousel .owl-nav button.owl-prev {
			  left: -20px;
			}
			
			.services-carousel .owl-nav button.owl-next {
			  right: -20px;
			}
			
			.services-carousel .owl-nav button:hover {
			  background: rgba(255, 255, 255, 0.9) !important;
			}
			
  </style>
  <script>
  	
  	$(document).ready(function(){
  	  $(".services-carousel").owlCarousel({
  	    loop: true,
  	    margin: 30,
  	    nav: true,
  	    responsive:{
  	      0:{
  	        items: 1
  	      },
  	      768:{
  	        items: 2
  	      },
  	      992:{
  	        items: 3
  	      },
  	      1200:{
  	        items: 4
  	      }
  	    },
  	    autoplay: true,
  	    autoplayTimeout: 5000,
  	    autoplayHoverPause: true,
  	    navText: ['<i class="fas fa-chevron-left"></i>','<i class="fas fa-chevron-right"></i>']
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
           <a href="${ctp}/" class="logo">
              <img src="${ctp}/images/smalllogo.png" alt="HomeLink">
            </a> 
            <!-- ***** Logo End ***** -->
            <!-- ***** Menu Start ***** -->
            <ul class="nav">
						  <li class="scroll-to-section"><a href="#top" class="active">홈</a></li>
						  <li class="scroll-to-section"><a href="#services">기능</a></li>
						  <li class="scroll-to-section"><a href="#clients">후기</a></li>
						  <li class="scroll-to-section"><a href="#newsletter">문의</a></li>
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
							      <h2 style="color:white;">HomeLink</h2>
							      <span class="sub-title" style="font-size: 1.2rem;">가족과 함께하는 효율적인 일상</span>
							      <p>HomeLink는 가족 구성원들이 함께 사용할 수 있는 다양한 기능을 제공하여 가정 내 소통과 협업을 효율적으로 돕는 가족 관리 플랫폼입니다.</p>
							    </div>
                  <div class="col-lg-12">
                    <div class="white-button first-button scroll-to-section">
                      <a href="${ctp}/member/memberLogin">로그인하기</a>
                    </div>
                    <div class="white-button scroll-to-section">
                      <a href="${ctp}/member/memberJoin0">지금 시작하기</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="right-image wow fadeInRight" data-wow-duration="1s" data-wow-delay="0.5s">
                <img src="${ctp}/images/slider-dec.png" alt="가족 관리 앱 이미지">
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
	          <img src="${ctp}/images/heading-line-dec.png" alt="">
	          <p>HomeLink는 가족 생활을 더욱 효율적이고 즐겁게 만들어주는 다양한 기능을 제공합니다.</p>
	        </div>
	      </div>
	    </div>
	  </div>
	  <div class="container">
	    <div class="row">
	      <div class="col-lg-12">
	        <div class="owl-carousel services-carousel">
	          <div class="service-item first-service">
	            <div class="icon"></div>
	            <h4>일정 관리</h4>
	            <p>가족 구성원들의 일정을 한눈에 확인하고 관리할 수 있습니다.</p>
	          </div>
	          <div class="service-item second-service">
	            <div class="icon"></div>
	            <h4>가족 투표</h4>
	            <p>중요한 결정을 가족 구성원들과 함께 투표로 결정할 수 있습니다.</p>
	          </div>
	          <div class="service-item third-service">
	            <div class="icon"></div>
	            <h4>가사 분담</h4>
	            <p>가사 업무를 효율적으로 분담하고 관리할 수 있습니다.</p>
	          </div>
	          <div class="service-item fourth-service">
	            <div class="icon"></div>
	            <h4>가족 앨범</h4>
	            <p>소중한 가족의 추억을 함께 저장하고 공유할 수 있습니다.</p>
	          </div>
	          <div class="service-item second-service">
	            <div class="icon"></div>
	            <h4>가족 회의</h4>
	            <p>가족 회의를 진행하고 회의록을 작성할 수 있습니다.</p>
	          </div>
	          <div class="service-item third-service">
	            <div class="icon"></div>
	            <h4>가족 소식</h4>
	            <p>가족 내 중요한 소식과 정보를 공유할 수 있는 게시판입니다.</p>
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
            <img src="assets/images/heading-line-dec.png">
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
      </div>
    </div>
  </div>

  <div id="clients" class="the-clients">
  <div class="container">
    <div class="row">
      <div class="col-lg-8 offset-lg-2">
        <div class="section-heading">
          <h4>HomeLink 사용자들의 <em>생생한 후기</em></h4>
          <img src="${ctp}/images/heading-line-dec.png" alt="">
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
                            <img src="${ctp}/images/quote.png" alt="">
                            <p>"HomeLink의 일정 관리 기능 덕분에 우리 가족의 생활이 훨씬 체계적으로 변했어요. 각자의 일정을 한눈에 볼 수 있어서 약속 잡기도 쉽고, 중요한 가족 행사도 놓치지 않게 되었죠. 특히 아이들의 학교 행사나 병원 예약 관리가 정말 편해졌어요."</p>
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
                            <img src="${ctp}/images/quote.png" alt="">
                            <p>"가족 투표 기능이 정말 유용해요. 주말 여행지 선택부터 저녁 메뉴 결정까지, 모든 가족의 의견을 쉽게 모을 수 있어 좋아요. 익명 투표 옵션도 있어서 솔직한 의견을 낼 수 있고, 결과를 그래프로 볼 수 있어 재미있어요. 덕분에 가족 간 소통이 더 활발해졌습니다."</p>
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
                            <img src="${ctp}/images/quote.png" alt="">
                            <p>"가사 분담 기능으로 우리 집 가사 일이 훨씬 공평해졌어요. 각자의 역할이 명확해지고, 완료된 일을 체크하는 재미도 있어요. 아이들도 자신의 할 일을 책임감 있게 하더라고요. 덕분에 집안일로 인한 스트레스가 줄고, 가족 모두가 협력하는 분위기가 생겼습니다."</p>
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
                            <img src="${ctp}/images/quote.png" alt="">
                            <p>"가족 앨범 기능이 정말 마음에 들어요. 각자 찍은 사진을 한 곳에 모아볼 수 있어 좋고, 특히 멀리 있는 조부모님과 손쉽게 일상을 공유할 수 있어 좋아요. 추억을 정리하는 것도 쉬워졌어요!"</p>
                          </div>
                          <%-- <div class="down-content">
                            <img src="${ctp}/images/client-image.jpg" alt="">
                            <div class="right-content">
                              <h4>최우진</h4>
                              <span>3대가족 손자</span>
                            </div>
                          </div> --%>
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
            <p>충청북도 청주시 서원구 사창동 148-7</p>
            <p><a href="#">043-225-2111</a></p>
            <p><a href="#">green_cju@naver.com</a></p>
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
				    <h4>회사 소개</h4>
				    <div class="logo">
				      <img src="${ctp}/images/white_logo.png" alt="" style="width: 200%; height: auto;">
				    </div>
				    <p>HomeLink는 가족 간의 소통과 협력을 돕는 혁신적인 플랫폼입니다. 현대 가정의 니즈를 이해하고,<br/>기술을 통해 가족의 유대를 강화하는 솔루션을 제공합니다.</p>
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