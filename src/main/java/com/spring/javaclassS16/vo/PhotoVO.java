package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class PhotoVO {
  private int idx;                // 사진 고유번호
  private int memberIdx;          // 사진을 올린 회원의 고유번호
  private String name;        		// 작성자 이름
  private String familyCode;      // 가족 코드
//  private String part;            // 사진 분류(풍경/인물/학습/사물/기타 등)
//  private String title;           // 사진 제목
  private String description;    	// 사진 설명
  private String content;     		// 사진 내용 (사진들)
  private int photoCount;         // 업로드된 사진 수량
  private String thumbnail;       // 썸네일 이미지 경로
  private String pDate;        		// 사진 업로드 날짜, 시간
  private int goodCount;          // 좋아요 수
  private int readNum;            // 조회수
  
  private int replyCnt;          // 댓글 수
  private String mid;            // 작성자 아이디
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
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getFamilyCode() {
	return familyCode;
}
public void setFamilyCode(String familyCode) {
	this.familyCode = familyCode;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public int getPhotoCount() {
	return photoCount;
}
public void setPhotoCount(int photoCount) {
	this.photoCount = photoCount;
}
public String getThumbnail() {
	return thumbnail;
}
public void setThumbnail(String thumbnail) {
	this.thumbnail = thumbnail;
}
public String getpDate() {
	return pDate;
}
public void setpDate(String pDate) {
	this.pDate = pDate;
}
public int getGoodCount() {
	return goodCount;
}
public void setGoodCount(int goodCount) {
	this.goodCount = goodCount;
}
public int getReadNum() {
	return readNum;
}
public void setReadNum(int readNum) {
	this.readNum = readNum;
}
public int getReplyCnt() {
	return replyCnt;
}
public void setReplyCnt(int replyCnt) {
	this.replyCnt = replyCnt;
}
public String getMid() {
	return mid;
}
public void setMid(String mid) {
	this.mid = mid;
}
@Override
public String toString() {
	return "PhotoVO [idx=" + idx + ", memberIdx=" + memberIdx + ", name=" + name + ", familyCode=" + familyCode
			+ ", description=" + description + ", content=" + content + ", photoCount=" + photoCount + ", thumbnail="
			+ thumbnail + ", pDate=" + pDate + ", goodCount=" + goodCount + ", readNum=" + readNum + ", replyCnt="
			+ replyCnt + ", mid=" + mid + "]";
}

  
    
}