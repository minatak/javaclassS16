package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class VoteReplyVO {
	private int idx;                  // 댓글 고유 번호
	private int voteIdx;              // 해당 투표 idx
	private int memberIdx;            // 댓글 작성자 idx
	private String name;            	// 댓글 작성자 이름
	private String content;           // 댓글 내용
	private String createdAt;  				// 댓글 작성 시간
	private Integer parentIdx;        // 부모 댓글 번호 (대댓글인 경우)

}
