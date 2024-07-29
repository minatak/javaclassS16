package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class MeetingTopicReplyVO {
	private int idx;
  private int topicIdx;
  private int memberIdx;
  private String memberName;
  private String content;
  private String createdAt;
//  private int parentIdx;
  
  private int replyCnt; 

}
