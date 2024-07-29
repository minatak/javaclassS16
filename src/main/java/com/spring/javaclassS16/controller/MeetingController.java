package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.pagination.PageProcess;
import com.spring.javaclassS16.service.MeetingService;
import com.spring.javaclassS16.service.MemberService;
import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.MeetingTopicReplyVO;
import com.spring.javaclassS16.vo.MeetingTopicVO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PageVO;

@Controller
@RequestMapping("/familyMeeting")
public class MeetingController {
  
  @Autowired
  MeetingService meetingService;
  
  @Autowired
  MemberService memberService;
  
  @Autowired
  PageProcess pageProcess;
  
  @RequestMapping(value = "/meetingList", method = RequestMethod.GET)
  public String meetingListGet(Model model, HttpSession session,
      @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
      @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
      @RequestParam(name="statusFilter", defaultValue = "", required = false) String statusFilter,
      @RequestParam(name="sortBy", defaultValue = "date", required = false) String sortBy) {
    
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    String dbSortBy;
    switch(sortBy) {
      case "date":
        dbSortBy = "meetingDate";
        break;
      case "status":
        dbSortBy = "status";
        break;
      default:
        dbSortBy = "createdAt";
    }
    
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "meeting", statusFilter, dbSortBy, session);
    
    ArrayList<FamilyMeetingVO> vos = meetingService.getMeetingList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize, statusFilter, dbSortBy);
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    model.addAttribute("statusFilter", statusFilter);
    model.addAttribute("sortBy", sortBy);
    return "familyMeeting/meetingList";
  }
  
  @RequestMapping(value = "/meetingInput", method = RequestMethod.GET)
  public String meetingInputGet(Model model, HttpSession session) {
    String familyCode = (String) session.getAttribute("sFamCode");
    List<MeetingTopicVO> proposedTopics = meetingService.getProposedTopics(familyCode, null);
    List<MemberVO> familyMembers = memberService.getFamilyMembersByFamCode(familyCode);
    
    model.addAttribute("proposedTopics", proposedTopics);
    model.addAttribute("familyMembers", familyMembers);
    
    return "familyMeeting/meetingInput";
  }
  
  @RequestMapping(value = "/meetingInput", method = RequestMethod.POST)
  public String meetingInputPost(HttpSession session, FamilyMeetingVO familyMeetingVO, 
                                 @RequestParam(value = "selectedTopics", required = false) List<Integer> selectedTopicIdx,
                                 @RequestParam(value = "newTopics[]", required = false) List<String> newTopics) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    familyMeetingVO.setFamilyCode(familyCode);
    familyMeetingVO.setCreatedBy(memberIdx);
    
    int res = meetingService.setMeetingInput(familyMeetingVO, selectedTopicIdx, newTopics);
    
    if(res != 0) return "redirect:/message/meetingInputOk";
		else return "redirect:/message/meetingInputNo";
  }
  
  @RequestMapping(value = "/topicList", method = RequestMethod.GET)
  public String proposedTopicsGet(@RequestParam(required = false) String status, Model model, HttpSession session) {
    String familyCode = (String) session.getAttribute("sFamCode");
    
    List<MeetingTopicVO> proposedTopics;
    if (status == null || status.equals("all")) {
        proposedTopics = meetingService.getProposedTopics(familyCode, null);
    } else {
        proposedTopics = meetingService.getProposedTopics(familyCode, status);
    }
    
    // 각 주제에 대한 댓글 가져오기
    Map<Integer, List<MeetingTopicReplyVO>> topicReplies = new HashMap<>();
    for (MeetingTopicVO topic : proposedTopics) {
        List<MeetingTopicReplyVO> replies = meetingService.getTopicReplies(topic.getIdx());
        topicReplies.put(topic.getIdx(), replies);
    }
    
    model.addAttribute("proposedTopics", proposedTopics);
    model.addAttribute("topicReplies", topicReplies);
    model.addAttribute("currentStatus", status == null ? "all" : status);
    
    return "familyMeeting/topicList";
  }
  
  @RequestMapping(value = "/meetingContent", method = RequestMethod.GET)
  public String meetingDetailGet(Model model, HttpSession session, @RequestParam("idx") int idx) {
    String familyCode = (String) session.getAttribute("sFamCode");
    FamilyMeetingVO meeting = meetingService.getMeetingContent(familyCode, idx);
    List<MeetingTopicVO> topics = meetingService.getMeetingTopics(idx);
    
    model.addAttribute("meeting", meeting);
    model.addAttribute("topics", topics);
    
    return "familyMeeting/meetingContent";
  }
  
  @RequestMapping(value = "/topicInput", method = RequestMethod.GET)
  public String topicInputGet() {
    return "familyMeeting/topicInput";
  }
  
  @ResponseBody
  @RequestMapping(value = "/topicInput", method = RequestMethod.POST)
  public int topicInputPost(HttpSession session, MeetingTopicVO topicVO) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    topicVO.setFamilyCode(familyCode);
    topicVO.setMemberIdx(memberIdx);
    
    int res = meetingService.setTopicInput(topicVO);
    
    return res;
  }
  
  @ResponseBody
  @RequestMapping(value = "/saveMeetingMinutes", method = RequestMethod.POST)
  public int saveMeetingMinutesPost(HttpSession session, FamilyMeetingVO familyMeetingVO) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    familyMeetingVO.setFamilyCode(familyCode);
    familyMeetingVO.setRecorderIdx(memberIdx);
    
    int res = meetingService.setMeetingMinutes(familyMeetingVO);
    
    return res;
  }
  
  @ResponseBody
  @RequestMapping(value = "/getComments", method = RequestMethod.GET)
  public List<MeetingTopicReplyVO> getComments(@RequestParam("topicIdx") int topicIdx) {
    return meetingService.getTopicReplies(topicIdx);
  }
  
  @ResponseBody
  @RequestMapping(value = "/replyInput", method = RequestMethod.POST)
  public String replyInputPost(MeetingTopicReplyVO replyVO, HttpSession session) {
    int memberIdx = (int) session.getAttribute("sIdx");
    String memberName = (String) session.getAttribute("sName");
    
    replyVO.setMemberIdx(memberIdx);
    replyVO.setMemberName(memberName);
    
    return meetingService.setReplyInput(replyVO);
  }

  @ResponseBody
  @RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
  public int replyDeletePost(@RequestParam(name="idx") int idx) {
    return meetingService.setReplyDelete(idx);
  }

  @RequestMapping(value = "/topicUpdate", method = RequestMethod.GET)
  public String topicUpdateGet(Model model, @RequestParam(name="idx") int idx) {
    MeetingTopicVO topicVO = meetingService.getTopicByIdx(idx);
    model.addAttribute("vo", topicVO);
    return "familyMeeting/topicUpdate";
  }

  @ResponseBody
  @RequestMapping(value = "/topicUpdate", method = RequestMethod.POST)
  public String topicUpdatePost(MeetingTopicVO topicVO) {
    return meetingService.setTopicUpdate(topicVO);
  }

  @ResponseBody
  @RequestMapping(value = "/topicDelete", method = RequestMethod.POST)
  public int topicDeletePost(@RequestParam(name="idx") int idx) {
    return meetingService.setTopicDelete(idx);
  }
  
}