package com.greensumers.carbonbudget.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.member.dao.IMemberDAO;
import com.greensumers.carbonbudget.member.vo.MemberVO;


@Service
public class MemberService {
	// Autowired 어노테이션은 자동 의존성 주입을 위해 사용
	// 클래스 필드, 생성자, 메소드에 어노테이션을 표시함으로써
	// 스프링에게 해당 타입을 자동으로 주입하도록 지시
	@Autowired
	IMemberDAO dao;

	// 회원가입
	public void registMember(MemberVO vo) throws Exception {
		int result = dao.registMember(vo);
		if (result == 0) {
			throw new Exception();
		}
	}
	
	// 닉네임 중복 체크
		public int aliasCheck(MemberVO vo) {
			return dao.aliasCheck(vo);
		}

	// 회원조회
	public MemberVO emailLogin(MemberVO vo) {
		return dao.emailLogin(vo);
	}
	
	// 소셜로그인 회원조회
	public MemberVO loginMember(MemberVO vo) {
		return dao.loginMember(vo);
	}
	
	// 회원 수정
	public void updateMember(MemberVO vo) throws Exception {
		int result = dao.updateMember(vo);
		if (result == 0) {
			throw new Exception();
		}
	}

	// 비밀번호 수정
	public void updateMemberPw(MemberVO vo) throws Exception {
		int result = dao.updateMemberPw(vo);
		if (result == 0) {
			throw new Exception();
		}
	}

	// 회원 탈퇴
	public void deleteMember(MemberVO vo) throws Exception {
		int result = dao.deleteMember(vo);
		if (result == 0) {
			throw new Exception();
		}
	}
	
	// 차량 정보 업데이트
		public void carUpdate(MemberVO vo) throws Exception {
			int result = dao.carUpdate(vo);
			if (result == 0) {
				throw new Exception();
			}
		}
	
	// 아이디 찾기
	public MemberVO findId(MemberVO vo) {
		return dao.findId(vo);
	}
	
}
