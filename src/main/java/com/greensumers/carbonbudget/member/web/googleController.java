package com.greensumers.carbonbudget.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greensumers.carbonbudget.member.service.MemberService;
import com.greensumers.carbonbudget.member.vo.GoogleInfResponse;
import com.greensumers.carbonbudget.member.vo.GoogleRequest;
import com.greensumers.carbonbudget.member.vo.GoogleResponse;
import com.greensumers.carbonbudget.member.vo.MemberVO;

//@RestController
//@CrossOrigin("*")
@Controller
public class googleController {
	private String googleClientId = "";
	private String googleClientPw = "";
	
	@Autowired
	MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@ResponseBody
	@RequestMapping(value="/api/v1/oauth2/google", method = RequestMethod.POST)
    public String loginUrlGoogle(){
        String reqUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=" + googleClientId
                + "&redirect_uri=http://localhost:8080/carbonbudget//api/v1/oauth2/google&response_type=code&scope=email%20profile%20openid&access_type=offline";
        return reqUrl;
    }
	
    @RequestMapping(value="/api/v1/oauth2/google", method = RequestMethod.GET)
    public String loginGoogle(@RequestParam(value = "code") String authCode, RedirectAttributes re, HttpSession session){
        RestTemplate restTemplate = new RestTemplate();
        GoogleRequest googleOAuthRequestParam = GoogleRequest
                .builder()
                .clientId(googleClientId)
                .clientSecret(googleClientPw)
                .code(authCode)
                .redirectUri("http://localhost:8080/carbonbudget//api/v1/oauth2/google")
                .grantType("authorization_code").build();
        ResponseEntity<GoogleResponse> resultEntity = restTemplate.postForEntity("https://oauth2.googleapis.com/token",
                googleOAuthRequestParam, GoogleResponse.class);
        String jwtToken=resultEntity.getBody().getId_token();
        Map<String, String> map=new HashMap<>();
        map.put("id_token",jwtToken);
        ResponseEntity<GoogleInfResponse> resultEntity2 = restTemplate.postForEntity("https://oauth2.googleapis.com/tokeninfo",
                map, GoogleInfResponse.class);
        
        String email= resultEntity2.getBody().getEmail();
        String name = resultEntity2.getBody().getName();
        System.out.println(resultEntity2.getBody());
        
        MemberVO userData = new MemberVO();
        userData.setMemEmail(email);
        userData.setMemNm(name);

        MemberVO google = service.emailLogin(userData);
        System.out.println(google);
         
        if(google == null) {
        	session.setAttribute("googleEmail", email);
        	session.setAttribute("googleName", name);
            
        	return "redirect:/socialRegistView";
        }
        session.setAttribute("login", google);
        return "redirect:/";
    }
    
    // 소셜 회원가입
    @RequestMapping("/socialRegistDo")
	public String registDo(HttpServletRequest request, MemberVO vo, RedirectAttributes re, HttpSession session) {
		vo.setMemPw(passwordEncoder.encode(request.getParameter("memPw")));
		String pwCheck = request.getParameter("pwCheck");
		String memPw = request.getParameter("memPw");
		System.out.println(vo);
		// 비밀번호 체크
		 if (pwCheck.equals(memPw) && memPw != null && pwCheck != null) {
	            try {
	                // 회원 가입 처리
	                service.registMember(vo);
	                // 회원 가입 후 자동 로그인
	                re.addFlashAttribute("msg", vo.getMemNm()+"님 환영합니다");
	                MemberVO login = service.loginMember(vo);
	                session.setAttribute("login", login);
	                return "redirect:/"; // 회원가입 후 메인 페이지로 바로 이동
	            } catch (Exception e) {
	                System.out.println(e);
	                re.addFlashAttribute("msg", "회원가입에 실패했습니다."); // 회원가입 실패 시 메시지 전달
	                return "redirect:/socialRegistView"; // 회원가입 실패 시 회원가입 페이지로 이동
	            }
	        } else {
	            re.addFlashAttribute("msg", "비밀번호를 확인해주세요."); // 비밀번호가 일치하지 않을 때 메시지 전달
	            return "redirect:/socialRegistView"; // 비밀번호가 일치하지 않을 때 회원가입 페이지로 이동
	        }
	}

}