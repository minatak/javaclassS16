package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class PhotoReplyVO {
    private int idx;            // 댓글 고유번호
    private int memberIdx;      // 댓글을 작성한 회원의 고유번호
    private int photoIdx;       // 댓글이 달린 사진의 고유번호
    private String content;     // 댓글 내용
    private String prDate;   		// 댓글 작성 날짜 및 시간

    // 추가 필드 (멤버 정보와 조인 시 사용)
    private String name;    // 작성자 이름
    private String mid;    	// 작성자 이름
    private int replyCnt;   // 댓글 수
}