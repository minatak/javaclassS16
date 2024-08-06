package com.spring.javaclassS16.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.pagination.PageProcess;
import com.spring.javaclassS16.service.VoteService;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PageVO;
import com.spring.javaclassS16.vo.VoteOptionVO;
import com.spring.javaclassS16.vo.VoteReplyVO;
import com.spring.javaclassS16.vo.VoteVO;

@Controller
@RequestMapping("/vote")
public class VoteController {
  
  @Autowired
  VoteService voteService;
  
  @Autowired
  PageProcess pageProcess;
  
  
  @RequestMapping(value = "/voteList", method = RequestMethod.GET)
  public String voteListGet(Model model, HttpSession session,
    @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
    @RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize,
    @RequestParam(name="choice", defaultValue = "전체", required = false) String choice) {
    
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");

    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "vote", choice, "", session);
    
    ArrayList<VoteVO> vos = voteService.getVoteList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize, choice);

    // 현재 날짜 구하기
    LocalDateTime currentDateTime = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

    // 각 투표의 daysLeft 계산 및 만료된 투표 종료
    for (VoteVO vo : vos) {
      if (vo.getEndTime() != null && !vo.getEndTime().isEmpty()) {
        LocalDateTime endDateTime = LocalDateTime.parse(vo.getEndTime(), formatter);
        
        if (currentDateTime.isAfter(endDateTime) && !"CLOSED".equals(vo.getStatus())) {
          // 투표가 만료되었고 아직 종료 상태가 아니라면 종료 처리
          voteService.setEndVote(vo.getIdx());
          vo.setStatus("CLOSED");
        } else if (!currentDateTime.isAfter(endDateTime)) {
          // 투표가 아직 진행 중이라면 남은 일수 계산
          long daysLeft = ChronoUnit.DAYS.between(currentDateTime.toLocalDate(), endDateTime.toLocalDate());
          vo.setDaysLeft((int) daysLeft);
        }
      }
    }
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    model.addAttribute("choice", choice); 
    
    return "vote/voteList";
  }

  
  @RequestMapping(value = "/voteInput", method = RequestMethod.GET)
  public String noticeInputGet(Model model) {
    return "vote/voteInput";
  }
  
  
  @RequestMapping(value = "/voteInput", method = RequestMethod.POST)
  public String voteInputPost(VoteVO vo, @RequestParam("options[]") List<String> options) {
    if(vo.getEndTime().trim().equals("")) vo.setEndTime(null);
    int res = voteService.setVoteInput(vo, options);
    
    if(res != 0) return "redirect:/message/voteInputOk";
    else return "redirect:/message/voteInputNo";
  }
  
  @RequestMapping(value = "/voteContent", method = RequestMethod.GET)
  public String voteContentGet(Model model, HttpSession session,
      @RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");

    VoteVO voteVO = voteService.getVoteContent(idx, familyCode);
    
    List<VoteOptionVO> voteOptions = voteService.getVoteOptionsWithResults(idx);
    boolean hasVoted = voteService.hasVoted(idx, memberIdx);

    // 현재 날짜 구하기
    LocalDateTime currentDateTime = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

    boolean isEnded = false;
    
    // 투표가 종료되었는지 확인
    if (voteVO.getEndTime() != null && !voteVO.getEndTime().isEmpty()) {
      LocalDateTime endDateTime = LocalDateTime.parse(voteVO.getEndTime(), formatter);
      isEnded = currentDateTime.isAfter(endDateTime); // 마감일이 지난 투표이면 종료 처리

      // 만약 투표가 종료되었다면 상태 업데이트
      if (isEnded && !"CLOSED".equals(voteVO.getStatus())) {
        voteService.setEndVote(idx);
        voteVO.setStatus("CLOSED");
      }

      // 남은 일수 계산 (종료되지 않은 경우에만)
      if (!isEnded) {
        long daysLeft = ChronoUnit.DAYS.between(currentDateTime.toLocalDate(), endDateTime.toLocalDate());
        voteVO.setDaysLeft((int) daysLeft);
      }
    }

    // 퍼센트 계산 코드
    int totalVotes = voteOptions.stream().mapToInt(VoteOptionVO::getVoteCount).sum();
    for (VoteOptionVO option : voteOptions) {
      double percent = totalVotes > 0 ? (double) option.getVoteCount() / totalVotes * 100 : 0;
      option.setVotePercent(Math.round(percent * 10.0) / 10.0);  // 소수점 첫째자리까지 반올림
    }
    
    // 투표 참여자 정보 가져오기
    List<MemberVO> participants = voteService.getVoteParticipants(idx);
    participants = participants.stream().distinct().collect(Collectors.toList()); // 중복 제거
    
    // 미참여 가족 정보 가져오기
    List<MemberVO> nonParticipants = voteService.getNonParticipants(idx, familyCode);

    String statusStr = "";
    
    if (voteVO.getEndTime() != null && !voteVO.getEndTime().isEmpty()) {
      LocalDateTime endDateTime = LocalDateTime.parse(voteVO.getEndTime(), formatter);
      long daysLeft = ChronoUnit.DAYS.between(currentDateTime.toLocalDate(), endDateTime.toLocalDate());
      long hoursLeft = ChronoUnit.HOURS.between(currentDateTime, endDateTime);
      long minutesLeft = ChronoUnit.MINUTES.between(currentDateTime, endDateTime) % 60;

      if (currentDateTime.isAfter(endDateTime)) {
      	statusStr = "종료됨";
      } else if (daysLeft > 1) {
      	statusStr = String.format("%d일 남음", daysLeft);
      } else if (daysLeft == 1) {
      	statusStr = "내일 마감";
      } else if (daysLeft == 0 && hoursLeft >= 24) {
        statusStr = "오늘 마감";
      } else if(minutesLeft > 0 && hoursLeft < 1) {
      	statusStr = String.format("%d분 남음", minutesLeft);
      } else {
      	statusStr = String.format("%d시간 %d분 남음", hoursLeft, minutesLeft);
      }
    }
    List<VoteReplyVO> replyVos = voteService.getVoteReply(idx); // 댓글 가져오기
    
    model.addAttribute("vo", voteVO);
    model.addAttribute("voteOptions", voteOptions);
    model.addAttribute("hasVoted", hasVoted);
    model.addAttribute("isEnded", isEnded);
    model.addAttribute("participants", participants);
    model.addAttribute("nonParticipants", nonParticipants);
    model.addAttribute("statusStr", statusStr);
    model.addAttribute("replyVos", replyVos);

    return "vote/voteContent";
  }

  @ResponseBody
  @RequestMapping(value = "/doVote", method = RequestMethod.POST)
  public String doVotePost(@RequestParam("voteIdx") int voteIdx, 
                           @RequestParam("optionIdx[]") List<Integer> optionIdx,
                           HttpSession session) {
    int memberIdx = (int) session.getAttribute("sIdx");
    
    List<MemberVO> vos =voteService.getVoteParticipants(memberIdx); // 해당 투표의 참여자 정보 가져오기
    for (MemberVO vo : vos) {
    	if(vo.getIdx() == memberIdx) voteService.setCancelVote(voteIdx, memberIdx); // 참여했던 투표일 경우 투표 취소시키기 (다시 투표하기를 누른 경우임)
    }
    
    int res = voteService.setDoVote(voteIdx, memberIdx, optionIdx);
    
    return res + "";
  }
  
  @ResponseBody
  @RequestMapping(value = "/endVote", method = RequestMethod.POST)
  public int endVote(@RequestParam("voteIdx") int voteIdx) {
	  int res = voteService.setEndVote(voteIdx);
	  return res;
  }
  
  @ResponseBody
	@RequestMapping(value = "/voteReplyInput", method = RequestMethod.POST)
	public String noticeReplyInputPost(VoteReplyVO replyVO, HttpSession session) {
    String name = (String) session.getAttribute("sName");
    replyVO.setName(name);
    int res = voteService.setVoteReplyInput(replyVO);
    
    return res+"";
	}
  
  @RequestMapping(value = "/voteDelete", method = RequestMethod.GET)
  public String voteDeleteGet(@RequestParam(name="idx") int idx) {
    boolean isDeleted = voteService.setDeleteVote(idx);
    
    if(isDeleted) {
        return "redirect:/message/voteDeleteOk";
    } else {
        return "redirect:/message/voteDeleteNo?idx=" + idx;
    }
  }
  
  @RequestMapping(value = "/voteUpdate", method = RequestMethod.GET)
  public String meetingUpdateGet(@RequestParam int idx, Model model, HttpSession session) {
    String familyCode = (String) session.getAttribute("sFamCode");
    // 투표 정보 조회
    VoteVO voteVO = voteService.getVoteContent(idx, familyCode);
    
    // 투표 옵션 조회
    List<VoteOptionVO> options = voteService.getVoteOptions(idx);
    
    model.addAttribute("vo", voteVO);
    model.addAttribute("options", options);
    return "vote/voteUpdate";
  }
  
  @RequestMapping(value = "/voteUpdate", method = RequestMethod.POST)
  public String voteUpdatePost(VoteVO vo, 
	                           @RequestParam("options[]") List<String> options,
	                           @RequestParam(value = "deletedOptions[]", required = false) List<Integer> deletedOptions) {
	  if(vo.getEndTime().trim().equals("")) vo.setEndTime(null);
	  
	  int res = voteService.setVoteUpdate(vo, options, deletedOptions);
	  
	  if(res != 0) return "redirect:/message/voteUpdateOk?idx=" + vo.getIdx();
	  else return "redirect:/message/voteUpdateNo?idx=" + vo.getIdx();
  }
  
  @ResponseBody
  @RequestMapping(value = "/reVote", method = RequestMethod.POST)
  public String reVotePost(@RequestParam("voteIdx") int voteIdx, HttpSession session) {
      int memberIdx = (int) session.getAttribute("sIdx");
      
      // 이전 투표 삭제 및 voteCount 감소
      int res = voteService.setCancelAndResetVote(voteIdx, memberIdx);
      
      if(res > 0) {
          return "1"; // 성공
      } else {
          return "0"; // 실패
      }
  }
  
//  @ResponseBody
//  @RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
//  public int replyDeletePost(@RequestParam(name="idx") int idx) {
//    return voteService.setReplyDelete(idx);
//  }
  

  @Transactional
  @ResponseBody
  @RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
  public String replyDeletePost(@RequestParam int idx) {
  	
  	// 삭제하려는 댓글이 부모 댓글인지 대댓글인지 확인 (parentIdx가 null이면 부모댓글)
  	VoteReplyVO vo = voteService.getVoteReplyVo(idx);
  	// 부모 댓글을 삭제할 경우
  	if(vo.getParentIdx() == null) {
  		// 먼저 대댓글들을 삭제 
  		voteService.setReplyDeleteByParentIdx(idx);
  	}

  	// 그 다음 부모 댓글 삭제
  	return voteService.setReplyDelete(idx) + "";
  }
  
  
}
