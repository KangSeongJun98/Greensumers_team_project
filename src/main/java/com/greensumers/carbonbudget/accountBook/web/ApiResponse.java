package com.greensumers.carbonbudget.accountBook.web;

import java.util.ArrayList;

import com.greensumers.carbonbudget.accountBook.vo.ExcategoryVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthExVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthInVO;

public class ApiResponse {
	 private ArrayList<MonthExVO> moex;
	    private ArrayList<MonthInVO> moin;
	    private ArrayList<ExcategoryVO> exca;

	    // 생성자
	    public ApiResponse(ArrayList<MonthExVO> moex, ArrayList<MonthInVO> moin, ArrayList<ExcategoryVO> exca) {
	        this.moex = moex;
	        this.moin = moin;
	        this.exca = exca;
	    }

		public ArrayList<MonthExVO> getMoex() {
			return moex;
		}

		public void setMoex(ArrayList<MonthExVO> moex) {
			this.moex = moex;
		}

		public ArrayList<MonthInVO> getMoin() {
			return moin;
		}

		public void setMoin(ArrayList<MonthInVO> moin) {
			this.moin = moin;
		}

		public ArrayList<ExcategoryVO> getExca() {
			return exca;
		}

		public void setExca(ArrayList<ExcategoryVO> exca) {
			this.exca = exca;
		}
	    
	    
	}
