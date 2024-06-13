package com.greensumers.carbonbudget.boards.vo;

import lombok.Data;

//롬복
@Data
// 댓글 관련
public class ReplyVO {
	 private String replyNo;
	 private int boardNo;
	 private String memId;
	 private String memNm;
	 private String replyContent;
	 private String replyDate;
	 
	 
}
