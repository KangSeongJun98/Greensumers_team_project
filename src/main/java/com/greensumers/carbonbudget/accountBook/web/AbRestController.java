package com.greensumers.carbonbudget.accountBook.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.greensumers.carbonbudget.accountBook.service.AbService;
import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.accountBook.vo.AccountSearchVO;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@RestController
public class AbRestController {
	
	@Autowired
	AbService service;
	
	@GetMapping("/getPost")
	public List<AbVO> getPosts(AccountSearchVO searchVO){
		System.out.println("요청옴");
		System.out.println(searchVO.getCurPage());
		System.out.println(searchVO);
		List<AbVO> post = service.getabList(searchVO);
		System.out.println("post" + post);
		
		
		return post;
	}
	
	@PostMapping("/OCRSave")
	public String OCRSave(@RequestBody ArrayList<AbVO> ocrData, HttpSession session) {
		
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		 for (AbVO data : ocrData) {
			 data.setMemId(login.getMemId());
			 try {
				service.OCRSave(data);
			} catch (Exception e) {
				e.printStackTrace();
				return "N";
			}
		 } 
		return "Y";
	}
}
