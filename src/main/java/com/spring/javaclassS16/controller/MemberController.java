package com.spring.javaclassS16.controller;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.javaclassS16.common.JavaclassProvide;
import com.spring.javaclassS16.service.MemberService;
import com.spring.javaclassS16.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	


	// 이메일 인증
	@ResponseBody
	@RequestMapping(value = "/joinEmailCheck", method = RequestMethod.POST)
	public String memberEmailCheckPost(String email, HttpSession session) throws MessagingException {
		MemberVO vo = memberService.getMemberEmailCheck(email);
		if(vo != null) {
			return "alreadyMember";
		}
		else {
		    UUID uid = UUID.randomUUID();
		    String emailKey = uid.toString().substring(0, 8);
		    session.setAttribute("sEmailKey", emailKey);
		    
		    String emailContent = 
		        "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 5px;'>" +
		            "<img src='cid:logo.png' alt='HomeLink Logo' style='display: block; margin: 0 auto; max-width: 150px;'>" +
		            "<h2 style='color: #333; text-align: center;'>HomeLink 이메일 인증</h2>" +
		            "<p style='color: #666; line-height: 1.6;'>홈링크에 오신 것을 환영합니다 :)</p>" +
		            "<p style='color: #666; line-height: 1.6;'>아래 8자리 인증번호를 사용하여 이메일 인증을 완료해주세요.</p>" +
		            "<div style='background-color: #f0f0f0; padding: 15px; border-radius: 5px; text-align: center; margin: 20px 0;'>" +
		                "<h3 style='margin: 0; color: #333;'>인증번호</h3>" +
		                "<p style='font-size: 24px; font-weight: bold; color: #84a98c; letter-spacing: 2px; margin: 10px 0;'>" + emailKey + "</p>" +
		            "</div>" +
		            "<h4 style='color: #333;'>인증 방법:</h4>" +
		            "<ol style='color: #666; line-height: 1.6;'>" +
		                "<li>가입하신 화면으로 돌아가세요.</li>" +
		                "<li>\"이메일 인증\" 탭으로 이동합니다.</li>" +
		                "<li>위에 발급된 8자리 인증번호를 입력합니다.</li>" +
		                "<li>\"인증 완료\" 버튼을 클릭합니다.</li>" +
		            "</ol>" +
		            "<p style='color: #666; line-height: 1.6;'>이메일 인증을 완료하면 홈링크의 모든 서비스를 이용할 수 있습니다.</p>" +
		            "<p style='color: #666; line-height: 1.6;'>감사합니다!</p>" +
		            "<p style='color: #666; line-height: 1.6;'>HomeLink 팀</p>" +
		            "<p style='color: #999; font-size: 12px; margin-top: 20px;'>인증번호는 5분 후에 만료됩니다.<br>만약 인증번호를 분실하셨다면 다시 요청하실 수 있습니다.</p>" +
		            "<p style='text-align: center;'>" +
		                "<a href='http://49.142.157.251:9090/javaclassS16/' style='display: inline-block; background-color: #84a98c; color: white; text-decoration: none; padding: 10px 20px; border-radius: 5px; font-weight: bold;'>HomeLink 홈페이지 바로가기</a>" +
		            "</p>" +
		        "</div>";
	
		    joinMailSend(email, "HomeLink 이메일 인증번호 안내", emailContent);
		    return emailKey;
		}
	}

	// 가입 메일 전송
	private void joinMailSend(String toMail, String title, String content) throws MessagingException {
	    if (mailSender == null) {
	        throw new MessagingException("Mail sender is not configured properly.");
	    }
	    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    
	    MimeMessage message = mailSender.createMimeMessage();
	    MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	    messageHelper.setTo(toMail);
	    messageHelper.setSubject(title);
	    messageHelper.setText(content, true);
	    
	    // 로고 이미지 첨부
	    FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/logo.png"));
	    messageHelper.addInline("logo.png", file);
	    
	    mailSender.send(message);
	}
	
	// 이메일 확인하기
	@ResponseBody
	@RequestMapping(value = "/memberEmailCheckOk", method = RequestMethod.POST)
	public String memberEmailCheckOkPost(String checkKey, HttpSession session) throws MessagingException {
		String sCheckKey = (String) session.getAttribute("sEmailKey");
		if(checkKey.equals(sCheckKey)) return "1";
		else return "0";
	}
	
	@RequestMapping(value = "/memberJoin0", method = RequestMethod.GET)
	public String memberJoin0Get() {
		return "member/memberJoin0";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(String name, String email, Model model) {
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		
		return "member/memberJoin2";
	}
	
	// 카카오로 회원가입 진행시 들어오는 화면
	@RequestMapping(value = "/memberJoin2", method = RequestMethod.GET)
	public String memberJoin2Get(Model model) {
	    // 리다이렉트로 전달된 데이터가 있다면 모델에 추가
	    if (model.asMap().containsKey("name")) {
	        model.addAttribute("name", model.asMap().get("name"));
	    }
	    if (model.asMap().containsKey("email")) {
	        model.addAttribute("email", model.asMap().get("email"));
	    }
	    return "member/memberJoin2";
	}
	
	@RequestMapping(value = "/memberJoin2", method = RequestMethod.POST)
	public String memberJoin2Post(MemberVO vo, MultipartFile fName, HttpSession session) {
		// 아이디/닉네임 중복체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/idCheckNo";
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 회원 사진 처리(service객체에서 처리후 DB에 저장한다.)
		if(!fName.getOriginalFilename().equals("")) vo.setPhoto(memberService.fileUpload(fName, vo.getMid(), ""));
		else vo.setPhoto("noimage.png");
		
		int res = memberService.setMemberJoinOk(vo);
		
		session.setAttribute("sMid", vo.getMid());
		session.setAttribute("sName", vo.getName());
		session.setAttribute("sPhoto", vo.getPhoto());
		session.setAttribute("sIdx", vo.getIdx());
		
		int age = memberService.calculateAge(vo.getBirthday());
		session.setAttribute("sAge", age);
		
		if(res != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	@RequestMapping(value = "/memberFamCode", method = RequestMethod.GET)
	public String memberFamCodeGet() {
		return "member/memberFamCode";
	}
	
	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.GET)
	public String memberIdCheckGet(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null) return "1";
		else return "0";
	}
	

	// 가족 코드 생성
  @ResponseBody
  @RequestMapping(value = "/createCode", method = RequestMethod.POST)
  public String createFamilyCode(HttpSession session) {
    String mid = (String) session.getAttribute("sMid");
    String familyCode = memberService.createFamilyCode();
    memberService.updateMemberFamilyCode(mid, familyCode);
    session.setAttribute("sFamCode", familyCode);
    return familyCode;
  }

  // 가족 코드 연결 
  @ResponseBody
  @RequestMapping(value = "/connectCode", method = RequestMethod.POST)
  public String connectFamilyCode(@RequestParam String familyCode, HttpSession session) {
  	familyCode = familyCode.toUpperCase();
    String mid = (String) session.getAttribute("sMid");
    boolean isConnected = memberService.connectToFamily(mid, familyCode);
    if(isConnected) {
    	session.setAttribute("sFamCode", familyCode);        	
    }
    return isConnected ? "success" : "error";
  }

  
  // 카카오 회원가입
  @RequestMapping(value = "/kakaoJoin", method = RequestMethod.GET)
  public String kakaoJoinGet(String name, String email, String accessToken,
          RedirectAttributes redirectAttributes,
          HttpSession session
      ) throws MessagingException {
      // 카카오 로그아웃을 위한 카카오앱키를 세션에 저장시켜둔다.
      session.setAttribute("sAccessToken", accessToken);
      
      // 카카오로 가입하는 회원인 경우 이미 회원인지 조사한다.(해당 이메일이 존재하는지 검색)
      MemberVO vo = memberService.getMemberEmailCheck(email);
      
      // 만약 이메일 정보가 있다면 로그인창으로 반환한다.
      if(vo != null) {
          return "redirect:/message/alreadyMember";
      }
      else {
          redirectAttributes.addFlashAttribute("name", name);
          redirectAttributes.addFlashAttribute("email", email);
          return "redirect:/member/memberJoin2";
      }
  }
    
  @RequestMapping(value = "/memberIdSearch", method = RequestMethod.GET)
	public String memberIdSearchGet() {
		return "member/memberIdSearch";
	}
  
  @RequestMapping(value = "/memberPwdChange", method = RequestMethod.GET)
  public String memberPwdChangeGet() {
  	return "member/memberPwdChange";
  }
  
	// 일반 로그인 폼
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		// 로그인창에 아이디 체크 유무에 대한 처리
		// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력창에 뿌릴수 있게 한다.
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 카카오 로그인
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLoginGet(String name, String email, String accessToken,
			HttpServletRequest request,
			HttpSession session
		) throws MessagingException {
		// 카카오 로그아웃을 위한 카카오앱키를 세션에 저장시켜둔다.
		session.setAttribute("sAccessToken", accessToken);
		
		// 카카오 로그인한 회원인 경우에는 우리 회원인지를 조사한다. 
		MemberVO vo = memberService.getMemberNameEmailCheck(name, email);
		
		if(vo != null && vo.getUserDel().equals("NO")) {
			int age = memberService.calculateAge(vo.getBirthday());

			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sFamCode", vo.getFamilyCode());
			session.setAttribute("sPhoto", vo.getPhoto());
			session.setAttribute("sAge", age);
			session.setAttribute("sIdx", vo.getIdx());
			
			return "redirect:/message/memberLoginOk?name="+ java.net.URLEncoder.encode(vo.getName());
		}
		else { // 가입된 회원이 아니었을 경우
			return "redirect:/message/memberNot";
		}
	}
	
	// 일반 로그인 처리하기
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(name="mid", defaultValue = "hkd1234", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "1234", required = false) String idSave
		) {
		
		mid = mid.trim();
		pwd = pwd.trim();
		
		//  로그인 인증처리(스프링 시큐리티의 BCryptPasswordEncoder객체를 이용한 암호화되어 있는 비밀번호 비교하기)
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 로그인 인증완료시 처리할 부분(1.세션, 2.쿠키, 3.기타 설정값....)
			// 1.세션처리
			session.setAttribute("sMid", mid);
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sFamCode", vo.getFamilyCode());
			session.setAttribute("sPhoto", vo.getPhoto());
			session.setAttribute("sIdx", vo.getIdx());
			
			int age = memberService.calculateAge(vo.getBirthday());
			session.setAttribute("sAge", age);
			
			// 2.쿠키 저장/삭제
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setPath("/");
				cookieMid.setMaxAge(60*60*24*7);		// 쿠키의 만료시간을 7일로 지정
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			return "redirect:/message/memberLoginOk?name="+ java.net.URLEncoder.encode(vo.getName());
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
	}
	
	// 일반 로그아웃
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberMainGet(HttpSession session) {
		String name = (String) session.getAttribute("sName");
		session.invalidate();
		
		return "redirect:/message/memberLogout?name="+ java.net.URLEncoder.encode(name);
	}
	
	// kakao 로그아웃
	@RequestMapping(value = "/kakaoLogout", method = RequestMethod.GET)
	public String kakaoLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		String name = (String) session.getAttribute("sName");
		String accessToken = (String) session.getAttribute("sAccessToken");
		String reqURL = "https://kapi.kakao.com/v1/user/unlink";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", " " + accessToken);
			
			// 카카오에서 정상적으로 처리 되었다면 200번이 돌아온다.
			int responseCode = conn.getResponseCode();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		session.invalidate();
		
		return "redirect:/message/kakaoLogout?name="+ java.net.URLEncoder.encode(name);
	}
	
	// 회원 정보 보기, 수정
	@RequestMapping(value = "/memberInfo", method = RequestMethod.GET)
	public String memberInfoGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		return "member/memberInfo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkPassword", method = RequestMethod.POST)
	public String checkPasswordPost(HttpSession session, String pwd) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(passwordEncoder.matches(pwd, vo.getPwd())) return "1";
		return "0";
	}
	
	@ResponseBody
  @RequestMapping(value = "/updateField", method = RequestMethod.POST)
  public String updateField(String field, String value, String mid, HttpSession session) {
	int res = memberService.updateMemberField(field, value, mid);
	  if (res == 1) {
	    // 업데이트 성공 시 세션 정보도 업데이트
	    if(field.equals("name")) session.setAttribute("sName", value);
	    return "success";
	  }
    return "failure";
  }

	@ResponseBody
	@RequestMapping(value = "/updatePhoto", method = RequestMethod.POST)
	public String updatePhoto(MultipartFile fName, HttpSession session) {
	  String mid = (String) session.getAttribute("sMid");
	  String res = memberService.updateMemberPhoto(fName, mid);
	  if (!res.equals("0")) {
	    // 업데이트 성공 시 세션의 사진 정보도 업데이트
	    session.setAttribute("sPhoto", res);
	    return "success";
	  }
	  return "failure";
	}
    
  @RequestMapping(value = "/userDel", method = RequestMethod.GET)
  public String userDel(HttpSession session) {
    String mid = (String) session.getAttribute("sMid");
    memberService.setMemberDel(mid);
    session.invalidate();
    return "redirect:/message/memberDeleteOk";
  }
	
  @ResponseBody
  @RequestMapping(value = "/memberEmailCheck", method = RequestMethod.POST)
  public String infoMemberEmailCheckPost(String email, HttpSession session) throws MessagingException {
    MemberVO vo = memberService.getMemberEmailCheck(email);
    if(vo != null) {
      return "alreadyMember";
    }
    else {
      UUID uid = UUID.randomUUID();
      String emailKey = uid.toString().substring(0, 8);
      session.setAttribute("sEmailKey", emailKey);
      
      String emailContent = 
        "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 5px;'>" +
            "<img src='cid:logo.png' alt='HomeLink Logo' style='display: block; margin: 0 auto; max-width: 150px;'>" +
            "<h2 style='color: #333; text-align: center;'>HomeLink 이메일 변경 인증</h2>" +
            "<p style='color: #666; line-height: 1.6;'>안녕하세요, HomeLink 회원님!</p>" +
            "<p style='color: #666; line-height: 1.6;'>이메일 주소 변경을 위한 인증 절차입니다. 아래 8자리 인증번호를 사용하여 이메일 변경을 완료해주세요.</p>" +
            "<div style='background-color: #f0f0f0; padding: 15px; border-radius: 5px; text-align: center; margin: 20px 0;'>" +
                "<h3 style='margin: 0; color: #333;'>인증번호</h3>" +
                "<p style='font-size: 24px; font-weight: bold; color: #84a98c; letter-spacing: 2px; margin: 10px 0;'>" + emailKey + "</p>" +
            "</div>" +
            "<h4 style='color: #333;'>인증 방법:</h4>" +
            "<ol style='color: #666; line-height: 1.6;'>" +
                "<li>이메일 변경 화면으로 돌아가세요.</li>" +
                "<li>\"이메일 인증\" 필드를 찾습니다.</li>" +
                "<li>위에 발급된 8자리 인증번호를 입력합니다.</li>" +
                "<li>\"인증 확인\" 버튼을 클릭합니다.</li>" +
            "</ol>" +
            "<p style='color: #666; line-height: 1.6;'>이메일 인증을 완료하면 새 이메일 주소로 변경이 완료됩니다.</p>" +
            "<p style='color: #666; line-height: 1.6;'>감사합니다!</p>" +
            "<p style='color: #666; line-height: 1.6;'>HomeLink 팀</p>" +
            "<p style='color: #999; font-size: 12px; margin-top: 20px;'>인증번호는 5분 후에 만료됩니다.<br>만약 인증번호를 분실하셨다면 다시 요청하실 수 있습니다.</p>" +
            "<p style='text-align: center;'>" +
                "<a href='http://49.142.157.251:9090/javaclassS16/' style='display: inline-block; background-color: #84a98c; color: white; text-decoration: none; padding: 10px 20px; border-radius: 5px; font-weight: bold;'>HomeLink 홈페이지 바로가기</a>" +
            "</p>" +
        "</div>";

      joinMailSend(email, "HomeLink 이메일 변경 인증번호 안내", emailContent);
      return "success";
    }
  }

  @ResponseBody
  @RequestMapping(value = "/verifyEmailForIdSearch", method = RequestMethod.POST)
  public String verifyEmailForIdSearch(@RequestParam String email, @RequestParam String verificationCode, HttpSession session) {
    String storedCode = (String) session.getAttribute("sEmailKey");
    if (storedCode != null && storedCode.equals(verificationCode)) {
      // 인증 성공
      MemberVO member = memberService.getMemberEmailCheck(email);
      if (member != null) {
        return member.getMid(); // 아이디 반환
      } else {
        return "not_found";
      }
    } 
    else {
      return "invalid_code";
    }
  }

  @ResponseBody
  @RequestMapping(value = "/sendVerificationForIdSearch", method = RequestMethod.POST)
  public String sendVerificationForIdSearch(@RequestParam String email, @RequestParam String name, HttpSession session) {
  		MemberVO member = memberService.getMemberNameEmailCheck(name, email);
      if (member == null) {
        return "not_found";
      }

      UUID uid = UUID.randomUUID();
      String emailKey = uid.toString().substring(0, 8);
      session.setAttribute("sEmailKey", emailKey);
      
      String emailContent = 
          "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 5px;'>" +
              "<img src='cid:logo.png' alt='HomeLink Logo' style='display: block; margin: 0 auto; max-width: 150px;'>" +
              "<h2 style='color: #333; text-align: center;'>HomeLink 아이디 찾기 인증</h2>" +
              "<p style='color: #666; line-height: 1.6;'>안녕하세요 "+name+"님 :)</p>" +
              "<p style='color: #666; line-height: 1.6;'>아이디 찾기를 위한 인증 절차입니다. 아래 8자리 인증번호를 사용하여 인증을 완료해주세요.</p>" +
              "<div style='background-color: #f0f0f0; padding: 15px; border-radius: 5px; text-align: center; margin: 20px 0;'>" +
                  "<h3 style='margin: 0; color: #333;'>인증번호</h3>" +
                  "<p style='font-size: 24px; font-weight: bold; color: #84a98c; letter-spacing: 2px; margin: 10px 0;'>" + emailKey + "</p>" +
              "</div>" +
              "<h4 style='color: #333;'>인증 방법:</h4>" +
              "<ol style='color: #666; line-height: 1.6;'>" +
                  "<li>아이디 찾기 화면으로 돌아가세요.</li>" +
                  "<li>\"인증번호\" 필드를 찾습니다.</li>" +
                  "<li>위에 발급된 8자리 인증번호를 입력합니다.</li>" +
                  "<li>\"인증 확인\" 버튼을 클릭합니다.</li>" +
              "</ol>" +
              "<p style='color: #666; line-height: 1.6;'>인증을 완료하면 귀하의 아이디를 확인하실 수 있습니다.</p>" +
              "<p style='color: #666; line-height: 1.6;'>감사합니다!</p>" +
              "<p style='color: #666; line-height: 1.6;'>HomeLink 팀</p>" +
              "<p style='color: #999; font-size: 12px; margin-top: 20px;'>인증번호는 5분 후에 만료됩니다.<br>만약 인증번호를 분실하셨다면 다시 요청하실 수 있습니다.</p>" +
              "<p style='text-align: center;'>" +
                  "<a href='http://49.142.157.251:9090/javaclassS16/' style='display: inline-block; background-color: #84a98c; color: white; text-decoration: none; padding: 10px 20px; border-radius: 5px; font-weight: bold;'>HomeLink 홈페이지 바로가기</a>" +
              "</p>" +
          "</div>";

      try {
          joinMailSend(email, "HomeLink 아이디 찾기 인증번호 안내", emailContent);
          return "success";
      } catch (MessagingException e) {
          e.printStackTrace();
          return "error";
      }
  }
  
  @ResponseBody
  @RequestMapping(value = "/memberNewPassword", method = RequestMethod.POST)
  public String memberNewPasswordPost(String mid, String email, HttpSession session) throws MessagingException {
      MemberVO vo = memberService.getMemberIdCheck(mid);
      if(vo != null && vo.getEmail().equals(email)) {
          // 정보확인후 정보가 맞으면 임시 비밀번호를 발급받아서 메일로 전송처리한다.
          
          UUID uid = UUID.randomUUID();
          String pwd = uid.toString().substring(0,8);
          
          // 새로 발급받은 비밀번호를 암호화 한후, DB에 저장한다.
          memberService.setPasswordUpdate(mid, passwordEncoder.encode(pwd));
          
          // 발급받은 비밀번호를 메일로 전송처리한다.
          String title = "HomeLink 임시 비밀번호 발급";
          String emailContent = 
              "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 5px;'>" +
                  "<img src='cid:logo.png' alt='HomeLink Logo' style='display: block; margin: 0 auto; max-width: 150px;'>" +
                  "<h2 style='color: #333; text-align: center;'>HomeLink 임시 비밀번호 발급</h2>" +
                  "<p style='color: #666; line-height: 1.6;'>안녕하세요 " + vo.getName() + "님,</p>" +
                  "<p style='color: #666; line-height: 1.6;'>귀하의 계정에 대한 임시 비밀번호가 발급되었습니다. 아래의 임시 비밀번호를 사용하여 로그인해 주세요.</p>" +
                  "<div style='background-color: #f0f0f0; padding: 15px; border-radius: 5px; text-align: center; margin: 20px 0;'>" +
                      "<h3 style='margin: 0; color: #333;'>임시 비밀번호</h3>" +
                      "<p style='font-size: 24px; font-weight: bold; color: #84a98c; letter-spacing: 2px; margin: 10px 0;'>" + pwd + "</p>" +
                  "</div>" +
                  "<p style='color: #666; line-height: 1.6;'>보안을 위해 로그인 후 즉시 비밀번호를 변경해 주시기 바랍니다.</p>" +
                  "<p style='color: #666; line-height: 1.6;'>감사합니다!</p>" +
                  "<p style='color: #666; line-height: 1.6;'>HomeLink 팀</p>" +
                  "<p style='text-align: center;'>" +
                      "<a href='http://49.142.157.251:9090/javaclassS16/' style='display: inline-block; background-color: #84a98c; color: white; text-decoration: none; padding: 10px 20px; border-radius: 5px; font-weight: bold;'>HomeLink 로그인 페이지</a>" +
                  "</p>" +
              "</div>";
          
          try {
              joinMailSend(email, title, emailContent);
              session.setAttribute("sLogin", "OK");
              return "1";
          } catch (MessagingException e) {
              // 이메일 전송 실패 시 로그 기록 또는 예외 처리
              e.printStackTrace();
              return "0";
          }
      }
      return "0";
  }
  
  // 비밀번호 재설정 페이지
	@RequestMapping(value = "/pwdChange", method = RequestMethod.GET)
	public String pwdChangeGet(HttpSession session, Model model) {
		return "member/pwdChange";
	}
	
	@ResponseBody
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public String updatePassword(@RequestParam String currentPwd, 
	                             @RequestParam String newPwd, 
	                             HttpSession session) {
	    String mid = (String) session.getAttribute("sMid");
	    MemberVO member = memberService.getMemberIdCheck(mid);
	    
	    if (member == null) {
	        return "user_not_found";
	    }
	    
	    // 현재 비밀번호 확인
	    if (!passwordEncoder.matches(currentPwd, member.getPwd())) {
	        return "wrong_password";
	    }
	    
	    // 새 비밀번호 암호화 및 업데이트
	    String encodedNewPwd = passwordEncoder.encode(newPwd);
	    memberService.setPasswordUpdate(mid, encodedNewPwd);
	    
	    return "success";
	}

	@RequestMapping(value = "/linkedFamily", method = RequestMethod.GET)
	public String viewFamily(HttpSession session, Model model) {
		 // 세션에서 현재 로그인한 사용자의 정보를 가져옵니다.
		 String mid = (String) session.getAttribute("sMid");
		 String familyCode = (String) session.getAttribute("sFamCode");
		 
		 
		 if(familyCode == null || familyCode.isEmpty()) {
		     model.addAttribute("message", "연결된 가족이 없습니다.");
		     return "member/linkedFamily"; // 가족이 없는 경우에 대한 처리
		 }
		 
		 // 가족 코드에 해당하는 모든 가족 구성원을 가져옵니다.
		 List<MemberVO> familyMembers = memberService.getFamilyMembersByFamCode(familyCode);
		 
		 model.addAttribute("familyMembers", familyMembers);
		 
		 return "member/linkedFamily";
	}

	
}
