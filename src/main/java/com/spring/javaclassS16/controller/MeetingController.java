package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    
    // statusFilter를 searchString으로 사용
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "meeting", "status", statusFilter, session);
    
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
    List<MeetingTopicVO> proposedTopics = meetingService.getProposedTopics(familyCode, "제안됨");
    List<MemberVO> familyMembers = memberService.getFamilyMembersByFamCode(familyCode);
    
    model.addAttribute("proposedTopics", proposedTopics);
    model.addAttribute("familyMembers", familyMembers);
    
    return "familyMeeting/meetingInput";
  }
  
  @Transactional
  @RequestMapping(value = "/meetingInput", method = RequestMethod.POST)
  public String meetingInputPost(HttpSession session, FamilyMeetingVO vo, 
                                 @RequestParam(value = "selectedTopics", required = false) List<Integer> selectedTopicIdx,
                                 @RequestParam(value = "newTopics[title][]", required = false) List<String> newTopicTitles,
                                 @RequestParam(value = "newTopics[description][]", required = false) List<String> newTopicDescriptions,
                                 @RequestParam(value = "newTopics[priority][]", required = false) List<Integer> newTopicPriorities) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    String memberName = (String) session.getAttribute("sName");
    
    vo.setFamilyCode(familyCode);
    vo.setCreatedBy(memberIdx);
    vo.setFacilitatorName(memberService.getMemberNameByIdx(vo.getFacilitatorIdx()));
    vo.setRecorderName(memberService.getMemberNameByIdx(vo.getRecorderIdx()));
    
    // 1. 먼저 회의를 등록 
    int res = meetingService.setMeetingInput(vo);
    
    if(res > 0) {
      FamilyMeetingVO vo2 = meetingService.getMeetingLastIdx();
      
      int meetingIdx = vo2.getIdx(); // 새로 삽입된 회의의 idx
      
      // 회의 ID가 유효한지 확인
      if (meetingIdx > 0) {
        // 2. 선택된 기존 토픽을 연결하고 상태를 '예정됨'으로 변경
        if (selectedTopicIdx != null && !selectedTopicIdx.isEmpty()) {
          for (int topicIdx : selectedTopicIdx) {
            meetingService.linkTopicToMeeting(meetingIdx, topicIdx);
            meetingService.updateTopicStatus(topicIdx);
          }
        }
        // 3. 새로운 토픽을 추가하고 연결함
        if (newTopicTitles != null && !newTopicTitles.isEmpty()) {
          for (int i = 0; i < newTopicTitles.size(); i++) {
            String title = newTopicTitles.get(i);
            String description = newTopicDescriptions.get(i);
            int priority = newTopicPriorities.get(i);
            
            meetingService.setNewTopic(familyCode, title, description, priority, memberIdx, memberName);
            MeetingTopicVO topicVo = meetingService.getLastTopic();
            meetingService.linkTopicToMeeting(meetingIdx, topicVo.getIdx());
          }
        }
        
        return "redirect:/message/meetingInputOk";
      } else {
        // 회의 ID가 유효하지 않은 경우
        return "redirect:/message/meetingInputNo";
      }
    } else {
      return "redirect:/message/meetingInputNo";
    }
  }
  

  @RequestMapping(value = "/meetingUpdate", method = RequestMethod.GET)
  public String meetingUpdateGet(@RequestParam int idx, Model model, HttpSession session) {
    String familyCode = (String) session.getAttribute("sFamCode");
    
    FamilyMeetingVO meeting = meetingService.getMeetingByIdx(idx);
    List<MeetingTopicVO> proposedTopics = meetingService.getProposedTopics(familyCode, null);
    List<MemberVO> familyMembers = memberService.getFamilyMembersByFamCode(familyCode);
    List<Integer> selectedTopics = meetingService.getSelectedTopicIdx(idx);
    
    model.addAttribute("meeting", meeting);
    model.addAttribute("proposedTopics", proposedTopics);
    model.addAttribute("familyMembers", familyMembers);
    model.addAttribute("selectedTopics", selectedTopics);
    
    return "familyMeeting/meetingUpdate";
  }
  
  @Transactional
  @RequestMapping(value = "/meetingUpdate", method = RequestMethod.POST)
  public String meetingUpdatePost(HttpSession session, FamilyMeetingVO vo, 
                                 @RequestParam(value = "selectedTopics", required = false) List<Integer> selectedTopicIdx,
                                 @RequestParam(value = "newTopics[title][]", required = false) List<String> newTopicTitles,
                                 @RequestParam(value = "newTopics[description][]", required = false) List<String> newTopicDescriptions,
                                 @RequestParam(value = "newTopics[priority][]", required = false) List<Integer> newTopicPriorities) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    String memberName = (String) session.getAttribute("sName");
    
    vo.setFamilyCode(familyCode);
    vo.setFacilitatorName(memberService.getMemberNameByIdx(vo.getFacilitatorIdx()));
    vo.setRecorderName(memberService.getMemberNameByIdx(vo.getRecorderIdx()));
    
    // 1. 먼저 회의를 수정 
    int res = meetingService.setMeetingUpdate(vo);
    
    if(res > 0) {
      int meetingIdx = vo.getIdx();
      
      // 2. 기존 토픽 연결을 모두 제거
      meetingService.setRemoveAllTopicLinks(meetingIdx);
      
      // 3. 선택된 기존 토픽을 다시 연결
      if (selectedTopicIdx != null && !selectedTopicIdx.isEmpty()) {
        for (int topicIdx : selectedTopicIdx) {
          meetingService.linkTopicToMeeting(meetingIdx, topicIdx);
          meetingService.updateTopicStatus(topicIdx);
        }
      }
      
      // 4. 새로운 토픽을 추가하고 연결
      if (newTopicTitles != null && !newTopicTitles.isEmpty()) {
        for (int i = 0; i < newTopicTitles.size(); i++) {
          String title = newTopicTitles.get(i);
          String description = newTopicDescriptions.get(i);
          int priority = newTopicPriorities.get(i);
          
          meetingService.setNewTopic(familyCode, title, description, priority, memberIdx, memberName);
          MeetingTopicVO topicVo = meetingService.getLastTopic();
          meetingService.linkTopicToMeeting(meetingIdx, topicVo.getIdx());
        }
      }
      
      return "redirect:/message/meetingUpdateOk?idx="+meetingIdx;
    } else {
      return "redirect:/message/meetingUpdateNo?idx="+vo.getIdx();
    }
  }
  
  @RequestMapping(value = "/topicList", method = RequestMethod.GET)
  public String proposedTopicsGet(@RequestParam(required = false, defaultValue = "all") String status, Model model, HttpSession session) {
    String familyCode = (String) session.getAttribute("sFamCode");
    
    List<MeetingTopicVO> proposedTopics = meetingService.getProposedTopics(familyCode, status);
    
    // 각 주제에 대한 댓글 가져오기
    Map<Integer, List<MeetingTopicReplyVO>> topicReplies = new HashMap<>();
    for (MeetingTopicVO topic : proposedTopics) {
        List<MeetingTopicReplyVO> replies = meetingService.getTopicReplies(topic.getIdx());
        topicReplies.put(topic.getIdx(), replies);
    }
    
    model.addAttribute("proposedTopics", proposedTopics);
    model.addAttribute("topicReplies", topicReplies);
    model.addAttribute("currentStatus", status);
    
    return "familyMeeting/topicList";
  }
  
  @RequestMapping(value = "/meetingContent", method = RequestMethod.GET)
  public String meetingDetailGet(Model model, HttpSession session, @RequestParam("idx") int idx) {
    String familyCode = (String) session.getAttribute("sFamCode");
    FamilyMeetingVO meeting = meetingService.getMeetingContent(familyCode, idx);
    List<MeetingTopicVO> topics = meetingService.getMeetingTopics(idx);
    
    model.addAttribute("meeting", meeting);
    model.addAttribute("topics", topics);
    
    String shortDecision = "";
    String shortActionItem = "";
    String shortNote = "";
    
	  if(meeting.getDecisions() != null && meeting.getDecisions().length() >= 100) {
	  	shortDecision = meetingService.truncateStr(meeting.getDecisions(), 100);
	  	if(shortDecision.equals(meeting.getDecisions())) shortDecision = "";
	  }
	  if(meeting.getActionItems() != null && meeting.getActionItems().length() >= 100) {
	  	shortActionItem = meetingService.truncateStr(meeting.getActionItems(), 100);
	  	if(shortActionItem.equals(meeting.getActionItems())) shortActionItem = "";
	  }
	  if(meeting.getNotes() != null && meeting.getNotes().length() >= 100) {
	  	shortNote = meetingService.truncateStr(meeting.getNotes(), 100);
	  	if(shortNote.equals(meeting.getNotes())) shortNote = "";
	  }
    
	  model.addAttribute("meeting", meeting);
    model.addAttribute("topics", topics);
    model.addAttribute("shortDecision", shortDecision);
    model.addAttribute("shortActionItem", shortActionItem);
    model.addAttribute("shortNote", shortNote);
    
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
  @RequestMapping(value = "/saveMeeting", method = RequestMethod.POST)
  public int saveMeetingPost(HttpSession session, FamilyMeetingVO familyMeetingVO) {
      String familyCode = (String) session.getAttribute("sFamCode");
      int memberIdx = (int) session.getAttribute("sIdx");
      
      familyMeetingVO.setFamilyCode(familyCode);
      familyMeetingVO.setRecorderIdx(memberIdx);
      
      int res1 = meetingService.setSaveMeeting(familyMeetingVO);
      int res2 = meetingService.updateMeetingTopicsStatus(familyMeetingVO.getIdx());
      
      return (res1 > 0 && res2 > 0) ? 1 : 0;
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