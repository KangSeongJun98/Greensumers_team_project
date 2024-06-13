package com.greensumers.carbonbudget.commons.web;

import java.io.UnsupportedEncodingException;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.greensumers.carbonbudget.commons.service.MailService;
import com.greensumers.carbonbudget.member.service.MemberService;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Controller
@EnableAsync
public class MailController {
	
	@Autowired
	private MailService mailService;
	
    @Autowired
    MemberService memberService;
    
    @Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/sendVerifMailDo", method = { RequestMethod.POST })	
	public ResponseEntity<String> test(@RequestParam("memEmail") String memEmail) {
	    System.out.println(memEmail);
	    // 여기서 적절한 응답을 생성하고 반환합니다.
	    try {
			mailService.sendVerificationMail(memEmail);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	    return ResponseEntity.ok("Success"); // 예시로 "Success" 문자열 반환
	}

	/**
	 * @Author : Pangsu
	 * @Date   : 2024. 5. 13.
	 * @Method : verifyCode
	 * @return : String
	 * Purpose : 메일 인증코드 체크 
	 * Description : redis (remote dictionary server key-value 구조의 비정형 데이터 저장관리 도구)에 저장된 값 체크
	*/
	@RequestMapping(value = "/verify", method = RequestMethod.POST)
    public @ResponseBody String verifyCode(@RequestParam String email, @RequestParam String code) {
        boolean isVerified = mailService.verifyEmail(email, code);
        return isVerified ? "Y" : "N";
    }
	
	@RequestMapping(value = "/sendTemporaryPasswordMailDo")
	public ResponseEntity<String> temporaryPasswordMailTest(MemberVO vo, HttpSession session) {
		
		MemberVO memberFindingPw = (MemberVO) session.getAttribute("memberFindingPw");
		vo.setMemId(memberFindingPw.getMemId());
		vo.setMemEmail(memberFindingPw.getMemEmail());
		
		try {
			CompletableFuture<String> futureCode = mailService.sendTemporaryPasswordMail(vo.getMemEmail());
			System.out.println("========================1");
			String code = futureCode.get(); // 비동기 작업이 완료될 때까지 대기
			vo.setMemPw(passwordEncoder.encode(code));
			System.out.println("========================2");
		} catch (UnsupportedEncodingException e) {
			System.out.println("메일을 전송하던 도중 오류가 발생했습니다.");
			e.printStackTrace();
		} catch (InterruptedException e) {
			System.out.println("메일을 전송하던 도중 오류가 발생했습니다.");
			e.printStackTrace();
		} catch (ExecutionException e) {
			System.out.println("메일을 전송하던 도중 오류가 발생했습니다.");
			e.printStackTrace();
		}
		System.out.println(vo);
		try {
			memberService.updateMemberPw(vo);
		} catch (Exception e1) {
			System.out.println("임시 비밀번호로 비밀번호를 변경하는 도중 오류가 발생했습니다.");
			e1.printStackTrace();
		}
		session.invalidate();
		System.out.println("비밀번호가 성공적으로 변경되었습니다.");
		return ResponseEntity.ok("Success");
	}
}
