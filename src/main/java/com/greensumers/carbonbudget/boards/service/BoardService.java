package com.greensumers.carbonbudget.boards.service;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.boards.dao.IBoardDAO;
import com.greensumers.carbonbudget.boards.vo.BoardVO;
import com.greensumers.carbonbudget.boards.vo.ReplyVO;

@Service
public class BoardService {
	@Autowired
	IBoardDAO dao;
	
	public ArrayList<BoardVO>getBoardList(){
		ArrayList<BoardVO> result = dao.getBoardList();
		return result;
	}
	
	public void writeBoard(BoardVO vo) throws Exception {
		int result = dao.writeBoard(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public BoardVO getBoard(int boardNo) throws Exception {
		BoardVO result = dao.getBoard(boardNo);
		if(result == null) {
			throw new Exception();
		}
		return result;
	}
	
	public void updateBoard(BoardVO vo) throws Exception {
		int result = dao.updateBoard(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public void deleteBoard(int boardNo) throws Exception {
		int result = dao.deleteBoard(boardNo);
		if(result == 0) {
			throw new Exception();
		}
	}
	
	// 댓글 등록
	public void writeReply(ReplyVO vo) throws Exception {
		int result = dao.writeReply(vo);
		if(result ==0) {
			throw new Exception();
		}
	}
	// 댓글 조회
	public ReplyVO getReply(String replyNo) throws Exception {
		ReplyVO result = dao.getReply(replyNo);
		if(result==null) throw new Exception();
		return result;
	}
	// 댓글 리스트 조회
	public ArrayList<ReplyVO>getReplyList(int boardNo) throws Exception{
		ArrayList<ReplyVO>result = dao.getReplyList(boardNo);
		if(result==null) throw new Exception();
		return result;
	}
	
	// 댓글 삭제
	public void replyDel (ReplyVO vo) throws Exception {
		int result = dao.replyDel(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
}
