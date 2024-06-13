package com.greensumers.carbonbudget.calendar.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.calendar.service.CalendarService;
import com.greensumers.carbonbudget.calendar.vo.CalendarVO;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Controller
public class CalenndarController {
	
	@Autowired
	CalendarService service;
	
	@RequestMapping("/calendarView")
		public String calendarView(CalendarVO vo, HttpSession session, RedirectAttributes re, Model model){
			MemberVO login = (MemberVO) session.getAttribute("login");
			if(login == null) {
				re.addFlashAttribute("msg", "로그인 후 사용가능합니다.");
				return "redirect:/loginView";
			}
			vo.setMemId(login.getMemId());
			ArrayList<CalendarVO>priceList = service.getPrice(vo);
			
			
			Date date = new Date();
	        // SimpleDateFormat 객체 생성 및 포맷 지정
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 M월");
	        // 포맷 적용하여 문자열로 변환
	        String formattedDate = formatter.format(date);
	        // 결과 출력
	        System.out.println("포맷된 날짜: " + formattedDate);
			
			// 현재 월 총 수입 지출
	        CalendarVO totalPrice = new CalendarVO();
	        totalPrice.setMemId(login.getMemId());
	        totalPrice.setFinDy(formattedDate);
	        ArrayList<CalendarVO>totalPriceList = service.getTotalPrice(totalPrice);
			System.out.println("priceList :"+priceList);
			System.out.println("totalPriceList"+totalPriceList);
			
			model.addAttribute("priceList", priceList);	
			model.addAttribute("totalPriceList", totalPriceList);	
			return "calendar/calendarView";
		}
	
	// 날짜 바꿀 때 차트 값 바뀌는 ajax
	@ResponseBody
	@RequestMapping(value = "/changeDate", method = RequestMethod.POST)	
	public ArrayList<CalendarVO> changeDate(@RequestParam("date") String date, HttpSession session) {
		System.out.println(date);
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		// 현재 월 총 수입 지출
        CalendarVO totalPrice = new CalendarVO();
        totalPrice.setMemId(login.getMemId());
        totalPrice.setFinDy(date);
		ArrayList<CalendarVO>totalPriceList = service.getTotalPrice(totalPrice);
		
		return totalPriceList;	
	}
	
	// 달력 클릭했을 때 상세보기
		@ResponseBody
		@RequestMapping(value = "/getDayPrice", method = RequestMethod.POST)	
		public ArrayList<AbVO> getDayPrice(@RequestParam("eventDate") String eventDate, HttpSession session) {
			System.out.println(eventDate);
			MemberVO login = (MemberVO) session.getAttribute("login");
			AbVO abVO = new AbVO();
			abVO.setFinDy(eventDate);
			abVO.setMemId(login.getMemId());
			ArrayList<AbVO>dayPriceList = service.getDayPrice(abVO);
			
			return dayPriceList;	
		}
}
