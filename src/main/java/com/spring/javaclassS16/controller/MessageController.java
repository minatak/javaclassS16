package com.spring.javaclassS16.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="name", defaultValue = "", required = false) String name,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) String pageSize
		) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입이 완료되었습니다");
			model.addAttribute("url", "/member/memberFamCode");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원 가입에 실패했어요");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", name+"님 로그인 되셨습니다");
			model.addAttribute("url", "/h");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인에 실패했어요. 아이디와 비밀번호를 확인해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", name + "님 로그아웃 되셨습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("alreadyMember")) {
			model.addAttribute("msg", "이미 가입되어있는 이메일이에요.\\n아이디 찾기 등을 이용하여 로그인해주세요!");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("successFamCode")) {
			model.addAttribute("msg", "가족 코드가 성공적으로 등록되었어요 :)");
			model.addAttribute("url", "/h");
		}
		else if(msgFlag.equals("memberNot")) {
			model.addAttribute("msg", "회원가입이 되지 않은 사용자에요.\\n회원가입 후 진행해주세요!");
			model.addAttribute("url", "/member/memberJoin0");
		}
		
		
		return "include/message";
	}
	
}
