package com.spring.javaclassS16.vo;

import lombok.Data;

// @Data
public class NoticeVO {
	private int idx;                  // 공지사항 고유번호
	private int memberIdx;            // 작성자 IDX
	private String memberName;        // 작성자 이름
	private String familyCode;        // 작성자 가족 코드
	private String title;             // 공지사항 제목
	private String content;           // 공지사항 내용
	private int viewCount;            // 조회수
	private int likeCount;            // 좋아요 수
	private String createdAt;  				// 작성 일시
	private String updatedAt;  				// 수정 일시
	private boolean important;      // 중요 공지사항 여부
	private boolean pinned;         // 고정된 공지사항 여부
	
	private int hour_diff;	// 게시글을 24시간 경과유무 체크변수
	private int date_diff;	// 게시글을 일자 경과유무 체크변수
	private int replyCnt;		// 부모글의 댓글수를 저장하는 변수
	
	private boolean isRead; // 읽음 상태 확인
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getFamilyCode() {
		return familyCode;
	}
	public void setFamilyCode(String familyCode) {
		this.familyCode = familyCode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
	public boolean isImportant() {
		return important;
	}
	public void setImportant(boolean important) {
		this.important = important;
	}
	public boolean isPinned() {
		return pinned;
	}
	public void setPinned(boolean pinned) {
		this.pinned = pinned;
	}
	public int getHour_diff() {
		return hour_diff;
	}
	public void setHour_diff(int hour_diff) {
		this.hour_diff = hour_diff;
	}
	public int getDate_diff() {
		return date_diff;
	}
	public void setDate_diff(int date_diff) {
		this.date_diff = date_diff;
	}
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
	
	public boolean isRead() {
	    return isRead;
	}
	
	public void setRead(boolean read) {
	    isRead = read;
	}
	
	@Override
	public String toString() {
		return "NoticeVO [idx=" + idx + ", memberIdx=" + memberIdx + ", memberName=" + memberName + ", familyCode="
				+ familyCode + ", title=" + title + ", content=" + content + ", viewCount=" + viewCount + ", likeCount="
				+ likeCount + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", important=" + important
				+ ", pinned=" + pinned + ", hour_diff=" + hour_diff + ", date_diff=" + date_diff + ", replyCnt="
				+ replyCnt + "]";
	}

	
	
}
