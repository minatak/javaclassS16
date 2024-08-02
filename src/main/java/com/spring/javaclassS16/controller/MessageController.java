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
		else if(msgFlag.equals("photoInputOk")) {
			model.addAttribute("msg", "사진이 업로드되었어요 :)");
			model.addAttribute("url", "/photo/photoList");
		}
		else if(msgFlag.equals("photoInputNo")) {
			model.addAttribute("msg", "사진 업로드에 실패했어요");
			model.addAttribute("url", "/photo/photoInput");
		}
		else if(msgFlag.equals("photoDeleteOk")) {
			model.addAttribute("msg", "사진이 삭제되었습니다");
			model.addAttribute("url", "/photo/photoList");
		}
		else if(msgFlag.equals("photoDeleteNo")) {
			model.addAttribute("msg", "사진 삭제에 실패했어요");
			model.addAttribute("url", "/photo/photoContent?idx="+idx);
		}
		else if(msgFlag.equals("noticeInputOk")) {
			model.addAttribute("msg", "소식이 등록되었습니다");
			model.addAttribute("url", "/notice/noticeList");
		}
		else if(msgFlag.equals("noticeInputNo")) {
			model.addAttribute("msg", "소식 등록에 실패했어요");
			model.addAttribute("url", "/notice/noticeInput");
		}
		else if(msgFlag.equals("noticeUpdateOk")) {
			model.addAttribute("msg", "소식이 수정되었습니다");
			model.addAttribute("url", "/notice/noticeList");
		}
		else if(msgFlag.equals("noticeUpdateNo")) {
			model.addAttribute("msg", "소식 수정에 실패했어요");
			model.addAttribute("url", "/notice/noticeContent?idx="+idx);
		}
		else if(msgFlag.equals("voteInputOk")) {
			model.addAttribute("msg", "투표가 등록되었습니다");
			model.addAttribute("url", "/vote/voteList");
		}
		else if(msgFlag.equals("voteInputNo")) {
			model.addAttribute("msg", "투표 등록에 실패했어요");
			model.addAttribute("url", "/vote/voteInput");
		}
		else if(msgFlag.equals("workInputOk")) {
			model.addAttribute("msg", "할 일이 등록되었습니다");
			model.addAttribute("url", "/housework/workMain");
		}
		else if(msgFlag.equals("workInputNo")) {
			model.addAttribute("msg", "할 일 등록에 실패했어요");
			model.addAttribute("url", "/housework/workMain");
		}
		else if(msgFlag.equals("workUpdateOk")) {
			model.addAttribute("msg", "할 일이 수정되었습니다");
			model.addAttribute("url", "/housework/workMain");
		}
		else if(msgFlag.equals("workUpdateNo")) {
			model.addAttribute("msg", "할 일 수정에 실패했어요");
			model.addAttribute("url", "/housework/workMain");
		}
		else if(msgFlag.equals("workDeleteOk")) {
			model.addAttribute("msg", "할 일이 삭제되었습니다");
			model.addAttribute("url", "/housework/workMain");
		}
		else if(msgFlag.equals("workDeleteNo")) {
			model.addAttribute("msg", "할 일 삭제에 실패했습니다");
			model.addAttribute("url", "/housework/workMain");
		}
		else if(msgFlag.equals("meetingInputOk")) {
			model.addAttribute("msg", "회의가 등록되었습니다");
			model.addAttribute("url", "/familyMeeting/meetingList");
		}
		else if(msgFlag.equals("meetingInputNo")) {
			model.addAttribute("msg", "회의 등록에 실패했어요");
			model.addAttribute("url", "/familyMeeting/meetingInput");
		}
		else if(msgFlag.equals("meetingUpdateOk")) {
			model.addAttribute("msg", "회의 정보가 수정되었습니다");
			model.addAttribute("url", "/familyMeeting/meetingContent?idx="+idx);
		}
		else if(msgFlag.equals("meetingUpdateNo")) {
			model.addAttribute("msg", "회의 정보 수정에 실패했어요");
			model.addAttribute("url", "/familyMeeting/meetingContent?idx="+idx);
		}
		else if(msgFlag.equals("photoUpdateOk")) {
			model.addAttribute("msg", "사진이 수정되었습니다");
			model.addAttribute("url", "/photo/photoContent?idx="+idx);
		}
		else if(msgFlag.equals("photoUpdateNo")) {
			model.addAttribute("msg", "사진 정보 수정에 실패했어요");
			model.addAttribute("url", "/photo/photoContent?idx="+idx);
		}
		else if(msgFlag.equals("meetingDeleteOk")) {
			model.addAttribute("msg", "회의가 삭제되었습니다");
			model.addAttribute("url", "/familyMeeting/meetingList");
		}
		else if(msgFlag.equals("meetingDeleteOk")) {
			model.addAttribute("msg", "회의 삭제에 실패했어요");
			model.addAttribute("url", "/familyMeeting/meetingContent?idx="+idx);
		}
		else if(msgFlag.equals("voteDeleteOk")) {
			model.addAttribute("msg", "투표가 삭제되었습니다");
			model.addAttribute("url", "/vote/voteList");
		}
		else if(msgFlag.equals("voteDeleteNo")) {
			model.addAttribute("msg", "투표 삭제에 실패했어요");
			model.addAttribute("url", "/vote/voteContent?idx="+idx);
		}
		else if(msgFlag.equals("voteUpdateOk")) {
			model.addAttribute("msg", "투표가 수정되었습니다");
			model.addAttribute("url", "/vote/voteContent?idx="+idx);
		}
		else if(msgFlag.equals("voteUpdateNo")) {
			model.addAttribute("msg", "투표 수정에 실패했어요");
			model.addAttribute("url", "/vote/voteContent?idx="+idx);
		}
		
		
		return "include/message";
	}
	
}
