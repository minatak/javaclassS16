package com.spring.javaclassS16.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
  
  @ResponseBody
  @RequestMapping(value = "/weeklyEvents", method = RequestMethod.GET)
  public List<Map<String, Object>> getWeeklyEvents(@RequestParam String startDate, @RequestParam String endDate, HttpSession session) {
      String memberId = (String) session.getAttribute("sMid");
      String familyCode = (String) session.getAttribute("sFamCode");
      
      // 날짜 형식 변환
      startDate = convertDateFormat(startDate);
      endDate = convertDateFormat(endDate);
      
      List<CalendarVO> events = calendarService.getWeeklyEvents(memberId, familyCode, startDate, endDate);
      
      SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
      
      List<Map<String, Object>> eventList = new ArrayList<>();
      
      try {
      	for (CalendarVO event : events) {
      		Map<String, Object> eventMap = new HashMap<>();
      		eventMap.put("id", event.getIdx());
      		eventMap.put("title", event.getTitle());
      		eventMap.put("start", outputFormat.format(inputFormat.parse(event.getStartTime())));
      		eventMap.put("end", outputFormat.format(inputFormat.parse(event.getEndTime())));
      		eventMap.put("allDay", event.isAllDay());
      		eventMap.put("color", event.isSharing() ? "#84a98c" : "#8c9daa");
      		eventList.add(eventMap);
      	}
      	
		  } catch (Exception e) {
		    System.err.println("Error processing event: " + e.getMessage());
		    e.printStackTrace();
		  }
      
      return eventList;
  }
  
  private String convertDateFormat(String dateString) {
    try {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = inputFormat.parse(dateString);
        return outputFormat.format(date);
    } catch (ParseException e) {
        e.printStackTrace();
        return dateString; // 파싱 실패 시 원래 문자열 반환
    }
  }
  
}
