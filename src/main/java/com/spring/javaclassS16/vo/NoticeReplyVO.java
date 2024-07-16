package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class NoticeReplyVO {
	private int idx;                  // 댓글 고유 번호
	private int noticeIdx;            // 해당 공지사항 번호
	private int memberIdx;            // 댓글 작성자 IDX
	private String name;            	// 댓글 작성자 이름
	private String content;           // 댓글 내용
	private String createdAt;  				// 댓글 작성 시간
	private Integer parentIdx;        // 부모 댓글 번호 (대댓글인 경우)
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getNoticeIdx() {
		return noticeIdx;
	}
	public void setNoticeIdx(int noticeIdx) {
		this.noticeIdx = noticeIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public Integer getParentIdx() {
		return parentIdx;
	}
	public void setParentIdx(Integer parentIdx) {
		this.parentIdx = parentIdx;
	}
	@Override
	public String toString() {
		return "NoticeReplyVO [idx=" + idx + ", noticeIdx=" + noticeIdx + ", memberIdx=" + memberIdx + ", name=" + name
				+ ", content=" + content + ", createdAt=" + createdAt + ", parentIdx=" + parentIdx + "]";
	}

	
}
