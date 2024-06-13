package com.greensumers.carbonbudget.accountBook.web;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greensumers.carbonbudget.accountBook.service.AbService;
import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.accountBook.vo.AccountSearchVO;
import com.greensumers.carbonbudget.accountBook.vo.BalanceVO;
import com.greensumers.carbonbudget.accountBook.vo.ExcategoryVO;
import com.greensumers.carbonbudget.accountBook.vo.ExpenseVO;
import com.greensumers.carbonbudget.accountBook.vo.IncomeVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthExVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthInVO;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Controller
public class AbController {
		
		@Autowired
		AbService service;
		private Object yearMonth;
		
		//가계부 메인화면 
		@RequestMapping("/abView")
		public String abView(Model model, HttpSession session, RedirectAttributes re
				, @ModelAttribute("searchVO") AccountSearchVO searchVO) {
			System.out.println(searchVO);
			if (session.getAttribute("login") == null) {
				re.addFlashAttribute("msg", "로그인 후 사용가능합니다.");
				return "redirect:/loginView";
			}
		
			MemberVO login = (MemberVO) session.getAttribute("login");
			String memId = login.getMemId();
			searchVO.setMemId(memId);
			
			ArrayList<AbVO> AbVO = service.getabList(searchVO);
			IncomeVO Income = service.getTotalIncome(searchVO);
			ExpenseVO Expense = service.getTotalExpense(searchVO);
			BalanceVO Balance = service.getBalance(searchVO);
			ArrayList<ExcategoryVO> Excategory = service.getExCategory(searchVO);
			ArrayList<MonthExVO> Moex = service.getmonthEx(searchVO);
			ArrayList<MonthInVO> Moin = service.getmonthIn(searchVO);

			model.addAttribute("AbVO", AbVO);
			model.addAttribute("Income", Income);
			model.addAttribute("Expense", Expense);
			model.addAttribute("Balance", Balance);
			model.addAttribute("Moex", Moex);
			model.addAttribute("Moin", Moin);
			model.addAttribute("Excategory", Excategory);
			
			
			System.out.println("로그인 정보 : " + login);
			System.out.println("====================");
			System.out.println("가계부 내용" + AbVO);
			return "accountBook/abView";
		}

		//가계부 작성
		@RequestMapping("/abWriteDo")
		public String abWriteDo(HttpSession session, AbVO abVO) throws Exception {
			System.out.println("체크");
			MemberVO login = (MemberVO)session.getAttribute("login");
			abVO.setMemId(login.getMemId());
		
			service.abWriteDo(abVO);
			System.out.println(abVO);
			return "redirect:/abView";
		}
		
		@RequestMapping(value="/abDelDo", method=RequestMethod.POST)
		public String abDelDo(int trxId) throws Exception {
			service.abDelDo(trxId);
			
			System.out.println("실행");
			System.out.println(trxId);
			System.out.println(trxId);
			System.out.println(trxId);
			System.out.println(trxId);
			System.out.println(trxId);
			System.out.println(trxId);
			return "redirect:/abView";
		}
				
}