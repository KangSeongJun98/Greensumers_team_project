package com.greensumers.carbonbudget.survey.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class ResponseVO {
	private String memId;
	private String cDt;
	private String q;
	private String a;
	private ArrayList<ResultVO> result; // 질문 아이디
}
