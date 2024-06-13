package com.greensumers.carbonbudget.survey.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.member.service.MemberService;
import com.greensumers.carbonbudget.member.vo.MemberVO;
import com.greensumers.carbonbudget.survey.service.SurveyService;
import com.greensumers.carbonbudget.survey.vo.CarVO;
import com.greensumers.carbonbudget.survey.vo.ResponseVO;
import com.greensumers.carbonbudget.survey.vo.SavingVO;
import com.greensumers.carbonbudget.survey.vo.SimilarityVO;

@Controller
public class SurveyController {

	@Autowired
	SurveyService surveyService;
	
	@Autowired
	MemberService memberService;

	@ResponseBody
	@RequestMapping("/getCarInfo")
	public ArrayList<CarVO>carInfos(HttpSession session, CarVO carVO) {
		System.out.println(carVO);
		ArrayList<CarVO>carInfos = surveyService.getCarInfo(carVO);
		return carInfos;
	}
	
	@RequestMapping("ServeyDo")
	public String surveyDo(ResponseVO responseVO, HttpSession session, HttpServletRequest re, Model model) {
		System.out.println("설문 대답 테스트");
		System.out.println(responseVO);
		int carId =  Integer.parseInt(re.getParameter("carId"));
		System.out.println("차량 정보: "+carId);
		MemberVO login = (MemberVO) session.getAttribute("login");
		System.out.println(login);
		if(login == null) {
			return "member/loginView";
		}
		login.setCarId(carId);
		responseVO.setMemId(login.getMemId());
		try {
			surveyService.surveyDo(responseVO);
			memberService.carUpdate(login);
			session.setAttribute("login", memberService.loginMember(login));
			System.out.println("성공");
			model.addAttribute("msg", "소중한 답변 감사합니다.");
			return "accountBook/abView";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "죄송합니다. 다시 시도해주세요");
		}
		return "accountBook/abView";
	}
	
	@ResponseBody
	@RequestMapping("/savingCmpDo")
	public ArrayList<SavingVO> savingCmpDo(HttpSession session, @RequestBody SimilarityVO similarityVO) {
		System.out.println("similarityVO: "+similarityVO);
		ArrayList<SavingVO>savings = surveyService.savingCmpDo(similarityVO);
		System.out.println("savings: "+savings);
		return savings;
	}
}
