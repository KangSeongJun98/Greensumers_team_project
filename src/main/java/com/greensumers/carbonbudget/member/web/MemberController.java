package com.greensumers.carbonbudget.member.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greensumers.carbonbudget.member.service.MemberService;
import com.greensumers.carbonbudget.member.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@RequestMapping("/loginView")
	public String loginView() {
		return "member/loginView";
	}
	
	@RequestMapping("/registView")
	public String registView() {
		return "member/registView";
	}
	
	@RequestMapping("/socialRegistView")
	public String socialRegistView() {
		return "member/socialRegistView";
	}

	@RequestMapping("/myPageView")
	public String myPageView(HttpSession session) {
		if (session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		return "member/myPageView";
	}
	
	@RequestMapping("/findPwView")
	public String findPwView() {
		return "member/findPwView";
	}
	
	@RequestMapping("/findIdView")
	public String findIdView() {
		return "member/findIdView";
	}

	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public String clippingDo(@RequestBody MemberVO vo, RedirectAttributes re) {
		try {
			MemberVO check = memberService.loginMember(vo);
			System.out.println(check);
			if (check != null) {
				return "notnull";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "null";
	}
	
	// 닉네임 중복체크
	@ResponseBody
	@RequestMapping(value = "/alsCheck", method = RequestMethod.POST)
	public String aliasCheck(@RequestBody MemberVO vo, RedirectAttributes re) {
		try {
			int check = memberService.aliasCheck(vo);
			System.out.println(check);
			if (check == 0) {
				return "null";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "notnull";
	}

	@RequestMapping("/registDo")
	public String registDo(HttpServletRequest request, MemberVO vo, RedirectAttributes re) {
		System.out.println("체크"+request.getParameter("memId"));
		System.out.println(request.getParameter("memPw"));
		vo.setMemPw(passwordEncoder.encode(request.getParameter("memPw")));
		String pwCheck = request.getParameter("pwCheck");
		String memPw = request.getParameter("memPw");
		System.out.println(vo);
		// 비밀번호 체크
		if (pwCheck.equals(memPw)) {
			try {
				memberService.registMember(vo);
			} catch (Exception e) {
				System.out.println(e);
				return "redirect:/registView";
			}
			// RedirectAttributes 리다이렉트시 전송하고 싶은 데이터를 포함시켜서 요청할 수 있음
			re.addFlashAttribute("msg", "회원가입이 정상적으로 처리됐습니다.");
			return "redirect:/loginView";
		} else {
			re.addFlashAttribute("msg", "비밀번호를 확인해주세요.");
			return "redirect:/registView";
		}
	}

	// 로그인
	@RequestMapping("/loginDo")
	public String loginDo(MemberVO vo, boolean remember,  Model model,
			HttpSession session, RedirectAttributes re, HttpServletResponse resp) {

		MemberVO login = memberService.loginMember(vo);
		if (login == null) {
			re.addFlashAttribute("msg", "아이디를 확인해주세요.");
			return "redirect:/loginView";
		}
		// 첫 번째 매개변수(사용자 입력 아직 암호화가 안됨), 두 번째 매개변수(암호화가 된 비밀번호)
		boolean match = passwordEncoder.matches(vo.getMemPw(), login.getMemPw());
		if (!match) {
			re.addFlashAttribute("msg", "비밀번호를 확인해주세요.");
			return "redirect:/loginView";
		}
		session.setAttribute("login", login);
		System.out.println(login);
		System.out.println(vo);
		re.addFlashAttribute("msg", login.getMemNm() + "님 환영합니다.");
		
		if(remember) {
			Cookie cookie = new Cookie("rememberId", vo.getMemId());
			resp.addCookie(cookie); // 응답하면 객체에 담아서 전달
		}else {
			Cookie cookie = new Cookie("rememberId", "");
			cookie.setMaxAge(0); // 유효시간을 0으로 만드는게 쿠키를 삭제하는 방법임
			resp.addCookie(cookie);
		}
		return "redirect:/";
	}

	// 로그아웃
	@RequestMapping("/logoutDo")
	public String logoutDo(HttpSession session, RedirectAttributes re) {
		// 세션종료
		session.invalidate();
		re.addFlashAttribute("msg", "로그아웃 되셨습니다.");
		return "redirect:/";
	}

	// 회원정보 수정
	@RequestMapping("/updateDo")
	public String updateDo(MemberVO vo, Model model, HttpSession session, RedirectAttributes re) {

		MemberVO login = (MemberVO) session.getAttribute("login");
		boolean match = passwordEncoder.matches(vo.getMemPw(), login.getMemPw());
		System.out.println(vo);
		vo.setMemId(login.getMemId());
		// 비밀번호 체크
		if (!match) {
			re.addFlashAttribute("msg", "비밀번호가 틀렸습니다.");
			return "redirect:/myPageView";
		} else if (match) {
			try {
				memberService.updateMember(vo);
				vo = memberService.loginMember(vo);
				session.setAttribute("login", vo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			re.addFlashAttribute("msg", "회원 정보가 수정되었습니다.");
		}
		return "redirect:/myPageView";
	}
	
	// 비밀번호 수정
	@RequestMapping("/updatePwDo")
	public String updatePwDo(HttpServletRequest request, MemberVO vo, Model model, HttpSession session, RedirectAttributes re) {
		
		vo.setMemPw(passwordEncoder.encode(request.getParameter("memPw")));
		MemberVO login = (MemberVO) session.getAttribute("login");
		vo.setMemId(login.getMemId());
		String pwCheck = request.getParameter("pwCheck");
		String memPw = request.getParameter("memPw");
		// 비밀번호 체크
		if (pwCheck.equals(memPw)) {
			try {
				memberService.updateMemberPw(vo);
			} catch (Exception e) {
				System.out.println(e);
				return "redirect:/myPageView";
			}
			// RedirectAttributes 리다이렉트시 전송하고 싶은 데이터를 포함시켜서 요청할 수 있음
			re.addFlashAttribute("msg", "비밀번호 변경이 정상적으로 처리됐습니다.");
		} else {
			re.addFlashAttribute("msg", "비밀번호를 확인해주세요.");
		}
		
		return "redirect:/myPageView";
	}
	
	// 회원탈퇴
	@ResponseBody
	@RequestMapping("/deleteDo")
	public String deleteDo(MemberVO vo, Model model, HttpSession session, RedirectAttributes re) {
		MemberVO login = (MemberVO) session.getAttribute("login");
		vo.setMemId(login.getMemId());
		
			try {
				memberService.deleteMember(vo);
			} catch (Exception e) {
				e.printStackTrace();
				return "N";
			}
		return "Y";
	}
	
	// 아이디 찾기
	@RequestMapping("/findIdDo")
	public String findIdDo(MemberVO vo, RedirectAttributes re, HttpSession session) {
		MemberVO findId = memberService.findId(vo);
		if (findId == null) {
			re.addFlashAttribute("msg", "이름을 확인해주세요.");
			return "redirect:/loginView";
		}
		boolean match = vo.getMemEmail().equals(findId.getMemEmail());
		if(!match) {
			re.addFlashAttribute("msg", "이메일을 확인해주세요.");
			return "redirect:/loginView";
		}
		session.setAttribute("findId", findId);
		re.addFlashAttribute("msg", "회원님의 아이디는 "+ findId.getMemId() +"입니다.");
		return "redirect:/loginView";
	}
	
	// 비밀번호 찾기 전 아이디 메일 일치 확인
	@RequestMapping("/idMailCheck")
	public String idMailCheck (MemberVO vo, RedirectAttributes re, HttpSession session) {
		MemberVO idCheck = memberService.loginMember(vo);
		if (idCheck == null) {
			re.addFlashAttribute("msg", "아이디를 확인해주세요.");
			return "redirect:/loginView";
		}
		boolean match = vo.getMemEmail().equals(idCheck.getMemEmail());
		if (!match) {
			re.addFlashAttribute("msg", "이메일을 확인해주세요.");
			return "redirect:/loginView";
		}
		session.setAttribute("memberFindingPw", idCheck);
		System.out.println("임시 비밀번호 안내 메일을 전송합니다.");
		return "redirect:/sendTemporaryPasswordMailDo";
		
	}
	
}