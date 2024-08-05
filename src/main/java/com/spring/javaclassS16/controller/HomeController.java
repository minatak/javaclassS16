package com.spring.javaclassS16.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaclassS16.service.CalendarService;
import com.spring.javaclassS16.service.MeetingService;
import com.spring.javaclassS16.service.NoticeService;
import com.spring.javaclassS16.service.PhotoService;
import com.spring.javaclassS16.service.VoteService;
import com.spring.javaclassS16.service.WorkService;
import com.spring.javaclassS16.vo.CalendarVO;
import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.NoticeVO;
import com.spring.javaclassS16.vo.PhotoVO;
import com.spring.javaclassS16.vo.VoteVO;
import com.spring.javaclassS16.vo.WorkVO;

@Controller
public class HomeController {
  
  @Autowired
  private WorkService houseworkService;
  
  @Autowired
  private NoticeService noticeService;
  
  @Autowired
  private CalendarService calendarService;
  
  @Autowired
  private MeetingService meetingService;
  
  @Autowired
  private VoteService voteService;
  
  @Autowired
  private PhotoService photoService;
  
  private static final String WEATHER_API_KEY = "91460e08be19725fb689b22c4d778a5c";
  private static final String WEATHER_API_URL = "http://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=" + WEATHER_API_KEY + "&units=metric";

  @RequestMapping(value = {"/","/h"}, method = RequestMethod.GET)
  public String homeGet(Locale locale, Model model, HttpSession session) {
  	String familyCode = (String) session.getAttribute("sFamCode");
  	
    try {
      URL url = new URL(WEATHER_API_URL);
      HttpURLConnection con = (HttpURLConnection) url.openConnection();
      con.setRequestMethod("GET");
      
      BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
      String inputLine;
      StringBuilder response = new StringBuilder();
      while ((inputLine = in.readLine()) != null) {
          response.append(inputLine);
      }
      in.close();
      
      ObjectMapper mapper = new ObjectMapper();
      JsonNode jsonNode = mapper.readTree(response.toString());
      
      double temp = jsonNode.path("main").path("temp").asDouble();
//      String description = jsonNode.path("weather").get(0).path("description").asText();
      String iconCode = jsonNode.path("weather").get(0).path("icon").asText();
      
//      model.addAttribute("weatherDescription", "서울의 현재 온도: " + temp + "°C, " + description);
      model.addAttribute("weatherIconCode", iconCode);
      
      String advice;
      if (temp < 0) {
          advice = "오늘은 꽤 추운 날이에요. 따뜻한 옷차림으로 체온을 지키세요.<br/>가족과 함께 따뜻한 차 한잔 어떠세요? 실내 온도 관리에도 신경 써주세요.";
      } else if (temp < 10) {
          advice = "쌀쌀한 날씨네요. 외출 시 목도리나 장갑을 챙기면 좋겠어요.<br/>오늘 저녁엔 따뜻한 국물 요리는 어떨까요? 가족과 따뜻한 시간 보내세요.";
      } else if (temp < 18) {
          advice = "상쾌한 날씨예요. 가족과 함께 근처 공원으로 산책 나가보는 건 어떨까요?<br/>맑은 공기를 마시며 활력을 얻어보세요. 귀가 후엔 창문을 열어 환기도 해주세요.";
      } else if (temp < 25) {
          advice = "날씨가 정말 좋아요. 가벼운 외출이나 가족과의 피크닉을 계획해보는 건 어떨까요?<br/>창문을 열어 상쾌한 공기로 집안 분위기를 바꿔보세요.";
      } else if (temp < 30) {
          advice = "조금 더운 날씨네요. 시원한 옷차림과 자외선 차단제를 잊지 마세요.<br/>수분 섭취를 자주 하고, 시원한 과일이나 음료로 더위를 식혀보세요.<br/>실내에선 선풍기나 에어컨으로 온도 조절을 해주세요.";
      } else {
          advice = "많이 더운 날이에요. 가급적 시원한 실내에서 지내세요.<br/>외출 시엔 꼭 물을 챙기고 그늘에서 쉬어가세요.<br/>가족들과 시원한 수박이나 아이스크림 만들기는 어떨까요?";
      }
      model.addAttribute("weatherAdvice", advice);
      model.addAttribute("temp", temp);
      
      // 집안일 목록
      List<WorkVO> houseworks = houseworkService.getTodayHouseworks(familyCode);
      model.addAttribute("houseworks", houseworks);
      
      // 최근 공지사항
      List<NoticeVO> notices = noticeService.getRecentNotices(familyCode);
      model.addAttribute("notices", notices);
      
      // 다가오는 일정
      List<CalendarVO> schedules = calendarService.getUpcomingSchedules(familyCode);
      model.addAttribute("schedules", schedules);
      
      // 예정된 회의
      List<FamilyMeetingVO> meetings = meetingService.getUpcomingMeetings(familyCode);
      model.addAttribute("meetings", meetings);
      
      // 진행 중인 투표
      List<VoteVO> votes = voteService.getActiveVotes(familyCode);
      model.addAttribute("votes", votes);
      
      // 최근 사진
      List<PhotoVO> photos = photoService.getRecentPhotos(familyCode);
      model.addAttribute("photos", photos);

      String customIconUrl = getCustomWeatherIcon(iconCode);
      model.addAttribute("weatherIconUrl", customIconUrl);
      
    } catch (Exception e) {
      e.printStackTrace();
      model.addAttribute("weatherDescription", "날씨 정보를 가져오는데 실패했습니다.");
      model.addAttribute("weatherAdvice", "");
    }
    
    return "home";
  }

  @RequestMapping(value = "/imageUpload")
  public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
    response.setCharacterEncoding("utf-8");
    response.setContentType("text/html; charset=utf-8");
    
    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
    String oFileName = upload.getOriginalFilename();
    
    // 파일명 중복방지를 위한 이름 설정하기(날짜로 분류처리...)
    Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
    oFileName = sdf.format(date) + "_" + oFileName;
    
    FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
    fos.write(upload.getBytes());
    
    PrintWriter out = response.getWriter();
    String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
    out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
    
    out.flush();
    fos.close();
  }
  
  @RequestMapping(value = "/beforeLogin")
  public String beforeLoginGet(){
  	
  	return "beforeLogin";
  }
  
  private String getCustomWeatherIcon(String apiIcon) {
    switch(apiIcon) {
        case "01d": case "01n": return "https://cdn-icons-png.flaticon.com/512/6974/6974833.png"; // 맑음
        case "02d": case "02n": return "https://cdn-icons-png.flaticon.com/512/1163/1163661.png"; // 구름 조금
        case "03d": case "03n": case "04d": case "04n": return "https://cdn-icons-png.flaticon.com/512/414/414825.png"; // 구름 많음
        case "09d": case "09n": case "10d": case "10n": return "https://cdn-icons-png.flaticon.com/512/3351/3351979.png"; // 비
        case "11d": case "11n": return "https://cdn-icons-png.flaticon.com/512/1959/1959368.png"; // 천둥번개
        case "13d": case "13n": return "https://cdn-icons-png.flaticon.com/512/642/642102.png"; // 눈
        case "50d": case "50n": return "https://cdn-icons-png.flaticon.com/512/4005/4005901.png"; // 안개
        default: return "https://cdn-icons-png.flaticon.com/512/1163/1163661.png"; // 기본
    }
}
  
}