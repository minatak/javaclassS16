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

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getPhotoIdx() {
		return photoIdx;
	}

	public void setPhotoIdx(int photoIdx) {
		this.photoIdx = photoIdx;
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public int getRe_order() {
		return re_order;
	}

	public void setRe_order(int re_order) {
		this.re_order = re_order;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPrDate() {
		return prDate;
	}

	public void setPrDate(String prDate) {
		this.prDate = prDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	@Override
	public String toString() {
		return "PhotoReplyVO [idx=" + idx + ", photoIdx=" + photoIdx + ", re_step=" + re_step + ", re_order=" + re_order
				+ ", mid=" + mid + ", name=" + name + ", prDate=" + prDate + ", content=" + content + ", replyCnt="
				+ replyCnt + "]";
	}
	
	
	
}