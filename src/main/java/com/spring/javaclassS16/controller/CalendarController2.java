//package com.spring.javaclassS16.controller;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.List;
//import java.util.Locale;
//import java.util.TimeZone;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
// 
//import com.spring.javaclassS16.service.CalendarService;
//import com.spring.javaclassS16.vo.CalendarVO;
// 
//@Controller
//@RequestMapping("/calendar")
//public class CalendarController2 {
//    
//    @Autowired
//    CalendarService calendarService;
//    
//    
//    
//    @RequestMapping(value = "/calendarMain", method = RequestMethod.GET)
//    public String calendarContentGet() {
//    	return "calendar/calendarMain";
//    }
//    
//    @RequestMapping(value = "/claude", method = RequestMethod.GET)
//    public String claudeGet() {
//    	return "home_claude";
//    }
//    
//    
//    @ResponseBody
//    @RequestMapping(value = "/calendarListAll", method = RequestMethod.POST)
//    public List<CalendarVO> calendarListAllPost(HttpSession session) {
//        String memberId = (String) session.getAttribute("sMid");
//        String familyCode = (String) session.getAttribute("sFamCode");
//        
//        return calendarService.getCalendarList(memberId, familyCode);
//    }
//    
//    
//    @ResponseBody
//    @RequestMapping(value = "/calendarDelete", method = RequestMethod.POST)
//    public String calendarDeletePost(
//            @RequestParam(name="title", defaultValue = "", required = false) String title,
//      @RequestParam(name="start", defaultValue = "", required = false) String startTime,
//      @RequestParam(name="end", defaultValue = "", required = false) String endTime,
//      @RequestParam(name="allDay", defaultValue = "false" , required = false) Boolean allDay
//            ) throws ParseException {
//        
//         // 날짜 형식을 한국어 패턴으로 변경
//    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd-a hh:mm:ss", Locale.KOREAN);
//    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        
//    Date startDate = inputFormat.parse(startTime);
//    Date endDate = inputFormat.parse(endTime);
//        
// // UTC 시간대로 변환 (필요시)
//    inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
//    
// // 파싱된 날짜를 출력 형식으로 변환
//    String formattedStartTime = outputFormat.format(startDate);
//    String formattedEndTime = outputFormat.format(endDate);
//    
//        int res = 0;
//        startTime = startTime.replace("-오전", "");
//        startTime = startTime.replace("-오후", "");
//        endTime = endTime.replace("-오전", "");
//        endTime = endTime.replace("-오후", "");
//        
//        if(allDay == true) {
//            System.out.println("들어옴1");
//            String startTimeChange = startTime.substring(10,19);
//            startTime = startTime.replace(startTimeChange, " 00:00:00");
//            res = calendarService.calendarDeleteTrue(title,formattedStartTime);                        
//        } else {            
//            System.out.println("들어옴2");
//            System.out.println(title+","+formattedStartTime+","+formattedEndTime+","+allDay);
//            res = calendarService.calendarDelete(title,formattedStartTime,formattedEndTime, allDay);            
//        }
//        
//        return res+"";
//    }
//    
//    @ResponseBody
//    @RequestMapping(value = "/calendarInput", method = RequestMethod.POST)
//    public String calendarInputPost(
//            CalendarVO vo,
//            @RequestParam(name="title", defaultValue = "", required = false) String title,
//            @RequestParam(name="start", defaultValue = "", required = false) String startTime,
//            @RequestParam(name="end", defaultValue = "", required = false) String endTime,
//            @RequestParam(name="allDay", defaultValue = "false", required = false) Boolean allDay,
//            @RequestParam(name="sharing", defaultValue = "false", required = false) Boolean sharing,
//            HttpSession session) {
//        int res = 0;
//        
//        // 세션에서 memberId와 familyCode 가져오기
//        String memberId = (String) session.getAttribute("memberId");
//        String familyCode = (String) session.getAttribute("familyCode");
//        
//        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.ENGLISH);
//        inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
//        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        
//        try {
//            Date startDate = inputFormat.parse(startTime);
//            Date endDate = inputFormat.parse(endTime);
//            
//            String formattedStartTime = outputFormat.format(startDate);
//            String formattedEndTime = outputFormat.format(endDate);
//            
//            vo.setAllDay(allDay);
//            vo.setStartTime(formattedStartTime);
//            vo.setEndTime(formattedEndTime);
//            vo.setTitle(title);
//            vo.setMemberId(memberId);
//            vo.setSharing(sharing);
//            vo.setFamilyCode(familyCode);
//            
//            res = calendarService.calendarInput(vo);
//            
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//        
//        return String.valueOf(res);
//    }
//    
//    // 홈 화면용 요약 일정 메소드 추가
//    @ResponseBody
//    @RequestMapping(value = "/calendarSummary", method = RequestMethod.POST)
//    public List<CalendarVO> calendarSummaryPost(HttpSession session) {
//        String memberId = (String) session.getAttribute("memberId");
//        String familyCode = (String) session.getAttribute("familyCode");
//        
//        return calendarService.getCalendarSummary(memberId, familyCode);
//    }
//    
//    
//    @ResponseBody
//    @RequestMapping(value = "/calendarUpdate", method = RequestMethod.POST)
//    public String  calendarUpdatePost(
//            @RequestParam(name="idx", defaultValue = "", required = false) int idx,
//            @RequestParam(name="title", defaultValue = "", required = false) String title,
//      @RequestParam(name="start", defaultValue = "", required = false) String startTime,
//      @RequestParam(name="end", defaultValue = "", required = false) String endTime,
//      @RequestParam(name="allDay", defaultValue = "false" , required = false) Boolean allDay
//            ) throws ParseException {
//        int res = 0;
//        
//        SimpleDateFormat inputFormat = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z", Locale.ENGLISH);
//         SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//         
//         Date startDate = null;
//         Date endDate = null;
//     CalendarVO vo = new CalendarVO();
//            
//        startDate = inputFormat.parse(startTime);
//        String formattedStartTime = outputFormat.format(startDate);
//        
//        if(allDay == true && endTime != null) {
//            endDate = inputFormat.parse(startTime);
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(endDate);
//            calendar.add(Calendar.HOUR_OF_DAY, 24);
//            endDate = calendar.getTime();
//            String formattedEndTime = outputFormat.format(endDate);
//            vo.setEndTime(formattedEndTime);    
//        }
//        else if(allDay == false && endTime == "") {
//            // startTime 파싱하여 endDate에 저장
//            System.out.println(startTime+" "+ endTime);
//        endDate = inputFormat.parse(startTime);
//        // endDate에 1시간을 더함
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(endDate);
//        calendar.add(Calendar.HOUR_OF_DAY, 1);
//        endDate = calendar.getTime();
//        
//        // 포맷팅하여 formattedEndTime에 저장
//        String formattedEndTime = outputFormat.format(endDate);
//        
//        // vo에 endTime 설정
//        vo.setEndTime(formattedEndTime);
//        } 
//         else {
//            endDate = inputFormat.parse(endTime);
//            String formattedEndTime = outputFormat.format(endDate);
//            System.out.println(startTime+" "+ formattedEndTime);
//            vo.setEndTime(formattedEndTime);            
//        }
// 
//    
//     vo.setTitle(title);
//     vo.setStartTime(formattedStartTime);
//     vo.setAllDay(allDay);
//     vo.setIdx(idx);
//     
//     // 여기서 데이터베이스 업데이트 로직을 수행
//     res = calendarService.calendarUpdate(vo);
// 
//     // 예시: 일정 업데이트 성공 여부에 따라 응답    
//        
//        
//        
//        return res+"";
//    }
//    
//    
//}