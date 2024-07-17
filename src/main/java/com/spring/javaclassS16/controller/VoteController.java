package com.spring.javaclassS16.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.spring.javaclassS16.vo.VoteVO;

@Controller
@RequestMapping("/vote")
public class VoteController {
  
  @Autowired
  VoteService voteService;
  
  @Autowired
  PageProcess pageProcess;
  
  
  @RequestMapping(value = "/voteList", method = RequestMethod.GET)
  public String noticeListGet(Model model, HttpSession session,
    @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
    @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "vote", "", "", session);
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
  
    ArrayList<VoteVO> vos = voteService.getVoteList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize);

    // 현재 날짜 구하기
    LocalDate currentDate = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");  // endTime을 날짜 형식으로 변환하기 위해서

    // 각 투표의 daysLeft 계산
    for (VoteVO vo : vos) {
      if (vo.getEndTime() != null && !vo.getEndTime().isEmpty()) {
        LocalDate endDate = LocalDate.parse(vo.getEndTime(), formatter);
        long daysLeft = ChronoUnit.DAYS.between(currentDate, endDate);
        vo.setDaysLeft((int) daysLeft);
      }
    }

    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
  
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
  
  /*
  @RequestMapping(value = "/voteContent", method = RequestMethod.GET)
  public String voteContentGet(Model model, HttpSession session,
    @RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");

    VoteVO voteVO = voteService.getVoteContent(idx, familyCode);
    
    List<VoteOptionVO> voteOptions = voteService.getVoteOptions(idx);
    boolean hasVoted = voteService.hasVoted(idx, memberIdx);

    // 현재 날짜 구하기
    LocalDate currentDate = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

    // 남은 일수 계산
    if (voteVO.getEndTime() != null) {
      LocalDate endDate = LocalDate.parse(voteVO.getEndTime(), formatter);
      long daysLeft = ChronoUnit.DAYS.between(currentDate, endDate);
      voteVO.setDaysLeft((int) daysLeft);
    }

    boolean isEnded = false;
    
    // 투표가 종료되었는지 확인
    if (voteVO.getEndTime() != null && !voteVO.getEndTime().isEmpty()) {
      LocalDateTime endDateTime = LocalDateTime.parse(voteVO.getEndTime(), formatter);
      isEnded = LocalDateTime.now().isAfter(endDateTime);

      if (isEnded) {
        // 투표 결과 조회 (voteCount 포함된 voteOptions)
        voteOptions = voteService.getVoteOptionsWithResults(idx);
      }
    }

    model.addAttribute("vo", voteVO);
    model.addAttribute("voteOptions", voteOptions);
    model.addAttribute("hasVoted", hasVoted);
    model.addAttribute("isEnded", isEnded);

    return "vote/voteContent";
  }
	*/
  @RequestMapping(value = "/voteContent", method = RequestMethod.GET)
  public String voteContentGet(Model model, HttpSession session,
    @RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");

    VoteVO voteVO = voteService.getVoteContent(idx, familyCode);
    
    List<VoteOptionVO> voteOptions = voteService.getVoteOptions(idx);
    boolean hasVoted = voteService.hasVoted(idx, memberIdx);

    // 현재 날짜 구하기
    LocalDate currentDate = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

    // 남은 일수 계산
    if (voteVO.getEndTime() != null) {
      LocalDate endDate = LocalDate.parse(voteVO.getEndTime(), formatter);
      long daysLeft = ChronoUnit.DAYS.between(currentDate, endDate);
      voteVO.setDaysLeft((int) daysLeft);
    }

    boolean isEnded = false;
    
    // 투표가 종료되었는지 확인
    if (voteVO.getEndTime() != null && !voteVO.getEndTime().isEmpty()) {
      LocalDateTime endDateTime = LocalDateTime.parse(voteVO.getEndTime(), formatter);
      isEnded = LocalDateTime.now().isAfter(endDateTime);

      if (isEnded) {
        // 투표 결과 조회 (voteCount 포함된 voteOptions)
        voteOptions = voteService.getVoteOptionsWithResults(idx);
      }
    }

    // 투표 참여자 정보 가져오기
    List<MemberVO> participants = voteService.getVoteParticipants(idx);

    // 미참여 가족 정보 가져오기
    List<MemberVO> nonParticipants = voteService.getNonParticipants(idx, familyCode);

    model.addAttribute("vo", voteVO);
    model.addAttribute("voteOptions", voteOptions);
    model.addAttribute("hasVoted", hasVoted);
    model.addAttribute("isEnded", isEnded);
    model.addAttribute("participants", participants);
    model.addAttribute("nonParticipants", nonParticipants);

    return "vote/voteContent";
  }

  @ResponseBody
  @RequestMapping(value = "/doVote", method = RequestMethod.POST)
  public String doVotePost(@RequestParam("voteIdx") int voteIdx, 
                           @RequestParam("optionIdx[]") List<Integer> optionIdx,
                           HttpSession session) {
      int memberIdx = (int) session.getAttribute("sIdx");
      int res = voteService.setDoVote(voteIdx, memberIdx, optionIdx);
      
      return res + "";
  }
//  
//  @ResponseBody
//  @RequestMapping(value = "/voteUpdate", method = RequestMethod.POST)
//  public String voteUpdatePost(VoteVO vo, 
//                               @RequestParam("options[]") List<String> options,
//                               HttpSession session) {
//      int memberIdx = (int) session.getAttribute("sIdx");
//      if (vo.getMemberIdx() != memberIdx) {
//          return "0"; // 투표 생성자만 수정 가능
//      }
//      
//      int res = voteService.setUpdateVote(vo, options);
//      
//      return res > 0 ? "1" : "0";
//  }
//
//  @ResponseBody
//  @RequestMapping(value = "/voteDelete", method = RequestMethod.POST)
//  public String voteDeletePost(@RequestParam("idx") int idx, HttpSession session) {
//      int memberIdx = (int) session.getAttribute("sIdx");
//      VoteVO voteVO = voteService.getVoteContent(idx, null);
//      
//      if (voteVO.getMemberIdx() != memberIdx) {
//          return "0"; // 투표 생성자만 삭제 가능
//      }
//      
//      int res = voteService.setDeleteVote(idx);
//      
//      return res > 0 ? "1" : "0";
//  }
//
//  @ResponseBody
//  @RequestMapping(value = "/voteEnd", method = RequestMethod.POST)
//  public String voteEndPost(@RequestParam("idx") int idx, HttpSession session) {
//      int memberIdx = (int) session.getAttribute("sIdx");
//      VoteVO voteVO = voteService.getVoteContent(idx, null);
//      
//      if (voteVO.getMemberIdx() != memberIdx) {
//          return "0"; // 투표 생성자만 종료 가능
//      }
//      
//      int res = voteService.setEndVote(idx);
//      
//      return res > 0 ? "1" : "0";
//  }
//  
  
  
  
}
