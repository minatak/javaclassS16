package com.spring.javaclassS16.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.javaclassS16.vo.CalendarVO;

public interface CalendarDAO {
  
  // 모든 일정 조회 (memberId와 familyCode 기반)
  public List<CalendarVO> getCalendarList(@Param("memberId") String memberId, @Param("familyCode") String familyCode);
  
  // 일정 요약 조회 (memberId와 familyCode 기반)
  public List<CalendarVO> getCalendarSummary(@Param("memberId") String memberId, @Param("familyCode") String familyCode);
  
  // 일정 입력
  public int calendarInput(@Param("vo") CalendarVO vo);
  
  // 일정 수정
  public int calendarUpdate(@Param("vo") CalendarVO vo);
  
  // 일정 삭제 (idx 기반)
  public int calendarDelete(@Param("idx") int idx);
  
}