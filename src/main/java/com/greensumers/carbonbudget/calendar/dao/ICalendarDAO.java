package com.greensumers.carbonbudget.calendar.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.calendar.vo.CalendarVO;


@Mapper
public interface ICalendarDAO {
	//사용자 일별 총 수입 지출 가져오기
	public ArrayList<CalendarVO> getPrice(CalendarVO calendarVO);
	
	//일별 세부 내역 가져오기
	public ArrayList<AbVO> getDayPrice(AbVO abVO);
	
	//월별 총 수입 지출 가져오기
	public ArrayList<CalendarVO> getTotalPrice(CalendarVO calendarVO);
}
