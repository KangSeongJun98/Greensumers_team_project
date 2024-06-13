package com.greensumers.carbonbudget.code.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.greensumers.carbonbudget.code.dao.ICodeDAO;
import com.greensumers.carbonbudget.code.vo.CodeVO;

@Service
public class CodeService {
	
	@Autowired
	ICodeDAO codeDao;
	
	public List<CodeVO> getCodeList(String ParentCode){
		return codeDao.getCodeListByParent(ParentCode);
	}
	

}
