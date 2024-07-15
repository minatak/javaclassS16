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
	
}