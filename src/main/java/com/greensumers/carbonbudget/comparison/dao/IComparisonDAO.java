package com.greensumers.carbonbudget.comparison.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.greensumers.carbonbudget.comparison.vo.CfVO;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Mapper
public interface IComparisonDAO {
	
	// 사용자별 탄소발자국 데이터
	public ArrayList<CfVO>getCfData(MemberVO vo);
	
	// 유저 평균 탄소발자국 데이터
	public ArrayList<CfVO>getAvgCfData();
	
	// 유저 평균 수 가져오는 쿼리
	public int getCountId();
}
