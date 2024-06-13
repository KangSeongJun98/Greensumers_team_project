package com.greensumers.carbonbudget.code.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greensumers.carbonbudget.code.vo.CodeVO;

@Mapper
public interface ICodeDAO {
	public List<CodeVO> getCodeListByParent(String parentCode);

}
