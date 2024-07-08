package com.spring.javaclassS16.dao;

import java.util.ArrayList;

import com.spring.javaclassS16.vo.CalendarVO;

public interface CalendarDAO {

	ArrayList<CalendarVO> calendarListAll();

	int calendarDeleteTrue(String title, String formattedStartTime);

	int calendarDelete(String title, String formattedStartTime, String formattedEndTime, Boolean allDay);

	int calendarInput(CalendarVO vo);

	int calendarUpdate(CalendarVO vo);

}
