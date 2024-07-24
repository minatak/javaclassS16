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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaclassS16.service.MeetingService;
import com.spring.javaclassS16.service.NoticeService;
import com.spring.javaclassS16.service.PhotoService;
import com.spring.javaclassS16.service.VoteService;
import com.spring.javaclassS16.service.WorkService;
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
    private MeetingService meetingService;
    
    @Autowired
    private VoteService voteService;
    
    @Autowired
    private PhotoService photoService;
    
    private static final String WEATHER_API_KEY = "91460e08be19725fb689b22c4d778a5c";
    private static final String WEATHER_API_URL = "http://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=" + WEATHER_API_KEY + "&units=metric";

    @RequestMapping(value = {"/","/h"}, method = RequestMethod.GET)
    public String homeGet(Locale locale, Model model) {
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
            String description = jsonNode.path("weather").get(0).path("description").asText();
            
            model.addAttribute("weatherDescription", "서울의 현재 온도: " + temp + "°C, " + description);
            
            String advice;
            if (temp < 10) {
                advice = "오늘은 추워요. 따뜻한 옷을 입고 핫팩을 챙기세요. 실내 난방에 신경 쓰고, 따뜻한 음료를 마시는 것도 좋아요.";
            } else if (temp > 25) {
                advice = "오늘은 더워요. 시원한 옷을 입고 자외선 차단제를 바르세요. 수분 섭취를 자주 하고, 실내에서는 에어컨이나 선풍기를 이용하세요.";
            } else {
                advice = "날씨가 좋아요. 가벼운 외출이나 가족과의 산책을 계획해보는 건 어떨까요? 창문을 열어 환기도 시켜주세요.";
            }
            model.addAttribute("weatherAdvice", advice);
            
            // 집안일 목록
            List<WorkVO> houseworks = houseworkService.getTodayHouseworks();
            model.addAttribute("houseworks", houseworks);
            
            // 최근 공지사항
            List<NoticeVO> notices = noticeService.getRecentNotices(5);
            model.addAttribute("notices", notices);
            
            // 예정된 회의
            List<FamilyMeetingVO> meetings = meetingService.getUpcomingMeetings(3);
            model.addAttribute("meetings", meetings);
            
            // 진행 중인 투표
            List<VoteVO> votes = voteService.getActiveVotes();
            model.addAttribute("votes", votes);
            
            // 최근 사진
            List<PhotoVO> photos = photoService.getRecentPhotos(6);
            model.addAttribute("photos", photos);
            
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
	
}
