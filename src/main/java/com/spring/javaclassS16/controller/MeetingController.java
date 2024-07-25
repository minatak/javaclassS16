package com.spring.javaclassS16.controller;

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
import com.spring.javaclassS16.service.MeetingService;
import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.MeetingTopicVO;
import com.spring.javaclassS16.vo.PageVO;

@Controller
@RequestMapping("/familyMeeting")
public class MeetingController {
  
  @Autowired
  MeetingService meetingService;
  
  @Autowired
  PageProcess pageProcess;
  
//  @RequestMapping(value = "/meetingList", method = RequestMethod.GET)
//  public String meetingListGet(Model model, HttpSession session,
//      @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//      @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
//      @RequestParam(name="statusFilter", defaultValue = "", required = false) String statusFilter,
//      @RequestParam(name="sortBy", defaultValue = "meetingDate", required = false) String sortBy) {
//    
//    String familyCode = (String) session.getAttribute("sFamCode");
//    int memberIdx = (int) session.getAttribute("sIdx");
//    
//    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "meeting", statusFilter, sortBy, session);
//    
//    ArrayList<FamilyMeetingVO> vos = meetingService.getMeetingList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize, statusFilter, sortBy);
//    
//    model.addAttribute("vos", vos);
//    model.addAttribute("pageVO", pageVO);
//    model.addAttribute("statusFilter", statusFilter);
//    model.addAttribute("sortBy", sortBy);
//    
//    // 통계 데이터 추가
////    model.addAttribute("totalMeetings", meetingService.getTotalMeetingsCount(familyCode));
////    model.addAttribute("completedMeetings", meetingService.getCompletedMeetingsCount(familyCode));
////    model.addAttribute("upcomingMeetings", meetingService.getUpcomingMeetingsCount(familyCode));
////    model.addAttribute("thisMonthMeetings", meetingService.getThisMonthMeetingsCount(familyCode));
//    
//    return "familyMeeting/meetingList";
//  }
  
  @RequestMapping(value = "/meetingList", method = RequestMethod.GET)
  public String meetingListGet(Model model, HttpSession session,
      @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
      @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
      @RequestParam(name="statusFilter", defaultValue = "", required = false) String statusFilter,
      @RequestParam(name="sortBy", defaultValue = "date", required = false) String sortBy) {
    
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    // sortBy 파라미터 처리
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
  
  @RequestMapping(value = "/meetingInput", method = RequestMethod.GET)
  public String addMeetingGet() {
    return "familyMeeting/meetingInput";
  }
  
  @ResponseBody
  @RequestMapping(value = "/meetingInput", method = RequestMethod.POST)
  public int addMeetingPost(HttpSession session, FamilyMeetingVO familyMeetingVO) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    familyMeetingVO.setFamilyCode(familyCode);
    familyMeetingVO.setCreatedBy(memberIdx);
    
    int res = meetingService.setMeetingInput(familyMeetingVO);
    
    return res;
  }
}