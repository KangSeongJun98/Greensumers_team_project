package com.greensumers.carbonbudget.free.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.free.dao.IFreeBoardDAO;
import com.greensumers.carbonbudget.free.vo.FreeBoardVO;
import com.greensumers.carbonbudget.free.vo.FreeSearchVO;



@Service
	public class FreeService{
		
		@Autowired
		IFreeBoardDAO dao;
		
		//게시글 조회
		public List<FreeBoardVO> getBoardList(FreeSearchVO searchVO){
			//검색조건에 따른 전체 건수 조회
			int total = dao.getTotalRowCount(searchVO);
//			전체건수로 paging 건수 세팅
			searchVO.setTotalRowCount(total);
			searchVO.pageSetting();
			return dao.getBoardList(searchVO);
		}
		// 게시글 상세조회
		public FreeBoardVO getBoard(int boNo) throws Exception {
			FreeBoardVO result = dao.getBoard(boNo);
			if(result == null) {
				throw new Exception();
			}
			// 조회수 증가
			dao.increaseHit(boNo);
			return result;
		}
		// 게시글 작성
		public int insertFreeBoard(FreeBoardVO vo) throws Exception {
			int result = dao.insertFreeBoard(vo);
			if(result == 0) {
				throw new Exception();
			}
			return result;
		}
	}
