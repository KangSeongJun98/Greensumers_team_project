package com.greensumers.carbonbudget.accountBook.vo;

import lombok.Data;

@Data
public class AccountSearchVO extends PagingVO{
	
	private String memId;
	private String yearMonth;
	private String currentTime;
	private int getTotalCount;
	
}
