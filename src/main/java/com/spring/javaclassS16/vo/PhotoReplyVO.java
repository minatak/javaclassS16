package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class PhotoReplyVO {
	private int idx;
	private int photoIdx;		// 댓글이 달린 사진의 고유번호
	private int re_step;		// 레벨(re_step)에 따른 들여쓰기(계층번호): 부모댓글의 re_step는 0이다. 대댓글의 경우는 '부모re_step+1'로 처리한다. 
	private int re_order;		// 댓글 순서
	private String mid;			// 작성자 아이디
	private String name;		// 작성자 이름
	private String prDate;	// 댓글 작성 날짜 및 시간
	private String content;	// 댓글 내용
    
	private int replyCnt;   // 댓글 수
}