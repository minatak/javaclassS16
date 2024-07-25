package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class MeetingTopicVO {
  private int idx;
  private String familyCode;
  private String title;
  private String description;
  private int priority;
  private String status;
  private int memberIdx;
  private String memberName;
  private String createdAt;
  
  private int replyCnt; 
}
