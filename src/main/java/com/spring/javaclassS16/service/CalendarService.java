package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS16.vo.CalendarVO;

public interface CalendarService {

	ArrayList<CalendarVO> calendarListAll();

	int calendarDeleteTrue(String title, String formattedStartTime);

	int calendarDelete(String title, String formattedStartTime, String formattedEndTime, Boolean allDay);

	int calendarInput(CalendarVO vo);

	int calendarUpdate(CalendarVO vo);

	List<CalendarVO> getCalendarList(String memberId, String familyCode);

	List<CalendarVO> getCalendarSummary(String memberId, String familyCode);

	int calendarDelete(int idx);

}
