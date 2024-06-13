package com.greensumers.carbonbudget.calendar.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.calendar.dao.ICalendarDAO;
import com.greensumers.carbonbudget.calendar.vo.CalendarVO;

@Service
public class CalendarService {
	
	@Autowired
	ICalendarDAO dao;
	
	// 일별 수입 지출 가져오기
	public ArrayList<CalendarVO> getPrice(CalendarVO calendarVO){
		return dao.getPrice(calendarVO);
	}
	
	// 월별 총 수입 지출 가져오기
	public ArrayList<CalendarVO> getTotalPrice(CalendarVO calendarVO){
		return dao.getTotalPrice(calendarVO);
	}
	
	// 일별 세부 내역 가져오기
	public ArrayList<AbVO> getDayPrice(AbVO abVO){
		return dao.getDayPrice(abVO);
	}
}
