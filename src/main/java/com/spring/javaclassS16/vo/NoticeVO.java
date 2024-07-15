package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class NoticeVO {
	private int idx;                  // 공지사항 고유번호
	private int memberIdx;            // 작성자 IDX
	private String memberName;        // 작성자 이름
	private String title;             // 공지사항 제목
	private String content;           // 공지사항 내용
	private int viewCount;            // 조회수
	private int likeCount;            // 좋아요 수
	private String createdAt;  				// 작성 일시
	private String updatedAt;  				// 수정 일시
	private boolean isImportant;      // 중요 공지사항 여부
	private boolean isPinned;         // 고정된 공지사항 여부
	
	private int hour_diff;	// 게시글을 24시간 경과유무 체크변수
	private int date_diff;	// 게시글을 일자 경과유무 체크변수
	private int replyCnt;		// 부모글의 댓글수를 저장하는 변수
}
