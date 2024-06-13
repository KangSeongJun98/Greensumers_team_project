package com.greensumers.carbonbudget.commons.service;

import java.io.UnsupportedEncodingException;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.greensumers.carbonbudget.commons.emailtemplete.VerificationEmailTemplete;
import com.greensumers.carbonbudget.commons.utils.RandomStringGenerator;

@Service
public class MailService {

	@Autowired
	private JavaMailSender mailSender;
	
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
	
	@Async
	public void sendMail(String to, String title, String content) throws UnsupportedEncodingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper;
		try {
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("hyy91234@gmail.com", "관리자");
			messageHelper.setSubject(title);
			messageHelper.setTo(to);
			messageHelper.setText(content);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	@Async
	public void sendVerificationMail(String to) throws UnsupportedEncodingException {
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper;
		String code = RandomStringGenerator.generateVerificationString();
		// 생성 코드를 redis에 24시간 저장(시간수정 가능) 		
		redisTemplate.opsForValue().set(to, code, 24, TimeUnit.HOURS);
		try {
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("hyy91234@gmail.com", "관리자");
			messageHelper.setSubject("CarbonBudget 인증메일입니다.");
			messageHelper.setTo(to);
			messageHelper.setText(VerificationEmailTemplete.registerEmailContent(code), true);
			mailSender.send(message);
		} catch(MessagingException e) {
			e.printStackTrace();
		}
	}
	// key value (key:체크이메일, value:생성코드)	
	public boolean verifyEmail(String email, String code) {
        String storedCode = redisTemplate.opsForValue().get(email);
        return code.equals(storedCode);
    }
	
	@Async
	public CompletableFuture<String>  sendTemporaryPasswordMail(String to) throws UnsupportedEncodingException {
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper;
		String code = RandomStringGenerator.generateTemporaryPassword();
		
		try {
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("hyy91234@gmail.com", "관리자");
			messageHelper.setSubject("CarbonBudget 임시 비밀번호 안내메일입니다.");
			messageHelper.setTo(to);
			messageHelper.setText(VerificationEmailTemplete.temporaryPasswordEmailContent(code), true);
			mailSender.send(message);
		} catch(MessagingException e) {
			e.printStackTrace();
		}
		
		return CompletableFuture.completedFuture(code);
	}

	
}