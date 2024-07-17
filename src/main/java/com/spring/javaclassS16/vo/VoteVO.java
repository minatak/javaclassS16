package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class VoteVO {
  private int idx;
  private int memberIdx; 			// 투표 생성자
  private String name; 				// 투표 생성자 이름
  private String familyCode; 	// 가족 코드
  private String title; 			// 투표 제목
  private String description; // 투표 설명
  private String part; 				// 투표 분류
  private String createdAt;		// 투표 생성 날짜(시간)
  private String endTime; 		// 투표 종료 시간
  private boolean anonymous;	// 익명 투표 여부
  private String status;			// 투표 상태 ('ACTIVE', 'CLOSED')
  private boolean multipleChoice; // 복수 선택 가능 여부

  private int daysLeft; 			// 종료까지 남은 날짜
  
}