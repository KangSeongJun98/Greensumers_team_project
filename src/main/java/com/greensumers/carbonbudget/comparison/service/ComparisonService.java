package com.greensumers.carbonbudget.comparison.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.comparison.dao.IComparisonDAO;
import com.greensumers.carbonbudget.comparison.vo.CfVO;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Service
public class ComparisonService {

	@Autowired
	IComparisonDAO dao;
	
	// 사용자별 탄소 발자국 전체 데이터
	public ArrayList<CfVO> getCfData(MemberVO vo) {
		return dao.getCfData(vo);
	}
	
	// 평균 탄소발자국 데이터
	public ArrayList<CfVO> getAvgCfData() {
		return dao.getAvgCfData();
	}
	
	// 사용자 수 가져오기
		public int getCountId() {
			return dao.getCountId();
		}
	
}
