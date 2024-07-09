package com.spring.javaclassS16.service;

import java.util.Calendar;
import java.util.List;

import com.spring.javaclassS16.vo.CalendarVO;

public interface CalendarService {
    // 모든 일정 조회 (memberId와 familyCode 기반)
    List<CalendarVO> getCalendarList(String memberId, String familyCode);
    
    // 일정 요약 조회 (memberId와 familyCode 기반)
    List<CalendarVO> getCalendarSummary(String memberId, String familyCode);
    
    // 일정 입력
    int calendarInput(CalendarVO vo);
    
    // 일정 수정
    int calendarUpdate(CalendarVO vo);
    
    // 일정 삭제 (idx 기반)
    int calendarDelete(int idx);
    
    
    
}