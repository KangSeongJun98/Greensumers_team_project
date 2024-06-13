package com.greensumers.carbonbudget.free.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.greensumers.carbonbudget.code.service.CodeService;
import com.greensumers.carbonbudget.code.vo.CodeVO;
import com.greensumers.carbonbudget.free.service.FreeService;
import com.greensumers.carbonbudget.free.vo.FreeBoardVO;
import com.greensumers.carbonbudget.free.vo.FreeSearchVO;


@Controller

public class FreeBoardController {
	@Autowired
	FreeService freeService;
	
	@Autowired
	CodeService codeService;
	
	@ModelAttribute("comList")
	public List<CodeVO> getCodeList(){
		return codeService.getCodeList("BC00");
	}
	// 게시글 리스트
	@RequestMapping("/freeList")
	public String freeList(Model model
			,@ModelAttribute("searchVO") FreeSearchVO searchVO) {
		
		List<FreeBoardVO> freeList = freeService.getBoardList(searchVO);
		model.addAttribute("freeList", freeList);
		return "free/freeList";
	}
	@RequestMapping("/freeView")
	public String freeView(Model model, int boNo) {
		try {
			FreeBoardVO freeBoard = freeService.getBoard(boNo);
			model.addAttribute("freeBoard", freeBoard);
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/freeList";
		}
		return "free/freeView";
	}
	@RequestMapping("/freeForm")
	public String freeForm() {
		return "free/freeForm";
	}
	
	@RequestMapping("/freeBoardWriteDo")
	public String freeBoardWriteDo(FreeBoardVO freeBoardVO) throws Exception {
		freeService.insertFreeBoard(freeBoardVO);
		return "redirect:/freeList";
	}
}
