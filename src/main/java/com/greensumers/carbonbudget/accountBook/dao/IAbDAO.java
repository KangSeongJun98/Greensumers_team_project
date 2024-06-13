package com.greensumers.carbonbudget.accountBook.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.accountBook.vo.AccountSearchVO;
import com.greensumers.carbonbudget.accountBook.vo.BalanceVO;
import com.greensumers.carbonbudget.accountBook.vo.ExcategoryVO;
import com.greensumers.carbonbudget.accountBook.vo.ExpenseVO;
import com.greensumers.carbonbudget.accountBook.vo.IncomeVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthExVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthInVO;

@Mapper
public interface IAbDAO {
	//가계부 조회
	public ArrayList<AbVO> getabList(AccountSearchVO searchVO);
	//가계부 페이지 개수
	public int getTotalCount(AccountSearchVO vo);
	//가계부 총 수입
	public IncomeVO getTotalIncome(AccountSearchVO searchVO);
	//가계부 총 지출
	public ExpenseVO getTotalExpense(AccountSearchVO searchVO);
	//가계부 총 잔액
	public BalanceVO getBalance(AccountSearchVO searchVO);
	//가계부 월별 지출
	public ArrayList<MonthExVO> getmonthEx(AccountSearchVO searchVO);
	//가계부 월별 수입
	public ArrayList<MonthInVO> getmonthIn(AccountSearchVO searchVO);
	//가계부 지출 카테고리
	public ArrayList<ExcategoryVO> getExCategory(AccountSearchVO searchVO);
	//가계부 작성 
	public int abWriteDo(AbVO vo);
	//가계부 삭제
	public int abDelDo(int trxId);
	// OCR 값 저장
	public int OCRSave(AbVO vo);	
}
