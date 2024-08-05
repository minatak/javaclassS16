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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.pagination.PageProcess;
import com.spring.javaclassS16.service.MeetingService;
import com.spring.javaclassS16.service.MemberService;
import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.MeetingTopicLinkVO;
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
    List<MeetingTopicVO> proposedTopics = meetingService.getAllProposedTopics(familyCode, "제안됨");
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
    List<MeetingTopicVO> proposedTopics = meetingService.getAllProposedTopics(familyCode, "제안됨");
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
  

  @RequestMapping(value = "/meetingDelete", method = RequestMethod.GET)
  public String meetingDeleteGet(@RequestParam(name="idx") int idx) {
    
    int res1 = meetingService.setMeetingTopicLink(idx);
    int res2 = meetingService.setMeetingDelete(idx);
		
		if(res1 != 0 && res2 != 0) return "redirect:/message/meetingDeleteOk";
		else return "redirect:/message/meetingDeleteNo?idx="+idx;
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
  
  // 아래에서부터 안건 제안 페이지의 백엔드 처리
  
  
  /*
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
  */
  
  @RequestMapping(value = "/topicList", method = RequestMethod.GET)
  public String proposedTopicsGet(
      @RequestParam(required = false, defaultValue = "all") String status,
      @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
      @RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize,
      @RequestParam(name="sortBy", defaultValue = "status", required = false) String sortBy,
      Model model, HttpSession session) {
      
      String familyCode = (String) session.getAttribute("sFamCode");
      
      // "meetingTopic" 섹션을 사용하고, status를 searchString으로 전달
      PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "meetingTopic", "status", status, session);
      
      String dbSortBy;
      switch(sortBy) {
          case "date":
              dbSortBy = "t.createdAt";
              break;
          case "status":
              dbSortBy = "CASE t.status " +
                         "WHEN '제안됨' THEN 1 " +
                         "WHEN '승인됨' THEN 2 " +
                         "WHEN '예정' THEN 3 " +
                         "WHEN '논의중' THEN 4 " +
                         "WHEN '결정됨' THEN 5 " +
                         "WHEN '보류' THEN 6 " +
                         "ELSE 7 END";
              break;
          default:
              dbSortBy = "t.createdAt";
      }
      
      List<MeetingTopicVO> proposedTopics = meetingService.getProposedTopics(familyCode, status, pageVO.getStartIndexNo(), pageSize, dbSortBy);
      
      Map<Integer, List<MeetingTopicReplyVO>> topicReplies = new HashMap<>();
      for (MeetingTopicVO topic : proposedTopics) {
          List<MeetingTopicReplyVO> replies = meetingService.getTopicReplies(topic.getIdx());
          topicReplies.put(topic.getIdx(), replies);
      }
      
      model.addAttribute("proposedTopics", proposedTopics);
      model.addAttribute("topicReplies", topicReplies);
      model.addAttribute("currentStatus", status);
      model.addAttribute("pageVO", pageVO);
      model.addAttribute("sortBy", sortBy);
      
      return "familyMeeting/topicList";
  }

  @ResponseBody
  @RequestMapping(value = "/topicInput", method = RequestMethod.POST)
  public String topicInputPost(MeetingTopicVO topicVO, HttpSession session) {
      String familyCode = (String) session.getAttribute("sFamCode");
      int memberIdx = (int) session.getAttribute("sIdx");
      String memberName = (String) session.getAttribute("sName");
      
      topicVO.setFamilyCode(familyCode);
      topicVO.setMemberIdx(memberIdx);
      topicVO.setMemberName(memberName);
      
      int res = meetingService.setTopicInput(topicVO);
      
      return res > 0 ? "1" : "0";
  }

  @ResponseBody
  @RequestMapping(value = "/topicUpdate", method = RequestMethod.POST)
  public int topicUpdatePost(MeetingTopicVO topicVO) {
  	
    return meetingService.setTopicUpdate(topicVO);
  }
  
  @ResponseBody
  @RequestMapping(value = "/getComments", method = RequestMethod.GET)
  public List<MeetingTopicReplyVO> getComments(@RequestParam("topicIdx") int topicIdx) {
    return meetingService.getTopicReplies(topicIdx);
  }
  
  @ResponseBody
  @RequestMapping(value = "/replyInput", method = RequestMethod.POST)
  public String replyInputPost(@RequestParam int topicIdx, @RequestParam String content, HttpSession session) {
      try {
          int memberIdx = (int) session.getAttribute("sIdx");
          String memberName = (String) session.getAttribute("sName");
          
          MeetingTopicReplyVO replyVO = new MeetingTopicReplyVO();
          replyVO.setTopicIdx(topicIdx);
          replyVO.setContent(content);
          replyVO.setMemberIdx(memberIdx);
          replyVO.setMemberName(memberName);
          
          int res = meetingService.setReplyInput(replyVO);
          return res + "";
      } catch (Exception e) {
          e.printStackTrace();
          return "0";
      }
  }

  @ResponseBody
  @RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
  public int replyDeletePost(@RequestParam(name="idx") int idx) {
    return meetingService.setReplyDelete(idx);
  }

  @ResponseBody
  @RequestMapping(value = "/deleteTopic", method = RequestMethod.POST)
  public String topicDeletePost(@RequestParam(name="idx") int idx) {
      List<MeetingTopicLinkVO> linkedTopics = meetingService.getLinkedTopicByIdx(idx);
      
      if(!linkedTopics.isEmpty()) {
          return "-1"; // 회의와 연결된 안건은 삭제 불가
      }
      
      // 연결된 meetingTopicReply 삭제
      meetingService.setTopicReplyDelete(idx);
      
      // meetingTopic 삭제
      int res = meetingService.setTopicDelete(idx);
      return res + "";
  }
  
  @ResponseBody
  @RequestMapping(value = "/getTopicDetails", method = RequestMethod.GET)
  public MeetingTopicVO getTopicDetails(@RequestParam int idx) {
    return meetingService.getTopicByIdx(idx);
  }
  
}