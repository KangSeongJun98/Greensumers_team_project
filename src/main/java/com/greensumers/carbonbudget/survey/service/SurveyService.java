package com.greensumers.carbonbudget.survey.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.survey.dao.ISurveyDAO;
import com.greensumers.carbonbudget.survey.vo.CarVO;
import com.greensumers.carbonbudget.survey.vo.ResponseVO;
import com.greensumers.carbonbudget.survey.vo.ResultVO;
import com.greensumers.carbonbudget.survey.vo.SavingVO;
import com.greensumers.carbonbudget.survey.vo.SimilarityVO;

@Service
public class SurveyService {
	
	@Autowired
	ISurveyDAO dao;
	
	public ArrayList<CarVO>getCarInfo (CarVO carVO){
		return dao.getCarInfo(carVO);
	}
	
	// 설문 대답
	public void surveyDo(ResponseVO responseVO) throws Exception {	
		for(int i = 0; i< responseVO.getResult().size(); i++) {
			ResultVO vo= responseVO.getResult().get(i);
			responseVO.setQ(vo.getQId());
			responseVO.setA(vo.getAId());
			System.out.println(responseVO);
			int result =  dao.surveyDo(responseVO);
			if(result == 0) {
				throw new Exception();
			}
		}
	}
	
	// 유사한 사용자 값 가져오기
	public ArrayList<SavingVO> savingCmpDo (SimilarityVO similarityVO){
		return dao.savingCmpDo(similarityVO);
	}
	
}
