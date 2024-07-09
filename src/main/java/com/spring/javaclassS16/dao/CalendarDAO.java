package com.spring.javaclassS16.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS16.vo.CalendarVO;

public interface CalendarDAO {

	ArrayList<CalendarVO> calendarListAll();

	int calendarDeleteTrue(@Param("title") String title, @Param("memberId") String formattedStartTime);

	int calendarDelete(@Param("title") String title, String formattedStartTime, String formattedEndTime, Boolean allDay);

	int calendarInput(@Param("vo") CalendarVO vo);

	int calendarUpdate(@Param("vo") CalendarVO vo);

	List<CalendarVO> getCalendarList(@Param("memberId") String memberId, @Param("familyCode") String familyCode);

	List<CalendarVO> getCalendarSummary(@Param("memberId") String memberId, @Param("familyCode") String familyCode);

}
