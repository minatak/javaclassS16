package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class PhotoReplyVO {
  private int idx;
  private int photoIdx;
  private String mid;
  private String name;
  private String prDate;
  private String content;
  private Integer parentIdx;  // 부모 댓글의 idx (대댓글인 경우), null 가능
    
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

	public Integer getParentIdx() {
		return parentIdx;
	}

	public void setParentIdx(Integer parentIdx) {
		this.parentIdx = parentIdx;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	@Override
	public String toString() {
		return "PhotoReplyVO [idx=" + idx + ", photoIdx=" + photoIdx + ", mid=" + mid + ", name=" + name + ", prDate="
				+ prDate + ", content=" + content + ", parentIdx=" + parentIdx + ", replyCnt=" + replyCnt + "]";
	}
	
	
}