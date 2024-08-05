package com.spring.javaclassS16.service;

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

    @Override
    public int calendarDelete(int idx) {
      return calendarDAO.calendarDelete(idx);
    }

		@Override
		public List<CalendarVO> getUpcomingSchedules(String familyCode, String memberId) {
			return calendarDAO.getUpcomingSchedules(familyCode, memberId);
		}

		@Override
		public List<CalendarVO> getWeeklyEvents(String memberId, String familyCode, String startDate, String endDate) {
			return calendarDAO.getWeeklyEvents(memberId, familyCode, startDate, endDate);
		}
    
}
