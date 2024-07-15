package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class NoticeReplyVO {
	private int idx;                  // 댓글 고유 번호
	private int noticeIdx;            // 해당 공지사항 번호
	private int memberIdx;            // 댓글 작성자 IDX
	private String content;           // 댓글 내용
	private String createdAt;  // 댓글 작성 시간
	private Integer parentIdx;        // 부모 댓글 번호 (대댓글인 경우)
}
