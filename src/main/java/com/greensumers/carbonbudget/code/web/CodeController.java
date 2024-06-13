package com.greensumers.carbonbudget.code.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.greensumers.carbonbudget.code.service.CodeService;
import com.greensumers.carbonbudget.code.vo.CodeVO;



@RestController // rest api 전용 컨트롤러(객체가 자동으로 json 형태로 리턴)
@RequestMapping("/api")
public class CodeController {
	@Autowired
	private CodeService codeService;
	
	@GetMapping("/getSubCodes")
	public List<CodeVO> getSubCodes(@RequestParam (value="commParent", defaultValue="BC00") String commParent){
		List<CodeVO> comList = codeService.getCodeList(commParent);
		return comList;
	}
}
