package com.spring.javaclassS16.vo;

import java.util.List;

import lombok.Data;

@Data
public class VoteOptionVO {
  private int idx;
  private int voteIdx; 			 // 연관된 투표의 idx 
  private String optionText; // 투표 옵션 내용
  private int voteCount; 		 // 해당 투표를 선택한 수 -> 안필요할거같음??
  private double votePercent;// 퍼센트 
  private List<MemberVO> voters;  
  
}