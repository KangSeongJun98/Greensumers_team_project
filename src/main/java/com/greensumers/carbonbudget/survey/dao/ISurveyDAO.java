package com.greensumers.carbonbudget.survey.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.greensumers.carbonbudget.accountBook.vo.AbVO;
import com.greensumers.carbonbudget.survey.vo.CarVO;
import com.greensumers.carbonbudget.survey.vo.ResponseVO;
import com.greensumers.carbonbudget.survey.vo.SavingVO;
import com.greensumers.carbonbudget.survey.vo.SimilarityVO;

@Mapper
public interface ISurveyDAO {
	// 차량 정보
	public ArrayList<CarVO> getCarInfo(CarVO carVO);
	// 설문 대답
	public int surveyDo(ResponseVO responseVO);
	// 나와 유사한 사용자의 지출
	public ArrayList<SavingVO> savingCmpDo(SimilarityVO similarityVO);
}
