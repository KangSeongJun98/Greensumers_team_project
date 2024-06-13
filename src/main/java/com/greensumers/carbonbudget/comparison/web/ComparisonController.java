package com.greensumers.carbonbudget.comparison.web;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greensumers.carbonbudget.comparison.service.ComparisonService;
import com.greensumers.carbonbudget.comparison.vo.CfVO;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Controller
public class ComparisonController {

	@Autowired
	ComparisonService comparisonService;
	
	@RequestMapping("/cfComparisonView")
	public String cfComparisonView(CfVO cfVO, RedirectAttributes re, HttpSession session, Model model) {
		MemberVO login = (MemberVO) session.getAttribute("login");
		if (login == null) {
			re.addFlashAttribute("msg", "로그인 후 사용가능합니다.");
			return "redirect:/loginView";
		}
		
		ArrayList<CfVO>cfList =  comparisonService.getCfData(login);
		ArrayList<CfVO>AvgList = comparisonService.getAvgCfData();
		System.out.println("cfList: "+cfList);
		System.out.println("AvgList: "+AvgList);
		model.addAttribute("cfList", cfList);
		model.addAttribute("AvgList", AvgList);
		return "comparison/cfComparisonView";
	}
}
