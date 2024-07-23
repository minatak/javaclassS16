package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class WorkVO {
  private int idx;                 
  private String category;        // 카테고리
  private String task;            // 할 일
  private String description;     // 설명
  private String familyCode;      // 가족 코드
  private String startDate;       // 시작일
  private String endDate;         // 마감일
  private int rotationPeriod;     // 로테이션 주기
  private int memberIdx;          // 구성원 인덱스
  private String memberName;      // 구성원 이름
  private String completionDate;  // 완료일
  private String status;          // 상태
  
  private String daysLeft;          // 마감일까지 남은 일
  
}