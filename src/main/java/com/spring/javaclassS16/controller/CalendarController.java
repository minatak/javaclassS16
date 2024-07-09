package com.spring.javaclassS16.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.service.CalendarService;
import com.spring.javaclassS16.vo.CalendarVO;
 
@Controller
@RequestMapping("/calendar")
public class CalendarController {
  
  @Autowired
  CalendarService calendarService;
  
  @RequestMapping(value = "/calendarMain", method = RequestMethod.GET)
  public String calendarContentGet() {
    return "calendar/calendarMain";
  }
  
  @RequestMapping(value = "/claude", method = RequestMethod.GET)
  public String claudeGet() {
    return "home_claude";
  }
  
  @ResponseBody
  @RequestMapping(value = "/calendarListAll", method = RequestMethod.POST)
  public ResponseEntity<?> calendarListAllPost(HttpSession session) {
    try {
      String memberId = (String) session.getAttribute("sMid");
      String familyCode = (String) session.getAttribute("sFamCode");
      
      if (memberId == null || familyCode == null) {
        return ResponseEntity.badRequest().body("Session attributes are missing");
      }
      
      List<CalendarVO> events = calendarService.getCalendarList(memberId, familyCode);
      return ResponseEntity.ok(events);
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                           .body("Error: " + e.getMessage());
    }
  }
  
  @ResponseBody
  @RequestMapping(value = "/calendarDelete", method = RequestMethod.POST)
  public ResponseEntity<String> calendarDeletePost(
      @RequestParam(name="idx", required = true) int idx) {
    try {
      int res = calendarService.calendarDelete(idx);
      return ResponseEntity.ok(String.valueOf(res));
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                           .body("Error: " + e.getMessage());
    }
  }
  
  @ResponseBody
  @RequestMapping(value = "/calendarInput", method = RequestMethod.POST)
  public ResponseEntity<String> calendarInputPost(@RequestBody CalendarVO vo, HttpSession session) {
    try {
      String memberId = (String) session.getAttribute("sMid");
      String familyCode = (String) session.getAttribute("sFamCode");
      
      if (memberId == null || familyCode == null) {
        return ResponseEntity.badRequest().body("Session attributes are missing");
      }
      
      vo.setMemberId(memberId);
      vo.setFamilyCode(familyCode);
      
      int res = calendarService.calendarInput(vo); 
      return ResponseEntity.ok(String.valueOf(res));
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                           .body("Error: " + e.getMessage());
    }
  }  
  
  @ResponseBody
  @RequestMapping(value = "/calendarSummary", method = RequestMethod.POST)
  public ResponseEntity<?> calendarSummaryPost(HttpSession session) {
    try {
      String memberId = (String) session.getAttribute("sMid");
      String familyCode = (String) session.getAttribute("sFamCode");
      
      if (memberId == null || familyCode == null) {
        return ResponseEntity.badRequest().body("Session attributes are missing");
      }
      
      List<CalendarVO> summary = calendarService.getCalendarSummary(memberId, familyCode);
      return ResponseEntity.ok(summary);
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                           .body("Error: " + e.getMessage());
    }
  }
  
  @ResponseBody
  @RequestMapping(value = "/calendarUpdate", method = RequestMethod.POST)
  public ResponseEntity<String> calendarUpdatePost(@RequestBody CalendarVO vo, HttpSession session) {
    try {
    	String memberId = (String) session.getAttribute("sMid");
      String familyCode = (String) session.getAttribute("sFamCode");
    	
      vo.setMemberId(memberId);
      vo.setFamilyCode(familyCode);
      
    	System.out.println("vo : " + vo);
      int res = calendarService.calendarUpdate(vo);
      return ResponseEntity.ok(String.valueOf(res));
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                           .body("Error: " + e.getMessage());
    }
  }
}
