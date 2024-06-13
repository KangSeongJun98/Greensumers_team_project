package com.greensumers.carbonbudget.comparison.vo;

import lombok.Data;

@Data
public class CfVO extends CountVO{
	private String memId;
	private String yearMonth;
	private float gasCf;
	private float elctrCf;
	private float waterCf;
	private float carCf;
	private int countId;
	
}
