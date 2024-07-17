package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class VoteOptionVO {
  private int idx;
  private int voteIdx; 			 // 연관된 투표의 idx 
  private String optionText; // 투표 옵션 내용
  
  private int voteCount; 
  
}