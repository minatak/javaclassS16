package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class PhotoVO {
  private int idx;                // 사진 고유번호
  private int memberIdx;          // 사진을 올린 회원의 고유번호
  private String name;        		// 작성자 이름
  private String familyCode;      // 가족 코드
  private String part;            // 사진 분류(풍경/인물/학습/사물/기타 등)
  private String title;           // 사진 제목
  private String content;     		// 사진 내용
  private int photoCount;         // 업로드된 사진 수량
  private String thumbnail;       // 썸네일 이미지 경로
  private String pDate;        		// 사진 업로드 날짜, 시간
  private int goodCount;          // 좋아요 수
  private int readNum;            // 조회수
  
  private int replyCnt;            // 댓글수

    
}