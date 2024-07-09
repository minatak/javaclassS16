package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS16.dao.CalendarDAO;
import com.spring.javaclassS16.vo.CalendarVO;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	CalendarDAO calendarDAO;

	@Override
	public ArrayList<CalendarVO> calendarListAll() {
		return calendarDAO.calendarListAll();
	}

	@Override
	public int calendarDeleteTrue(String title, String formattedStartTime) {
		return calendarDAO.calendarDeleteTrue(title, formattedStartTime);
	}

	@Override
	public int calendarDelete(String title, String formattedStartTime, String formattedEndTime, Boolean allDay) {
		return calendarDAO.calendarDelete(title, formattedStartTime, formattedEndTime, allDay);
	}

	@Override
	public int calendarInput(CalendarVO vo) {
		return calendarDAO.calendarInput(vo);
	}

	@Override
	public int calendarUpdate(CalendarVO vo) {
		return calendarDAO.calendarUpdate(vo);
	}

	@Override
	public List<CalendarVO> getCalendarList(String memberId, String familyCode) {
		return calendarDAO.getCalendarList(memberId, familyCode);
	}

	@Override
	public List<CalendarVO> getCalendarSummary(String memberId, String familyCode) {
		return calendarDAO.getCalendarSummary(memberId, familyCode);
	}
	
}

