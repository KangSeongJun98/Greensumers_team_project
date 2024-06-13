package com.greensumers.carbonbudget.accountBook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.accountBook.dao.IAbDAO;
import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.accountBook.vo.AccountSearchVO;
import com.greensumers.carbonbudget.accountBook.vo.BalanceVO;
import com.greensumers.carbonbudget.accountBook.vo.ExcategoryVO;
import com.greensumers.carbonbudget.accountBook.vo.ExpenseVO;
import com.greensumers.carbonbudget.accountBook.vo.IncomeVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthExVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthInVO;

@Service
public class AbService {
	@Autowired
	IAbDAO dao;
	
	public ArrayList<AbVO> getabList(AccountSearchVO searchVO){
		int cnt = dao.getTotalCount(searchVO);
		searchVO.setTotalRowCount(cnt);
		searchVO.pageSetting(); //페이징 계산
		return dao.getabList(searchVO);
	}
	public IncomeVO getTotalIncome(AccountSearchVO searchVO) {
		return dao.getTotalIncome(searchVO);
	}
	public ExpenseVO getTotalExpense(AccountSearchVO searchVO) {
		return dao.getTotalExpense(searchVO);
	}
	public BalanceVO getBalance(AccountSearchVO searchVO) {
		return dao.getBalance(searchVO);
	}
	public ArrayList<MonthExVO> getmonthEx(AccountSearchVO searchVO) {
		return dao.getmonthEx(searchVO);
	}
	public ArrayList<MonthInVO> getmonthIn(AccountSearchVO searchVO) {
		return dao.getmonthIn(searchVO);
	}
	public ArrayList<ExcategoryVO> getExCategory(AccountSearchVO searchVO) {
		return dao.getExCategory(searchVO);
	}
	public void abWriteDo(AbVO vo) throws Exception{
		int result = dao.abWriteDo(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	public void abDelDo(int trxId) throws Exception {
		int result = dao.abDelDo(trxId);
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public void OCRSave(AbVO vo) throws Exception {
		int result = dao.OCRSave(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
}
